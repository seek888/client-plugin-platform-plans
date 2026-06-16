import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/article/data/services/article_block_service_impl.dart';
import 'package:rss_reader/features/article/domain/services/article_block_service.dart';

/// **Property 19: 屏蔽功能正确性**
/// **Validates: Requirements 21.3, 21.4**
///
/// 21.3: WHEN 用户选择屏蔽文章 THEN THE Content_Browser SHALL 从列表中移除该文章
/// 21.4: WHEN 用户选择屏蔽订阅源 THEN THE Feed_Manager SHALL 将该源加入屏蔽列表

// Custom generators for block testing
extension BlockGenerators on Any {
  /// Generator for article count (1-20 articles)
  Generator<int> get articleCount {
    return any.intInRange(1, 20);
  }
}

/// Helper to create fresh database and service for each test
class BlockTestContext {
  final AppDatabase database;
  final ArticleDao articleDao;
  final FeedDao feedDao;
  final ArticleBlockService blockService;

  BlockTestContext._({
    required this.database,
    required this.articleDao,
    required this.feedDao,
    required this.blockService,
  });

  factory BlockTestContext.create() {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final articleDao = ArticleDao(database);
    final feedDao = FeedDao(database);
    final blockService = ArticleBlockServiceImpl(articleDao: articleDao);
    return BlockTestContext._(
      database: database,
      articleDao: articleDao,
      feedDao: feedDao,
      blockService: blockService,
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

  /// Create test articles
  Future<List<String>> createTestArticles(
    String feedId,
    int count, {
    bool allBlocked = false,
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
          isBlocked: Value(allBlocked),
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
  group('Property 19: Block Functionality Correctness', () {
    // Property 19a: Blocking an article marks it as blocked
    Glados(any.articleCount).test(
      'Property 19a: Blocking an article marks it as blocked',
      (int count) async {
        final ctx = BlockTestContext.create();

        try {
          // Create feed and articles (not blocked)
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allBlocked: false,
          );

          // Block first article
          final result = await ctx.blockService.blockArticle(articleIds[0]);
          expect(result.isRight(), isTrue);

          // Verify it's now blocked
          final isBlocked = await ctx.blockService.isBlocked(articleIds[0]);
          expect(isBlocked.isRight(), isTrue);
          expect(
            isBlocked.getOrElse(() => false),
            isTrue,
            reason: 'Article should be blocked after blocking',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 19b: Blocked articles don't appear in unblocked list
    Glados(any.articleCount).test(
      'Property 19b: Blocked articles removed from list',
      (int count) async {
        final ctx = BlockTestContext.create();

        try {
          // Create feed and articles
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allBlocked: false,
          );

          // Block first article
          await ctx.blockService.blockArticle(articleIds[0]);

          // Get unblocked articles
          final result = await ctx.blockService.getUnblockedArticles(
            feedId: feedId,
            pageSize: 100,
          );
          expect(result.isRight(), isTrue);

          final articles = result.getOrElse(() => []);

          // Verify blocked article is not in list
          final articleIdsInList = articles.map((a) => a.id).toSet();
          expect(
            articleIdsInList.contains(articleIds[0]),
            isFalse,
            reason: 'Blocked article should not appear in unblocked list',
          );

          // Verify other articles are still in list
          for (var i = 1; i < articleIds.length; i++) {
            expect(
              articleIdsInList.contains(articleIds[i]),
              isTrue,
              reason: 'Non-blocked article ${articleIds[i]} should be in list',
            );
          }
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 19c: Blocking multiple articles removes all from list
    Glados(
      any.articleCount,
    ).test('Property 19c: Blocking multiple articles removes all from list', (
      int count,
    ) async {
      final ctx = BlockTestContext.create();

      try {
        // Create feed and articles
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(
          feedId,
          count,
          allBlocked: false,
        );

        // Block half of the articles
        final blockCount = (count / 2).ceil();
        for (var i = 0; i < blockCount; i++) {
          await ctx.blockService.blockArticle(articleIds[i]);
        }

        // Get unblocked articles
        final result = await ctx.blockService.getUnblockedArticles(
          feedId: feedId,
          pageSize: 100,
        );
        expect(result.isRight(), isTrue);

        final articles = result.getOrElse(() => []);
        final expectedCount = count - blockCount;

        expect(
          articles.length,
          equals(expectedCount),
          reason:
              'Should have $expectedCount unblocked articles after blocking $blockCount',
        );

        // Verify blocked articles are not in list
        final articleIdsInList = articles.map((a) => a.id).toSet();
        for (var i = 0; i < blockCount; i++) {
          expect(
            articleIdsInList.contains(articleIds[i]),
            isFalse,
            reason: 'Blocked article ${articleIds[i]} should not be in list',
          );
        }
      } finally {
        await ctx.dispose();
      }
    });

    // Property 19d: Blocking is idempotent
    test('Property 19d: Blocking is idempotent', () async {
      final ctx = BlockTestContext.create();

      try {
        // Create feed and article
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(
          feedId,
          1,
          allBlocked: false,
        );

        // Block twice
        await ctx.blockService.blockArticle(articleIds[0]);
        final result = await ctx.blockService.blockArticle(articleIds[0]);
        expect(result.isRight(), isTrue);

        // Verify still blocked
        final isBlocked = await ctx.blockService.isBlocked(articleIds[0]);
        expect(isBlocked.getOrElse(() => false), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 19e: Non-existent article returns error
    test('Property 19e: Non-existent article returns error', () async {
      final ctx = BlockTestContext.create();

      try {
        final result = await ctx.blockService.blockArticle('non-existent');
        expect(result.isLeft(), isTrue);

        final isBlockedResult = await ctx.blockService.isBlocked(
          'non-existent',
        );
        expect(isBlockedResult.isLeft(), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 19f: Blocking all articles results in empty list
    Glados(any.articleCount).test(
      'Property 19f: Blocking all articles results in empty list',
      (int count) async {
        final ctx = BlockTestContext.create();

        try {
          // Create feed and articles
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allBlocked: false,
          );

          // Block all articles
          for (final articleId in articleIds) {
            await ctx.blockService.blockArticle(articleId);
          }

          // Get unblocked articles
          final result = await ctx.blockService.getUnblockedArticles(
            feedId: feedId,
            pageSize: 100,
          );
          expect(result.isRight(), isTrue);

          final articles = result.getOrElse(() => []);
          expect(
            articles.length,
            equals(0),
            reason: 'Should have no unblocked articles after blocking all',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 19g: Blocked articles from one feed don't affect other feeds
    test('Property 19g: Blocking in one feed does not affect others', () async {
      final ctx = BlockTestContext.create();

      try {
        // Create two feeds with articles
        final feedId1 = await ctx.createTestFeed('feed-1');
        final feedId2 = await ctx.createTestFeed('feed-2');
        final articleIds1 = await ctx.createTestArticles(
          feedId1,
          5,
          allBlocked: false,
        );
        final articleIds2 = await ctx.createTestArticles(
          feedId2,
          5,
          allBlocked: false,
        );

        // Block all articles from feed 1
        for (final articleId in articleIds1) {
          await ctx.blockService.blockArticle(articleId);
        }

        // Verify feed 2 articles are unaffected
        final result = await ctx.blockService.getUnblockedArticles(
          feedId: feedId2,
          pageSize: 100,
        );
        expect(result.isRight(), isTrue);

        final articles = result.getOrElse(() => []);
        expect(
          articles.length,
          equals(5),
          reason: 'Feed 2 should still have all 5 articles',
        );

        // Verify all feed 2 articles are in list
        final articleIdsInList = articles.map((a) => a.id).toSet();
        for (final articleId in articleIds2) {
          expect(
            articleIdsInList.contains(articleId),
            isTrue,
            reason: 'Article $articleId from feed 2 should be in list',
          );
        }
      } finally {
        await ctx.dispose();
      }
    });

    // Property 19h: Initially created articles are not blocked
    Glados(any.articleCount).test(
      'Property 19h: Initially created articles are not blocked',
      (int count) async {
        final ctx = BlockTestContext.create();

        try {
          // Create feed and articles
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allBlocked: false,
          );

          // Verify all articles are not blocked
          for (final articleId in articleIds) {
            final isBlocked = await ctx.blockService.isBlocked(articleId);
            expect(isBlocked.isRight(), isTrue);
            expect(
              isBlocked.getOrElse(() => true),
              isFalse,
              reason: 'Newly created article $articleId should not be blocked',
            );
          }
        } finally {
          await ctx.dispose();
        }
      },
    );
  });
}
