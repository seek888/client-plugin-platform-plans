import 'package:flutter/material.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/presentation/widgets/feed_health_indicator.dart';

/// 订阅源列表项组件
class FeedItem extends StatelessWidget {
  /// 订阅源数据
  final Feed feed;

  /// 是否选中
  final bool isSelected;

  /// 点击回调
  final VoidCallback onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  const FeedItem({
    super.key,
    required this.feed,
    this.isSelected = false,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: _buildIcon(colorScheme),
      title: Row(
        children: [
          Expanded(
            child: Text(
              feed.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: feed.isInvalid ? colorScheme.outline : null),
            ),
          ),
          // 数据源类型标识
          if (feed.sourceType == SourceType.api)
            Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'API',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onTertiaryContainer,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
      subtitle: feed.description != null
          ? Text(
              feed.description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: _buildTrailing(colorScheme),
      selected: isSelected,
      selectedTileColor: colorScheme.secondaryContainer.withValues(alpha: 0.5),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  /// 构建图标
  Widget _buildIcon(ColorScheme colorScheme) {
    final iconWidget = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: feed.isInvalid
            ? colorScheme.surfaceContainerHighest
            : colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: feed.iconUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                feed.iconUrl!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildDefaultIcon(colorScheme),
              ),
            )
          : _buildDefaultIcon(colorScheme),
    );

    // 如果订阅源不健康，使用健康状态徽章包装
    if (!feed.isHealthy) {
      return FeedHealthBadge(feed: feed, child: iconWidget);
    }

    return iconWidget;
  }

  /// 构建默认图标
  Widget _buildDefaultIcon(ColorScheme colorScheme) {
    return Icon(
      Icons.rss_feed,
      color: feed.isInvalid
          ? colorScheme.outline
          : colorScheme.onSecondaryContainer,
    );
  }

  /// 构建尾部组件
  Widget? _buildTrailing(ColorScheme colorScheme) {
    final widgets = <Widget>[];

    // 健康状态指示器（使用新组件）
    if (!feed.isHealthy) {
      widgets.add(FeedHealthIndicator(feed: feed));
    }

    // 未读数角标
    if (feed.unreadCount > 0) {
      widgets.add(
        Badge(
          label: Text(
            feed.unreadCount > 99 ? '99+' : feed.unreadCount.toString(),
          ),
        ),
      );
    }

    if (widgets.isEmpty) return null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widgets
          .map(
            (w) => Padding(padding: const EdgeInsets.only(left: 4), child: w),
          )
          .toList(),
    );
  }
}
