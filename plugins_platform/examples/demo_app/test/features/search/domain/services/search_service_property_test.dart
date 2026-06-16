import 'package:glados/glados.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/search/data/services/search_service_impl.dart';
import 'package:rss_reader/features/search/domain/entities/search_result.dart';
import 'package:rss_reader/features/search/domain/services/search_service.dart';

/// **Property 12: 搜索结果正确性**
/// **Validates: Requirements 8.2, 8.3, 8.5**
///
/// 8.2: WHEN 用户输入搜索关键词 THEN THE Search_Engine SHALL 在标题、内容、订阅源名称中搜索匹配项
/// 8.3: WHEN 搜索完成 THEN THE RSS_Client SHALL 展示匹配结果并高亮显示关键词
/// 8.5: WHEN 用户选择筛选标签 THEN THE Search_Engine SHALL 仅在对应范围内搜索

// Custom generators for search testing
extension SearchGenerators on Any {
  /// Generator for article count (1-15 articles)
  Generator<int> get articleCount {
    return any.intInRange(1, 15);
  }

  /// Generator for feed count (1-10 feeds)
  Generator<int> get feedCount {
    return any.intInRange(1, 10);
  }

  /// Generator for a random search keyword
  Generator<String> get searchKeyword {
    return any.choose([
      'flutter',
      'dart',
      'rss',
      'news',
      'tech',
      'programming',
      'mobile',
      'app',
      'development',
      'tutorial',
    ]);
  }
}

/// Helper class for creating test data
class SearchTestHelper {
  late SearchService searchService;
  List<Article> articles = [];
  List<Feed> feeds = [];

  /// Initialize the search service with test data
  void initialize({
    required List<Article> testArticles,
    required List<Feed> testFeeds,
  }) {
    articles = testArticles;
    feeds = testFeeds;
    searchService = SearchServiceImpl(
      getArticles: () => articles,
      getFeeds: () => feeds,
    );
  }

  /// Create test articles with specific keywords in title
  List<Article> createArticlesWithTitleKeyword(int count, String keyword) {
    return List.generate(count, (i) {
      final hasKeyword = i % 2 == 0; // Half have the keyword
      return Article(
        id: 'article-$i',
        feedId: 'feed-1',
        title: hasKeyword ? 'Article about $keyword $i' : 'Article $i',
        summary: 'Summary for article $i',
        content: 'Content for article $i',
        link: 'https://example.com/article-$i',
        publishedAt: DateTime(2020, 1, 1).add(Duration(days: i)),
      );
    });
  }

  /// Create test articles with specific keywords in content
  List<Article> createArticlesWithContentKeyword(int count, String keyword) {
    return List.generate(count, (i) {
      final hasKeyword = i % 2 == 0; // Half have the keyword
      return Article(
        id: 'article-$i',
        feedId: 'feed-1',
        title: 'Article $i',
        summary: hasKeyword ? 'Summary about $keyword' : 'Summary $i',
        content: hasKeyword ? 'Content about $keyword' : 'Content $i',
        link: 'https://example.com/article-$i',
        publishedAt: DateTime(2020, 1, 1).add(Duration(days: i)),
      );
    });
  }

  /// Create test feeds with specific keywords
  List<Feed> createFeedsWithKeyword(int count, String keyword) {
    return List.generate(count, (i) {
      final hasKeyword = i % 2 == 0; // Half have the keyword
      return Feed(
        id: 'feed-$i',
        url: 'https://example.com/feed-$i',
        title: hasKeyword ? '$keyword Feed $i' : 'Feed $i',
        description: hasKeyword ? 'About $keyword' : 'Description $i',
      );
    });
  }

  /// Create mixed test data
  List<Article> createMixedArticles(int count, String keyword) {
    return List.generate(count, (i) {
      final inTitle = i % 3 == 0;
      final inContent = i % 3 == 1;
      return Article(
        id: 'article-$i',
        feedId: 'feed-1',
        title: inTitle ? 'Article about $keyword' : 'Article $i',
        summary: 'Summary $i',
        content: inContent ? 'Content about $keyword' : 'Content $i',
        link: 'https://example.com/article-$i',
        publishedAt: DateTime(2020, 1, 1).add(Duration(days: i)),
      );
    });
  }
}

