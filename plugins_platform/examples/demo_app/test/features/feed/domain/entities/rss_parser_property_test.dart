import 'package:glados/glados.dart';
import 'package:rss_reader/features/feed/domain/entities/opml.dart';

/// **Property 7: OPML 解析正确性**
/// **Validates: Requirements 4.2, 4.3**
///
/// *For any* 有效的 OPML 文件内容，解析后应产生正确数量的订阅源，
/// 且每个订阅源的 URL 和标题与 OPML 中定义的一致。

// Custom generator for valid OPML feeds with unique URLs
extension OPMLGenerators on Any {
  /// Generate a valid OPML feed with unique URL based on index
  Generator<OPMLFeed> validOpmlFeed(int index) {
    return any.combine2(
      any.lowercaseLetters,
      any.lowercaseLetters,
      (String titlePart, String urlPart) => OPMLFeed(
        title: titlePart.isEmpty ? 'Feed $index' : '$titlePart $index',
        xmlUrl:
            'https://example$index.com/${urlPart.isEmpty ? 'rss' : urlPart}/feed.xml',
        htmlUrl: 'https://example$index.com/${urlPart.isEmpty ? '' : urlPart}',
        description: 'Description for feed $index',
        category: null,
      ),
    );
  }

  /// Generate a valid OPML feed with category
  Generator<OPMLFeed> validCategorizedOpmlFeed(int index) {
    return any.combine3(
      any.lowercaseLetters,
      any.lowercaseLetters,
      any.lowercaseLetters,
      (String titlePart, String urlPart, String categoryPart) => OPMLFeed(
        title: titlePart.isEmpty ? 'Feed $index' : '$titlePart $index',
        xmlUrl:
            'https://example$index.com/${urlPart.isEmpty ? 'rss' : urlPart}/feed.xml',
        htmlUrl: 'https://example$index.com/${urlPart.isEmpty ? '' : urlPart}',
        description: 'Description for feed $index',
        category: categoryPart.isEmpty ? 'Category' : categoryPart,
      ),
    );
  }
}

