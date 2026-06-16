import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/article/data/services/article_cache_service_impl.dart';
import 'package:rss_reader/features/article/domain/services/article_cache_service.dart';

extension CacheGenerators on Any {
  Generator<int> get articleCount {
    return any.intInRange(1, 20);
  }
}

class CacheTestContext {
  final AppDatabase database;
  final ArticleDao articleDao;
  final FeedDao feedDao;
  final ArticleCacheService cacheService;

  CacheTestContext._({
    required this.database,
    required this.articleDao,
    required this.feedDao,
    required this.cacheService,
  });

  factory CacheTestContext.create() {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final articleDao = ArticleDao(database);
    final feedDao = FeedDao(database);
    final cacheService = ArticleCacheServiceImpl(articleDao: articleDao);
    return CacheTestContext._(
      database: database,
      articleDao: articleDao,
      feedDao: feedDao,
      cacheService: cacheService,
    );
  }

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

  Future<List<String>> createTestArticles(
    String feedId,
    int count, {
    bool allCached = false,
  }) async {
    final articleIds = <String>[];
    for (var i = 0; i < count; i++) {
      final articleId = '$feedId-article-$i';
      await articleDao.insertArticle(
        ArticlesTableCompanion(
          id: Value(articleId),
          feedId: Value(feedId),
          title: Value('Article $i'),
          content: Value('Content for article $i'),
          link: Value('https://example.com/$feedId/article-$i'),
          isCached: Value(allCached),
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
  group('Property 14: Cache Functionality Correctness', () {
    Glados(any.articleCount).test(
      'Property 14a: Caching an article sets isCached to true',
      (int count) async {
        final ctx = CacheTestContext.create();
        try {
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allCached: false,
          );
          final result = await ctx.cacheService.cacheArticle(articleIds[0]);
          expect(result.isRight(), isTrue);
          final isCached = await ctx.cacheService.isArticleCached(
            articleIds[0],
          );
          expect(isCached.isRight(), isTrue);
          expect(
            isCached.getOrElse(() => false),
            isTrue,
            reason: 'Article should be cached',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    Glados(any.articleCount).test(
      'Property 14b: Cached articles appear in cached articles list',
      (int count) async {
        final ctx = CacheTestContext.create();
        try {
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allCached: false,
          );
          final cacheCount = (count / 2).ceil();
          for (var i = 0; i < cacheCount; i++) {
            await ctx.cacheService.cacheArticle(articleIds[i]);
          }
          final result = await ctx.cacheService.getCachedArticles();
          expect(result.isRight(), isTrue);
          final cachedArticles = result.getOrElse(() => []);
          expect(cachedArticles.length, equals(cacheCount));
          final cachedIds = cachedArticles.map((a) => a.id).toSet();
          for (var i = 0; i < cacheCount; i++) {
            expect(cachedIds.contains(articleIds[i]), isTrue);
          }
        } finally {
          await ctx.dispose();
        }
      },
    );

    Glados(any.articleCount).test(
      'Property 14c: Batch caching caches all articles in a feed',
      (int count) async {
        final ctx = CacheTestContext.create();
        try {
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allCached: false,
          );
          final result = await ctx.cacheService.cacheArticlesByFeed(feedId);
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => 0), equals(count));
          for (final articleId in articleIds) {
            final isCached = await ctx.cacheService.isArticleCached(articleId);
            expect(isCached.getOrElse(() => false), isTrue);
          }
        } finally {
          await ctx.dispose();
        }
      },
    );

    test(
      'Property 14d: Uncaching an article removes it from cached list',
      () async {
        final ctx = CacheTestContext.create();
        try {
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            5,
            allCached: true,
          );
          final result = await ctx.cacheService.uncacheArticle(articleIds[0]);
          expect(result.isRight(), isTrue);
          final isCached = await ctx.cacheService.isArticleCached(
            articleIds[0],
          );
          expect(isCached.getOrElse(() => true), isFalse);
          final cachedResult = await ctx.cacheService.getCachedArticles();
          final cachedIds = cachedResult
              .getOrElse(() => [])
              .map((a) => a.id)
              .toSet();
          expect(cachedIds.contains(articleIds[0]), isFalse);
          expect(cachedIds.length, equals(4));
        } finally {
          await ctx.dispose();
        }
      },
    );

    Glados(any.articleCount).test(
      'Property 14e: Clear cache removes all cached articles',
      (int count) async {
        final ctx = CacheTestContext.create();
        try {
          final feedId = await ctx.createTestFeed('feed-1');
          await ctx.createTestArticles(feedId, count, allCached: true);
          final result = await ctx.cacheService.clearCache();
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => 0), equals(count));
          final cachedResult = await ctx.cacheService.getCachedArticles();
          expect(cachedResult.getOrElse(() => []).length, equals(0));
        } finally {
          await ctx.dispose();
        }
      },
    );

    Glados(any.articleCount).test(
      'Property 14f: Clear cache by feed only clears that feed cache',
      (int count) async {
        final ctx = CacheTestContext.create();
        try {
          final feedId1 = await ctx.createTestFeed('feed-1');
          final feedId2 = await ctx.createTestFeed('feed-2');
          await ctx.createTestArticles(feedId1, count, allCached: true);
          await ctx.createTestArticles(feedId2, count, allCached: true);
          final result = await ctx.cacheService.clearCache(feedId: feedId1);
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => 0), equals(count));
          final countResult1 = await ctx.cacheService.getCachedCount(
            feedId: feedId1,
          );
          expect(countResult1.getOrElse(() => -1), equals(0));
          final countResult2 = await ctx.cacheService.getCachedCount(
            feedId: feedId2,
          );
          expect(countResult2.getOrElse(() => 0), equals(count));
        } finally {
          await ctx.dispose();
        }
      },
    );

