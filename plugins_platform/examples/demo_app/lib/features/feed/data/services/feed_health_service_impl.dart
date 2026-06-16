import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/services/feed_health_service.dart';
import 'package:rss_reader/features/feed/domain/services/feed_validator.dart';

/// 订阅源健康检测服务实现
class FeedHealthServiceImpl implements FeedHealthService {
  final FeedValidator _feedValidator;
  final FeedDao _feedDao;

  /// 长期未更新的天数阈值
  static const int _staleDaysThreshold = 30;

  /// 连续失败次数阈值
  static const int _failureCountThreshold = 3;

  FeedHealthServiceImpl({
    required FeedValidator feedValidator,
    required FeedDao feedDao,
  }) : _feedValidator = feedValidator,
       _feedDao = feedDao;

  @override
  Future<FeedHealthCheckResult> checkFeedHealth(Feed feed) async {
    // 使用 FeedValidator 检测健康状态
    final status = await _feedValidator.checkHealth(feed);

    // 更新数据库中的健康状态
    await _updateFeedHealthStatus(feed, status);

    // 判断是否应该提示取消订阅
    final shouldPrompt = shouldPromptUnsubscribe(
      feed.copyWith(
        healthStatus: status.status,
        failureCount: status.isHealthy ? 0 : feed.failureCount + 1,
      ),
    );

    // 获取健康建议
    final suggestion = getHealthSuggestion(feed, status);

    return FeedHealthCheckResult(
      feedId: feed.id,
      feedTitle: feed.title,
      status: status,
      shouldPromptUnsubscribe: shouldPrompt,
      suggestion: suggestion,
    );
  }

  @override
  Future<BatchHealthCheckResult> checkAllFeedsHealth(List<Feed> feeds) async {
    final results = <FeedHealthCheckResult>[];
    int healthyCount = 0;
    int warningCount = 0;
    int invalidCount = 0;

    for (final feed in feeds) {
      // 跳过已禁用或已屏蔽的订阅源
      if (!feed.isEnabled || feed.isBlocked) {
        continue;
      }

      final result = await checkFeedHealth(feed);
      results.add(result);

      if (result.status.isHealthy) {
        healthyCount++;
      } else if (result.status.hasWarning) {
        warningCount++;
      } else if (result.status.isInvalid) {
        invalidCount++;
      }
    }

    return BatchHealthCheckResult(
      totalChecked: results.length,
      healthyCount: healthyCount,
      warningCount: warningCount,
      invalidCount: invalidCount,
      results: results,
      checkedAt: DateTime.now(),
    );
  }

  @override
  List<Feed> findStaleFeeds(
    List<Feed> feeds, {
    int staleDays = _staleDaysThreshold,
  }) {
    final now = DateTime.now();
    return feeds.where((feed) {
      if (!feed.isEnabled || feed.isBlocked) return false;
      if (feed.lastUpdated == null) return false;

      final daysSinceUpdate = now.difference(feed.lastUpdated!).inDays;
      return daysSinceUpdate > staleDays;
    }).toList();
  }

  @override
  List<Feed> findFailedFeeds(
    List<Feed> feeds, {
    int minFailureCount = _failureCountThreshold,
  }) {
    return feeds.where((feed) {
      if (!feed.isEnabled || feed.isBlocked) return false;
      return feed.failureCount >= minFailureCount;
    }).toList();
  }

  @override
  bool shouldPromptUnsubscribe(Feed feed) {
    // 1. 如果订阅源已失效（healthStatus == 2），应该提示
    if (feed.isInvalid) {
      return true;
    }

    // 2. 如果连续失败次数达到阈值，应该提示
    if (feed.failureCount >= _failureCountThreshold) {
      return true;
    }

    // 3. 如果长期未更新（超过30天），应该提示
    if (feed.lastUpdated != null) {
      final daysSinceUpdate = DateTime.now()
          .difference(feed.lastUpdated!)
          .inDays;
      if (daysSinceUpdate > _staleDaysThreshold) {
        return true;
      }
    }

    return false;
  }

  @override
  String? getHealthSuggestion(Feed feed, FeedHealthStatus status) {
    if (status.isHealthy) {
      return null;
    }

    if (status.isInvalid) {
      return '该订阅源无法访问，建议取消订阅或检查 URL 是否正确';
    }

    if (status.hasWarning) {
      if (status.errorMessage?.contains('30天') == true ||
          status.errorMessage?.contains('未更新') == true) {
        return '该订阅源已超过30天未更新，是否继续订阅？';
      }
      return '该订阅源可能存在问题，建议稍后重试';
    }

    return status.errorMessage;
  }

  /// 更新订阅源健康状态到数据库
  Future<void> _updateFeedHealthStatus(
    Feed feed,
    FeedHealthStatus status,
  ) async {
    final newFailureCount = status.isHealthy ? 0 : feed.failureCount + 1;
    await _feedDao.updateHealthStatus(feed.id, status.status, newFailureCount);
  }
}
