import 'package:flutter/material.dart';
import 'package:rss_reader/features/feed/domain/services/feed_health_service.dart';

/// 订阅源健康状态对话框
/// Requirements: 19.2 - 检测到失效订阅源时提示"是否取消订阅"
class FeedHealthDialog extends StatelessWidget {
  /// 健康检测结果
  final FeedHealthCheckResult result;

  /// 取消订阅回调
  final VoidCallback onUnsubscribe;

  /// 继续订阅回调
  final VoidCallback onKeep;

  /// 重试回调
  final VoidCallback? onRetry;

  const FeedHealthDialog({
    super.key,
    required this.result,
    required this.onUnsubscribe,
    required this.onKeep,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (icon, title, message) = _getDialogContent();

    return AlertDialog(
      icon: Icon(
        icon,
        size: 48,
        color: result.status.isInvalid ? colorScheme.error : Colors.orange,
      ),
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          if (result.suggestion != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      result.suggestion!,
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        if (onRetry != null)
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              onRetry!();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('重试'),
          ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onKeep();
          },
          child: const Text('继续订阅'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            onUnsubscribe();
          },
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
          ),
          child: const Text('取消订阅'),
        ),
      ],
    );
  }

  /// 获取对话框内容
  (IconData, String, String) _getDialogContent() {
    if (result.status.isInvalid) {
      return (Icons.link_off, '订阅源已失效', '"${result.feedTitle}" 无法访问，是否取消订阅？');
    }

    if (result.status.hasWarning) {
      if (result.status.errorMessage?.contains('30天') == true ||
          result.status.errorMessage?.contains('未更新') == true) {
        return (
          Icons.schedule,
          '订阅源长期未更新',
          '"${result.feedTitle}" 已超过30天未更新，是否继续订阅？',
        );
      }
      return (
        Icons.warning_amber,
        '订阅源可能存在问题',
        '"${result.feedTitle}" 获取失败，是否继续订阅？',
      );
    }

    return (Icons.info_outline, '订阅源状态', '"${result.feedTitle}" 状态正常。');
  }

  /// 显示健康状态对话框
  static Future<void> show({
    required BuildContext context,
    required FeedHealthCheckResult result,
    required VoidCallback onUnsubscribe,
    required VoidCallback onKeep,
    VoidCallback? onRetry,
  }) {
    return showDialog(
      context: context,
      builder: (context) => FeedHealthDialog(
        result: result,
        onUnsubscribe: onUnsubscribe,
        onKeep: onKeep,
        onRetry: onRetry,
      ),
    );
  }
}

/// 批量健康检测结果对话框
class BatchHealthCheckDialog extends StatelessWidget {
  /// 批量检测结果
  final BatchHealthCheckResult result;

  /// 查看详情回调
  final VoidCallback? onViewDetails;

  /// 关闭回调
  final VoidCallback onClose;

  const BatchHealthCheckDialog({
    super.key,
    required this.result,
    this.onViewDetails,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      icon: Icon(_getIcon(), size: 48, color: _getIconColor(colorScheme)),
      title: const Text('健康检测完成'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStatRow(
            context,
            Icons.check_circle,
            '正常',
            result.healthyCount,
            colorScheme.primary,
          ),
          const SizedBox(height: 8),
          _buildStatRow(
            context,
            Icons.warning_amber,
            '警告',
            result.warningCount,
            Colors.orange,
          ),
          const SizedBox(height: 8),
          _buildStatRow(
            context,
            Icons.error_outline,
            '失效',
            result.invalidCount,
            colorScheme.error,
          ),
          if (result.feedsToPromptUnsubscribe.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: colorScheme.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '有 ${result.feedsToPromptUnsubscribe.length} 个订阅源建议取消订阅',
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        if (onViewDetails != null && result.feedsToPromptUnsubscribe.isNotEmpty)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onViewDetails!();
            },
            child: const Text('查看详情'),
          ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            onClose();
          },
          child: const Text('确定'),
        ),
      ],
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    IconData icon,
    String label,
    int count,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text(label),
        const Spacer(),
        Text(
          count.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  IconData _getIcon() {
    if (result.invalidCount > 0) {
      return Icons.error_outline;
    }
    if (result.warningCount > 0) {
      return Icons.warning_amber;
    }
    return Icons.check_circle;
  }

  Color _getIconColor(ColorScheme colorScheme) {
    if (result.invalidCount > 0) {
      return colorScheme.error;
    }
    if (result.warningCount > 0) {
      return Colors.orange;
    }
    return colorScheme.primary;
  }

  /// 显示批量健康检测结果对话框
  static Future<void> show({
    required BuildContext context,
    required BatchHealthCheckResult result,
    VoidCallback? onViewDetails,
    required VoidCallback onClose,
  }) {
    return showDialog(
      context: context,
      builder: (context) => BatchHealthCheckDialog(
        result: result,
        onViewDetails: onViewDetails,
        onClose: onClose,
      ),
    );
  }
}
