import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/presentation/notifiers/feed_management_notifier.dart';
import 'package:rss_reader/features/feed/presentation/side_effects/feed_management_side_effect.dart';
import 'package:rss_reader/features/feed/presentation/states/feed_management_state.dart';
import 'package:rss_reader/features/feed/presentation/widgets/add_feed_dialog.dart';

/// 订阅源管理页面
class FeedManagementPage extends HookConsumerWidget {
  const FeedManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(feedManagementNotifierProvider);
    final notifier = ref.read(feedManagementNotifierProvider.notifier);

    // 处理副作用
    useEffect(() {
      final stream = notifier.sideEffect;
      final subscription = stream.listen((sideEffect) {
        _handleSideEffect(context, ref, sideEffect);
      });
      return subscription.cancel;
    }, []);

    return Scaffold(
      appBar: _buildAppBar(context, state, notifier),
      body: state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (
          feeds,
          categories,
          isSelectionMode,
          selectedFeedIds,
          isImporting,
          isExporting,
          isValidating,
          validationState,
          isDragging,
          selectedSourceType,
        ) {
          if (feeds.isEmpty) {
            return _buildEmptyState(context, notifier);
          }
          return _buildFeedList(
            context,
            feeds,
            categories,
            isSelectionMode,
            selectedFeedIds,
            notifier,
          );
        },
        error: (message) => _buildErrorState(context, message, ref),
      ),
      floatingActionButton: state.maybeMap(
        loaded: (s) => s.isSelectionMode
            ? null
            : FloatingActionButton(
                onPressed: notifier.onShowAddFeedDialog,
                tooltip: '添加订阅源',
                child: const Icon(Icons.add),
              ),
        orElse: () => null,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    FeedManagementState state,
    FeedManagementNotifier notifier,
  ) {
    return state.maybeMap(
      loaded: (s) {
        if (s.isSelectionMode) {
          return AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: notifier.onExitSelectionMode,
            ),
            title: Text('已选择 ${s.selectedFeedIds.length} 项'),
            actions: [
              IconButton(
                icon: Icon(
                  s.selectedFeedIds.length == s.feeds.length
                      ? Icons.deselect
                      : Icons.select_all,
                ),
                tooltip:
                    s.selectedFeedIds.length == s.feeds.length ? '取消全选' : '全选',
                onPressed: notifier.onToggleSelectAll,
              ),
              if (s.selectedFeedIds.isNotEmpty) ...[
                IconButton(
                  icon: const Icon(Icons.folder_outlined),
                  tooltip: '移动到分类',
                  onPressed: notifier.onBatchMoveToCategory,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: '删除',
                  onPressed: notifier.onBatchDelete,
                ),
              ],
            ],
          );
        }
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
          title: const Text('订阅源管理'),
          actions: [
            // OPML 导入
            IconButton(
              icon: s.isImporting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.file_download_outlined),
              tooltip: '导入 OPML',
              onPressed: s.isImporting ? null : notifier.onShowImportPicker,
            ),
            // OPML 导出
            IconButton(
              icon: s.isExporting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.file_upload_outlined),
              tooltip: '导出 OPML',
              onPressed: s.isExporting || s.feeds.isEmpty
                  ? null
                  : notifier.onShowExportSaver,
            ),
            // 批量选择
            IconButton(
              icon: const Icon(Icons.checklist),
              tooltip: '批量操作',
              onPressed: s.feeds.isEmpty ? null : notifier.onEnterSelectionMode,
            ),
            // 更多菜单
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'create_category':
                    notifier.onShowCreateCategoryDialog();
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'create_category',
                  child: ListTile(
                    leading: Icon(Icons.create_new_folder_outlined),
                    title: Text('新建分类'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        );
      },
      orElse: () => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('订阅源管理'),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    FeedManagementNotifier notifier,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rss_feed,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无订阅源',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '点击右下角按钮添加订阅源\n或导入 OPML 文件',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: notifier.onShowImportPicker,
                icon: const Icon(Icons.file_download_outlined),
                label: const Text('导入 OPML'),
              ),
              const SizedBox(width: 16),
              FilledButton.icon(
                onPressed: notifier.onShowAddFeedDialog,
                icon: const Icon(Icons.add),
                label: const Text('添加订阅源'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => ref.invalidate(feedManagementNotifierProvider),
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedList(
    BuildContext context,
    List<Feed> feeds,
    List<FeedCategory> categories,
    bool isSelectionMode,
    List<String> selectedFeedIds,
    FeedManagementNotifier notifier,
  ) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      buildDefaultDragHandles: !isSelectionMode,
      onReorder: notifier.onReorderFeeds,
      onReorderStart: (_) => notifier.onDragStart(),
      onReorderEnd: (_) => notifier.onDragEnd(),
      itemCount: feeds.length,
      itemBuilder: (context, index) {
        final feed = feeds[index];
        final category =
            categories.where((c) => c.id == feed.categoryId).firstOrNull;

        return _FeedManagementItem(
          key: ValueKey(feed.id),
          feed: feed,
          category: category,
          isSelectionMode: isSelectionMode,
          isSelected: selectedFeedIds.contains(feed.id),
          onTap: isSelectionMode
              ? () => notifier.onToggleFeedSelection(feed.id)
              : null,
          onDelete: () => notifier.onDeleteFeed(feed.id),
          onMoveToCategory: () => notifier.onMoveFeedToCategory(feed.id),
        );
      },
    );
  }

  void _handleSideEffect(
    BuildContext context,
    WidgetRef ref,
    FeedManagementSideEffect sideEffect,
  ) {
    final notifier = ref.read(feedManagementNotifierProvider.notifier);

    sideEffect.when(
      showToast: (message, isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor:
                isError ? Theme.of(context).colorScheme.error : null,
          ),
        );
      },
      navigateBack: () {
        // 使用 go_router 的方式返回，更安全
        context.go('/');
      },
      showConfirmDialog: (title, message, onConfirm, onCancel) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onCancel?.call();
                },
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onConfirm();
                },
                child: const Text('确定'),
              ),
            ],
          ),
        );
      },
      showAddFeedDialog: () {
        showDialog(
          context: context,
          builder: (context) => const AddFeedDialog(),
        );
      },
      showCategoryPicker: (feedIds) {
        _showCategoryPicker(context, ref, feedIds);
      },
      showCreateCategoryDialog: () {
        _showCreateCategoryDialog(context, notifier);
      },
      openFilePicker: () async {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['opml', 'xml'],
        );
        if (result != null && result.files.single.path != null) {
          final file = File(result.files.single.path!);
          notifier.onImportOPML(file);
        }
      },
      openFileSaver: (suggestedFileName) async {
        String? outputPath;
        if (PlatformUtils.isDesktop) {
          outputPath = await FilePicker.platform.saveFile(
            dialogTitle: '导出 OPML',
            fileName: suggestedFileName,
            type: FileType.custom,
            allowedExtensions: ['opml'],
          );
        } else {
          // 移动端使用默认路径
          final directory = await FilePicker.platform.getDirectoryPath();
          if (directory != null) {
            outputPath = '$directory/$suggestedFileName';
          }
        }
        if (outputPath != null) {
          notifier.onExportOPML(outputPath);
        }
      },
      importCompleted: (importedCount, failedCount) {
        String message;
        if (failedCount > 0) {
          message = '导入完成：$importedCount 成功，$failedCount 失败';
        } else {
          message = '已导入 $importedCount 个订阅源';
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      },
      exportCompleted: (filePath) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('已导出到: $filePath'),
            action: SnackBarAction(label: '确定', onPressed: () {}),
          ),
        );
      },
      closeAddFeedDialog: () {
        // 不再通过 side effect 关闭对话框
        // 对话框已由用户操作直接关闭
      },
    );
  }

  void _showCategoryPicker(
    BuildContext context,
    WidgetRef ref,
    List<String> feedIds,
  ) {
    final state = ref.read(feedManagementNotifierProvider);
    final notifier = ref.read(feedManagementNotifierProvider.notifier);

    final categories = state.maybeMap(
      loaded: (s) => s.categories,
      orElse: () => <FeedCategory>[],
    );

    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.folder_off_outlined),
              title: const Text('无分类'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                if (feedIds.length == 1) {
                  notifier.onExecuteMoveFeedToCategory(feedIds.first, null);
                } else {
                  notifier.onExecuteBatchMoveToCategory(null);
                }
              },
            ),
            const Divider(height: 1),
            ...categories.map(
              (category) => ListTile(
                leading: const Icon(Icons.folder_outlined),
                title: Text(category.name),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  if (feedIds.length == 1) {
                    notifier.onExecuteMoveFeedToCategory(
                      feedIds.first,
                      category.id,
                    );
                  } else {
                    notifier.onExecuteBatchMoveToCategory(category.id);
                  }
                },
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.create_new_folder_outlined),
              title: const Text('新建分类'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _showCreateCategoryDialog(context, notifier);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateCategoryDialog(
    BuildContext context,
    FeedManagementNotifier notifier,
  ) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('新建分类'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: '分类名称',
            hintText: '请输入分类名称',
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              Navigator.of(dialogContext).pop();
              notifier.onCreateCategory(value.trim());
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                Navigator.of(dialogContext).pop();
                notifier.onCreateCategory(name);
              }
            },
            child: const Text('创建'),
          ),
        ],
      ),
    );
  }
}

