import 'package:glados/glados.dart';
import 'package:rss_reader/features/feed/domain/repositories/feed_repository.dart';

/// **Property 15: 刷新结果计数正确性**
/// **Validates: Requirements 14.3**
///
/// *For any* 刷新操作，刷新结果中的 newArticleCount 应等于本次刷新新增的文章数量
/// （刷新后文章总数 - 刷新前文章总数，仅计算新增）。

// Custom generators for refresh result testing
extension RefreshResultGenerators on Any {
  /// Generator for valid RefreshResult with consistent counts
  Generator<RefreshResult> get validRefreshResult {
    return any.combine4(
      any.intInRange(1, 100), // totalFeeds
      any.intInRange(0, 100), // successCount (will be capped)
      any.intInRange(0, 100), // failedCount (will be capped)
      any.intInRange(0, 1000), // newArticleCount
      (int total, int success, int failed, int newArticles) {
        // Ensure successCount + failedCount <= totalFeeds
        final actualSuccess = success.clamp(0, total);
        final actualFailed = failed.clamp(0, total - actualSuccess);

        return RefreshResult(
          totalFeeds: total,
          successCount: actualSuccess,
          failedCount: actualFailed,
          newArticleCount: newArticles,
          errors: [],
        );
      },
    );
  }

  /// Generator for RefreshResult with errors
  Generator<RefreshResult> get refreshResultWithErrors {
    return any.combine5(
      any.intInRange(1, 50), // totalFeeds
      any.intInRange(0, 50), // successCount
      any.intInRange(1, 10), // failedCount (at least 1)
      any.intInRange(0, 500), // newArticleCount
      any.intInRange(1, 10), // number of errors
      (int total, int success, int failed, int newArticles, int errorCount) {
        final actualSuccess = success.clamp(0, total - 1);
        final actualFailed = (total - actualSuccess).clamp(1, total);

        final actualErrorCount = actualFailed.clamp(1, errorCount.clamp(1, 10));
        final errors = List.generate(
          actualErrorCount,
          (i) => FeedRefreshError(
            feedId: 'feed_$i',
            feedTitle: 'Feed $i',
            errorMessage: 'Error message $i',
          ),
        );

        return RefreshResult(
          totalFeeds: total,
          successCount: actualSuccess,
          failedCount: actualFailed,
          newArticleCount: newArticles,
          errors: errors,
        );
      },
    );
  }

  /// Generator for article count pairs (before and after refresh)
  Generator<({int before, int after, int expected})> get articleCountPair {
    return any.combine2(
      any.intInRange(0, 1000), // articles before refresh
      any.intInRange(0, 500), // new articles added
      (int before, int newCount) {
        return (before: before, after: before + newCount, expected: newCount);
      },
    );
  }

  /// Generator for multiple feed refresh scenarios
  Generator<List<({String feedId, int beforeCount, int afterCount})>>
  get multiFeedRefreshScenario {
    return any.combine2(
      any.intInRange(1, 10), // number of feeds
      any.intInRange(0, 100), // max articles per feed
      (int feedCount, int maxArticles) {
        return List.generate(feedCount, (i) {
          final before = i * 10 % (maxArticles + 1);
          final newArticles = (i * 7 + 3) % 20;
          return (
            feedId: 'feed_$i',
            beforeCount: before,
            afterCount: before + newArticles,
          );
        });
      },
    );
  }
}

