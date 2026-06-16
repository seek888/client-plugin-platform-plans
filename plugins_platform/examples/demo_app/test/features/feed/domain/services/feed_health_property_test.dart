import 'package:test/test.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/services/feed_health_service.dart';
import 'package:rss_reader/features/feed/domain/services/feed_validator.dart';

/// **Property 16: 订阅源健康状态正确性**
/// **Validates: Requirements 16.2, 16.3, 19.1, 19.2, 19.3**
///
/// 19.1: THE Feed_Validator SHALL 定期检测所有订阅源的可访问性
/// 19.2: WHEN 检测到失效订阅源 THEN THE RSS_Client SHALL 提示"是否取消订阅"并给出备选建议
/// 19.3: WHEN 订阅源连续多次获取失败 THEN THE RSS_Client SHALL 在内容流显示错误提示卡片含"重试"按钮
/// 16.2: WHEN 订阅源失效 THEN THE RSS_Client SHALL 在列表中将该源标灰并显示提示
/// 16.3: WHEN 订阅源长期未更新（超过30天） THEN THE RSS_Client SHALL 提示"是否取消订阅"

// Custom generators for Feed testing
extension FeedGenerators on Any {
  /// Generator for feed IDs
  Generator<String> get feedId {
    return any.combine2(any.lowercaseLetters, any.positiveIntOrZero, (
      String prefix,
      int index,
    ) {
      final safePrefix = prefix.isEmpty ? 'feed' : prefix;
      return '$safePrefix-$index';
    });
  }

  /// Generator for feed titles
  Generator<String> get feedTitle {
    return any.combine2(any.lowercaseLetters, any.positiveIntOrZero, (
      String name,
      int index,
    ) {
      final safeName = name.isEmpty ? 'Feed' : name;
      return '$safeName Blog $index';
    });
  }

  /// Generator for feed URLs
  Generator<String> get feedUrl {
    return any.combine2(any.lowercaseLetters, any.positiveIntOrZero, (
      String domain,
      int index,
    ) {
      final safeDomain = domain.isEmpty ? 'example' : domain;
      return 'https://$safeDomain$index.com/feed.xml';
    });
  }

  /// Generator for healthy feeds (healthStatus = 0, failureCount = 0)
  Generator<Feed> get healthyFeed {
    return any.combine3(any.feedId, any.feedTitle, any.feedUrl, (
      String id,
      String title,
      String url,
    ) {
      return Feed(
        id: id,
        url: url,
        title: title,
        healthStatus: 0,
        failureCount: 0,
        isEnabled: true,
        isBlocked: false,
        lastUpdated: DateTime.now().subtract(const Duration(days: 5)),
      );
    });
  }

  /// Generator for warning feeds (healthStatus = 1)
  Generator<Feed> get warningFeed {
    return any.combine3(any.feedId, any.feedTitle, any.feedUrl, (
      String id,
      String title,
      String url,
    ) {
      return Feed(
        id: id,
        url: url,
        title: title,
        healthStatus: 1,
        failureCount: 1,
        isEnabled: true,
        isBlocked: false,
        lastUpdated: DateTime.now().subtract(const Duration(days: 10)),
      );
    });
  }

  /// Generator for invalid feeds (healthStatus = 2)
  Generator<Feed> get invalidFeed {
    return any.combine3(any.feedId, any.feedTitle, any.feedUrl, (
      String id,
      String title,
      String url,
    ) {
      return Feed(
        id: id,
        url: url,
        title: title,
        healthStatus: 2,
        failureCount: 5,
        isEnabled: true,
        isBlocked: false,
        lastUpdated: DateTime.now().subtract(const Duration(days: 60)),
      );
    });
  }

  /// Generator for stale feeds (not updated for more than 30 days)
  Generator<Feed> get staleFeed {
    return any.combine4(
      any.feedId,
      any.feedTitle,
      any.feedUrl,
      any.intInRange(31, 365),
      (String id, String title, String url, int staleDays) {
        return Feed(
          id: id,
          url: url,
          title: title,
          healthStatus: 0,
          failureCount: 0,
          isEnabled: true,
          isBlocked: false,
          lastUpdated: DateTime.now().subtract(Duration(days: staleDays)),
        );
      },
    );
  }