/// 订阅源管理列表项
class _FeedManagementItem extends StatelessWidget {
  final Feed feed;
  final FeedCategory? category;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback onDelete;
  final VoidCallback onMoveToCategory;

  const _FeedManagementItem({
    super.key,
    required this.feed,
    this.category,
    required this.isSelectionMode,
    required this.isSelected,
    this.onTap,
    required this.onDelete,
    required this.onMoveToCategory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: isSelected
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
          : null,
      child: ListTile(
        leading: isSelectionMode
            ? Checkbox(value: isSelected, onChanged: (_) => onTap?.call())
            : _buildFeedIcon(context),
        title: Row(
          children: [
            Expanded(
              child: Text(
                feed.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // 数据源类型标识
            if (feed.sourceType == SourceType.api)
              Container(
                margin: const EdgeInsets.only(left: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.api,
                      size: 12,
                      color: theme.colorScheme.onTertiaryContainer,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'API',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onTertiaryContainer,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feed.url,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            if (category != null)
              Row(
                children: [
                  Icon(
                    Icons.folder_outlined,
                    size: 14,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    category!.name,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
          ],
        ),
        trailing: isSelectionMode
            ? const Icon(Icons.drag_handle)
            : _buildTrailingActions(context),
        onTap: onTap,
        isThreeLine: category != null,
      ),
    );
  }

  Widget _buildFeedIcon(BuildContext context) {
    final theme = Theme.of(context);

    if (feed.iconUrl != null && feed.iconUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          feed.iconUrl!,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildDefaultIcon(theme),
        ),
      );
    }
    return _buildDefaultIcon(theme);
  }

  Widget _buildDefaultIcon(ThemeData theme) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          feed.title.isNotEmpty ? feed.title[0].toUpperCase() : 'R',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }

  Widget _buildTrailingActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 未读数
        if (feed.unreadCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${feed.unreadCount}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
        // 健康状态指示
        if (!feed.isHealthy)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              feed.isInvalid ? Icons.error_outline : Icons.warning_amber,
              size: 20,
              color: feed.isInvalid
                  ? Theme.of(context).colorScheme.error
                  : Colors.orange,
            ),
          ),
        // 更多操作
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'move':
                onMoveToCategory();
                break;
              case 'delete':
                onDelete();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'move',
              child: ListTile(
                leading: Icon(Icons.folder_outlined),
                title: Text('移动到分类'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete_outline, color: Colors.red),
                title: Text('取消订阅', style: TextStyle(color: Colors.red)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
