import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/presentation/notifiers/feed_management_notifier.dart';
import 'package:rss_reader/features/feed/presentation/states/feed_management_state.dart';

/// 添加订阅源对话框
class AddFeedDialog extends HookConsumerWidget {
  const AddFeedDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(feedManagementNotifierProvider);
    final notifier = ref.read(feedManagementNotifierProvider.notifier);

    // 获取当前选择的数据源类型
    final selectedSourceType = state.maybeMap(
      loaded: (s) => s.selectedSourceType,
      orElse: () => SourceType.rss,
    );

    return AlertDialog(
      title: const Text('添加订阅源'),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 数据源类型选择
              _SourceTypeSelector(
                selectedType: selectedSourceType,
                onChanged: notifier.onChangeSourceType,
              ),
              const SizedBox(height: 16),
              // 根据类型显示不同的表单
              if (selectedSourceType == SourceType.rss)
                _RssSourceForm(state: state, notifier: notifier)
              else
                _ApiSourceForm(state: state, notifier: notifier),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            notifier.onClearValidation();
            Navigator.pop(context);
          },
          child: const Text('取消'),
        ),
      ],
    );
  }
}

/// 数据源类型选择器
class _SourceTypeSelector extends StatelessWidget {
  final SourceType selectedType;
  final ValueChanged<SourceType> onChanged;

  const _SourceTypeSelector({
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SourceType>(
      segments: const [
        ButtonSegment(
          value: SourceType.rss,
          label: Text('RSS 订阅'),
          icon: Icon(Icons.rss_feed),
        ),
        ButtonSegment(
          value: SourceType.api,
          label: Text('API 数据源'),
          icon: Icon(Icons.api),
        ),
      ],
      selected: {selectedType},
      onSelectionChanged: (selected) => onChanged(selected.first),
    );
  }
}

/// RSS 订阅源表单
class _RssSourceForm extends HookWidget {
  final FeedManagementState state;
  final FeedManagementNotifier notifier;

  const _RssSourceForm({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final urlController = useTextEditingController();
    final debounceTimer = useRef<Timer?>(null);

    final validationState = state.maybeMap(
      loaded: (s) => s.validationState,
      orElse: () => null,
    );

    final isValidating = state.maybeMap(
      loaded: (s) => s.isValidating,
      orElse: () => false,
    );

    useEffect(() {
      return () => debounceTimer.value?.cancel();
    }, []);

    void onUrlChanged(String url) {
      debounceTimer.value?.cancel();
      if (url.trim().isEmpty) {
        notifier.onClearValidation();
        return;
      }
      debounceTimer.value = Timer(const Duration(milliseconds: 800), () {
        notifier.onValidateFeedUrl(url.trim());
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: urlController,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'RSS URL',
            hintText: '请输入 RSS 订阅源地址',
            prefixIcon: const Icon(Icons.link),
            suffixIcon: isValidating
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : urlController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          urlController.clear();
                          notifier.onClearValidation();
                        },
                      )
                    : null,
            errorText: validationState?.maybeMap(
              failure: (s) => s.errorMessage,
              orElse: () => null,
            ),
          ),
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          onChanged: onUrlChanged,
          onSubmitted: (url) {
            if (url.trim().isNotEmpty &&
                _canAdd(validationState, isValidating)) {
              Navigator.pop(context);
              notifier.onAddFeedWithoutClose(url.trim());
            }
          },
        ),
        const SizedBox(height: 16),
        _buildValidationStatus(context, validationState, isValidating),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: _canAdd(validationState, isValidating)
              ? () {
                  final url = urlController.text.trim();
                  if (url.isNotEmpty) {
                    Navigator.pop(context);
                    notifier.onAddFeedWithoutClose(url);
                  }
                }
              : null,
          child: const Text('添加'),
        ),
      ],
    );
  }

  bool _canAdd(FeedValidationState? validationState, bool isValidating) {
    if (isValidating) return false;
    return validationState?.maybeMap(
          success: (_) => true,
          orElse: () => false,
        ) ??
        false;
  }

  Widget _buildValidationStatus(
    BuildContext context,
    FeedValidationState? validationState,
    bool isValidating,
  ) {
    if (validationState == null && !isValidating) {
      return _buildHintCard(context, '输入 RSS/Atom 订阅源地址，系统将自动验证');
    }

    return validationState?.when(
          validating: () => _buildValidatingCard(context),
          success: (title, description, iconUrl, articleCount, _) =>
              _buildSuccessCard(
                  context, title, description, iconUrl, articleCount),
          failure: (errorMessage) => _buildFailureCard(context, errorMessage),
        ) ??
        _buildHintCard(context, '输入 RSS/Atom 订阅源地址，系统将自动验证');
  }
}

/// API 数据源表单
class _ApiSourceForm extends HookWidget {
  final FeedManagementState state;
  final FeedManagementNotifier notifier;

