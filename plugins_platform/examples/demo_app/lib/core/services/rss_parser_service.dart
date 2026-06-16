import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';

/// RSS/Atom 解析服务接口
abstract class RssParserService {
  /// 解析 RSS/Atom 内容
  ///
  /// [xmlContent] - RSS/Atom XML 内容字符串
  /// 返回解析后的 [ParsedFeed] 或 [Failure]
  Future<Either<Failure, ParsedFeed>> parseFeed(String xmlContent);

  /// 检测 Feed 类型
  ///
  /// [xmlContent] - RSS/Atom XML 内容字符串
  /// 返回检测到的 [FeedType]
  FeedType detectFeedType(String xmlContent);

  /// 从 URL 获取并解析 Feed
  ///
  /// [url] - RSS/Atom Feed URL
  /// 返回解析后的 [ParsedFeed] 或 [Failure]
  Future<Either<Failure, ParsedFeed>> fetchAndParseFeed(String url);
}
