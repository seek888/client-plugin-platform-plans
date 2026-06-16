import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';

/// 文章缓存服务接口
///
/// 负责文章的离线缓存功能，支持单篇缓存、批量缓存和缓存管理
abstract class ArticleCacheService {
  /// 缓存单篇文章（离线阅读）
  ///
  /// [articleId] 要缓存的文章 ID
  /// 返回缓存结果
  Future<Either<Failure, void>> cacheArticle(String articleId);

  /// 批量缓存订阅源的所有文章
  ///
  /// [feedId] 订阅源 ID
  /// 返回成功缓存的文章数量
  Future<Either<Failure, int>> cacheArticlesByFeed(String feedId);

  /// 获取已缓存的文章列表
  ///
  /// [page] 页码（从 1 开始）
  /// [pageSize] 每页数量
  Future<Either<Failure, List<Article>>> getCachedArticles({
    int page = 1,
    int pageSize = 20,
  });

  /// 检查文章是否已缓存
  ///
  /// [articleId] 文章 ID
  Future<Either<Failure, bool>> isArticleCached(String articleId);

  /// 取消缓存单篇文章
  ///
  /// [articleId] 文章 ID
  Future<Either<Failure, void>> uncacheArticle(String articleId);

  /// 清除缓存
  ///
  /// [feedId] 如果提供，则只清除该订阅源的缓存；否则清除所有缓存
  /// 返回清除的文章数量
  Future<Either<Failure, int>> clearCache({String? feedId});

  /// 获取已缓存文章数量
  Future<Either<Failure, int>> getCachedCount({String? feedId});
}
