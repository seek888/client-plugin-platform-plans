import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/article/data/services/article_navigation_service_impl.dart';
import 'package:rss_reader/features/article/domain/services/article_navigation_service.dart';

/// **Property 18: 文章导航正确性**
/// **Validates: Requirements 20.1, 20.2**
///
/// 20.1: WHEN 用户点击底部上一篇按钮 THEN THE RSS_Client SHALL 切换到同订阅源的上一篇文章
/// 20.2: WHEN 用户点击底部下一篇按钮 THEN THE RSS_Client SHALL 切换到同订阅源的下一篇文章

// Custom generators for navigation testing
extension NavigationGenerators on Any {
  /// Generator for article count (2-20 articles, need at least 2 for navigation)
  Generator<int> get articleCount {
    return any.intInRange(2, 20);
  }

  /// Generator for valid index within a list
  Generator<int> validIndexFor(int listLength) {
    return any.intInRange(0, listLength - 1);
  }
}

/// Helper to create fresh database and service for each test
class NavigationTestContext {
  final AppDatabase database;
  final ArticleDao articleDao;
  final FeedDao feedDao;
  final ArticleNavigationService navigationService;

  NavigationTestContext._({
    required this.database,
    required this.articleDao,
    required this.feedDao,
    required this.navigationService,
  });