    test(
      'Property 14g: Caching already cached article is idempotent',
      () async {
        final ctx = CacheTestContext.create();
        try {
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            1,
            allCached: true,
          );
          final result = await ctx.cacheService.cacheArticle(articleIds[0]);
          expect(result.isRight(), isTrue);
          final isCached = await ctx.cacheService.isArticleCached(
            articleIds[0],
          );
          expect(isCached.getOrElse(() => false), isTrue);
        } finally {
          await ctx.dispose();
        }
      },
    );

    test('Property 14h: Uncaching non-cached article is idempotent', () async {
      final ctx = CacheTestContext.create();
      try {
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(
          feedId,
          1,
          allCached: false,
        );
        final result = await ctx.cacheService.uncacheArticle(articleIds[0]);
        expect(result.isRight(), isTrue);
        final isCached = await ctx.cacheService.isArticleCached(articleIds[0]);
        expect(isCached.getOrElse(() => true), isFalse);
      } finally {
        await ctx.dispose();
      }
    });

    test('Property 14i: Non-existent article returns error', () async {
      final ctx = CacheTestContext.create();
      try {
        final result = await ctx.cacheService.cacheArticle('non-existent');
        expect(result.isLeft(), isTrue);
        final uncacheResult = await ctx.cacheService.uncacheArticle(
          'non-existent',
        );
        expect(uncacheResult.isLeft(), isTrue);
        final isCachedResult = await ctx.cacheService.isArticleCached(
          'non-existent',
        );
        expect(isCachedResult.isLeft(), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    test('Property 14j: Empty cached list when none cached', () async {
      final ctx = CacheTestContext.create();
      try {
        final feedId = await ctx.createTestFeed('feed-1');
        await ctx.createTestArticles(feedId, 5, allCached: false);
        final result = await ctx.cacheService.getCachedArticles();
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => []).length, equals(0));
      } finally {
        await ctx.dispose();
      }
    });

    Glados(any.articleCount).test(
      'Property 14k: getCachedCount returns correct count',
      (int count) async {
        final ctx = CacheTestContext.create();
        try {
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allCached: false,
          );
          final cacheCount = (count / 2).ceil();
          for (var i = 0; i < cacheCount; i++) {
            await ctx.cacheService.cacheArticle(articleIds[i]);
          }
          final countResult = await ctx.cacheService.getCachedCount();
          expect(countResult.getOrElse(() => -1), equals(cacheCount));
          final feedCountResult = await ctx.cacheService.getCachedCount(
            feedId: feedId,
          );
          expect(feedCountResult.getOrElse(() => -1), equals(cacheCount));
        } finally {
          await ctx.dispose();
        }
      },
    );

    test('Property 14l: Batch cache on empty feed returns 0', () async {
      final ctx = CacheTestContext.create();
      try {
        final feedId = await ctx.createTestFeed('feed-1');
        final result = await ctx.cacheService.cacheArticlesByFeed(feedId);
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => -1), equals(0));
      } finally {
        await ctx.dispose();
      }
    });
  });
}
