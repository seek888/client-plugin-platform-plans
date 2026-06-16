import 'package:glados/glados.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/entities/opml.dart';
import 'package:rss_reader/features/feed/data/services/opml_service_impl.dart';

/// **Property 1: OPML 往返一致性**
/// **Validates: Requirements 4.5**
///
/// FOR ALL 有效订阅源列表, 导出为 OPML 后再导入 SHALL 产生等价的订阅源列表（往返一致性）

// Custom generator for Feed with unique URLs using index
extension FeedAny on Any {
  Generator<Feed> feedWithIndex(int index) {
    return any.combine2(
      any.lowercaseLetters,
      any.lowercaseLetters,
      (String title, String urlPart) => Feed(
        id: 'feed-$index',
        title: title.isEmpty ? 'Feed $index' : '$title $index',
        url:
            'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index/rss.xml',
        link: 'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index',
        description: 'Description for feed $index',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Generator<Feed> get feed {
    return any.combine3(
      any.lowercaseLetters,
      any.lowercaseLetters,
      any.positiveIntOrZero,
      (String title, String urlPart, int index) => Feed(
        id: 'feed-$index',
        title: title.isEmpty ? 'Feed $index' : '$title $index',
        url:
            'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index/rss.xml',
        link: 'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index',
        description: 'Description for feed $index',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Generator<Feed> feedWithCategory(String categoryId) {
    return any.combine3(
      any.lowercaseLetters,
      any.lowercaseLetters,
      any.positiveIntOrZero,
      (String title, String urlPart, int index) => Feed(
        id: 'feed-$index',
        title: title.isEmpty ? 'Feed $index' : '$title $index',
        url:
            'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index/rss.xml',
        link: 'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index',
        description: 'Description for feed $index',
        categoryId: categoryId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Generator<FeedCategory> get feedCategory {
    return any.combine2(
      any.lowercaseLetters,
      any.positiveIntOrZero,
      (String name, int index) => FeedCategory(
        id: 'category-$index',
        name: name.isEmpty ? 'Category $index' : '$name $index',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}

void main() {
  group('OPMLService Round-Trip Property Tests', () {
    final opmlService = OPMLServiceImpl();

    Glados(any.feed).test(
      'Property 1: Single feed export-import round-trip preserves essential data',
      (Feed feed) {
        // 导出为 OPML
        final exportResult = opmlService.exportToOPML([feed]);
        expect(exportResult.isRight(), isTrue, reason: 'Export should succeed');

        final opmlContent = exportResult.getOrElse(() => '');
        expect(
          opmlContent.isNotEmpty,
          isTrue,
          reason: 'OPML content should not be empty',
        );

        // 再导入
        final importResult = opmlService.parseOPML(opmlContent);
        expect(importResult.isRight(), isTrue, reason: 'Import should succeed');

        final importedFeeds = importResult.getOrElse(() => []);
        expect(
          importedFeeds.length,
          equals(1),
          reason: 'Should have exactly one feed',
        );

        // 验证等价性
        final importedFeed = importedFeeds.first;
        expect(
          importedFeed.title,
          equals(feed.title),
          reason: 'Title should be preserved',
        );
        expect(
          importedFeed.xmlUrl,
          equals(feed.url),
          reason: 'URL should be preserved',
        );

        if (feed.link != null && feed.link!.isNotEmpty) {
          expect(
            importedFeed.htmlUrl,
            equals(feed.link),
            reason: 'Link should be preserved',
          );
        }
      },
    );

    Glados2<Feed, Feed>(any.feedWithIndex(0), any.feedWithIndex(1)).test(
      'Property 1b: Multiple feeds export-import round-trip preserves all feeds',
      (Feed feed1, Feed feed2) {
        final feeds = [feed1, feed2];

        // 导出为 OPML
        final exportResult = opmlService.exportToOPML(feeds);
        expect(exportResult.isRight(), isTrue, reason: 'Export should succeed');

        final opmlContent = exportResult.getOrElse(() => '');

        // 再导入
        final importResult = opmlService.parseOPML(opmlContent);
        expect(importResult.isRight(), isTrue, reason: 'Import should succeed');

        final importedFeeds = importResult.getOrElse(() => []);
        expect(
          importedFeeds.length,
          equals(feeds.length),
          reason: 'Number of feeds should be preserved',
        );

        // 验证每个订阅源都被保留
        for (final originalFeed in feeds) {
          final matchingFeed = importedFeeds.firstWhere(
            (f) => f.xmlUrl == originalFeed.url,
            orElse: () => throw StateError(
              'Feed with URL ${originalFeed.url} not found after round-trip',
            ),
          );

          expect(matchingFeed.title, equals(originalFeed.title));
          expect(matchingFeed.xmlUrl, equals(originalFeed.url));
        }
      },
    );

    Glados(any.feedCategory).test(
      'Property 1c: Feed with category export-import round-trip preserves category',
      (FeedCategory category) {
        final feed = Feed(
          id: 'test-feed',
          title: 'Test Feed',
          url: 'https://example.com/feed.xml',
          link: 'https://example.com',
          categoryId: category.id,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // 导出为 OPML（带分类信息）
        final exportResult = opmlService.exportToOPML(
          [feed],
          categories: [category],
        );
        expect(exportResult.isRight(), isTrue, reason: 'Export should succeed');

        final opmlContent = exportResult.getOrElse(() => '');

        // 再导入
        final importResult = opmlService.parseOPML(opmlContent);
        expect(importResult.isRight(), isTrue, reason: 'Import should succeed');

        final importedFeeds = importResult.getOrElse(() => []);
        expect(
          importedFeeds.length,
          equals(1),
          reason: 'Should have exactly one feed',
        );

        // 验证分类被保留
        final importedFeed = importedFeeds.first;
        expect(
          importedFeed.category,
          equals(category.name),
          reason: 'Category name should be preserved',
        );
      },
    );
  });

  group('OPMLService Validation Tests', () {
    final opmlService = OPMLServiceImpl();

    test('isValidOPML returns false for empty content', () {
      expect(opmlService.isValidOPML(''), isFalse);
      expect(opmlService.isValidOPML('   '), isFalse);
    });

    test('isValidOPML returns false for invalid XML', () {
      expect(opmlService.isValidOPML('<html></html>'), isFalse);
      expect(opmlService.isValidOPML('<rss></rss>'), isFalse);
    });

    test('isValidOPML returns true for valid OPML', () {
      const validOpml = '''<?xml version="1.0" encoding="UTF-8"?>
<opml version="2.0">
  <head><title>Test</title></head>
  <body>
    <outline text="Test" xmlUrl="https://example.com/feed.xml"/>
  </body>
</opml>''';
      expect(opmlService.isValidOPML(validOpml), isTrue);
    });

    test('parseOPML returns failure for empty content', () {
      final result = opmlService.parseOPML('');
      expect(result.isLeft(), isTrue);
    });

    test('parseOPML returns failure for invalid OPML', () {
      final result = opmlService.parseOPML('<html></html>');
      expect(result.isLeft(), isTrue);
    });
  });

  group('OPMLService convertToFeeds Tests', () {
    final opmlService = OPMLServiceImpl();

    test('convertToFeeds creates valid Feed objects', () {
      final opmlFeeds = [
        const OPMLFeed(
          title: 'Test Feed',
          xmlUrl: 'https://example.com/feed.xml',
          htmlUrl: 'https://example.com',
          description: 'A test feed',
        ),
      ];

      final feeds = opmlService.convertToFeeds(opmlFeeds);

      expect(feeds.length, equals(1));
      expect(feeds.first.title, equals('Test Feed'));
      expect(feeds.first.url, equals('https://example.com/feed.xml'));
      expect(feeds.first.link, equals('https://example.com'));
      expect(feeds.first.description, equals('A test feed'));
      expect(feeds.first.id, isNotEmpty);
    });

    test('convertToFeeds filters out invalid feeds', () {
      final opmlFeeds = [
        const OPMLFeed(
          title: 'Valid Feed',
          xmlUrl: 'https://example.com/feed.xml',
        ),
        const OPMLFeed(
          title: 'Invalid Feed',
          xmlUrl: '', // Invalid - empty URL
        ),
      ];

      final feeds = opmlService.convertToFeeds(opmlFeeds);

      expect(feeds.length, equals(1));
      expect(feeds.first.title, equals('Valid Feed'));
    });
  });
}