  factory NavigationTestContext.create() {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final articleDao = ArticleDao(database);
    final feedDao = FeedDao(database);
    final navigationService = ArticleNavigationServiceImpl(
      articleDao: articleDao,
    );
    return NavigationTestContext._(
      database: database,
      articleDao: articleDao,
      feedDao: feedDao,
      navigationService: navigationService,
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

  /// Create test articles with sequential dates (newest first in list)
  /// Returns article IDs in order from newest to oldest
  Future<List<String>> createTestArticles(String feedId, int count) async {
    final articleIds = <String>[];
    final baseTime = DateTime.now();

    for (var i = 0; i < count; i++) {
      final articleId = '$feedId-article-$i';
      // Article 0 is newest, article count-1 is oldest
      await articleDao.insertArticle(
        ArticlesTableCompanion(
          id: Value(articleId),
          feedId: Value(feedId),
          title: Value('Article $i'),
          link: Value('https://example.com/$feedId/article-$i'),
          publishedAt: Value(baseTime.subtract(Duration(hours: i))),
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
  group('Property 18: Article Navigation Correctness', () {
    // Property 18a: Next article returns older article
    Glados(any.articleCount).test(
      'Property 18a: Next article returns older article',
      (int count) async {
        final ctx = NavigationTestContext.create();

        try {
          // Create feed and articles
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(feedId, count);

          // Get next article from the first (newest) article
          final result = await ctx.navigationService.getNextArticle(
            articleIds[0],
            feedId,
          );

          expect(result.isRight(), isTrue);
          final nextArticle = result.getOrElse(() => null);

          if (count > 1) {
            expect(nextArticle, isNotNull);
            expect(
              nextArticle!.id,
              equals(articleIds[1]),
              reason: 'Next article should be the second article (older)',
            );
          }
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 18b: Previous article returns newer article
    Glados(
      any.articleCount,
    ).test('Property 18b: Previous article returns newer article', (
      int count,
    ) async {
      final ctx = NavigationTestContext.create();

      try {
        // Create feed and articles
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(feedId, count);

        // Get previous article from the last (oldest) article
        final result = await ctx.navigationService.getPreviousArticle(
          articleIds[count - 1],
          feedId,
        );

        expect(result.isRight(), isTrue);
        final prevArticle = result.getOrElse(() => null);

        if (count > 1) {
          expect(prevArticle, isNotNull);
          expect(
            prevArticle!.id,
            equals(articleIds[count - 2]),
            reason:
                'Previous article should be the second-to-last article (newer)',
          );
        }
      } finally {
        await ctx.dispose();
      }
    });

    // Property 18c: First article has no previous
    Glados(any.articleCount).test(
      'Property 18c: First article has no previous',
      (int count) async {
        final ctx = NavigationTestContext.create();

        try {
          // Create feed and articles
          final feedId = await ctx.createTestFeed('feed-1');
          final articleIds = await ctx.createTestArticles(feedId, count);

          // Get previous article from the first (newest) article
          final result = await ctx.navigationService.getPreviousArticle(
            articleIds[0],
            feedId,
          );

          expect(result.isRight(), isTrue);
          expect(
            result.getOrElse(() => null),
            isNull,
            reason: 'First article should have no previous article',
          );

          // Also check hasPreviousArticle
          final hasPrev = await ctx.navigationService.hasPreviousArticle(
            articleIds[0],
            feedId,
          );
          expect(hasPrev.getOrElse(() => true), isFalse);
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 18d: Last article has no next
    Glados(any.articleCount).test('Property 18d: Last article has no next', (
      int count,
    ) async {
      final ctx = NavigationTestContext.create();

      try {
        // Create feed and articles
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(feedId, count);

        // Get next article from the last (oldest) article
        final result = await ctx.navigationService.getNextArticle(
          articleIds[count - 1],
          feedId,
        );

        expect(result.isRight(), isTrue);
        expect(
          result.getOrElse(() => null),
          isNull,
          reason: 'Last article should have no next article',
        );

        // Also check hasNextArticle
        final hasNext = await ctx.navigationService.hasNextArticle(
          articleIds[count - 1],
          feedId,
        );
        expect(hasNext.getOrElse(() => true), isFalse);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 18e: Navigation is consistent (next then previous returns to same)
    Glados(any.articleCount).test('Property 18e: Navigation is consistent', (
      int count,
    ) async {
      if (count < 2) return; // Need at least 2 articles

      final ctx = NavigationTestContext.create();

      try {
        // Create feed and articles
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(feedId, count);

        // Start from first article, go next, then previous
        final nextResult = await ctx.navigationService.getNextArticle(
          articleIds[0],
          feedId,
        );
        expect(nextResult.isRight(), isTrue);
        final nextArticle = nextResult.getOrElse(() => null);
        expect(nextArticle, isNotNull);

        final prevResult = await ctx.navigationService.getPreviousArticle(
          nextArticle!.id,
          feedId,
        );
        expect(prevResult.isRight(), isTrue);
        final prevArticle = prevResult.getOrElse(() => null);

        expect(
          prevArticle?.id,
          equals(articleIds[0]),
          reason: 'Going next then previous should return to original article',
        );
      } finally {
        await ctx.dispose();
      }
    });

    // Property 18f: Article position is correct
    test('Property 18f: Article position is correct', () async {
      final ctx = NavigationTestContext.create();

      try {
        // Create feed and 5 articles
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(feedId, 5);

        // Check position of middle article
        final result = await ctx.navigationService.getArticlePosition(
          articleIds[2],
          feedId,
        );

        expect(result.isRight(), isTrue);
        final position = result.getOrElse(
          () => throw StateError('Expected Right'),
        );

        expect(position.currentIndex, equals(3)); // 1-based index
        expect(position.totalCount, equals(5));
        expect(position.hasPrevious, isTrue);
        expect(position.hasNext, isTrue);
        expect(position.isFirst, isFalse);
        expect(position.isLast, isFalse);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 18g: First article position is correct
    test('Property 18g: First article position is correct', () async {
      final ctx = NavigationTestContext.create();

      try {
        // Create feed and 5 articles
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(feedId, 5);

        // Check position of first article
        final result = await ctx.navigationService.getArticlePosition(
          articleIds[0],
          feedId,
        );

        expect(result.isRight(), isTrue);
        final position = result.getOrElse(
          () => throw StateError('Expected Right'),
        );

        expect(position.currentIndex, equals(1));
        expect(position.totalCount, equals(5));
        expect(position.hasPrevious, isFalse);
        expect(position.hasNext, isTrue);
        expect(position.isFirst, isTrue);
        expect(position.isLast, isFalse);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 18h: Last article position is correct
    test('Property 18h: Last article position is correct', () async {
      final ctx = NavigationTestContext.create();

      try {
        // Create feed and 5 articles
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(feedId, 5);

        // Check position of last article
        final result = await ctx.navigationService.getArticlePosition(
          articleIds[4],
          feedId,
        );

        expect(result.isRight(), isTrue);
        final position = result.getOrElse(
          () => throw StateError('Expected Right'),
        );

        expect(position.currentIndex, equals(5));
        expect(position.totalCount, equals(5));
        expect(position.hasPrevious, isTrue);
        expect(position.hasNext, isFalse);
        expect(position.isFirst, isFalse);
        expect(position.isLast, isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 18i: Single article has no navigation
    test('Property 18i: Single article has no navigation', () async {
      final ctx = NavigationTestContext.create();

      try {
        // Create feed and 1 article
        final feedId = await ctx.createTestFeed('feed-1');
        final articleIds = await ctx.createTestArticles(feedId, 1);

        // Check navigation
        final prevResult = await ctx.navigationService.getPreviousArticle(
          articleIds[0],
          feedId,
        );
        final nextResult = await ctx.navigationService.getNextArticle(
          articleIds[0],
          feedId,
        );

        expect(prevResult.getOrElse(() => null), isNull);
        expect(nextResult.getOrElse(() => null), isNull);

        // Check position
        final posResult = await ctx.navigationService.getArticlePosition(
          articleIds[0],
          feedId,
        );
        final position = posResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        expect(position.currentIndex, equals(1));
        expect(position.totalCount, equals(1));
        expect(position.hasPrevious, isFalse);
        expect(position.hasNext, isFalse);
        expect(position.isFirst, isTrue);
        expect(position.isLast, isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    // Property 18j: Navigation only within same feed
    test('Property 18j: Navigation only within same feed', () async {
      final ctx = NavigationTestContext.create();

      try {
        // Create two feeds with articles
        final feedId1 = await ctx.createTestFeed('feed-1');
        final feedId2 = await ctx.createTestFeed('feed-2');
        final articleIds1 = await ctx.createTestArticles(feedId1, 3);
        await ctx.createTestArticles(feedId2, 3);

        // Navigate from feed-1's first article
        final nextResult = await ctx.navigationService.getNextArticle(
          articleIds1[0],
          feedId1,
        );

        expect(nextResult.isRight(), isTrue);
        final nextArticle = nextResult.getOrElse(() => null);

        // Should get feed-1's second article, not feed-2's
        expect(nextArticle, isNotNull);
        expect(nextArticle!.feedId, equals(feedId1));
        expect(nextArticle.id, equals(articleIds1[1]));
      } finally {
        await ctx.dispose();
      }
    });

    // Property 18k: Non-existent article returns error for position
    test('Property 18k: Non-existent article returns error', () async {
      final ctx = NavigationTestContext.create();

      try {
        final feedId = await ctx.createTestFeed('feed-1');
        await ctx.createTestArticles(feedId, 3);

        final result = await ctx.navigationService.getArticlePosition(
          'non-existent',
          feedId,
        );

        expect(result.isLeft(), isTrue);
      } finally {
        await ctx.dispose();
      }
    });
  });
}
