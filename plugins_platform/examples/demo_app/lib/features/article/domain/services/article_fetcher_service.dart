import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';

/// 文章内容抓取服务接口
/// 用于从文章原始链接抓取完整内容
abstract class ArticleFetcherService {
  /// 从 URL 抓取文章完整内容
  ///
  /// [url] 文章原始链接
  /// 返回抓取到的 HTML 内容
  Future<Either<Failure, String>> fetchArticleContent(String url);

  /// 判断是否需要抓取完整内容
  ///
  /// [content] 当前内容
  /// [summary] 摘要
  /// 返回 true 表示需要抓取
  bool shouldFetchFullContent(String? content, String? summary);
}
