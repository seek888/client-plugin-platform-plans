import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/features/article/presentation/notifiers/article_editor_notifier.dart';
import 'package:rss_reader/features/article/presentation/side_effects/article_editor_side_effect.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_editor_widget.dart';

/// 文章编辑器页面
class ArticleEditorPage extends HookConsumerWidget {
  final String articleId;

  const ArticleEditorPage({
    super.key,
    required this.articleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(articleEditorNotifierProvider(articleId).notifier);

    // 监听副作用
    useEffect(() {
      // 使用 StreamSubscription 监听副作用
      StreamSubscription<ArticleEditorSideEffect>? sideEffectSubscription;

      Future.microtask(() async {
        try {
          sideEffectSubscription = notifier.sideEffect.listen((effect) {
            if (context.mounted) {
              _handleSideEffect(context, effect, notifier);
            }
          });
        } catch (_) {
          // 忽略错误
        }
      });

      return () {
        sideEffectSubscription?.cancel();
      };
    }, [articleId]);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          notifier.onBack();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ArticleEditorWidget(
            articleId: articleId,
          ),
        ),
      ),
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
        if (context.mounted) {
          context.pop();
        }
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
      builder: (context) => AlertDialog(
        title: const Text('放弃更改？'),
        content: const Text('您有未保存的更改，确定要放弃吗？'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              notifier.onCancelDiscard();
            },
            child: const Text('继续编辑'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
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
}
