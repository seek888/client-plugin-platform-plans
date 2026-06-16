import 'package:flutter/material.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

/// 订阅源健康状态指示器
/// Requirements: 16.2, 19.2, 19.3
class FeedHealthIndicator extends StatelessWidget {
  /// 订阅源
  final Feed feed;

  /// 图标大小
  final double iconSize;

  /// 是否显示文字提示
  final bool showLabel;

  const FeedHealthIndicator({
    super.key,
    required this.feed,
    this.iconSize = 16,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    if (feed.isHealthy) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (icon, color, label) = _getHealthInfo(colorScheme);

    if (showLabel) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
        ],
      );
    }

    return Tooltip(
      message: label,
      child: Icon(icon, size: iconSize, color: color),
    );
  }

  /// 获取健康状态信息
  (IconData, Color, String) _getHealthInfo(ColorScheme colorScheme) {
    if (feed.isInvalid) {
      return (Icons.error_outline, colorScheme.error, '订阅源无法访问');
    }

    if (feed.hasWarning) {
      // 检查是否是长期未更新
      if (feed.lastUpdated != null) {
        final daysSinceUpdate = DateTime.now()
            .difference(feed.lastUpdated!)
            .inDays;
        if (daysSinceUpdate > 30) {
          return (Icons.schedule, Colors.orange, '已超过30天未更新');
        }
      }
      return (Icons.warning_amber, Colors.orange, '订阅源可能存在问题');
    }

    return (Icons.check_circle_outline, colorScheme.primary, '正常');
  }
}

/// 订阅源健康状态徽章
/// 用于在订阅源图标上显示健康状态
class FeedHealthBadge extends StatelessWidget {
  /// 订阅源
  final Feed feed;

  /// 子组件（通常是订阅源图标）
  final Widget child;

  const FeedHealthBadge({super.key, required this.feed, required this.child});

  @override
  Widget build(BuildContext context) {
    if (feed.isHealthy) {
      return child;
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 如果订阅源失效，添加灰色遮罩
        if (feed.isInvalid)
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
            child: child,
          )
        else
          child,
        // 健康状态指示点
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: feed.isInvalid ? colorScheme.error : Colors.orange,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.surface, width: 2),
            ),
            child: Icon(
              feed.isInvalid ? Icons.close : Icons.warning,
              size: 8,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
