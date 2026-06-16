import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/article/data/services/unread_count_service_impl.dart';
import 'package:rss_reader/features/article/domain/services/unread_count_service.dart';

/// **Property 9: 未读数字计算正确性**
/// **Validates: Requirements 6.6**
///
/// 6.6: THE RSS_Client SHALL 在订阅源图标上显示红色小圆点角标展示未读数字

// Custom generators for unread count testing
extension UnreadCountGenerators on Any {
  /// Generator for article count (1-20 articles)
  Generator<int> get articleCount {
    return any.intInRange(1, 20);
  }

  /// Generator for feed count (1-5 feeds)
  Generator<int> get feedCount {
    return any.intInRange(1, 5);
  }

  /// Generator for unread count within article count
  Generator<int> unreadCountFor(int articleCount) {
    return any.intInRange(0, articleCount);
  }
}

/// Helper to create fresh database and service for each test
class UnreadCountTestContext {
  final AppDatabase database;
  final ArticleDao articleDao;
  final FeedDao feedDao;
  final UnreadCountService unreadCountService;

  UnreadCountTestContext._({
    required this.database,
    required this.articleDao,
    required this.feedDao,
    required this.unreadCountService,
  });

  factory UnreadCountTestContext.create() {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final articleDao = ArticleDao(database);
    final feedDao = FeedDao(database);
    final unreadCountService = UnreadCountServiceImpl(
      articleDao: articleDao,
      feedDao: feedDao,
    );
    return UnreadCountTestContext._(
      database: database,
      articleDao: articleDao,
      feedDao: feedDao,
      unreadCountService: unreadCountService,
    );
  }

