import 'package:flutter/material.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

/// 订阅源错误提示卡片
/// Requirements: 19.3 - 订阅源连续多次获取失败时显示错误提示卡片含"重试"按钮
class FeedErrorCard extends StatelessWidget {
  /// 订阅源
  final Feed feed;

  /// 重试回调
  final VoidCallback onRetry;

  /// 取消订阅回调
  final VoidCallback? onUnsubscribe;

  /// 关闭回调
  final VoidCallback? onDismiss;

  const FeedErrorCard({
    super.key,
    required this.feed,
    required this.onRetry,
    this.onUnsubscribe,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline, color: colorScheme.onErrorContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '订阅源获取失败',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onErrorContainer,
                    ),
                  ),
                ),
                if (onDismiss != null)
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onErrorContainer,
                    ),
                    onPressed: onDismiss,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '无法获取 "${feed.title}" 的内容',
              style: TextStyle(color: colorScheme.onErrorContainer),
            ),
            if (feed.failureCount > 0) ...[
              const SizedBox(height: 4),
              Text(
                '已连续失败 ${feed.failureCount} 次',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onErrorContainer.withValues(alpha: 0.7),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onUnsubscribe != null)
                  TextButton(
                    onPressed: onUnsubscribe,
                    child: Text(
                      '取消订阅',
                      style: TextStyle(color: colorScheme.onErrorContainer),
                    ),
                  ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('重试'),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 订阅源长期未更新提示卡片
/// Requirements: 16.3 - 订阅源长期未更新（超过30天）时提示"是否取消订阅"
class FeedStaleCard extends StatelessWidget {
  /// 订阅源
  final Feed feed;

  /// 继续订阅回调
  final VoidCallback onKeep;

  /// 取消订阅回调
  final VoidCallback onUnsubscribe;

  /// 关闭回调
  final VoidCallback? onDismiss;

  const FeedStaleCard({
    super.key,
    required this.feed,
    required this.onKeep,
    required this.onUnsubscribe,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final daysSinceUpdate = feed.lastUpdated != null
        ? DateTime.now().difference(feed.lastUpdated!).inDays
        : 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.schedule, color: colorScheme.onTertiaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '订阅源长期未更新',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                ),
                if (onDismiss != null)
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onTertiaryContainer,
                    ),
                    onPressed: onDismiss,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '"${feed.title}" 已超过 $daysSinceUpdate 天未更新',
              style: TextStyle(color: colorScheme.onTertiaryContainer),
            ),
            const SizedBox(height: 4),
            Text(
              '是否继续订阅？',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onTertiaryContainer.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onUnsubscribe,
                  child: Text(
                    '取消订阅',
                    style: TextStyle(color: colorScheme.onTertiaryContainer),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: onKeep,
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.tertiary,
                    foregroundColor: colorScheme.onTertiary,
                  ),
                  child: const Text('继续订阅'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 订阅源失效提示卡片
/// Requirements: 19.2 - 检测到失效订阅源时提示"是否取消订阅"并给出备选建议
class FeedInvalidCard extends StatelessWidget {
  /// 订阅源
  final Feed feed;

  /// 重试回调
  final VoidCallback onRetry;

  /// 取消订阅回调
  final VoidCallback onUnsubscribe;

  /// 关闭回调
  final VoidCallback? onDismiss;

  const FeedInvalidCard({
    super.key,
    required this.feed,
    required this.onRetry,
    required this.onUnsubscribe,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.link_off, color: colorScheme.onErrorContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '订阅源已失效',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onErrorContainer,
                    ),
                  ),
                ),
                if (onDismiss != null)
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onErrorContainer,
                    ),
                    onPressed: onDismiss,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '"${feed.title}" 无法访问',
              style: TextStyle(color: colorScheme.onErrorContainer),
            ),
            const SizedBox(height: 4),
            Text(
              '建议取消订阅或检查 URL 是否正确',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onErrorContainer.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 8),
            // 显示 URL 供用户检查
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                feed.url,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: colorScheme.onErrorContainer,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('重试'),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.onErrorContainer,
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: onUnsubscribe,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('取消订阅'),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
