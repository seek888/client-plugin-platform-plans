import 'dart:async';

import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/features/article/presentation/notifiers/article_editor_notifier.dart';
import 'package:rss_reader/features/article/presentation/side_effects/article_editor_side_effect.dart';
import 'package:rss_reader/features/article/presentation/states/article_editor_state.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_editor_toolbar.dart';

/// 文章编辑器组件
class ArticleEditorWidget extends HookConsumerWidget {
  final String articleId;
  final VoidCallback? onSaved;
  final VoidCallback? onCancelled;

  const ArticleEditorWidget({
    super.key,
    required this.articleId,
    this.onSaved,
    this.onCancelled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(articleEditorNotifierProvider(articleId));
    final notifier =
        ref.read(articleEditorNotifierProvider(articleId).notifier);

    // 创建 QuillController - 只创建一次
    final controller = useMemoized(() => QuillController.basic(), [articleId]);

    // 创建 FocusNode
    final focusNode = useMemoized(() => FocusNode(), [articleId]);

    // 创建 ScrollController
    final scrollController = useScrollController();

    // 标记是否已初始化内容
    final isInitialized = useRef(false);

    // 监听副作用
    useEffect(() {
      StreamSubscription<ArticleEditorSideEffect>? subscription;

      Future.microtask(() {
        subscription = notifier.sideEffect.listen((effect) {
          if (context.mounted) {
            _handleSideEffect(context, effect, notifier);
          }
        });
      });

      return () => subscription?.cancel();
    }, [articleId]);

    // 当内容加载完成时，只初始化一次 controller
    useEffect(() {
      if (state is ArticleEditorLoaded && !isInitialized.value) {
        try {
          final delta = Delta.fromJson(state.content);
          controller.document = Document.fromDelta(delta);
          isInitialized.value = true;
        } catch (e) {
          // 如果转换失败，使用空文档
          controller.document = Document();
          isInitialized.value = true;
        }
      }
      return null;
    }, [state is ArticleEditorLoaded]);

    // 监听内容变化 - 只在初始化后才通知
    useEffect(() {
      void listener() {
        if (isInitialized.value) {
          final deltaJson = controller.document.toDelta().toJson();
          notifier
              .onContentChanged(List<Map<String, dynamic>>.from(deltaJson));
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    // 清理资源
    useEffect(() {
      return () {
        controller.dispose();
        focusNode.dispose();
      };
    }, []);

    // 延迟请求焦点，解决 Windows 键盘输入问题
    useEffect(() {
      if (state is ArticleEditorLoaded && isInitialized.value) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (focusNode.canRequestFocus && !focusNode.hasFocus) {
            focusNode.requestFocus();
          }
        });
      }
      return null;
    }, [state is ArticleEditorLoaded, isInitialized.value]);

    return state.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded:
          (articleId, content, hasEditedVersion, isDirty, isSaving, isNewNote) {
        return Column(
          children: [
            // 工具栏
            ArticleEditorToolbar(
              controller: controller,
              onSave: () => notifier.onSave(),
              onDiscard: () => notifier.onBack(),
              isSaving: isSaving,
              isDirty: isDirty,
            ),
            // 编辑器
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // 点击时请求焦点，解决 Windows 键盘输入问题
                  if (!focusNode.hasFocus) {
                    focusNode.requestFocus();
                  }
                },
                child: QuillEditor(
                  controller: controller,
                  focusNode: focusNode,
                  scrollController: scrollController,
                  configurations: QuillEditorConfigurations(
                    padding: const EdgeInsets.all(16),
                    placeholder:
                        isNewNote ? '开始写笔记...' : '开始编辑文章内容...',
                    scrollable: true,
                    autoFocus: false,
                    expands: true,
                    showCursor: true,
                    customStyles: _buildCustomStyles(context),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      error: (message, articleId) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => notifier.onRefresh(),
                icon: const Icon(Icons.refresh),
                label: const Text('重试'),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 处理副作用
  void _handleSideEffect(
    BuildContext context,
    ArticleEditorSideEffect effect,
    ArticleEditorNotifier notifier,
  ) {
    effect.when(
      showSaveSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('保存成功'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
        onSaved?.call();
      },
      showSaveError: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('保存失败: $message'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 3),
          ),
        );
      },
      showDiscardConfirmation: () {
        _showDiscardConfirmationDialog(context, notifier);
      },
      navigateBack: () {
        onCancelled?.call();
      },
      showLoadError: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('加载失败: $message'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 3),
          ),
        );
      },
    );
  }

  /// 显示丢弃确认对话框
  void _showDiscardConfirmationDialog(
    BuildContext context,
    ArticleEditorNotifier notifier,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('放弃更改？'),
        content: const Text('您有未保存的更改，确定要放弃吗？'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              notifier.onCancelDiscard();
            },
            child: const Text('继续编辑'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              notifier.onConfirmDiscard();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('放弃'),
          ),
        ],
      ),
    );
  }

  /// 构建自定义样式
  DefaultStyles _buildCustomStyles(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle = theme.textTheme.bodyLarge?.copyWith(
      height: 1.6,
    );

    return DefaultStyles(
      paragraph: DefaultTextBlockStyle(
        baseStyle ?? const TextStyle(),
        const HorizontalSpacing(0, 0),
        const VerticalSpacing(8, 8),
        const VerticalSpacing(0, 0),
        null,
      ),
      h1: DefaultTextBlockStyle(
        theme.textTheme.headlineLarge ?? const TextStyle(),
        const HorizontalSpacing(0, 0),
        const VerticalSpacing(16, 8),
        const VerticalSpacing(0, 0),
        null,
      ),
      h2: DefaultTextBlockStyle(
        theme.textTheme.headlineMedium ?? const TextStyle(),
        const HorizontalSpacing(0, 0),
        const VerticalSpacing(12, 6),
        const VerticalSpacing(0, 0),
        null,
      ),
      h3: DefaultTextBlockStyle(
        theme.textTheme.headlineSmall ?? const TextStyle(),
        const HorizontalSpacing(0, 0),
        const VerticalSpacing(8, 4),
        const VerticalSpacing(0, 0),
        null,
      ),
      quote: DefaultTextBlockStyle(
        baseStyle?.copyWith(
          fontStyle: FontStyle.italic,
          color: theme.colorScheme.onSurfaceVariant,
        ) ?? const TextStyle(),
        const HorizontalSpacing(16, 0),
        const VerticalSpacing(8, 8),
        const VerticalSpacing(0, 0),
        BoxDecoration(
          border: Border(
            left: BorderSide(
              color: theme.colorScheme.primary,
              width: 4,
            ),
          ),
        ),
      ),
      code: DefaultTextBlockStyle(
        TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const HorizontalSpacing(0, 0),
        const VerticalSpacing(8, 8),
        const VerticalSpacing(0, 0),
        BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      link: TextStyle(
        color: theme.colorScheme.primary,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
