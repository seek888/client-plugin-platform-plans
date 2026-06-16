import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

/// 移动端横向订阅源栏
/// 用于在移动端顶部显示订阅源快捷切换
/// Requirements: 22.1, 22.2, 22.3, 22.4, 2.3, 2.4
class MobileFeedBar extends StatefulWidget {
  /// 订阅源列表
  final List<Feed> feeds;

  /// 分类列表
  final List<FeedCategory> categories;

  /// 当前选中的订阅源 ID
  final String? selectedFeedId;

  /// 总未读数
  final int totalUnreadCount;

  /// 订阅源选择回调
  final ValueChanged<String?> onFeedSelected;

  /// 分类展开/折叠回调
  final ValueChanged<String>? onCategoryToggle;

  /// 长按订阅源回调
  final ValueChanged<Feed>? onFeedLongPress;

  /// 长按分类回调
  final ValueChanged<FeedCategory>? onCategoryLongPress;

  const MobileFeedBar({
    super.key,
    required this.feeds,
    required this.categories,
    this.selectedFeedId,
    this.totalUnreadCount = 0,
    required this.onFeedSelected,
    this.onCategoryToggle,
    this.onFeedLongPress,
    this.onCategoryLongPress,
  });

  @override
  State<MobileFeedBar> createState() => _MobileFeedBarState();
}

class _MobileFeedBarState extends State<MobileFeedBar> {
  late ScrollController _scrollController;
  final double _itemWidth = 100.0; // Approximate width of each item

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Build the list of items to display
    final items = _buildItemList();

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
      ),
      // Requirements 22.2: 订阅源超过8个支持左右滑动浏览
      // Requirements 22.3: 快速滑动自动吸附到最近的订阅源
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          _snapToNearestItem();
          return true;
        },
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
        ),
      ),
    );
  }

  /// Build the list of items including "All", categories, and feeds
  List<Widget> _buildItemList() {
    final items = <Widget>[];

    // Requirements 22.1: 横向栏首项固定显示"全部"选项
    items.add(
      _FeedChip(
        label: '全部',
        unreadCount: widget.totalUnreadCount,
        isSelected: widget.selectedFeedId == null,
        onTap: () {
          HapticFeedback.selectionClick();
          widget.onFeedSelected(null);
        },
        isAllItem: true,
      ),
    );

    // Group feeds by category
    final uncategorizedFeeds = widget.feeds
        .where((f) => f.categoryId == null)
        .toList();
    final categorizedFeeds = <String, List<Feed>>{};

    for (final category in widget.categories) {
      categorizedFeeds[category.id] = widget.feeds
          .where((f) => f.categoryId == category.id)
          .toList();
    }

    // Add uncategorized feeds first
    for (final feed in uncategorizedFeeds) {
      items.add(
        _FeedChip(
          label: feed.title,
          iconUrl: feed.iconUrl,
          unreadCount: feed.unreadCount,
          isSelected: widget.selectedFeedId == feed.id,
          isInvalid: feed.isInvalid,
          hasWarning: feed.hasWarning,
          onTap: () {
            HapticFeedback.selectionClick();
            widget.onFeedSelected(feed.id);
          },
          onLongPress: widget.onFeedLongPress != null
              ? () {
                  HapticFeedback.mediumImpact();
                  widget.onFeedLongPress!(feed);
                }
              : null,
        ),
      );
    }

    // Add categories with their feeds
    // Requirements 2.3, 2.4: 分类文件夹展开/折叠
    for (final category in widget.categories) {
      final categoryFeeds = categorizedFeeds[category.id] ?? [];
      if (categoryFeeds.isEmpty) continue;

      final categoryUnread = categoryFeeds.fold(
        0,
        (sum, f) => sum + f.unreadCount,
      );

      // Add category folder chip
      items.add(
        _CategoryChip(
          category: category,
          unreadCount: categoryUnread,
          isExpanded: category.isExpanded,
          onTap: () {
            HapticFeedback.selectionClick();
            widget.onCategoryToggle?.call(category.id);
          },
          onLongPress: widget.onCategoryLongPress != null
              ? () {
                  HapticFeedback.mediumImpact();
                  widget.onCategoryLongPress!(category);
                }
              : null,
        ),
      );

      // Add feeds in category if expanded
      if (category.isExpanded) {
        for (final feed in categoryFeeds) {
          items.add(
            _FeedChip(
              label: feed.title,
              iconUrl: feed.iconUrl,
              unreadCount: feed.unreadCount,
              isSelected: widget.selectedFeedId == feed.id,
              isInvalid: feed.isInvalid,
              hasWarning: feed.hasWarning,
              isInCategory: true,
              onTap: () {
                HapticFeedback.selectionClick();
                widget.onFeedSelected(feed.id);
              },
              onLongPress: widget.onFeedLongPress != null
                  ? () {
                      HapticFeedback.mediumImpact();
                      widget.onFeedLongPress!(feed);
                    }
                  : null,
            ),
          );
        }
      }
    }

    return items;
  }

  /// Snap to the nearest item after scrolling ends
  /// Requirements 22.3: 快速滑动自动吸附到最近的订阅源避免停留在空白处
  void _snapToNearestItem() {
    if (!_scrollController.hasClients) return;

    final currentOffset = _scrollController.offset;
    final nearestItemIndex = (currentOffset / _itemWidth).round();
    final targetOffset = nearestItemIndex * _itemWidth;

    // Only snap if we're not already at the target
    if ((currentOffset - targetOffset).abs() > 1) {
      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }
}

