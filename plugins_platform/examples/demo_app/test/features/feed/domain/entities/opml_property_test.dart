import 'package:test/test.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/features/feed/domain/entities/opml.dart';

/// **Property 1: OPML 往返一致性**
/// **Validates: Requirements 4.5**
///
/// FOR ALL 有效 OPML 文件, 导出后再导入 SHALL 产生等价的订阅源列表（往返一致性）

// Custom generator for OPMLFeed with unique URLs using index
extension OPMLFeedAny on Any {
  Generator<OPMLFeed> opmlFeedWithIndex(int index) {
    return any.combine2(
      any.lowercaseLetters,
      any.lowercaseLetters,
      (String title, String urlPart) => OPMLFeed(
        title: title.isEmpty ? 'feed$index' : '$title$index',
        xmlUrl:
            'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index/feed.xml',
        htmlUrl:
            'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index',
        description: null,
        category: null,
      ),
    );
  }

  Generator<OPMLFeed> get opmlFeed {
    return any.combine3(
      any.lowercaseLetters,
      any.lowercaseLetters,
      any.positiveIntOrZero,
      (String title, String urlPart, int index) => OPMLFeed(
        title: title.isEmpty ? 'feed$index' : '$title$index',
        xmlUrl:
            'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index/feed.xml',
        htmlUrl:
            'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index',
        description: null,
        category: null,
      ),
    );
  }

  Generator<OPMLFeed> get categorizedOpmlFeed {
    return any.combine4(
      any.lowercaseLetters,
      any.lowercaseLetters,
      any.lowercaseLetters,
      any.positiveIntOrZero,
      (String title, String urlPart, String category, int index) => OPMLFeed(
        title: title.isEmpty ? 'feed$index' : '$title$index',
        xmlUrl:
            'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index/feed.xml',
        htmlUrl:
            'https://example.com/${urlPart.isEmpty ? 'feed' : urlPart}$index',
        description: null,
        category: category.isEmpty ? 'category' : category,
      ),
    );
  }
}

void main() {
  group('OPML Round-Trip Property Tests', () {
    Glados(any.opmlFeed).test(
      'Property 1: Single feed round-trip preserves all attributes',
      (OPMLFeed feed) {
        final originalDocument = OPMLDocument(
          title: 'Single Feed Test',
          feeds: [feed],
        );

        final xmlString = originalDocument.toXmlString();
        final reimportedDocument = OPMLDocument.fromXmlString(xmlString);

        expect(reimportedDocument.feeds.length, equals(1));

        final reimportedFeed = reimportedDocument.feeds.first;
        expect(reimportedFeed.title, equals(feed.title));
        expect(reimportedFeed.xmlUrl, equals(feed.xmlUrl));

        if (feed.htmlUrl != null && feed.htmlUrl!.isNotEmpty) {
          expect(reimportedFeed.htmlUrl, equals(feed.htmlUrl));
        }
      },
    );

    Glados(any.categorizedOpmlFeed).test(
      'Property 1b: Categorized feed round-trip preserves category',
      (OPMLFeed feed) {
        final originalDocument = OPMLDocument(
          title: 'Categorized Test',
          feeds: [feed],
        );

        final xmlString = originalDocument.toXmlString();
        final reimportedDocument = OPMLDocument.fromXmlString(xmlString);

        expect(reimportedDocument.feeds.length, equals(1));

        final reimportedFeed = reimportedDocument.feeds.first;
        expect(reimportedFeed.title, equals(feed.title));
        expect(reimportedFeed.xmlUrl, equals(feed.xmlUrl));
        expect(
          reimportedFeed.category,
          equals(feed.category),
          reason: 'Feed category should be preserved',
        );
      },
    );

    // Test with multiple feeds using indexed generators to ensure unique URLs
    Glados2<OPMLFeed, OPMLFeed>(
      any.opmlFeedWithIndex(0),
      any.opmlFeedWithIndex(1),
    ).test('Property 1c: Multiple feeds round-trip preserves all feeds', (
      OPMLFeed feed1,
      OPMLFeed feed2,
    ) {
      final feeds = [feed1, feed2];

      final originalDocument = OPMLDocument(
        title: 'Multi Feed Test',
        dateCreated: DateTime.now(),
        feeds: feeds,
      );

      final xmlString = originalDocument.toXmlString();
      final reimportedDocument = OPMLDocument.fromXmlString(xmlString);

      expect(
        reimportedDocument.feeds.length,
        equals(feeds.length),
        reason: 'Number of feeds should be preserved after round-trip',
      );

      for (final originalFeed in feeds) {
        final reimportedFeed = reimportedDocument.feeds.firstWhere(
          (f) => f.xmlUrl == originalFeed.xmlUrl,
          orElse: () => throw StateError(
            'Feed with xmlUrl ${originalFeed.xmlUrl} not found',
          ),
        );

        expect(reimportedFeed.title, equals(originalFeed.title));
        expect(reimportedFeed.xmlUrl, equals(originalFeed.xmlUrl));
      }
    });
  });

  group('OPML Edge Cases', () {
    test('Empty OPML document round-trip', () {
      final originalDocument = OPMLDocument(title: 'Empty Test', feeds: []);

      final xmlString = originalDocument.toXmlString();
      final reimportedDocument = OPMLDocument.fromXmlString(xmlString);

      expect(reimportedDocument.feeds, isEmpty);
    });

    test('OPML with special characters in title', () {
      final feed = OPMLFeed(
        title: 'Test & Feed',
        xmlUrl: 'https://example.com/feed.xml',
      );

      final originalDocument = OPMLDocument(
        title: 'Special Chars Test',
        feeds: [feed],
      );

      final xmlString = originalDocument.toXmlString();
      final reimportedDocument = OPMLDocument.fromXmlString(xmlString);

      expect(reimportedDocument.feeds.length, equals(1));
      expect(reimportedDocument.feeds.first.title, equals(feed.title));
    });
  });
}