void main() {
  group('Property 7: OPML 解析正确性', () {
    // Test single feed parsing correctness
    Glados(any.validOpmlFeed(0)).test(
      'Single feed: parsed feed count equals original count',
      (OPMLFeed feed) {
        // Create OPML document with single feed
        final originalDocument = OPMLDocument(
          title: 'Test OPML',
          feeds: [feed],
        );

        // Convert to XML and parse back
        final xmlString = originalDocument.toXmlString();
        final parsedDocument = OPMLDocument.fromXmlString(xmlString);

        // Property: parsed feed count should equal original count
        expect(
          parsedDocument.feeds.length,
          equals(originalDocument.feeds.length),
          reason: 'Parsed feed count should equal original feed count',
        );
      },
    );

    Glados(any.validOpmlFeed(0)).test(
      'Single feed: parsed feed URL matches original URL',
      (OPMLFeed feed) {
        final originalDocument = OPMLDocument(
          title: 'Test OPML',
          feeds: [feed],
        );

        final xmlString = originalDocument.toXmlString();
        final parsedDocument = OPMLDocument.fromXmlString(xmlString);

        // Property: each feed's URL should match
        expect(parsedDocument.feeds.length, equals(1));
        expect(
          parsedDocument.feeds.first.xmlUrl,
          equals(feed.xmlUrl),
          reason: 'Parsed feed URL should match original URL',
        );
      },
    );

    Glados(any.validOpmlFeed(0)).test(
      'Single feed: parsed feed title matches original title',
      (OPMLFeed feed) {
        final originalDocument = OPMLDocument(
          title: 'Test OPML',
          feeds: [feed],
        );

        final xmlString = originalDocument.toXmlString();
        final parsedDocument = OPMLDocument.fromXmlString(xmlString);

        // Property: each feed's title should match
        expect(parsedDocument.feeds.length, equals(1));
        expect(
          parsedDocument.feeds.first.title,
          equals(feed.title),
          reason: 'Parsed feed title should match original title',
        );
      },
    );

    // Test multiple feeds parsing correctness
    Glados2<OPMLFeed, OPMLFeed>(
      any.validOpmlFeed(0),
      any.validOpmlFeed(1),
    ).test('Multiple feeds: all feeds are preserved after parsing', (
      OPMLFeed feed1,
      OPMLFeed feed2,
    ) {
      final feeds = [feed1, feed2];
      final originalDocument = OPMLDocument(title: 'Test OPML', feeds: feeds);

      final xmlString = originalDocument.toXmlString();
      final parsedDocument = OPMLDocument.fromXmlString(xmlString);

      // Property: feed count should be preserved
      expect(
        parsedDocument.feeds.length,
        equals(feeds.length),
        reason: 'All feeds should be preserved after parsing',
      );

      // Property: each original feed should exist in parsed result
      for (final originalFeed in feeds) {
        final matchingFeed = parsedDocument.feeds.where(
          (f) => f.xmlUrl == originalFeed.xmlUrl,
        );
        expect(
          matchingFeed.isNotEmpty,
          isTrue,
          reason:
              'Feed with URL ${originalFeed.xmlUrl} should exist in parsed result',
        );
      }
    });

    Glados2<OPMLFeed, OPMLFeed>(
      any.validOpmlFeed(0),
      any.validOpmlFeed(1),
    ).test('Multiple feeds: URL and title consistency', (
      OPMLFeed feed1,
      OPMLFeed feed2,
    ) {
      final feeds = [feed1, feed2];
      final originalDocument = OPMLDocument(title: 'Test OPML', feeds: feeds);

      final xmlString = originalDocument.toXmlString();
      final parsedDocument = OPMLDocument.fromXmlString(xmlString);

      // Property: for each original feed, the parsed version should have matching URL and title
      for (final originalFeed in feeds) {
        final parsedFeed = parsedDocument.feeds.firstWhere(
          (f) => f.xmlUrl == originalFeed.xmlUrl,
        );

        expect(
          parsedFeed.title,
          equals(originalFeed.title),
          reason: 'Title should match for feed ${originalFeed.xmlUrl}',
        );
      }
    });

    // Test categorized feeds parsing correctness
    Glados(any.validCategorizedOpmlFeed(0)).test(
      'Categorized feed: category is preserved after parsing',
      (OPMLFeed feed) {
        final originalDocument = OPMLDocument(
          title: 'Test OPML',
          feeds: [feed],
        );

        final xmlString = originalDocument.toXmlString();
        final parsedDocument = OPMLDocument.fromXmlString(xmlString);

        expect(parsedDocument.feeds.length, equals(1));
        expect(
          parsedDocument.feeds.first.category,
          equals(feed.category),
          reason: 'Category should be preserved after parsing',
        );
      },
    );

    // Test with three feeds to ensure scalability
    Glados3<OPMLFeed, OPMLFeed, OPMLFeed>(
      any.validOpmlFeed(0),
      any.validOpmlFeed(1),
      any.validOpmlFeed(2),
    ).test('Three feeds: all attributes preserved', (
      OPMLFeed feed1,
      OPMLFeed feed2,
      OPMLFeed feed3,
    ) {
      final feeds = [feed1, feed2, feed3];
      final originalDocument = OPMLDocument(title: 'Test OPML', feeds: feeds);

      final xmlString = originalDocument.toXmlString();
      final parsedDocument = OPMLDocument.fromXmlString(xmlString);

      // Property: count preserved
      expect(parsedDocument.feeds.length, equals(3));

      // Property: all URLs and titles preserved
      for (final originalFeed in feeds) {
        final parsedFeed = parsedDocument.feeds.firstWhere(
          (f) => f.xmlUrl == originalFeed.xmlUrl,
        );
        expect(parsedFeed.title, equals(originalFeed.title));
        expect(parsedFeed.xmlUrl, equals(originalFeed.xmlUrl));
      }
    });
  });

  group('OPML Parsing Edge Cases', () {
    test('Empty OPML document parses correctly', () {
      final originalDocument = OPMLDocument(title: 'Empty Test', feeds: []);

      final xmlString = originalDocument.toXmlString();
      final parsedDocument = OPMLDocument.fromXmlString(xmlString);

      expect(parsedDocument.feeds, isEmpty);
    });

    test('OPML with special characters in title parses correctly', () {
      final feed = OPMLFeed(
        title: 'Test & Feed <Special>',
        xmlUrl: 'https://example.com/feed.xml',
      );

      final originalDocument = OPMLDocument(
        title: 'Special Chars Test',
        feeds: [feed],
      );

      final xmlString = originalDocument.toXmlString();
      final parsedDocument = OPMLDocument.fromXmlString(xmlString);

      expect(parsedDocument.feeds.length, equals(1));
      expect(parsedDocument.feeds.first.title, equals(feed.title));
      expect(parsedDocument.feeds.first.xmlUrl, equals(feed.xmlUrl));
    });

    test('Invalid OPML throws FormatException', () {
      const invalidXml = '<invalid>not opml</invalid>';

      expect(
        () => OPMLDocument.fromXmlString(invalidXml),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