  /// Create a test feed
  Future<String> createTestFeed(String feedId) async {
    await feedDao.insertFeed(
      FeedsTableCompanion(
        id: Value(feedId),
        url: Value('https://example.com/$feedId/feed.xml'),
        title: Value('Feed $feedId'),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return feedId;
  }

  /// Create test articles with specific unread count
  Future<List<String>> createTestArticles(
    String feedId,
    int totalCount,
    int unreadCount,
  ) async {
    final articleIds = <String>[];
    for (var i = 0; i < totalCount; i++) {
      final articleId = '$feedId-article-$i';
      await articleDao.insertArticle(
        ArticlesTableCompanion(
          id: Value(articleId),
          feedId: Value(feedId),
          title: Value('Article $i'),
          link: Value('https://example.com/$feedId/article-$i'),
          isRead: Value(
            i >= unreadCount,
          ), // First unreadCount articles are unread
          publishedAt: Value(DateTime.now().subtract(Duration(hours: i))),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
      articleIds.add(articleId);
    }
    return articleIds;
  }

  Future<void> dispose() async {
    await database.close();
  }
}

void main() {
  group('Property 9: Unread Count Calculation Correctness', () {
    // Property 9a: Unread count equals number of unread articles
    Glados2(any.articleCount, any.intInRange(0, 20)).test(
      'Property 9a: Unread count equals number of unread articles',
      (int totalCount, int unreadCount) async {
        // Ensure unreadCount doesn't exceed totalCount
        final actualUnreadCount = unreadCount.clamp(0, totalCount);
        final ctx = UnreadCountTestContext.create();

        try {
          // Create feed and articles
          final feedId = await ctx.createTestFeed('feed-1');
          await ctx.createTestArticles(feedId, totalCount, actualUnreadCount);

          // Get unread count
          final result = await ctx.unreadCountService.getUnreadCountByFeed(
            feedId,
          );
          expect(result.isRight(), isTrue);
          expect(
            result.getOrElse(() => -1),
            equals(actualUnreadCount),
            reason: 'Unread count should equal the number of unread articles',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 9b: Total unread count equals sum of all feed unread counts
    Glados2(any.feedCount, any.articleCount).test(
      'Property 9b: Total unread count equals sum of feed unread counts',
      (int feedCount, int articlesPerFeed) async {
        final ctx = UnreadCountTestContext.create();

        try {
          int expectedTotal = 0;

          // Create multiple feeds with varying unread counts
          for (var i = 0; i < feedCount; i++) {
            final feedId = await ctx.createTestFeed('feed-$i');
            final unreadCount = (articlesPerFeed * (i + 1) / (feedCount + 1))
                .floor();
            await ctx.createTestArticles(feedId, articlesPerFeed, unreadCount);
            expectedTotal += unreadCount;
          }

          // Get total unread count
          final result = await ctx.unreadCountService.getTotalUnreadCount();
          expect(result.isRight(), isTrue);
          expect(
            result.getOrElse(() => -1),
            equals(expectedTotal),
            reason:
                'Total unread count should equal sum of all feed unread counts',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 9c: getAllUnreadCounts returns correct counts for each feed
    test('Property 9c: getAllUnreadCounts returns correct counts', () async {
      final ctx = UnreadCountTestContext.create();

      try {
        // Create feeds with different unread counts
        final feedId1 = await ctx.createTestFeed('feed-1');
        final feedId2 = await ctx.createTestFeed('feed-2');
        final feedId3 = await ctx.createTestFeed('feed-3');

        await ctx.createTestArticles(feedId1, 10, 5);
        await ctx.createTestArticles(feedId2, 8, 3);
        await ctx.createTestArticles(feedId3, 6, 6);

        // Get all unread counts
        final result = await ctx.unreadCountService.getAllUnreadCounts();
        expect(result.isRight(), isTrue);

        final counts = result.getOrElse(() => {});
        expect(counts[feedId1], equals(5));
        expect(counts[feedId2], equals(3));
        expect(counts[feedId3], equals(6));
      } finally {
        await ctx.dispose();
      }
    });

    // Property 9d: Recalculate updates feed's stored unread count
    test('Property 9d: Recalculate updates stored unread count', () async {
      final ctx = UnreadCountTestContext.create();

      try {
        // Create feed and articles
        final feedId = await ctx.createTestFeed('feed-1');
        await ctx.createTestArticles(feedId, 10, 7);

        // Manually set wrong unread count in feed
        await ctx.feedDao.updateUnreadCount(feedId, 999);

        // Verify wrong count
        var feed = await ctx.feedDao.getFeedById(feedId);
        expect(feed?.unreadCount, equals(999));

        // Recalculate
        final result = await ctx.unreadCountService.recalculateUnreadCount(
          feedId,
        );
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => -1), equals(7));

        // Verify corrected count
        feed = await ctx.feedDao.getFeedById(feedId);
        expect(feed?.unreadCount, equals(7));
      } finally {
        await ctx.dispose();
      }
    });

    // Property 9e: Recalculate all updates all feeds' stored unread counts
    test('Property 9e: Recalculate all updates all stored counts', () async {
      final ctx = UnreadCountTestContext.create();

      try {
        // Create feeds with articles
        final feedId1 = await ctx.createTestFeed('feed-1');
        final feedId2 = await ctx.createTestFeed('feed-2');

        await ctx.createTestArticles(feedId1, 10, 5);
        await ctx.createTestArticles(feedId2, 8, 3);

        // Manually set wrong unread counts
        await ctx.feedDao.updateUnreadCount(feedId1, 999);
        await ctx.feedDao.updateUnreadCount(feedId2, 888);

        // Recalculate all
        final result = await ctx.unreadCountService
            .recalculateAllUnreadCounts();
        expect(result.isRight(), isTrue);

        // Verify corrected counts
        final feed1 = await ctx.feedDao.getFeedById(feedId1);
        final feed2 = await ctx.feedDao.getFeedById(feedId2);
        expect(feed1?.unreadCount, equals(5));
        expect(feed2?.unreadCount, equals(3));
      } finally {
        await ctx.dispose();
      }
    });

    // Property 9f: Empty feed has zero unread count
    test('Property 9f: Empty feed has zero unread count', () async {
      final ctx = UnreadCountTestContext.create();

      try {
        // Create feed without articles
        final feedId = await ctx.createTestFeed('feed-1');

        // Get unread count
        final result = await ctx.unreadCountService.getUnreadCountByFeed(
          feedId,
        );
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => -1), equals(0));
      } finally {
        await ctx.dispose();
      }
    });

    // Property 9g: All read articles means zero unread count
    Glados(any.articleCount).test(
      'Property 9g: All read articles means zero unread count',
      (int count) async {
        final ctx = UnreadCountTestContext.create();

        try {
          // Create feed with all read articles
          final feedId = await ctx.createTestFeed('feed-1');
          await ctx.createTestArticles(feedId, count, 0); // 0 unread

          // Get unread count
          final result = await ctx.unreadCountService.getUnreadCountByFeed(
            feedId,
          );
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => -1), equals(0));
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 9h: All unread articles means count equals total
    Glados(any.articleCount).test(
      'Property 9h: All unread articles means count equals total',
      (int count) async {
        final ctx = UnreadCountTestContext.create();

        try {
          // Create feed with all unread articles
          final feedId = await ctx.createTestFeed('feed-1');
          await ctx.createTestArticles(feedId, count, count); // All unread

          // Get unread count
          final result = await ctx.unreadCountService.getUnreadCountByFeed(
            feedId,
          );
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => -1), equals(count));
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 9i: Unread count is non-negative
    Glados2(any.articleCount, any.intInRange(0, 20)).test(
      'Property 9i: Unread count is non-negative',
      (int totalCount, int unreadCount) async {
        final actualUnreadCount = unreadCount.clamp(0, totalCount);
        final ctx = UnreadCountTestContext.create();

        try {
          final feedId = await ctx.createTestFeed('feed-1');
          await ctx.createTestArticles(feedId, totalCount, actualUnreadCount);

          final result = await ctx.unreadCountService.getUnreadCountByFeed(
            feedId,
          );
          expect(result.isRight(), isTrue);
          expect(
            result.getOrElse(() => -1),
            greaterThanOrEqualTo(0),
            reason: 'Unread count should never be negative',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );
  });
}