/// 订阅源芯片组件
class _FeedChip extends StatelessWidget {
  final String label;
  final String? iconUrl;
  final int unreadCount;
  final bool isSelected;
  final bool isInvalid;
  final bool hasWarning;
  final bool isAllItem;
  final bool isInCategory;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _FeedChip({
    required this.label,
    this.iconUrl,
    this.unreadCount = 0,
    this.isSelected = false,
    this.isInvalid = false,
    this.hasWarning = false,
    this.isAllItem = false,
    this.isInCategory = false,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: isInCategory ? 2 : 4,
        right: 4,
        top: 8,
        bottom: 8,
      ),
      child: GestureDetector(
        onLongPress: onLongPress,
        child: FilterChip(
          avatar: _buildAvatar(colorScheme),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning indicator
              if (hasWarning && !isInvalid)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.warning_amber,
                    size: 14,
                    color: Colors.orange,
                  ),
                ),
              // Error indicator
              if (isInvalid)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.error_outline,
                    size: 14,
                    color: colorScheme.error,
                  ),
                ),
              // Label
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 80),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isInvalid ? colorScheme.outline : null,
                    fontSize: 13,
                  ),
                ),
              ),
              // Unread badge
              if (unreadCount > 0) ...[
                const SizedBox(width: 4),
                _UnreadBadge(count: unreadCount, isSelected: isSelected),
              ],
            ],
          ),
          // Requirements 22.4: 点击订阅源标蓝高亮选中项
          selected: isSelected,
          onSelected: (_) => onTap(),
          showCheckmark: false,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }

  Widget? _buildAvatar(ColorScheme colorScheme) {
    if (isAllItem) {
      return CircleAvatar(
        radius: 12,
        backgroundColor: colorScheme.primaryContainer,
        child: Icon(
          Icons.all_inbox,
          size: 14,
          color: colorScheme.onPrimaryContainer,
        ),
      );
    }

    if (iconUrl != null) {
      return CircleAvatar(
        radius: 12,
        backgroundImage: NetworkImage(iconUrl!),
        onBackgroundImageError: (_, __) {},
      );
    }

    return CircleAvatar(
      radius: 12,
      backgroundColor: isInvalid
          ? colorScheme.surfaceContainerHighest
          : colorScheme.secondaryContainer,
      child: Icon(
        Icons.rss_feed,
        size: 14,
        color: isInvalid
            ? colorScheme.outline
            : colorScheme.onSecondaryContainer,
      ),
    );
  }
}

/// 分类文件夹芯片组件
/// Requirements 2.3, 2.4: 分类文件夹展开/折叠
class _CategoryChip extends StatelessWidget {
  final FeedCategory category;
  final int unreadCount;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _CategoryChip({
    required this.category,
    this.unreadCount = 0,
    this.isExpanded = false,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: GestureDetector(
        onLongPress: onLongPress,
        child: ActionChip(
          avatar: CircleAvatar(
            radius: 12,
            backgroundColor: colorScheme.tertiaryContainer,
            child: Icon(
              isExpanded ? Icons.folder_open : Icons.folder,
              size: 14,
              color: colorScheme.onTertiaryContainer,
            ),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 60),
                child: Text(
                  category.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(width: 2),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              if (unreadCount > 0) ...[
                const SizedBox(width: 4),
                _UnreadBadge(count: unreadCount, isSelected: false),
              ],
            ],
          ),
          onPressed: onTap,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}

/// 未读数角标组件
class _UnreadBadge extends StatelessWidget {
  final int count;
  final bool isSelected;

  const _UnreadBadge({required this.count, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: isSelected ? colorScheme.primary : colorScheme.onPrimary,
        ),
      ),
    );
  }
}
