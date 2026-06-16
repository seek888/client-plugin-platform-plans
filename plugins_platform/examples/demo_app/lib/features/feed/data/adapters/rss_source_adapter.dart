import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/services/rss_parser_service.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';
import 'package:rss_reader/features/feed/domain/services/data_source_adapter.dart';

/// RSS 数据源适配器
/// 封装现有的 RssParserService，实现 DataSourceAdapter 接口
class RssSourceAdapter implements DataSourceAdapter {
  /// RSS Feed URL
  final String feedUrl;

  /// RSS 解析服务
  final RssParserService _parserService;

  /// 缓存的 Feed 数据（用于文章详情查询）
  ParsedFeed? _cachedFeed;

  RssSourceAdapter({
    required this.feedUrl,
    required RssParserService parserService,
  }) : _parserService = parserService;

  @override
  SourceType get sourceType => SourceType.rss;

  @override
  Future<Either<Failure, ParsedFeed>> fetchFeedMetadata() async {
    final result = await _parserService.fetchAndParseFeed(feedUrl);
    return result.map((feed) {
      _cachedFeed = feed;
      return feed;
    });
  }

  @override
  Future<Either<Failure, ArticleListResult>> fetchArticles({
    int page = 1,
    int pageSize = 20,
    DateTime? since,
  }) async {
    // RSS 不支持真正的分页，每次都获取所有文章
    final result = await _parserService.fetchAndParseFeed(feedUrl);

    return result.map((feed) {
      _cachedFeed = feed;

      var articles = feed.articles;

      // 如果指定了 since，只返回该时间之后的文章
      if (since != null) {
        articles = articles.where((article) {
          if (article.publishedAt == null) return true;
          return article.publishedAt!.isAfter(since);
        }).toList();
      }

      // 按发布时间倒序排序
      articles.sort((a, b) {
        final aTime = a.publishedAt ?? DateTime(1970);
        final bTime = b.publishedAt ?? DateTime(1970);
        return bTime.compareTo(aTime);
      });

      // 模拟分页（RSS 实际上返回所有文章，但我们可以在客户端分页）
      final startIndex = (page - 1) * pageSize;
      final endIndex = startIndex + pageSize;

      if (startIndex >= articles.length) {
        return ArticleListResult(
          articles: [],
          hasMore: false,
          totalCount: articles.length,
          currentPage: page,
          pageSize: pageSize,
        );
      }

      final pagedArticles = articles.sublist(
        startIndex,
        endIndex > articles.length ? articles.length : endIndex,
      );

      return ArticleListResult(
        articles: pagedArticles,
        hasMore: endIndex < articles.length,
        totalCount: articles.length,
        currentPage: page,
        pageSize: pageSize,
      );
    });
  }

  @override
  Future<Either<Failure, ParsedArticle>> fetchArticleDetail(
    String articleId,
  ) async {
    // 如果有缓存，先从缓存中查找
    if (_cachedFeed != null) {
      final article = _findArticleById(_cachedFeed!, articleId);
      if (article != null) {
        return Right(article);
      }
    }

    // 没有缓存或缓存中没找到，重新获取 Feed
    final result = await _parserService.fetchAndParseFeed(feedUrl);

    return result.fold(
      (failure) => Left(failure),
      (feed) {
        _cachedFeed = feed;
        final article = _findArticleById(feed, articleId);
        if (article != null) {
          return Right(article);
        }
        return Left(
          Failure.notFound(
            message: '文章不存在',
            resourceType: 'Article',
            resourceId: articleId,
          ),
        );
      },
    );
  }

  @override
  Future<Either<Failure, bool>> validateConnection() async {
    final result = await _parserService.fetchAndParseFeed(feedUrl);
    return result.map((_) => true);
  }

  @override
  void dispose() {
    _cachedFeed = null;
  }

  /// 根据 ID 查找文章
  ParsedArticle? _findArticleById(ParsedFeed feed, String articleId) {
    try {
      return feed.articles.firstWhere(
        (article) => article.uniqueId == articleId,
      );
    } catch (_) {
      return null;
    }
  }
}
