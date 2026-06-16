import 'package:glados/glados.dart';
import 'package:rss_reader/features/article/data/services/article_sorting_service_impl.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/domain/services/article_sorting_service.dart';

/// **Property 8: 文章列表排序正确性**
/// **Validates: Requirements 5.1, 5.2, 15.1, 15.2**
///
/// 5.1: WHEN 用户选择订阅源 THEN THE Content_Browser SHALL 按时间倒序展示该源的文章列表
/// 5.2: WHEN 用户选择"全部" THEN THE Content_Browser SHALL 展示所有订阅源的文章汇总并按时间倒序排列
/// 15.1: THE Content_Browser SHALL 默认按时间倒序排列文章
/// 15.2: WHEN 用户在筛选栏切换排序方式 THEN THE Content_Browser SHALL 按选择的方式重新排序（时间/未读优先）

// Custom generators for article testing
extension ArticleGenerators on Any {
  /// Generator for article count (1-20 articles)
  Generator<int> get articleCount {
    return any.intInRange(1, 20);
  }

  /// Generator for a random DateTime within a reasonable range
  Generator<DateTime> get randomDateTime {
    return any.intInRange(0, 365 * 5).map((days) {
      return DateTime(2020, 1, 1).add(Duration(days: days));
    });
  }

  /// Generator for a random boolean
  Generator<bool> get randomBool {
    return any.intInRange(0, 1).map((i) => i == 1);
  }
}

/// Helper to create test articles
class ArticleTestHelper {
  final ArticleSortingService sortingService;

  ArticleTestHelper() : sortingService = ArticleSortingServiceImpl();

  /// Create a list of test articles with random dates and read status
  List<Article> createTestArticles(
    int count,
    List<DateTime> dates,
    List<bool> readStatuses,
  ) {
    final articles = <Article>[];
    for (var i = 0; i < count; i++) {
      articles.add(
        Article(
          id: 'article-$i',
          feedId: 'feed-1',
          title: 'Article $i',
          link: 'https://example.com/article-$i',
          publishedAt: dates[i % dates.length],
          isRead: readStatuses[i % readStatuses.length],
        ),
      );
    }
    return articles;
  }

  /// Create articles with specific dates for deterministic testing
  List<Article> createArticlesWithDates(List<DateTime> dates) {
    return dates.asMap().entries.map((entry) {
      return Article(
        id: 'article-${entry.key}',
        feedId: 'feed-1',
        title: 'Article ${entry.key}',
        link: 'https://example.com/article-${entry.key}',
        publishedAt: entry.value,
        isRead: false,
      );
    }).toList();
  }

  /// Create articles with specific read statuses
  List<Article> createArticlesWithReadStatus(
    List<DateTime> dates,
    List<bool> readStatuses,
  ) {
    return dates.asMap().entries.map((entry) {
      return Article(
        id: 'article-${entry.key}',
        feedId: 'feed-1',
        title: 'Article ${entry.key}',
        link: 'https://example.com/article-${entry.key}',
        publishedAt: entry.value,
        isRead: readStatuses[entry.key],
      );
    }).toList();
  }
}

