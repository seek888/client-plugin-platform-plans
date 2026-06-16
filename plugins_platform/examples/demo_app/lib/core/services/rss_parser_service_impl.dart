import 'dart:convert';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:dart_rss/domain/rss1_item.dart';
import 'package:http/http.dart' as http;
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/core/services/rss_parser_service.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';

final _log = logger.tag(LogTags.parser);

/// RSS/Atom 解析服务实现
class RssParserServiceImpl implements RssParserService {
  final http.Client _httpClient;

  RssParserServiceImpl({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// 支持的中文编码列表
  static const _chineseEncodings = ['gb2312', 'gbk', 'gb18030', 'big5'];

  /// 从 Content-Type header 中提取编码
  String? _extractCharsetFromContentType(String? contentType) {
    if (contentType == null) return null;
    final regex = RegExp(r'charset=([^\s;]+)', caseSensitive: false);
    final match = regex.firstMatch(contentType);
    return match
        ?.group(1)
        ?.toLowerCase()
        .replaceAll('"', '')
        .replaceAll("'", '');
  }

  /// 从 XML 声明中提取编码
  String? _extractCharsetFromXml(List<int> bytes) {
    try {
      // 只读取前 1000 字节来检测编码声明
      final sample = bytes.length > 1000 ? bytes.sublist(0, 1000) : bytes;
      final preview = latin1.decode(sample, allowInvalid: true);

      // 匹配 XML 声明中的 encoding
      final regex = RegExp(
        r'''<\?xml[^>]+encoding=["']([^"']+)["']''',
        caseSensitive: false,
      );
      final match = regex.firstMatch(preview);
      return match?.group(1)?.toLowerCase();
    } catch (_) {
      return null;
    }
  }

  /// 检测并转换字节到正确编码的字符串
  Future<String> _decodeContent(
    List<int> bytes,
    String? contentTypeCharset,
  ) async {
    final uint8Bytes = Uint8List.fromList(bytes);

    // 1. 优先使用 XML 声明中的编码
    final xmlCharset = _extractCharsetFromXml(bytes);

    // 2. 其次使用 Content-Type header 中的编码
    final charset = xmlCharset ?? contentTypeCharset;

    // 3. 如果检测到中文编码，使用 charset_converter 转换
    if (charset != null && _chineseEncodings.contains(charset.toLowerCase())) {
      try {
        final charsetName = _normalizeCharset(charset);
        final decoded = await CharsetConverter.decode(charsetName, uint8Bytes);
        return decoded;
      } catch (e) {
        // 转换失败，尝试 UTF-8
      }
    }

    // 4. 尝试 UTF-8 解码
    try {
      return utf8.decode(bytes);
    } catch (_) {
      // UTF-8 解码失败，尝试检测是否为中文编码
    }

    // 5. 如果 UTF-8 失败，尝试常见的中文编码
    for (final encoding in ['gbk', 'gb2312', 'big5']) {
      try {
        final decoded = await CharsetConverter.decode(encoding, uint8Bytes);
        // 简单验证：检查是否包含常见的中文字符或 XML 标签
        if (decoded.contains('<') && decoded.contains('>')) {
          return decoded;
        }
      } catch (_) {
        continue;
      }
    }

    // 6. 最后使用 latin1 作为后备
    return latin1.decode(bytes, allowInvalid: true);
  }

  /// 标准化编码名称
  String _normalizeCharset(String charset) {
    final lower = charset.toLowerCase();
    if (lower == 'gb2312' || lower == 'gbk' || lower == 'gb18030') {
      return 'gbk'; // charset_converter 使用 gbk 处理这些编码
    }
    return lower;
  }

  @override
  FeedType detectFeedType(String xmlContent) {
    final trimmed = xmlContent.trim().toLowerCase();

    // 检测 RSS 2.0
    if (trimmed.contains('<rss') && trimmed.contains('version="2.0"')) {
      return FeedType.rss2;
    }

    // 检测 RSS 1.0 (RDF)
    if (trimmed.contains('rdf:rdf') ||
        (trimmed.contains('<rss') && trimmed.contains('version="1.0"'))) {
      return FeedType.rss1;
    }

    // 检测 Atom
    if (trimmed.contains('<feed') &&
        trimmed.contains('xmlns="http://www.w3.org/2005/atom"')) {
      return FeedType.atom;
    }

    // 额外检测：如果包含 <feed 但没有明确的 xmlns
    if (trimmed.contains('<feed')) {
      return FeedType.atom;
    }

    // 额外检测：如果包含 <rss 但没有明确版本
    if (trimmed.contains('<rss')) {
      return FeedType.rss2;
    }

    return FeedType.unknown;
  }

  @override
  Future<Either<Failure, ParsedFeed>> parseFeed(String xmlContent) async {
    try {
      final feedType = detectFeedType(xmlContent);
      _log.debug('检测到 Feed 类型: $feedType');

      switch (feedType) {
        case FeedType.rss2:
          return _parseRss2Feed(xmlContent);
        case FeedType.rss1:
          return _parseRss1Feed(xmlContent);
        case FeedType.atom:
          return _parseAtomFeed(xmlContent);
        case FeedType.unknown:
          return _tryParseUnknownFeed(xmlContent);
      }
    } catch (e, stackTrace) {
      _log.error('解析 Feed 失败', error: e, stackTrace: stackTrace);
      return Left(
        Failure.parse(
          message: '解析失败: ${e.toString()}',
          source: 'RssParserService',
          details: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ParsedFeed>> fetchAndParseFeed(String url) async {
    _log.debug('开始获取并解析 Feed: $url');
    final stopwatch = Stopwatch()..start();

    try {
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: {
          'Accept':
              'application/rss+xml, application/atom+xml, application/xml, text/xml',
          'User-Agent': 'RSS Reader/1.0',
        },
      );

      _log.debug(
          '收到响应: ${response.statusCode}, 耗时: ${stopwatch.elapsedMilliseconds}ms');

      if (response.statusCode == 200) {
        // 从 Content-Type header 提取编码
        final contentType = response.headers['content-type'];
        final headerCharset = _extractCharsetFromContentType(contentType);

        // 使用原始字节进行编码检测和转换
        final content = await _decodeContent(response.bodyBytes, headerCharset);
        final result = await parseFeed(content);

        result.fold(
          (failure) => _log.warning('解析 Feed 失败: $url, ${failure.message}'),
          (feed) => _log
              .info('解析 Feed 成功: ${feed.title}, 文章数: ${feed.articles.length}'),
        );

        return result;
      }

      _log.warning('获取 Feed 失败: $url, 状态码: ${response.statusCode}');
      return Left(
        Failure.network(
          message: '获取 Feed 失败',
          statusCode: response.statusCode,
          url: url,
        ),
      );
    } catch (e, stackTrace) {
      _log.error('网络错误: $url', error: e, stackTrace: stackTrace);
      return Left(Failure.network(message: '网络错误: ${e.toString()}', url: url));
    }
  }

  /// 解析 RSS 2.0 Feed
  Either<Failure, ParsedFeed> _parseRss2Feed(String xmlContent) {
    try {
      final rssFeed = RssFeed.parse(xmlContent);
      return Right(_convertRss2Feed(rssFeed));
    } catch (e) {
      return Left(
        Failure.parse(
          message: 'RSS 2.0 解析失败',
          source: 'RSS 2.0',
          details: e.toString(),
        ),
      );
    }
  }

  /// 解析 RSS 1.0 Feed
  Either<Failure, ParsedFeed> _parseRss1Feed(String xmlContent) {
    try {
      final rss1Feed = Rss1Feed.parse(xmlContent);
      return Right(_convertRss1Feed(rss1Feed));
    } catch (e) {
      return Left(
        Failure.parse(
          message: 'RSS 1.0 解析失败',
          source: 'RSS 1.0',
          details: e.toString(),
        ),
      );
    }
  }

  /// 解析 Atom Feed
  Either<Failure, ParsedFeed> _parseAtomFeed(String xmlContent) {
    try {
      final atomFeed = AtomFeed.parse(xmlContent);
      return Right(_convertAtomFeed(atomFeed));
    } catch (e) {
      return Left(
        Failure.parse(
          message: 'Atom 解析失败',
          source: 'Atom',
          details: e.toString(),
        ),
      );
    }
  }

  /// 尝试解析未知类型的 Feed
  Either<Failure, ParsedFeed> _tryParseUnknownFeed(String xmlContent) {
    // 尝试按顺序解析
    try {
      final rssFeed = RssFeed.parse(xmlContent);
      return Right(_convertRss2Feed(rssFeed));
    } catch (_) {
      try {
        final atomFeed = AtomFeed.parse(xmlContent);
        return Right(_convertAtomFeed(atomFeed));
      } catch (_) {
        try {
          final rss1Feed = Rss1Feed.parse(xmlContent);
          return Right(_convertRss1Feed(rss1Feed));
        } catch (e) {
          return Left(
            Failure.parse(
              message: '无法解析 Feed 内容',
              source: 'Unknown',
              details: e.toString(),
            ),
          );
        }
      }
    }
  }

  /// 转换 RSS 2.0 Feed 到统一模型
  ParsedFeed _convertRss2Feed(RssFeed feed) {
    return ParsedFeed(
      title: feed.title ?? 'Unknown',
      description: feed.description,
      link: feed.link,
      iconUrl: feed.image?.url,
      feedType: FeedType.rss2,
      lastUpdated: _parseDateTime(feed.lastBuildDate),
      articles: feed.items.map((item) => _convertRss2Item(item)).toList(),
    );
  }

  /// 转换 RSS 2.0 Item 到统一模型
  ParsedArticle _convertRss2Item(RssItem item) {
    return ParsedArticle(
      guid: item.guid,
      title: item.title ?? 'No Title',
      summary: item.description,
      content: item.content?.value,
      author: item.author ?? item.dc?.creator,
      link: item.link,
      imageUrl: _extractImageUrlFromRssItem(item),
      publishedAt: _parseDateTime(item.pubDate),
      categories: item.categories
          .map((c) => c.value ?? '')
          .where((c) => c.isNotEmpty)
          .toList(),
    );
  }

  /// 转换 Atom Feed 到统一模型
  ParsedFeed _convertAtomFeed(AtomFeed feed) {
    return ParsedFeed(
      title: feed.title ?? 'Unknown',
      description: feed.subtitle,
      link: feed.links.isNotEmpty ? feed.links.first.href : null,
      iconUrl: feed.icon ?? feed.logo,
      feedType: FeedType.atom,
      lastUpdated: _parseDateTime(feed.updated),
      articles: feed.items.map((item) => _convertAtomItem(item)).toList(),
    );
  }

  /// 转换 Atom Item 到统一模型
  ParsedArticle _convertAtomItem(AtomItem item) {
    return ParsedArticle(
      guid: item.id,
      title: item.title ?? 'No Title',
      summary: item.summary,
      content: item.content,
      author: item.authors.isNotEmpty ? item.authors.first.name : null,
      link: item.links.isNotEmpty ? item.links.first.href : null,
      imageUrl: _extractImageUrlFromAtomItem(item),
      publishedAt: _parseDateTime(item.published ?? item.updated),
      categories: item.categories
          .map((c) => c.term ?? '')
          .where((c) => c.isNotEmpty)
          .toList(),
    );
  }

  /// 转换 RSS 1.0 Feed 到统一模型
  ParsedFeed _convertRss1Feed(Rss1Feed feed) {
    return ParsedFeed(
      title: feed.title ?? 'Unknown',
      description: feed.description,
      link: feed.link,
      iconUrl: feed.image, // Rss1Feed.image is already a String?
      feedType: FeedType.rss1,
      articles: feed.items.map((item) => _convertRss1Item(item)).toList(),
    );
  }

  /// 转换 RSS 1.0 Item 到统一模型
  ParsedArticle _convertRss1Item(Rss1Item item) {
    return ParsedArticle(
      title: item.title ?? 'No Title',
      summary: item.description,
      content: item.content?.value,
      link: item.link,
      publishedAt: _parseDateTime(item.dc?.date),
    );
  }

  /// 解析日期时间字符串
  DateTime? _parseDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      // 尝试解析 RFC 822 格式
      try {
        return _parseRfc822Date(dateStr);
      } catch (_) {
        return null;
      }
    }
  }

  /// 解析 RFC 822 日期格式
  DateTime? _parseRfc822Date(String dateStr) {
    // RFC 822 格式: "Tue, 03 Jun 2008 11:05:30 GMT"
    final months = {
      'jan': 1,
      'feb': 2,
      'mar': 3,
      'apr': 4,
      'may': 5,
      'jun': 6,
      'jul': 7,
      'aug': 8,
      'sep': 9,
      'oct': 10,
      'nov': 11,
      'dec': 12,
    };

    final regex = RegExp(
      r'(\d{1,2})\s+(\w{3})\s+(\d{4})\s+(\d{2}):(\d{2}):(\d{2})',
    );
    final match = regex.firstMatch(dateStr);
    if (match == null) return null;

    final day = int.parse(match.group(1)!);
    final monthStr = match.group(2)!.toLowerCase();
    final year = int.parse(match.group(3)!);
    final hour = int.parse(match.group(4)!);
    final minute = int.parse(match.group(5)!);
    final second = int.parse(match.group(6)!);

    final month = months[monthStr];
    if (month == null) return null;

    return DateTime.utc(year, month, day, hour, minute, second);
  }

  /// 从 RSS Item 提取图片 URL
  String? _extractImageUrlFromRssItem(RssItem item) {
    // 优先使用 media:content
    if (item.media?.contents.isNotEmpty == true) {
      final mediaContent = item.media!.contents.first;
      if (mediaContent.url != null) {
        return mediaContent.url;
      }
    }

    // 其次使用 media:thumbnails
    if (item.media?.thumbnails.isNotEmpty == true) {
      final thumbnail = item.media!.thumbnails.first;
      if (thumbnail.url != null) {
        return thumbnail.url;
      }
    }

    // 然后使用 enclosure
    if (item.enclosure?.url != null) {
      final mimeType = item.enclosure!.type?.toLowerCase() ?? '';
      if (mimeType.startsWith('image/') || _isImageUrl(item.enclosure!.url!)) {
        return item.enclosure!.url;
      }
    }

    // 最后从 description 中提取
    return _extractImageFromHtml(item.description) ??
        _extractImageFromHtml(item.content?.value);
  }

  /// 从 Atom Item 提取图片 URL
  String? _extractImageUrlFromAtomItem(AtomItem item) {
    // 从 links 中查找图片类型
    for (final link in item.links) {
      if (link.type?.startsWith('image/') == true) {
        return link.href;
      }
    }

    // 从 content 中提取
    return _extractImageFromHtml(item.content) ??
        _extractImageFromHtml(item.summary);
  }

  /// 从 HTML 内容中提取第一个图片 URL
  String? _extractImageFromHtml(String? html) {
    if (html == null || html.isEmpty) return null;

    // 匹配 img 标签的 src 属性
    final imgRegex = RegExp(
      r'''<img[^>]+src=["']([^"']+)["']''',
      caseSensitive: false,
    );
    final match = imgRegex.firstMatch(html);
    return match?.group(1);
  }

  /// 检查 URL 是否为图片
  bool _isImageUrl(String url) {
    final lowerUrl = url.toLowerCase();
    return lowerUrl.endsWith('.jpg') ||
        lowerUrl.endsWith('.jpeg') ||
        lowerUrl.endsWith('.png') ||
        lowerUrl.endsWith('.gif') ||
        lowerUrl.endsWith('.webp') ||
        lowerUrl.endsWith('.svg');
  }
}