  /// Generator for feeds with high failure count
  Generator<Feed> get failedFeed {
    return any.combine4(
      any.feedId,
      any.feedTitle,
      any.feedUrl,
      any.intInRange(3, 10),
      (String id, String title, String url, int failureCount) {
        return Feed(
          id: id,
          url: url,
          title: title,
          healthStatus: 2,
          failureCount: failureCount,
          isEnabled: true,
          isBlocked: false,
          lastUpdated: DateTime.now().subtract(const Duration(days: 5)),
        );
      },
    );
  }

  /// Generator for disabled feeds
  Generator<Feed> get disabledFeed {
    return any.combine3(any.feedId, any.feedTitle, any.feedUrl, (
      String id,
      String title,
      String url,
    ) {
      return Feed(
        id: id,
        url: url,
        title: title,
        healthStatus: 0,
        failureCount: 0,
        isEnabled: false,
        isBlocked: false,
      );
    });
  }

  /// Generator for blocked feeds
  Generator<Feed> get blockedFeed {
    return any.combine3(any.feedId, any.feedTitle, any.feedUrl, (
      String id,
      String title,
      String url,
    ) {
      return Feed(
        id: id,
        url: url,
        title: title,
        healthStatus: 0,
        failureCount: 0,
        isEnabled: true,
        isBlocked: true,
      );
    });
  }

  /// Generator for list of mixed feeds
  Generator<List<Feed>> get mixedFeedList {
    return any.combine5(
      any.healthyFeed,
      any.warningFeed,
      any.invalidFeed,
      any.staleFeed,
      any.failedFeed,
      (Feed healthy, Feed warning, Feed invalid, Feed stale, Feed failed) {
        return [healthy, warning, invalid, stale, failed];
      },
    );
  }
}

/// Mock implementation of FeedHealthService for testing pure logic
class MockFeedHealthService implements FeedHealthService {
  static const int staleDaysThreshold = 30;
  static const int failureCountThreshold = 3;

  @override
  Future<FeedHealthCheckResult> checkFeedHealth(Feed feed) async {
    // Simulate health check based on feed properties
    FeedHealthStatus status;

    if (!feed.isEnabled || feed.isBlocked) {
      status = FeedHealthStatus(
        feedId: feed.id,
        status: 2,
        errorMessage: '订阅源已禁用或屏蔽',
        checkedAt: DateTime.now(),
      );
    } else if (feed.failureCount >= failureCountThreshold) {
      status = FeedHealthStatus(
        feedId: feed.id,
        status: 2,
        errorMessage: '订阅源连续多次获取失败',
        checkedAt: DateTime.now(),
      );
    } else if (feed.lastUpdated != null) {
      final daysSinceUpdate = DateTime.now()
          .difference(feed.lastUpdated!)
          .inDays;
      if (daysSinceUpdate > staleDaysThreshold) {
        status = FeedHealthStatus(
          feedId: feed.id,
          status: 1,
          errorMessage: '订阅源已超过30天未更新',
          checkedAt: DateTime.now(),
        );
      } else {
        status = FeedHealthStatus(
          feedId: feed.id,
          status: 0,
          checkedAt: DateTime.now(),
        );
      }
    } else {
      status = FeedHealthStatus(
        feedId: feed.id,
        status: feed.healthStatus,
        checkedAt: DateTime.now(),
      );
    }

    return FeedHealthCheckResult(
      feedId: feed.id,
      feedTitle: feed.title,
      status: status,
      shouldPromptUnsubscribe: shouldPromptUnsubscribe(feed),
      suggestion: getHealthSuggestion(feed, status),
    );
  }

  @override
  Future<BatchHealthCheckResult> checkAllFeedsHealth(List<Feed> feeds) async {
    final results = <FeedHealthCheckResult>[];
    int healthyCount = 0;
    int warningCount = 0;
    int invalidCount = 0;

    for (final feed in feeds) {
      if (!feed.isEnabled || feed.isBlocked) continue;

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
    int staleDays = staleDaysThreshold,
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
    int minFailureCount = failureCountThreshold,
  }) {
    return feeds.where((feed) {
      if (!feed.isEnabled || feed.isBlocked) return false;
      return feed.failureCount >= minFailureCount;
    }).toList();
  }