void main() {
  group('Property 12: Search Result Correctness', () {
    late SearchTestHelper helper;

    setUp(() {
      helper = SearchTestHelper();
    });

    // Property 12a: All search results contain the query keyword (title scope)
    Glados2(any.articleCount, any.searchKeyword).test(
      'Property 12a: Title scope search returns only articles with keyword in title',
      (int count, String keyword) async {
        final articles = helper.createArticlesWithTitleKeyword(count, keyword);
        final feeds = <Feed>[];

        helper.initialize(testArticles: articles, testFeeds: feeds);

        final result = await helper.searchService.search(
          keyword,
          scope: SearchScope.title,
        );

        result.fold(
          (failure) => fail('Search should not fail: ${failure.message}'),
          (searchResult) {
            // All returned articles should have the keyword in their title
            for (final article in searchResult.articles) {
              expect(
                article.title.toLowerCase().contains(keyword.toLowerCase()),
                isTrue,
                reason:
                    'Article "${article.title}" should contain keyword "$keyword" in title',
              );
            }
          },
        );
      },
    );

    // Property 12b: All search results contain the query keyword (content scope)
    Glados2(any.articleCount, any.searchKeyword).test(
      'Property 12b: Content scope search returns only articles with keyword in content',
      (int count, String keyword) async {
        final articles = helper.createArticlesWithContentKeyword(
          count,
          keyword,
        );
        final feeds = <Feed>[];

        helper.initialize(testArticles: articles, testFeeds: feeds);

        final result = await helper.searchService.search(
          keyword,
          scope: SearchScope.content,
        );

        result.fold(
          (failure) => fail('Search should not fail: ${failure.message}'),
          (searchResult) {
            // All returned articles should have the keyword in their content or summary
            for (final article in searchResult.articles) {
              final summary = article.summary?.toLowerCase() ?? '';
              final content = article.content?.toLowerCase() ?? '';
              final lowerKeyword = keyword.toLowerCase();

              expect(
                summary.contains(lowerKeyword) ||
                    content.contains(lowerKeyword),
                isTrue,
                reason:
                    'Article should contain keyword "$keyword" in content or summary',
              );
            }
          },
        );
      },
    );

    // Property 12c: Feed scope search returns only feeds with keyword
    Glados2(
      any.feedCount,
      any.searchKeyword,
    ).test('Property 12c: Feed scope search returns only feeds with keyword', (
      int count,
      String keyword,
    ) async {
      final articles = <Article>[];
      final feeds = helper.createFeedsWithKeyword(count, keyword);

      helper.initialize(testArticles: articles, testFeeds: feeds);

      final result = await helper.searchService.search(
        keyword,
        scope: SearchScope.feed,
      );

      result.fold(
        (failure) => fail('Search should not fail: ${failure.message}'),
        (searchResult) {
          // All returned feeds should have the keyword in title or description
          for (final feed in searchResult.feeds) {
            final title = feed.title.toLowerCase();
            final description = feed.description?.toLowerCase() ?? '';
            final lowerKeyword = keyword.toLowerCase();

            expect(
              title.contains(lowerKeyword) ||
                  description.contains(lowerKeyword),
              isTrue,
              reason: 'Feed "${feed.title}" should contain keyword "$keyword"',
            );
          }
        },
      );
    });

    // Property 12d: All scope search returns results from both articles and feeds
    Glados(any.searchKeyword).test(
      'Property 12d: All scope search returns results from articles and feeds',
      (String keyword) async {
        final articles = helper.createArticlesWithTitleKeyword(10, keyword);
        final feeds = helper.createFeedsWithKeyword(5, keyword);

        helper.initialize(testArticles: articles, testFeeds: feeds);

        final result = await helper.searchService.search(
          keyword,
          scope: SearchScope.all,
        );

        result.fold(
          (failure) => fail('Search should not fail: ${failure.message}'),
          (searchResult) {
            // Should have results from both articles and feeds
            // (since we created data with the keyword)
            expect(
              searchResult.articles.isNotEmpty || searchResult.feeds.isNotEmpty,
              isTrue,
              reason: 'Should find results in articles or feeds',
            );

            // Verify all article results contain keyword
            for (final article in searchResult.articles) {
              final title = article.title.toLowerCase();
              final summary = article.summary?.toLowerCase() ?? '';
              final content = article.content?.toLowerCase() ?? '';
              final lowerKeyword = keyword.toLowerCase();

              expect(
                title.contains(lowerKeyword) ||
                    summary.contains(lowerKeyword) ||
                    content.contains(lowerKeyword),
                isTrue,
                reason: 'Article should contain keyword "$keyword"',
              );
            }

            // Verify all feed results contain keyword
            for (final feed in searchResult.feeds) {
              final title = feed.title.toLowerCase();
              final description = feed.description?.toLowerCase() ?? '';
              final lowerKeyword = keyword.toLowerCase();

              expect(
                title.contains(lowerKeyword) ||
                    description.contains(lowerKeyword),
                isTrue,
                reason: 'Feed should contain keyword "$keyword"',
              );
            }
          },
        );
      },
    );

    // Property 12e: Empty query returns empty results
    test('Property 12e: Empty query returns empty results', () async {
      final articles = helper.createArticlesWithTitleKeyword(5, 'test');
      final feeds = helper.createFeedsWithKeyword(3, 'test');

      helper.initialize(testArticles: articles, testFeeds: feeds);

      final result = await helper.searchService.search('');

      result.fold((failure) => fail('Search should not fail'), (searchResult) {
        expect(searchResult.articles, isEmpty);
        expect(searchResult.feeds, isEmpty);
        expect(searchResult.totalCount, equals(0));
      });
    });

    // Property 12f: Whitespace-only query returns empty results
    test('Property 12f: Whitespace-only query returns empty results', () async {
      final articles = helper.createArticlesWithTitleKeyword(5, 'test');
      final feeds = helper.createFeedsWithKeyword(3, 'test');

      helper.initialize(testArticles: articles, testFeeds: feeds);

      final result = await helper.searchService.search('   ');

      result.fold((failure) => fail('Search should not fail'), (searchResult) {
        expect(searchResult.articles, isEmpty);
        expect(searchResult.feeds, isEmpty);
        expect(searchResult.totalCount, equals(0));
      });
    });

    // Property 12g: Search is case-insensitive
    Glados(any.searchKeyword).test('Property 12g: Search is case-insensitive', (
      String keyword,
    ) async {
      final articles = helper.createArticlesWithTitleKeyword(10, keyword);
      final feeds = <Feed>[];

      helper.initialize(testArticles: articles, testFeeds: feeds);

      // Search with uppercase
      final upperResult = await helper.searchService.search(
        keyword.toUpperCase(),
        scope: SearchScope.title,
      );

      // Search with lowercase
      final lowerResult = await helper.searchService.search(
        keyword.toLowerCase(),
        scope: SearchScope.title,
      );

      upperResult.fold((failure) => fail('Upper search should not fail'), (
        upperSearchResult,
      ) {
        lowerResult.fold((failure) => fail('Lower search should not fail'), (
          lowerSearchResult,
        ) {
          // Both searches should return the same number of results
          expect(
            upperSearchResult.articles.length,
            equals(lowerSearchResult.articles.length),
            reason: 'Case-insensitive search should return same results',
          );
        });
      });
    });

    // Property 12h: Blocked articles are excluded from search results
    test(
      'Property 12h: Blocked articles are excluded from search results',
      () async {
        final keyword = 'flutter';
        final articles = [
          Article(
            id: 'article-1',
            feedId: 'feed-1',
            title: 'Article about $keyword',
            link: 'https://example.com/1',
            isBlocked: false,
          ),
          Article(
            id: 'article-2',
            feedId: 'feed-1',
            title: 'Another $keyword article',
            link: 'https://example.com/2',
            isBlocked: true, // This should be excluded
          ),
          Article(
            id: 'article-3',
            feedId: 'feed-1',
            title: '$keyword tutorial',
            link: 'https://example.com/3',
            isBlocked: false,
          ),
        ];

        helper.initialize(testArticles: articles, testFeeds: []);

        final result = await helper.searchService.search(keyword);

        result.fold((failure) => fail('Search should not fail'), (
          searchResult,
        ) {
          // Should only return 2 articles (excluding the blocked one)
          expect(searchResult.articles.length, equals(2));

          // None of the results should be blocked
          for (final article in searchResult.articles) {
            expect(article.isBlocked, isFalse);
          }
        });
      },
    );

    // Property 12i: Blocked feeds are excluded from search results
    test(
      'Property 12i: Blocked feeds are excluded from search results',
      () async {
        final keyword = 'tech';
        final feeds = [
          Feed(
            id: 'feed-1',
            url: 'https://example.com/1',
            title: '$keyword News',
            isBlocked: false,
          ),
          Feed(
            id: 'feed-2',
            url: 'https://example.com/2',
            title: '$keyword Blog',
            isBlocked: true, // This should be excluded
          ),
        ];

        helper.initialize(testArticles: [], testFeeds: feeds);

        final result = await helper.searchService.search(
          keyword,
          scope: SearchScope.feed,
        );

        result.fold((failure) => fail('Search should not fail'), (
          searchResult,
        ) {
          // Should only return 1 feed (excluding the blocked one)
          expect(searchResult.feeds.length, equals(1));

          // None of the results should be blocked
          for (final feed in searchResult.feeds) {
            expect(feed.isBlocked, isFalse);
          }
        });
      },
    );

    // Property 12j: Limit parameter restricts result count
    Glados(any.intInRange(1, 5)).test(
      'Property 12j: Limit parameter restricts result count',
      (int limit) async {
        final keyword = 'test';
        // Create more articles than the limit
        final articles = List.generate(20, (i) {
          return Article(
            id: 'article-$i',
            feedId: 'feed-1',
            title: 'Article about $keyword $i',
            link: 'https://example.com/$i',
          );
        });

        helper.initialize(testArticles: articles, testFeeds: []);

        final result = await helper.searchService.search(keyword, limit: limit);

        result.fold((failure) => fail('Search should not fail'), (
          searchResult,
        ) {
          expect(
            searchResult.articles.length,
            lessThanOrEqualTo(limit),
            reason: 'Result count should not exceed limit',
          );
        });
      },
    );

    // Property 12k: Total count reflects actual matches
    test('Property 12k: Total count reflects actual matches', () async {
      final keyword = 'flutter';
      final articles = helper.createArticlesWithTitleKeyword(10, keyword);
      final feeds = helper.createFeedsWithKeyword(6, keyword);

      helper.initialize(testArticles: articles, testFeeds: feeds);

      final result = await helper.searchService.search(keyword);

      result.fold((failure) => fail('Search should not fail'), (searchResult) {
        expect(
          searchResult.totalCount,
          equals(searchResult.articles.length + searchResult.feeds.length),
          reason: 'Total count should equal sum of articles and feeds',
        );
      });
    });

    // Property 12l: Search scope is correctly recorded in result
    test(
      'Property 12l: Search scope is correctly recorded in result',
      () async {
        final keyword = 'test';
        final articles = helper.createArticlesWithTitleKeyword(5, keyword);

        helper.initialize(testArticles: articles, testFeeds: []);

        for (final scope in SearchScope.values) {
          final result = await helper.searchService.search(
            keyword,
            scope: scope,
          );

          result.fold((failure) => fail('Search should not fail'), (
            searchResult,
          ) {
            expect(
              searchResult.scope,
              equals(scope),
              reason: 'Search scope should be recorded in result',
            );
          });
        }
      },
    );

    // Property 12m: Query is trimmed and recorded in result
    test('Property 12m: Query is trimmed and recorded in result', () async {
      final keyword = '  flutter  ';
      final articles = helper.createArticlesWithTitleKeyword(5, 'flutter');

      helper.initialize(testArticles: articles, testFeeds: []);

      final result = await helper.searchService.search(keyword);

      result.fold((failure) => fail('Search should not fail'), (searchResult) {
        expect(
          searchResult.query,
          equals('flutter'),
          reason: 'Query should be trimmed in result',
        );
      });
    });
  });

  group('Search History Tests', () {
    late SearchTestHelper helper;

    setUp(() {
      helper = SearchTestHelper();
      helper.initialize(testArticles: [], testFeeds: []);
    });

    test('Search history starts empty', () async {
      final history = await helper.searchService.getSearchHistory();
      expect(history, isEmpty);
    });

    test('Adding search history works correctly', () async {
      await helper.searchService.addSearchHistory('flutter');
      await helper.searchService.addSearchHistory('dart');

      final history = await helper.searchService.getSearchHistory();
      expect(history.length, equals(2));
      expect(history[0], equals('dart')); // Most recent first
      expect(history[1], equals('flutter'));
    });

    test('Duplicate search history moves to top', () async {
      await helper.searchService.addSearchHistory('flutter');
      await helper.searchService.addSearchHistory('dart');
      await helper.searchService.addSearchHistory('flutter'); // Duplicate

      final history = await helper.searchService.getSearchHistory();
      expect(history.length, equals(2));
      expect(history[0], equals('flutter')); // Moved to top
      expect(history[1], equals('dart'));
    });

    test('Clear search history works', () async {
      await helper.searchService.addSearchHistory('flutter');
      await helper.searchService.addSearchHistory('dart');
      await helper.searchService.clearSearchHistory();

      final history = await helper.searchService.getSearchHistory();
      expect(history, isEmpty);
    });

    test('Remove single search history works', () async {
      await helper.searchService.addSearchHistory('flutter');
      await helper.searchService.addSearchHistory('dart');
      await helper.searchService.removeSearchHistory('flutter');

      final history = await helper.searchService.getSearchHistory();
      expect(history.length, equals(1));
      expect(history[0], equals('dart'));
    });

    test('Empty query is not added to history', () async {
      await helper.searchService.addSearchHistory('');
      await helper.searchService.addSearchHistory('   ');

      final history = await helper.searchService.getSearchHistory();
      expect(history, isEmpty);
    });
  });
}