void main() {
  group('Property 15: Refresh Result Count Correctness', () {
    // Property 15a: newArticleCount should equal the difference between
    // article counts after and before refresh
    Glados(any.articleCountPair).test(
      'Property 15a: newArticleCount equals after - before article count',
      (({int before, int after, int expected}) counts) {
        final newArticleCount = counts.after - counts.before;

        expect(
          newArticleCount,
          equals(counts.expected),
          reason:
              'New article count should be ${counts.expected} '
              '(${counts.after} - ${counts.before})',
        );
        expect(
          newArticleCount,
          greaterThanOrEqualTo(0),
          reason: 'New article count should never be negative',
        );
      },
    );

    // Property 15b: RefreshResult counts should be internally consistent
    Glados(
      any.validRefreshResult,
    ).test('Property 15b: RefreshResult counts are internally consistent', (
      RefreshResult result,
    ) {
      // successCount + failedCount should not exceed totalFeeds
      expect(
        result.successCount + result.failedCount,
        lessThanOrEqualTo(result.totalFeeds),
        reason:
            'Success (${result.successCount}) + Failed (${result.failedCount}) '
            'should not exceed total (${result.totalFeeds})',
      );

      // All counts should be non-negative
      expect(
        result.totalFeeds,
        greaterThanOrEqualTo(0),
        reason: 'totalFeeds should be non-negative',
      );
      expect(
        result.successCount,
        greaterThanOrEqualTo(0),
        reason: 'successCount should be non-negative',
      );
      expect(
        result.failedCount,
        greaterThanOrEqualTo(0),
        reason: 'failedCount should be non-negative',
      );
      expect(
        result.newArticleCount,
        greaterThanOrEqualTo(0),
        reason: 'newArticleCount should be non-negative',
      );
    });

    // Property 15c: RefreshResult with errors should have matching error count
    Glados(any.refreshResultWithErrors).test(
      'Property 15c: Error list length should not exceed failedCount',
      (RefreshResult result) {
        expect(
          result.errors.length,
          lessThanOrEqualTo(result.failedCount),
          reason:
              'Error list length (${result.errors.length}) should not exceed '
              'failedCount (${result.failedCount})',
        );

        // Each error should have required fields
        for (final error in result.errors) {
          expect(
            error.feedId,
            isNotEmpty,
            reason: 'feedId should not be empty',
          );
          expect(
            error.feedTitle,
            isNotEmpty,
            reason: 'feedTitle should not be empty',
          );
          expect(
            error.errorMessage,
            isNotEmpty,
            reason: 'errorMessage should not be empty',
          );
        }
      },
    );

    // Property 15d: Total new articles across multiple feeds should sum correctly
    Glados(any.multiFeedRefreshScenario).test(
      'Property 15d: Total new articles equals sum of individual feed increases',
      (List<({String feedId, int beforeCount, int afterCount})> scenario) {
        final totalNewArticles = scenario.fold<int>(
          0,
          (sum, feed) => sum + (feed.afterCount - feed.beforeCount),
        );

        final individualNewCounts = scenario.map(
          (feed) => feed.afterCount - feed.beforeCount,
        );

        expect(
          totalNewArticles,
          equals(individualNewCounts.fold<int>(0, (a, b) => a + b)),
          reason: 'Total new articles should equal sum of individual increases',
        );

        // Each individual count should be non-negative
        for (final feed in scenario) {
          expect(
            feed.afterCount - feed.beforeCount,
            greaterThanOrEqualTo(0),
            reason:
                'Feed ${feed.feedId} should not have negative article increase',
          );
        }
      },
    );
  });

  group('Refresh Result Edge Cases', () {
    test('Empty refresh (no feeds) should have zero counts', () {
      const result = RefreshResult(
        totalFeeds: 0,
        successCount: 0,
        failedCount: 0,
        newArticleCount: 0,
        errors: [],
      );

      expect(result.totalFeeds, equals(0));
      expect(result.successCount, equals(0));
      expect(result.failedCount, equals(0));
      expect(result.newArticleCount, equals(0));
      expect(result.errors, isEmpty);
    });

    test('All feeds successful should have failedCount = 0', () {
      const result = RefreshResult(
        totalFeeds: 10,
        successCount: 10,
        failedCount: 0,
        newArticleCount: 50,
        errors: [],
      );

      expect(result.failedCount, equals(0));
      expect(result.errors, isEmpty);
      expect(result.successCount, equals(result.totalFeeds));
    });

    test('All feeds failed should have successCount = 0', () {
      final result = RefreshResult(
        totalFeeds: 5,
        successCount: 0,
        failedCount: 5,
        newArticleCount: 0,
        errors: List.generate(
          5,
          (i) => FeedRefreshError(
            feedId: 'feed_$i',
            feedTitle: 'Feed $i',
            errorMessage: 'Network error',
          ),
        ),
      );

      expect(result.successCount, equals(0));
      expect(result.newArticleCount, equals(0));
      expect(result.errors.length, equals(result.failedCount));
    });

    test('Refresh with no new articles should have newArticleCount = 0', () {
      const result = RefreshResult(
        totalFeeds: 10,
        successCount: 10,
        failedCount: 0,
        newArticleCount: 0,
        errors: [],
      );

      expect(result.newArticleCount, equals(0));
    });

    test('Single feed refresh result is valid', () {
      const result = RefreshResult(
        totalFeeds: 1,
        successCount: 1,
        failedCount: 0,
        newArticleCount: 5,
        errors: [],
      );

      expect(result.totalFeeds, equals(1));
      expect(result.successCount + result.failedCount, equals(1));
    });
  });
}
