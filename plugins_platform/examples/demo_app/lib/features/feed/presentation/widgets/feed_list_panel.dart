import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/presentation/widgets/feed_item.dart';
import 'package:rss_reader/shared/widgets/common/offline_aware_button.dart';

/// 订阅源列表面板
/// 用于中间面板显示订阅源列表（桌面端和移动端共用）
/// Requirements: 22.1, 22.2, 22.3, 22.4
class FeedListPanel extends HookConsumerWidget {
  /// 订阅源列表
  final List<Feed> feeds;

  /// 分类列表
  final List<FeedCategory> categories;

  /// 当前选中的订阅源 ID
  final String? selectedFeedId;

  /// 是否正在刷新
  final bool isRefreshing;

  /// 总未读数
  final int totalUnreadCount;

  /// 订阅源选择回调
  final ValueChanged<String?> onFeedSelected;

  /// 刷新回调
  final VoidCallback onRefresh;

  /// 添加订阅源回调
  final VoidCallback onAddFeed;

  /// 搜索按钮点击回调
  final VoidCallback onSearchPressed;

  /// 长按订阅源回调（用于显示操作菜单）
  final ValueChanged<Feed>? onFeedLongPress;

  /// 长按分类回调（用于显示操作菜单）
  final ValueChanged<FeedCategory>? onCategoryLongPress;

  const FeedListPanel({
    super.key,
    required this.feeds,
    required this.categories,
    this.selectedFeedId,
    this.isRefreshing = false,
    this.totalUnreadCount = 0,
    required this.onFeedSelected,
    required this.onRefresh,
    required this.onAddFeed,
    required this.onSearchPressed,
    this.onFeedLongPress,
    this.onCategoryLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // 搜索栏和添加按钮
        _buildSearchBar(context, colorScheme, ref),
        const Divider(height: 1),
        // 订阅源列表
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => onRefresh(),
            child: _buildFeedList(context, colorScheme),
          ),
        ),
      ],
    );
  }

  /// 构建搜索栏
  Widget _buildSearchBar(
    BuildContext context,
    ColorScheme colorScheme,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onSearchPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '搜索订阅源和文章',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // 添加订阅源按钮 - 离线时禁用
          OfflineAwareIconButton(
            onPressed: onAddFeed,
            icon: const Icon(Icons.add),
            tooltip: '添加订阅源',
            offlineTooltip: '离线模式下无法添加订阅源',
          ),
        ],
      ),
    );
  }

  /// 构建订阅源列表
  Widget _buildFeedList(BuildContext context, ColorScheme colorScheme) {
    if (feeds.isEmpty) {
      return _buildEmptyState(context, colorScheme);
    }

    // 按分类组织订阅源
    final uncategorizedFeeds = feeds
        .where((f) => f.categoryId == null)
        .toList();
    final categorizedFeeds = <String, List<Feed>>{};

    for (final category in categories) {
      categorizedFeeds[category.id] = feeds
          .where((f) => f.categoryId == category.id)
          .toList();
    }

    return ListView(
      children: [
        // "全部" 选项 - Requirements 22.1: 首项固定显示"全部"选项
        _AllFeedsItem(
          totalUnreadCount: totalUnreadCount,
          isSelected: selectedFeedId == null,
          onTap: () => onFeedSelected(null),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),

        // 未分类的订阅源
        ...uncategorizedFeeds.map(
          (feed) => FeedItem(
            feed: feed,
            isSelected: selectedFeedId == feed.id,
            onTap: () => onFeedSelected(feed.id),
            onLongPress: onFeedLongPress != null
                ? () => onFeedLongPress!(feed)
                : null,
          ),
        ),

        // 分类及其订阅源（支持展开/折叠）
        ...categories.map((category) {
          final categoryFeeds = categorizedFeeds[category.id] ?? [];
          if (categoryFeeds.isEmpty) return const SizedBox.shrink();

          return _CategorySection(
            category: category,
            feeds: categoryFeeds,
            selectedFeedId: selectedFeedId,
            onFeedSelected: onFeedSelected,
            onFeedLongPress: onFeedLongPress,
            onCategoryLongPress: onCategoryLongPress,
          );
        }),
      ],
    );
  }

  /// 构建空状态
  Widget _buildEmptyState(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.rss_feed, size: 64, color: colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            '还没有订阅源',
            style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            '点击右上角添加你的第一个订阅源',
            style: TextStyle(color: colorScheme.outline, fontSize: 14),
          ),
          const SizedBox(height: 24),
          // 添加订阅源按钮 - 离线时禁用
          OfflineAwareButton(
            onPressed: onAddFeed,
            offlineTooltip: '离线模式下无法添加订阅源',
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add), SizedBox(width: 8), Text('添加订阅源')],
            ),
          ),
        ],
      ),
    );
  }
}

/// "全部" 订阅源选项
/// Requirements 22.1: 横向栏首项固定显示"全部"选项
class _AllFeedsItem extends StatelessWidget {
  final int totalUnreadCount;
  final bool isSelected;
  final VoidCallback onTap;

  const _AllFeedsItem({
    required this.totalUnreadCount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.all_inbox, color: colorScheme.onPrimaryContainer),
      ),
      title: const Text('全部'),
      trailing: totalUnreadCount > 0
          ? Badge(
              label: Text(
                totalUnreadCount > 99 ? '99+' : totalUnreadCount.toString(),
              ),
            )
          : null,
      selected: isSelected,
      // Requirements 22.4: 点击订阅源标蓝高亮选中项
      selectedTileColor: colorScheme.secondaryContainer.withValues(alpha: 0.5),
      onTap: onTap,
    );
  }
}

/// 分类区块
/// Requirements 2.3, 2.4: 分类文件夹展开/折叠
class _CategorySection extends StatelessWidget {
  final FeedCategory category;
  final List<Feed> feeds;
  final String? selectedFeedId;
  final ValueChanged<String?> onFeedSelected;
  final ValueChanged<Feed>? onFeedLongPress;
  final ValueChanged<FeedCategory>? onCategoryLongPress;

  const _CategorySection({
    required this.category,
    required this.feeds,
    this.selectedFeedId,
    required this.onFeedSelected,
    this.onFeedLongPress,
    this.onCategoryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final totalUnread = feeds.fold(0, (sum, f) => sum + f.unreadCount);

    return GestureDetector(
      onLongPress: onCategoryLongPress != null
          ? () => onCategoryLongPress!(category)
          : null,
      child: ExpansionTile(
        leading: Icon(
          category.isExpanded ? Icons.folder_open : Icons.folder,
          color: colorScheme.primary,
        ),
        title: Text(category.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (totalUnread > 0)
              Badge(
                label: Text(totalUnread > 99 ? '99+' : totalUnread.toString()),
              ),
            const SizedBox(width: 8),
            const Icon(Icons.expand_more),
          ],
        ),
        initiallyExpanded: category.isExpanded,
        children: feeds
            .map(
              (feed) => Padding(
                padding: const EdgeInsets.only(left: 16),
                child: FeedItem(
                  feed: feed,
                  isSelected: selectedFeedId == feed.id,
                  onTap: () => onFeedSelected(feed.id),
                  onLongPress: onFeedLongPress != null
                      ? () => onFeedLongPress!(feed)
                      : null,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