  const _ApiSourceForm({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final baseUrlController = useTextEditingController();
    final apiKeyController = useTextEditingController();
    final remoteFeedIdController = useTextEditingController();
    final debounceTimer = useRef<Timer?>(null);

    final validationState = state.maybeMap(
      loaded: (s) => s.validationState,
      orElse: () => null,
    );

    final isValidating = state.maybeMap(
      loaded: (s) => s.isValidating,
      orElse: () => false,
    );

    useEffect(() {
      return () => debounceTimer.value?.cancel();
    }, []);

    void onBaseUrlChanged(String url) {
      debounceTimer.value?.cancel();
      if (url.trim().isEmpty) {
        notifier.onClearValidation();
        return;
      }
      debounceTimer.value = Timer(const Duration(milliseconds: 1000), () {
        notifier.onValidateApiSource(
          baseUrl: url.trim(),
          apiKey: apiKeyController.text.trim().isEmpty
              ? null
              : apiKeyController.text.trim(),
          remoteFeedId: remoteFeedIdController.text.trim().isEmpty
              ? null
              : remoteFeedIdController.text.trim(),
        );
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: '数据源名称 *',
            hintText: '请输入数据源名称',
            prefixIcon: Icon(Icons.label_outline),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: baseUrlController,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'API 地址 *',
            hintText: 'https://api.example.com',
            prefixIcon: const Icon(Icons.link),
            suffixIcon: isValidating
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
            errorText: validationState?.maybeMap(
              failure: (s) => s.errorMessage,
              orElse: () => null,
            ),
          ),
          keyboardType: TextInputType.url,
          onChanged: onBaseUrlChanged,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: apiKeyController,
          decoration: const InputDecoration(
            labelText: 'API 密钥',
            hintText: '可选，用于认证',
            prefixIcon: Icon(Icons.key),
          ),
          obscureText: true,
          onChanged: (_) {
            if (baseUrlController.text.trim().isNotEmpty) {
              onBaseUrlChanged(baseUrlController.text);
            }
          },
        ),
        const SizedBox(height: 12),
        TextField(
          controller: remoteFeedIdController,
          decoration: const InputDecoration(
            labelText: '远程 Feed ID',
            hintText: '可选，指定远程数据源 ID',
            prefixIcon: Icon(Icons.tag),
          ),
          onChanged: (_) {
            if (baseUrlController.text.trim().isNotEmpty) {
              onBaseUrlChanged(baseUrlController.text);
            }
          },
        ),
        const SizedBox(height: 16),
        _buildValidationStatus(context, validationState, isValidating),
        const SizedBox(height: 16),
        FilledButton(
          onPressed:
              _canAdd(titleController.text, validationState, isValidating)
                  ? () {
                      Navigator.pop(context);
                      notifier.onAddApiFeed(
                        title: titleController.text.trim(),
                        baseUrl: baseUrlController.text.trim(),
                        apiKey: apiKeyController.text.trim().isEmpty
                            ? null
                            : apiKeyController.text.trim(),
                        remoteFeedId: remoteFeedIdController.text.trim().isEmpty
                            ? null
                            : remoteFeedIdController.text.trim(),
                      );
                    }
                  : null,
          child: const Text('添加'),
        ),
      ],
    );
  }

  bool _canAdd(
      String title, FeedValidationState? validationState, bool isValidating) {
    if (title.trim().isEmpty) return false;
    if (isValidating) return false;
    return validationState?.maybeMap(
          success: (_) => true,
          orElse: () => false,
        ) ??
        false;
  }

  Widget _buildValidationStatus(
    BuildContext context,
    FeedValidationState? validationState,
    bool isValidating,
  ) {
    if (validationState == null && !isValidating) {
      return _buildHintCard(context, '输入 API 地址，系统将自动验证连接');
    }

    return validationState?.when(
          validating: () => _buildValidatingCard(context),
          success: (title, description, iconUrl, _, __) =>
              _buildApiSuccessCard(context, title, description),
          failure: (errorMessage) => _buildFailureCard(context, errorMessage),
        ) ??
        _buildHintCard(context, '输入 API 地址，系统将自动验证连接');
  }

  Widget _buildApiSuccessCard(
    BuildContext context,
    String title,
    String? description,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 20, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '连接成功',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (description != null && description.isNotEmpty)
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 共享组件
// ============================================================================

Widget _buildHintCard(BuildContext context, String hint) {
  final theme = Theme.of(context);
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 20, color: theme.colorScheme.outline),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            hint,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildValidatingCard(BuildContext context) {
  final theme = Theme.of(context);
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '正在验证...',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSuccessCard(
  BuildContext context,
  String title,
  String? description,
  String? iconUrl,
  int articleCount,
) {
  final theme = Theme.of(context);
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.green.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (iconUrl != null && iconUrl.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              iconUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildDefaultIcon(theme, title),
            ),
          )
        else
          _buildDefaultIcon(theme, title),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    '验证成功',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: theme.textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (description != null && description.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 4),
              Text(
                '包含 $articleCount 篇文章',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDefaultIcon(ThemeData theme, String title) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: theme.colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Center(
      child: Text(
        title.isNotEmpty ? title[0].toUpperCase() : 'R',
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    ),
  );
}

Widget _buildFailureCard(BuildContext context, String errorMessage) {
  final theme = Theme.of(context);
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, size: 20, color: theme.colorScheme.error),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            errorMessage,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ),
      ],
    ),
  );
}
