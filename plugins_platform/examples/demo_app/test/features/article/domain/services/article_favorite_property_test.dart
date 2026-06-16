import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/article/data/services/article_favorite_service_impl.dart';
import 'package:rss_reader/features/article/domain/services/article_favorite_service.dart';

/// **Property 11: 收藏切换正确性**
/// **Validates: Requirements 7.1, 7.3**
///
/// 7.1: WHEN 用户点击收藏图标 THEN THE RSS_Client SHALL 将文章添加到收藏列表并同步至云端
/// 7.3: WHEN 用户再次点击已收藏文章的收藏图标 THEN THE RSS_Client SHALL 取消收藏并恢复图标颜色

// Custom generators for favorite testing
extension FavoriteGenerators on Any {
  /// Generator for article count (1-20 articles)
  Generator<int> get articleCount {
    return any.intInRange(1, 20);
  }
}

/// Helper to create fresh database and service for each test
class FavoriteTestContext {
  final AppDatabase database;
  final ArticleDao articleDao;
  final FeedDao feedDao;
  final ArticleFavoriteService favoriteService;

  FavoriteTestContext._({
    required this.database,
    required this.articleDao,
    required this.feedDao,
    required this.favoriteService,
  });

  factory FavoriteTestContext.create() {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final articleDao = ArticleDao(database);
    final feedDao = FeedDao(database);
    final favoriteService = ArticleFavoriteServiceImpl(articleDao: articleDao);
    return FavoriteTestContext._(
      database: database,
      articleDao: articleDao,
      feedDao: feedDao,
      favoriteService: favoriteService,
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
    bool allFavorite = false,
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
          isFavorite: Value(allFavorite),
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
  group('Property 11: Favorite Toggle Correctness', () {
    // Property 11a: Adding to favorites makes article favorited
    Glados(any.articleCount).test(
      'Property 11a: Adding to favorites makes article favorited',
      (int count) async {
        final ctx = FavoriteTestContext.create();

        try {
          // Create feed and articles (not favorited)
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allFavorite: false,
          );

          // Add first article to favorites
          final result = await ctx.favoriteService.addToFavorites(
            articleIds[0],
          );
          expect(result.isRight(), isTrue);

          // Verify it's now favorited
          final isFav = await ctx.favoriteService.isFavorite(articleIds[0]);
          expect(isFav.isRight(), isTrue);
          expect(
            isFav.getOrElse(() => false),
            isTrue,
            reason: 'Article should be favorited after adding',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 11b: Removing from favorites makes article not favorited
    test(
      'Property 11b: Removing from favorites makes article not favorited',
      () async {
        final ctx = FavoriteTestContext.create();

        try {
          // Create feed and favorited article
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            1,
            allFavorite: true,
          );

          // Remove from favorites
          final result = await ctx.favoriteService.removeFromFavorites(
            articleIds[0],
          );
          expect(result.isRight(), isTrue);

          // Verify it's no longer favorited
          final isFav = await ctx.favoriteService.isFavorite(articleIds[0]);
          expect(isFav.isRight(), isTrue);
          expect(
            isFav.getOrElse(() => true),
            isFalse,
            reason: 'Article should not be favorited after removing',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 11c: Toggle changes favorite status
    test('Property 11c: Toggle changes favorite status', () async {
      final ctx = FavoriteTestContext.create();

      try {
        // Create feed and non-favorited article
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(
          feedId,
          1,
          allFavorite: false,
        );

        // Toggle to favorite
        var result = await ctx.favoriteService.toggleFavorite(articleIds[0]);
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => false), isTrue);

        // Verify favorited
        var isFav = await ctx.favoriteService.isFavorite(articleIds[0]);
        expect(isFav.getOrElse(() => false), isTrue);

        // Toggle back to not favorite
        result = await ctx.favoriteService.toggleFavorite(articleIds[0]);
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => true), isFalse);

        // Verify not favorited
        isFav = await ctx.favoriteService.isFavorite(articleIds[0]);
        expect(isFav.getOrElse(() => true), isFalse);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 11d: Double toggle returns to original state
    Glados(any.articleCount).test(
      'Property 11d: Double toggle returns to original state',
      (int count) async {
        final ctx = FavoriteTestContext.create();

        try {
          // Create feed and articles
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allFavorite: false,
          );

          // Get initial state
          final initialFav = await ctx.favoriteService.isFavorite(
            articleIds[0],
          );
          final initialState = initialFav.getOrElse(() => false);

          // Toggle twice
          await ctx.favoriteService.toggleFavorite(articleIds[0]);
          await ctx.favoriteService.toggleFavorite(articleIds[0]);

          // Verify back to original state
          final finalFav = await ctx.favoriteService.isFavorite(articleIds[0]);
          expect(
            finalFav.getOrElse(() => !initialState),
            equals(initialState),
            reason: 'Double toggle should return to original state',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 11e: Favorited articles appear in favorites list
    Glados(any.articleCount).test(
      'Property 11e: Favorited articles appear in favorites list',
      (int count) async {
        final ctx = FavoriteTestContext.create();

        try {
          // Create feed and articles
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            count,
            allFavorite: false,
          );

          // Favorite half of them
          final favoriteCount = (count / 2).ceil();
          for (var i = 0; i < favoriteCount; i++) {
            await ctx.favoriteService.addToFavorites(articleIds[i]);
          }

          // Get favorites list
          final result = await ctx.favoriteService.getFavoriteArticles();
          expect(result.isRight(), isTrue);

          final favorites = result.getOrElse(() => []);
          expect(
            favorites.length,
            equals(favoriteCount),
            reason: 'Favorites list should contain all favorited articles',
          );

          // Verify all favorited articles are in the list
          final favoriteIds = favorites.map((a) => a.id).toSet();
          for (var i = 0; i < favoriteCount; i++) {
            expect(
              favoriteIds.contains(articleIds[i]),
              isTrue,
              reason: 'Article ${articleIds[i]} should be in favorites list',
            );
          }
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 11f: Unfavorited articles don't appear in favorites list
    test(
      'Property 11f: Unfavorited articles removed from favorites list',
      () async {
        final ctx = FavoriteTestContext.create();

        try {
          // Create feed and favorited articles
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(
            feedId,
            5,
            allFavorite: true,
          );

          // Unfavorite one
          await ctx.favoriteService.removeFromFavorites(articleIds[0]);

          // Get favorites list
          final result = await ctx.favoriteService.getFavoriteArticles();
          final favorites = result.getOrElse(() => []);

          // Verify unfavorited article is not in list
          final favoriteIds = favorites.map((a) => a.id).toSet();
          expect(
            favoriteIds.contains(articleIds[0]),
            isFalse,
            reason: 'Unfavorited article should not be in favorites list',
          );
          expect(favorites.length, equals(4));
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 11g: Adding already favorited article is idempotent
    test('Property 11g: Adding already favorited is idempotent', () async {
      final ctx = FavoriteTestContext.create();

      try {
        // Create feed and favorited article
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(
          feedId,
          1,
          allFavorite: true,
        );

        // Add to favorites again
        final result = await ctx.favoriteService.addToFavorites(articleIds[0]);
        expect(result.isRight(), isTrue);

        // Verify still favorited
        final isFav = await ctx.favoriteService.isFavorite(articleIds[0]);
        expect(isFav.getOrElse(() => false), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 11h: Removing non-favorited article is idempotent
    test('Property 11h: Removing non-favorited is idempotent', () async {
      final ctx = FavoriteTestContext.create();

      try {
        // Create feed and non-favorited article
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(
          feedId,
          1,
          allFavorite: false,
        );

        // Remove from favorites
        final result = await ctx.favoriteService.removeFromFavorites(
          articleIds[0],
        );
        expect(result.isRight(), isTrue);

        // Verify still not favorited
        final isFav = await ctx.favoriteService.isFavorite(articleIds[0]);
        expect(isFav.getOrElse(() => true), isFalse);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 11i: Non-existent article returns error
    test('Property 11i: Non-existent article returns error', () async {
      final ctx = FavoriteTestContext.create();

      try {
        final result = await ctx.favoriteService.addToFavorites('non-existent');
        expect(result.isLeft(), isTrue);

        final toggleResult = await ctx.favoriteService.toggleFavorite(
          'non-existent',
        );
        expect(toggleResult.isLeft(), isTrue);

        final isFavResult = await ctx.favoriteService.isFavorite(
          'non-existent',
        );
        expect(isFavResult.isLeft(), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 11j: Empty favorites list when no articles favorited
    test('Property 11j: Empty favorites list when none favorited', () async {
      final ctx = FavoriteTestContext.create();

      try {
        // Create feed and non-favorited articles
        final feedId = await ctx.createTestFeed('feed-1');
        await ctx.createTestArticles(feedId, 5, allFavorite: false);

        // Get favorites list
        final result = await ctx.favoriteService.getFavoriteArticles();
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => []).length, equals(0));
      } finally {
        await ctx.dispose();
      }
    });
  });
}