void main() {
  group('Property 8: Article Sorting Correctness', () {
    late ArticleTestHelper helper;

    setUp(() {
      helper = ArticleTestHelper();
    });

    // Property 8a: Time descending sort produces articles in newest-first order
    Glados(
      any.articleCount,
    ).test('Property 8a: Time descending sort produces newest-first order', (
      int count,
    ) {
      // Generate random dates
      final dates = List.generate(
        count,
        (i) => DateTime(2020, 1, 1).add(Duration(days: i * 10)),
      );
      dates.shuffle(); // Shuffle to create unsorted input

      final articles = helper.createArticlesWithDates(dates);
      final sorted = helper.sortingService.sortByTimeDesc(articles);

      // Verify sorted in descending order
      for (var i = 0; i < sorted.length - 1; i++) {
        final current = sorted[i].publishedAt ?? DateTime(1970);
        final next = sorted[i + 1].publishedAt ?? DateTime(1970);
        expect(
          current.compareTo(next) >= 0,
          isTrue,
          reason:
              'Article at index $i should be newer or equal to article at index ${i + 1}',
        );
      }
    });

    // Property 8b: Time ascending sort produces articles in oldest-first order
    Glados(
      any.articleCount,
    ).test('Property 8b: Time ascending sort produces oldest-first order', (
      int count,
    ) {
      // Generate random dates
      final dates = List.generate(
        count,
        (i) => DateTime(2020, 1, 1).add(Duration(days: i * 10)),
      );
      dates.shuffle(); // Shuffle to create unsorted input

      final articles = helper.createArticlesWithDates(dates);
      final sorted = helper.sortingService.sortByTimeAsc(articles);

      // Verify sorted in ascending order
      for (var i = 0; i < sorted.length - 1; i++) {
        final current = sorted[i].publishedAt ?? DateTime(1970);
        final next = sorted[i + 1].publishedAt ?? DateTime(1970);
        expect(
          current.compareTo(next) <= 0,
          isTrue,
          reason:
              'Article at index $i should be older or equal to article at index ${i + 1}',
        );
      }
    });

    // Property 8c: Unread-first sort places all unread articles before read articles
    Glados(any.articleCount).test(
      'Property 8c: Unread-first sort places unread before read',
      (int count) {
        // Generate dates and read statuses
        final dates = List.generate(
          count,
          (i) => DateTime(2020, 1, 1).add(Duration(days: i * 10)),
        );
        final readStatuses = List.generate(count, (i) => i % 2 == 0);

        final articles = helper.createArticlesWithReadStatus(
          dates,
          readStatuses,
        );
        final sorted = helper.sortingService.sortByUnreadFirst(articles);

        // Find the first read article
        int firstReadIndex = sorted.length;
        for (var i = 0; i < sorted.length; i++) {
          if (sorted[i].isRead) {
            firstReadIndex = i;
            break;
          }
        }

        // Verify all articles before firstReadIndex are unread
        for (var i = 0; i < firstReadIndex; i++) {
          expect(
            sorted[i].isRead,
            isFalse,
            reason: 'Article at index $i should be unread',
          );
        }

        // Verify all articles from firstReadIndex onwards are read
        for (var i = firstReadIndex; i < sorted.length; i++) {
          expect(
            sorted[i].isRead,
            isTrue,
            reason: 'Article at index $i should be read',
          );
        }
      },
    );

    // Property 8d: Unread-first sort maintains time order within each group
    test('Property 8d: Unread-first maintains time order within groups', () {
      final dates = [
        DateTime(2020, 1, 5),
        DateTime(2020, 1, 3),
        DateTime(2020, 1, 4),
        DateTime(2020, 1, 1),
        DateTime(2020, 1, 2),
      ];
      final readStatuses = [false, true, false, true, false];

      final articles = helper.createArticlesWithReadStatus(dates, readStatuses);
      final sorted = helper.sortingService.sortByUnreadFirst(articles);

      // Separate into unread and read groups
      final unread = sorted.where((a) => !a.isRead).toList();
      final read = sorted.where((a) => a.isRead).toList();

      // Verify unread group is sorted by time descending
      for (var i = 0; i < unread.length - 1; i++) {
        final current = unread[i].publishedAt ?? DateTime(1970);
        final next = unread[i + 1].publishedAt ?? DateTime(1970);
        expect(
          current.compareTo(next) >= 0,
          isTrue,
          reason: 'Unread articles should be sorted by time descending',
        );
      }

      // Verify read group is sorted by time descending
      for (var i = 0; i < read.length - 1; i++) {
        final current = read[i].publishedAt ?? DateTime(1970);
        final next = read[i + 1].publishedAt ?? DateTime(1970);
        expect(
          current.compareTo(next) >= 0,
          isTrue,
          reason: 'Read articles should be sorted by time descending',
        );
      }
    });

    // Property 8e: Sorting preserves all articles (no loss or duplication)
    Glados(any.articleCount).test(
      'Property 8e: Sorting preserves all articles',
      (int count) {
        final dates = List.generate(
          count,
          (i) => DateTime(2020, 1, 1).add(Duration(days: i)),
        );
        dates.shuffle();

        final articles = helper.createArticlesWithDates(dates);
        final sortedDesc = helper.sortingService.sortByTimeDesc(articles);
        final sortedAsc = helper.sortingService.sortByTimeAsc(articles);
        final sortedUnread = helper.sortingService.sortByUnreadFirst(articles);

        // Verify count is preserved
        expect(sortedDesc.length, equals(count));
        expect(sortedAsc.length, equals(count));
        expect(sortedUnread.length, equals(count));

        // Verify all original IDs are present
        final originalIds = articles.map((a) => a.id).toSet();
        final sortedDescIds = sortedDesc.map((a) => a.id).toSet();
        final sortedAscIds = sortedAsc.map((a) => a.id).toSet();
        final sortedUnreadIds = sortedUnread.map((a) => a.id).toSet();

        expect(sortedDescIds, equals(originalIds));
        expect(sortedAscIds, equals(originalIds));
        expect(sortedUnreadIds, equals(originalIds));
      },
    );

    // Property 8f: sortArticles delegates correctly to specific sort methods
    test('Property 8f: sortArticles delegates correctly', () {
      final dates = [
        DateTime(2020, 1, 3),
        DateTime(2020, 1, 1),
        DateTime(2020, 1, 2),
      ];
      final articles = helper.createArticlesWithDates(dates);

      final sortedDesc = helper.sortingService.sortArticles(
        articles,
        ArticleSortType.timeDesc,
      );
      final sortedAsc = helper.sortingService.sortArticles(
        articles,
        ArticleSortType.timeAsc,
      );
      final sortedUnread = helper.sortingService.sortArticles(
        articles,
        ArticleSortType.unreadFirst,
      );

      // Verify timeDesc
      expect(sortedDesc[0].publishedAt, equals(DateTime(2020, 1, 3)));
      expect(sortedDesc[2].publishedAt, equals(DateTime(2020, 1, 1)));

      // Verify timeAsc
      expect(sortedAsc[0].publishedAt, equals(DateTime(2020, 1, 1)));
      expect(sortedAsc[2].publishedAt, equals(DateTime(2020, 1, 3)));

      // Verify unreadFirst (all unread, so just time desc)
      expect(sortedUnread[0].publishedAt, equals(DateTime(2020, 1, 3)));
      expect(sortedUnread[2].publishedAt, equals(DateTime(2020, 1, 1)));
    });

    // Property 8g: Sorting is stable for articles with same timestamp
    test('Property 8g: Sorting handles articles with same timestamp', () {
      final sameDate = DateTime(2020, 1, 1);
      final articles = [
        Article(
          id: 'article-0',
          feedId: 'feed-1',
          title: 'Article 0',
          link: 'https://example.com/0',
          publishedAt: sameDate,
          isRead: false,
        ),
        Article(
          id: 'article-1',
          feedId: 'feed-1',
          title: 'Article 1',
          link: 'https://example.com/1',
          publishedAt: sameDate,
          isRead: true,
        ),
        Article(
          id: 'article-2',
          feedId: 'feed-1',
          title: 'Article 2',
          link: 'https://example.com/2',
          publishedAt: sameDate,
          isRead: false,
        ),
      ];

      final sorted = helper.sortingService.sortByUnreadFirst(articles);

      // All unread should come before read
      expect(sorted[0].isRead, isFalse);
      expect(sorted[1].isRead, isFalse);
      expect(sorted[2].isRead, isTrue);
    });

    // Property 8h: Empty list sorting returns empty list
    test('Property 8h: Empty list sorting returns empty list', () {
      final empty = <Article>[];

      expect(helper.sortingService.sortByTimeDesc(empty), isEmpty);
      expect(helper.sortingService.sortByTimeAsc(empty), isEmpty);
      expect(helper.sortingService.sortByUnreadFirst(empty), isEmpty);
    });

    // Property 8i: Single article list returns same article
    test('Property 8i: Single article list returns same article', () {
      final single = [
        Article(
          id: 'article-0',
          feedId: 'feed-1',
          title: 'Article 0',
          link: 'https://example.com/0',
          publishedAt: DateTime(2020, 1, 1),
        ),
      ];

      expect(helper.sortingService.sortByTimeDesc(single).length, equals(1));
      expect(helper.sortingService.sortByTimeAsc(single).length, equals(1));
      expect(helper.sortingService.sortByUnreadFirst(single).length, equals(1));
      expect(
        helper.sortingService.sortByTimeDesc(single)[0].id,
        equals('article-0'),
      );
    });

    // Property 8j: Articles with null publishedAt are handled correctly
    test('Property 8j: Articles with null publishedAt are handled', () {
      final articles = [
        Article(
          id: 'article-0',
          feedId: 'feed-1',
          title: 'Article 0',
          link: 'https://example.com/0',
          publishedAt: DateTime(2020, 1, 3),
        ),
        Article(
          id: 'article-1',
          feedId: 'feed-1',
          title: 'Article 1',
          link: 'https://example.com/1',
          publishedAt: null, // null date
        ),
        Article(
          id: 'article-2',
          feedId: 'feed-1',
          title: 'Article 2',
          link: 'https://example.com/2',
          publishedAt: DateTime(2020, 1, 1),
        ),
      ];

      // Should not throw and should handle null dates
      final sortedDesc = helper.sortingService.sortByTimeDesc(articles);
      final sortedAsc = helper.sortingService.sortByTimeAsc(articles);

      expect(sortedDesc.length, equals(3));
      expect(sortedAsc.length, equals(3));

      // Null date should be treated as very old (1970)
      // In descending order, null should be last
      expect(sortedDesc.last.id, equals('article-1'));
      // In ascending order, null should be first
      expect(sortedAsc.first.id, equals('article-1'));
    });
  });
}
