import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/services/feed_validator.dart';

/// 订阅源健康检测结果
class FeedHealthCheckResult {
  final String feedId;
  final String feedTitle;
  final FeedHealthStatus status;
  final bool shouldPromptUnsubscribe;
  final String? suggestion;

  const FeedHealthCheckResult({
    required this.feedId,
    required this.feedTitle,
    required this.status,
    this.shouldPromptUnsubscribe = false,
    this.suggestion,
  });
}

/// 批量健康检测结果
class BatchHealthCheckResult {
  final int totalChecked;
  final int healthyCount;
  final int warningCount;
  final int invalidCount;
  final List<FeedHealthCheckResult> results;
  final DateTime checkedAt;

  const BatchHealthCheckResult({
    required this.totalChecked,
    required this.healthyCount,
    required this.warningCount,
    required this.invalidCount,
    required this.results,
    required this.checkedAt,
  });

  /// 获取需要提示取消订阅的订阅源
  List<FeedHealthCheckResult> get feedsToPromptUnsubscribe =>
      results.where((r) => r.shouldPromptUnsubscribe).toList();

  /// 获取失效的订阅源
  List<FeedHealthCheckResult> get invalidFeeds =>
      results.where((r) => r.status.isInvalid).toList();

  /// 获取有警告的订阅源
  List<FeedHealthCheckResult> get warningFeeds =>
      results.where((r) => r.status.hasWarning).toList();
}

/// 订阅源健康检测服务接口
abstract class FeedHealthService {
  /// 检测单个订阅源健康状态
  Future<FeedHealthCheckResult> checkFeedHealth(Feed feed);

  /// 批量检测所有订阅源健康状态
  Future<BatchHealthCheckResult> checkAllFeedsHealth(List<Feed> feeds);

  /// 检测长期未更新的订阅源（超过指定天数）
  List<Feed> findStaleFeeds(List<Feed> feeds, {int staleDays = 30});

  /// 检测连续失败的订阅源
  List<Feed> findFailedFeeds(List<Feed> feeds, {int minFailureCount = 3});

  /// 判断是否应该提示用户取消订阅
  bool shouldPromptUnsubscribe(Feed feed);

  /// 获取订阅源健康建议
  String? getHealthSuggestion(Feed feed, FeedHealthStatus status);
}