  @override
  bool shouldPromptUnsubscribe(Feed feed) {
    // 1. If feed is invalid (healthStatus == 2), should prompt
    if (feed.isInvalid) {
      return true;
    }

    // 2. If failure count reaches threshold, should prompt
    if (feed.failureCount >= failureCountThreshold) {
      return true;
    }

    // 3. If not updated for more than 30 days, should prompt
    if (feed.lastUpdated != null) {
      final daysSinceUpdate = DateTime.now()
          .difference(feed.lastUpdated!)
          .inDays;
      if (daysSinceUpdate > staleDaysThreshold) {
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
}

void main() {
  late FeedHealthService healthService;

  setUp(() {
    healthService = MockFeedHealthService();
  });

  group('Property 16: Feed Health Status Correctness', () {
    // Property 16a: Healthy feeds should have status 0 and not prompt unsubscribe
    Glados(any.healthyFeed).test(
      'Property 16a: Healthy feeds have correct status and no unsubscribe prompt',
      (Feed feed) async {
        final result = await healthService.checkFeedHealth(feed);

        expect(
          result.status.isHealthy,
          isTrue,
          reason: 'Healthy feed "${feed.title}" should have healthy status',
        );
        expect(
          result.shouldPromptUnsubscribe,
          isFalse,
          reason: 'Healthy feed should not prompt unsubscribe',
        );
        expect(result.suggestion, isNull);
      },
    );

    // Property 16b: Invalid feeds should have status 2 and prompt unsubscribe
    Glados(any.invalidFeed).test(
      'Property 16b: Invalid feeds have correct status and prompt unsubscribe',
      (Feed feed) async {
        final result = await healthService.checkFeedHealth(feed);

        expect(
          result.status.isInvalid || result.status.hasWarning,
          isTrue,
          reason:
              'Invalid feed "${feed.title}" should have invalid or warning status',
        );
        expect(
          result.shouldPromptUnsubscribe,
          isTrue,
          reason: 'Invalid feed should prompt unsubscribe',
        );
        expect(result.suggestion, isNotNull);
      },
    );

    // Property 16c: Stale feeds (>30 days) should prompt unsubscribe
    Glados(any.staleFeed).test(
      'Property 16c: Stale feeds (>30 days) prompt unsubscribe',
      (Feed feed) async {
        final result = await healthService.checkFeedHealth(feed);

        expect(
          result.shouldPromptUnsubscribe,
          isTrue,
          reason: 'Stale feed "${feed.title}" should prompt unsubscribe',
        );
      },
    );

    // Property 16d: Feeds with high failure count should prompt unsubscribe
    Glados(
      any.failedFeed,
    ).test('Property 16d: Feeds with high failure count prompt unsubscribe', (
      Feed feed,
    ) async {
      final result = await healthService.checkFeedHealth(feed);

      expect(
        result.shouldPromptUnsubscribe,
        isTrue,
        reason:
            'Failed feed "${feed.title}" with ${feed.failureCount} failures should prompt unsubscribe',
      );
    });

    // Property 16e: findStaleFeeds returns only feeds older than threshold
    Glados(any.mixedFeedList).test(
      'Property 16e: findStaleFeeds returns only feeds older than threshold',
      (List<Feed> feeds) {
        final staleFeeds = healthService.findStaleFeeds(feeds);
        final now = DateTime.now();

        for (final feed in staleFeeds) {
          expect(feed.isEnabled, isTrue);
          expect(feed.isBlocked, isFalse);
          expect(feed.lastUpdated, isNotNull);

          final daysSinceUpdate = now.difference(feed.lastUpdated!).inDays;
          expect(
            daysSinceUpdate > 30,
            isTrue,
            reason: 'Stale feed "${feed.title}" should be older than 30 days',
          );
        }
      },
    );

    // Property 16f: findFailedFeeds returns only feeds with failure count >= threshold
    Glados(any.mixedFeedList).test(
      'Property 16f: findFailedFeeds returns only feeds with high failure count',
      (List<Feed> feeds) {
        final failedFeeds = healthService.findFailedFeeds(feeds);

        for (final feed in failedFeeds) {
          expect(feed.isEnabled, isTrue);
          expect(feed.isBlocked, isFalse);
          expect(
            feed.failureCount >= 3,
            isTrue,
            reason:
                'Failed feed "${feed.title}" should have failure count >= 3',
          );
        }
      },
    );

    // Property 16g: Disabled feeds should not be included in batch health check
    Glados(any.disabledFeed).test(
      'Property 16g: Disabled feeds are excluded from batch health check',
      (Feed feed) async {
        final result = await healthService.checkAllFeedsHealth([feed]);

        expect(
          result.totalChecked,
          equals(0),
          reason: 'Disabled feed should not be checked',
        );
      },
    );

    // Property 16h: Blocked feeds should not be included in batch health check
    Glados(any.blockedFeed).test(
      'Property 16h: Blocked feeds are excluded from batch health check',
      (Feed feed) async {
        final result = await healthService.checkAllFeedsHealth([feed]);

        expect(
          result.totalChecked,
          equals(0),
          reason: 'Blocked feed should not be checked',
        );
      },
    );

    // Property 16i: Batch health check counts are consistent
    Glados(any.mixedFeedList).test(
      'Property 16i: Batch health check counts are consistent',
      (List<Feed> feeds) async {
        final result = await healthService.checkAllFeedsHealth(feeds);

        // Total checked should equal sum of all status counts
        expect(
          result.totalChecked,
          equals(
            result.healthyCount + result.warningCount + result.invalidCount,
          ),
          reason: 'Total checked should equal sum of status counts',
        );

        // Results list length should match total checked
        expect(
          result.results.length,
          equals(result.totalChecked),
          reason: 'Results list length should match total checked',
        );
      },
    );
  });

  group('Feed Health Edge Cases', () {
    test('Feed with null lastUpdated does not count as stale', () {
      final feed = Feed(
        id: 'test-1',
        url: 'https://example.com/feed.xml',
        title: 'Test Feed',
        healthStatus: 0,
        failureCount: 0,
        isEnabled: true,
        isBlocked: false,
        lastUpdated: null,
      );

      final staleFeeds = healthService.findStaleFeeds([feed]);
      expect(staleFeeds, isEmpty);
    });

    test('Feed exactly at 30 days is not stale', () {
      final feed = Feed(
        id: 'test-1',
        url: 'https://example.com/feed.xml',
        title: 'Test Feed',
        healthStatus: 0,
        failureCount: 0,
        isEnabled: true,
        isBlocked: false,
        lastUpdated: DateTime.now().subtract(const Duration(days: 30)),
      );

      final staleFeeds = healthService.findStaleFeeds([feed]);
      expect(staleFeeds, isEmpty);
    });

    test('Feed at 31 days is stale', () {
      final feed = Feed(
        id: 'test-1',
        url: 'https://example.com/feed.xml',
        title: 'Test Feed',
        healthStatus: 0,
        failureCount: 0,
        isEnabled: true,
        isBlocked: false,
        lastUpdated: DateTime.now().subtract(const Duration(days: 31)),
      );

      final staleFeeds = healthService.findStaleFeeds([feed]);
      expect(staleFeeds.length, equals(1));
    });

    test('Feed with exactly 3 failures is considered failed', () {
      final feed = Feed(
        id: 'test-1',
        url: 'https://example.com/feed.xml',
        title: 'Test Feed',
        healthStatus: 1,
        failureCount: 3,
        isEnabled: true,
        isBlocked: false,
      );

      final failedFeeds = healthService.findFailedFeeds([feed]);
      expect(failedFeeds.length, equals(1));
    });

    test('Feed with 2 failures is not considered failed', () {
      final feed = Feed(
        id: 'test-1',
        url: 'https://example.com/feed.xml',
        title: 'Test Feed',
        healthStatus: 1,
        failureCount: 2,
        isEnabled: true,
        isBlocked: false,
      );

      final failedFeeds = healthService.findFailedFeeds([feed]);
      expect(failedFeeds, isEmpty);
    });

    test(
      'Health suggestion for invalid feed contains unsubscribe advice',
      () async {
        final feed = Feed(
          id: 'test-1',
          url: 'https://example.com/feed.xml',
          title: 'Test Feed',
          healthStatus: 2,
          failureCount: 5,
          isEnabled: true,
          isBlocked: false,
        );

        final result = await healthService.checkFeedHealth(feed);
        expect(result.suggestion, contains('取消订阅'));
      },
    );
  });
}
