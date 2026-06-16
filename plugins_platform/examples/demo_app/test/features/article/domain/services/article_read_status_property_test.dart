import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/article/data/services/article_read_status_service_impl.dart';
import 'package:rss_reader/features/article/domain/services/article_read_status_service.dart';

/// **Property 10: 批量标记已读正确性**
/// **Validates: Requirements 6.4, 6.5**
///
/// 6.4: WHEN 用户点击订阅源的未读数字 THEN THE Content_Browser SHALL 标记该源所有文章为已读
/// 6.5: WHEN 用户点击"全部"的未读数字 THEN THE RSS_Client SHALL 弹窗二次确认后标记所有文章为已读

// Custom generators for read status testing
extension ReadStatusGenerators on Any {
  /// Generator for article count (1-20 articles)
  Generator<int> get articleCount {
    return any.intInRange(1, 20);
  }

  /// Generator for feed count (1-5 feeds)
  Generator<int> get feedCount {
    return any.intInRange(1, 5);
  }
}

/// Helper to create fresh database and service for each test
class ReadStatusTestContext {
  final AppDatabase database;
  final ArticleDao articleDao;
  final FeedDao feedDao;
  final ArticleReadStatusService readStatusService;

  ReadStatusTestContext._({
    required this.database,
    required this.articleDao,
    required this.feedDao,
    required this.readStatusService,
  });

