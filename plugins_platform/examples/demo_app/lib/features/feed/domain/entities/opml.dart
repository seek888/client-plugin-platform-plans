import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

part 'opml.freezed.dart';
part 'opml.g.dart';

/// OPML 订阅源项
@freezed
class OPMLFeed with _$OPMLFeed {
  const OPMLFeed._();

  const factory OPMLFeed({
    required String title,
    required String xmlUrl,
    String? htmlUrl,
    String? description,
    String? category,
  }) = _OPMLFeed;

  factory OPMLFeed.fromJson(Map<String, dynamic> json) =>
      _$OPMLFeedFromJson(json);

  /// 从 XML 元素解析
  factory OPMLFeed.fromXmlElement(XmlElement element, {String? category}) {
    return OPMLFeed(
      title:
          element.getAttribute('title') ??
          element.getAttribute('text') ??
          'Untitled',
      xmlUrl: element.getAttribute('xmlUrl') ?? '',
      htmlUrl: element.getAttribute('htmlUrl'),
      description: element.getAttribute('description'),
      category: category,
    );
  }

  /// 转换为 XML 元素
  XmlElement toXmlElement() {
    final attributes = <XmlAttribute>[
      XmlAttribute(XmlName('text'), title),
      XmlAttribute(XmlName('title'), title),
      XmlAttribute(XmlName('type'), 'rss'),
      XmlAttribute(XmlName('xmlUrl'), xmlUrl),
    ];

    if (htmlUrl != null && htmlUrl!.isNotEmpty) {
      attributes.add(XmlAttribute(XmlName('htmlUrl'), htmlUrl!));
    }

    if (description != null && description!.isNotEmpty) {
      attributes.add(XmlAttribute(XmlName('description'), description!));
    }

    return XmlElement(XmlName('outline'), attributes);
  }

  /// 是否有效
  bool get isValid => xmlUrl.isNotEmpty;
}

/// OPML 文档
@freezed
class OPMLDocument with _$OPMLDocument {
  const OPMLDocument._();

  const factory OPMLDocument({
    @Default('RSS Reader Export') String title,
    DateTime? dateCreated,
    @Default([]) List<OPMLFeed> feeds,
    @Default({}) Map<String, List<OPMLFeed>> categorizedFeeds,
  }) = _OPMLDocument;

  factory OPMLDocument.fromJson(Map<String, dynamic> json) =>
      _$OPMLDocumentFromJson(json);

  /// 从 XML 字符串解析
  factory OPMLDocument.fromXmlString(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final opml = document.findElements('opml').firstOrNull;
    if (opml == null) {
      throw FormatException('Invalid OPML: missing opml element');
    }

    final head = opml.findElements('head').firstOrNull;
    final body = opml.findElements('body').firstOrNull;

    if (body == null) {
      throw FormatException('Invalid OPML: missing body element');
    }

    final title =
        head?.findElements('title').firstOrNull?.innerText ?? 'Imported';
    final dateCreatedStr = head
        ?.findElements('dateCreated')
        .firstOrNull
        ?.innerText;
    DateTime? dateCreated;
    if (dateCreatedStr != null) {
      try {
        dateCreated = DateTime.parse(dateCreatedStr);
      } catch (_) {
        // Ignore parse errors
      }
    }

    final feeds = <OPMLFeed>[];
    final categorizedFeeds = <String, List<OPMLFeed>>{};

    void parseOutlines(XmlElement parent, {String? category}) {
      for (final outline in parent.findElements('outline')) {
        final xmlUrl = outline.getAttribute('xmlUrl');

        if (xmlUrl != null && xmlUrl.isNotEmpty) {
          // This is a feed
          final feed = OPMLFeed.fromXmlElement(outline, category: category);
          if (feed.isValid) {
            feeds.add(feed);
            if (category != null) {
              categorizedFeeds.putIfAbsent(category, () => []).add(feed);
            }
          }
        } else {
          // This is a category/folder
          final categoryName =
              outline.getAttribute('text') ?? outline.getAttribute('title');
          if (categoryName != null) {
            parseOutlines(outline, category: categoryName);
          }
        }
      }
    }

    parseOutlines(body);

    return OPMLDocument(
      title: title,
      dateCreated: dateCreated,
      feeds: feeds,
      categorizedFeeds: categorizedFeeds,
    );
  }

  /// 转换为 XML 字符串
  String toXmlString() {
    final builder = XmlBuilder();

    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element(
      'opml',
      attributes: {'version': '2.0'},
      nest: () {
        // Head
        builder.element(
          'head',
          nest: () {
            builder.element('title', nest: title);
            builder.element(
              'dateCreated',
              nest: (dateCreated ?? DateTime.now()).toIso8601String(),
            );
          },
        );

        // Body
        builder.element(
          'body',
          nest: () {
            // Group feeds by category
            final uncategorizedFeeds = feeds
                .where((f) => f.category == null || f.category!.isEmpty)
                .toList();
            final categories = <String>{};

            for (final feed in feeds) {
              if (feed.category != null && feed.category!.isNotEmpty) {
                categories.add(feed.category!);
              }
            }

            // Write uncategorized feeds first
            for (final feed in uncategorizedFeeds) {
              builder.xml(feed.toXmlElement().toXmlString());
            }

            // Write categorized feeds
            for (final category in categories) {
              final categoryFeeds = feeds
                  .where((f) => f.category == category)
                  .toList();
              builder.element(
                'outline',
                attributes: {'text': category, 'title': category},
                nest: () {
                  for (final feed in categoryFeeds) {
                    builder.xml(feed.toXmlElement().toXmlString());
                  }
                },
              );
            }
          },
        );
      },
    );

    return builder.buildDocument().toXmlString(pretty: true);
  }

  /// 获取所有订阅源（包括分类中的）
  List<OPMLFeed> get allFeeds => feeds;
}