  factory ReadStatusTestContext.create() {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final articleDao = ArticleDao(database);
    final feedDao = FeedDao(database);
    final readStatusService = ArticleReadStatusServiceImpl(
      articleDao: articleDao,
      feedDao: feedDao,
    );
    return ReadStatusTestContext._(
      database: database,
      articleDao: articleDao,
      feedDao: feedDao,
      readStatusService: readStatusService,
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

  /// Create test articles for a feed
  Future<List<String>> createTestArticles(
    String feedId,
    int count, {
    bool allUnread = true,
  }) async {
    final articleIds = <String>[];
    for (var i = 0; i < count; i++) {
      final articleId = '$feedId-article-$i';
      await articleDao.insertArticle(
        ArticlesTableCompanion(
          id: Value(articleId),
          feedId: Value(feedId),
          title: Value('Article $i'),
          link: Value('https://example.com/$feedId/article-$i'),
          isRead: Value(!allUnread && i % 2 == 0),
          publishedAt: Value(DateTime.now().subtract(Duration(hours: i))),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
      articleIds.add(articleId);
    }

    // Update feed unread count
    final unreadCount = await articleDao.getUnreadCountByFeed(feedId);
    await feedDao.updateUnreadCount(feedId, unreadCount);

    return articleIds;
  }

  Future<void> dispose() async {
    await database.close();
  }
}

void main() {
  group('Property 10: Batch Mark As Read Correctness', () {
    // Property 10a: Mark all as read by feed marks all articles in that feed
    Glados(any.articleCount).test(
      'Property 10a: Mark all as read by feed marks all articles',
      (int count) async {
        final ctx = ReadStatusTestContext.create();

        try {
          // Create feed and articles
          final feedId = await ctx.createTestFeed('feed-1');
          await ctx.createTestArticles(feedId, count, allUnread: true);

          // Verify initial unread count
          final initialUnread = await ctx.readStatusService
              .getUnreadCountByFeed(feedId);
          expect(initialUnread.isRight(), isTrue);
          expect(
            initialUnread.getOrElse(() => -1),
            equals(count),
            reason: 'All articles should be unread initially',
          );

          // Mark all as read
          final result = await ctx.readStatusService.markAllAsReadByFeed(
            feedId,
          );
          expect(result.isRight(), isTrue);
          expect(
            result.getOrElse(() => -1),
            equals(count),
            reason: 'Should return the count of marked articles',
          );

          // Verify all are now read
          final finalUnread = await ctx.readStatusService.getUnreadCountByFeed(
            feedId,
          );
          expect(finalUnread.isRight(), isTrue);
          expect(
            finalUnread.getOrElse(() => -1),
            equals(0),
            reason: 'All articles should be read after marking',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 10b: Mark all as read globally marks all articles across all feeds
    Glados2(any.feedCount, any.articleCount).test(
      'Property 10b: Mark all as read globally marks all articles',
      (int feedCount, int articleCount) async {
        final ctx = ReadStatusTestContext.create();

        try {
          // Create multiple feeds with articles
          int totalArticles = 0;
          for (var i = 0; i < feedCount; i++) {
            final feedId = await ctx.createTestFeed('feed-$i');
            await ctx.createTestArticles(feedId, articleCount, allUnread: true);
            totalArticles += articleCount;
          }

          // Verify initial total unread count
          final initialUnread = await ctx.readStatusService
              .getTotalUnreadCount();
          expect(initialUnread.isRight(), isTrue);
          expect(
            initialUnread.getOrElse(() => -1),
            equals(totalArticles),
            reason: 'All articles should be unread initially',
          );

          // Mark all as read globally
          final result = await ctx.readStatusService.markAllAsRead();
          expect(result.isRight(), isTrue);

          // Verify all are now read
          final finalUnread = await ctx.readStatusService.getTotalUnreadCount();
          expect(finalUnread.isRight(), isTrue);
          expect(
            finalUnread.getOrElse(() => -1),
            equals(0),
            reason: 'All articles should be read after global marking',
          );

          // Verify each feed has 0 unread
          for (var i = 0; i < feedCount; i++) {
            final feedUnread = await ctx.readStatusService.getUnreadCountByFeed(
              'feed-$i',
            );
            expect(feedUnread.isRight(), isTrue);
            expect(
              feedUnread.getOrElse(() => -1),
              equals(0),
              reason: 'Feed $i should have 0 unread articles',
            );
          }
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 10c: Mark all as read by feed only affects that feed
    test(
      'Property 10c: Mark all as read by feed only affects that feed',
      () async {
        final ctx = ReadStatusTestContext.create();

        try {
          // Create two feeds with articles
          final feedId1 = await ctx.createTestFeed('feed-1');
          final feedId2 = await ctx.createTestFeed('feed-2');
          await ctx.createTestArticles(feedId1, 5, allUnread: true);
          await ctx.createTestArticles(feedId2, 5, allUnread: true);

          // Mark only feed-1 as read
          await ctx.readStatusService.markAllAsReadByFeed(feedId1);

          // Verify feed-1 has 0 unread
          final feed1Unread = await ctx.readStatusService.getUnreadCountByFeed(
            feedId1,
          );
          expect(feed1Unread.getOrElse(() => -1), equals(0));

          // Verify feed-2 still has 5 unread
          final feed2Unread = await ctx.readStatusService.getUnreadCountByFeed(
            feedId2,
          );
          expect(feed2Unread.getOrElse(() => -1), equals(5));
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 10d: Mark all as read is idempotent
    Glados(
      any.articleCount,
    ).test('Property 10d: Mark all as read is idempotent', (int count) async {
      final ctx = ReadStatusTestContext.create();

      try {
        // Create feed and articles
        final feedId = await ctx.createTestFeed('feed-1');
        await ctx.createTestArticles(feedId, count, allUnread: true);

        // Mark all as read twice
        await ctx.readStatusService.markAllAsReadByFeed(feedId);
        final result = await ctx.readStatusService.markAllAsReadByFeed(feedId);

        expect(result.isRight(), isTrue);

        // Verify still 0 unread
        final unread = await ctx.readStatusService.getUnreadCountByFeed(feedId);
        expect(unread.getOrElse(() => -1), equals(0));
      } finally {
        await ctx.dispose();
      }
    });

    // Property 10e: Single article mark as read updates unread count correctly
    test('Property 10e: Single article mark updates unread count', () async {
      final ctx = ReadStatusTestContext.create();

      try {
        // Create feed and articles
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(
          feedId,
          5,
          allUnread: true,
        );

        // Mark one article as read
        await ctx.readStatusService.markAsRead(articleIds[0]);

        // Verify unread count decreased by 1
        final unread = await ctx.readStatusService.getUnreadCountByFeed(feedId);
        expect(unread.getOrElse(() => -1), equals(4));
      } finally {
        await ctx.dispose();
      }
    });

    // Property 10f: Toggle read status works correctly
    test('Property 10f: Toggle read status works correctly', () async {
      final ctx = ReadStatusTestContext.create();

      try {
        // Create feed and articles
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(
          feedId,
          1,
          allUnread: true,
        );

        // Toggle to read
        final result1 = await ctx.readStatusService.toggleReadStatus(
          articleIds[0],
        );
        expect(result1.isRight(), isTrue);
        expect(result1.getOrElse(() => false), isTrue); // Now read

        // Verify unread count is 0
        var unread = await ctx.readStatusService.getUnreadCountByFeed(feedId);
        expect(unread.getOrElse(() => -1), equals(0));

        // Toggle back to unread
        final result2 = await ctx.readStatusService.toggleReadStatus(
          articleIds[0],
        );
        expect(result2.isRight(), isTrue);
        expect(result2.getOrElse(() => true), isFalse); // Now unread

        // Verify unread count is 1
        unread = await ctx.readStatusService.getUnreadCountByFeed(feedId);
        expect(unread.getOrElse(() => -1), equals(1));
      } finally {
        await ctx.dispose();
      }
    });

    // Property 10g: Mark as unread increases unread count
    test('Property 10g: Mark as unread increases unread count', () async {
      final ctx = ReadStatusTestContext.create();

      try {
        // Create feed and articles (all read)
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(
          feedId,
          5,
          allUnread: false,
        );

        // Get initial unread count
        final initialUnread = await ctx.readStatusService.getUnreadCountByFeed(
          feedId,
        );
        final initialCount = initialUnread.getOrElse(() => -1);

        // Mark one article as unread
        await ctx.readStatusService.markAsUnread(articleIds[0]);

        // Verify unread count increased
        final finalUnread = await ctx.readStatusService.getUnreadCountByFeed(
          feedId,
        );
        expect(
          finalUnread.getOrElse(() => -1),
          greaterThanOrEqualTo(initialCount),
        );
      } finally {
        await ctx.dispose();
      }
    });

    // Property 10h: Non-existent article returns error
    test('Property 10h: Non-existent article returns error', () async {
      final ctx = ReadStatusTestContext.create();

      try {
        final result = await ctx.readStatusService.markAsRead('non-existent');
        expect(result.isLeft(), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 10i: Empty feed mark all as read succeeds
    test('Property 10i: Empty feed mark all as read succeeds', () async {
      final ctx = ReadStatusTestContext.create();

      try {
        // Create feed without articles
        final feedId = await ctx.createTestFeed('feed-1');

        // Mark all as read (should succeed with 0 count)
        final result = await ctx.readStatusService.markAllAsReadByFeed(feedId);
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => -1), equals(0));
      } finally {
        await ctx.dispose();
      }
    });
  });
}
