import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';

/// 文章仓库接口
abstract class ArticleRepository {
  /// 获取订阅源的文章列表
  ///
  /// [feedId] 订阅源 ID
  /// [page] 页码（从 1 开始）
  /// [pageSize] 每页数量
  /// [sortType] 排序类型
  /// [filterType] 筛选类型
  Future<Either<Failure, List<Article>>> getArticlesByFeed(
    String feedId, {
    int page = 1,
    int pageSize = 20,
    ArticleSortType sortType = ArticleSortType.timeDesc,
    ArticleFilterType filterType = ArticleFilterType.all,
  });

  /// 获取所有文章（汇总）
  ///
  /// [page] 页码（从 1 开始）
  /// [pageSize] 每页数量
  /// [sortType] 排序类型
  /// [filterType] 筛选类型
  Future<Either<Failure, List<Article>>> getAllArticles({
    int page = 1,
    int pageSize = 20,
    ArticleSortType sortType = ArticleSortType.timeDesc,
    ArticleFilterType filterType = ArticleFilterType.all,
  });

  /// 获取文章详情
  Future<Either<Failure, Article>> getArticleDetail(String articleId);

  /// 标记文章已读/未读
  Future<Either<Failure, void>> markAsRead(String articleId, bool isRead);

  /// 批量标记已读（按订阅源）
  ///
  /// [feedId] 如果为 null，则标记所有文章为已读
  Future<Either<Failure, int>> markAllAsRead({String? feedId});

  /// 收藏/取消收藏文章
  Future<Either<Failure, void>> toggleFavorite(String articleId);

  /// 获取收藏文章列表
  Future<Either<Failure, List<Article>>> getFavoriteArticles({
    int page = 1,
    int pageSize = 20,
  });

  /// 屏蔽文章
  Future<Either<Failure, void>> blockArticle(String articleId);

  /// 获取上一篇/下一篇文章
  ///
  /// [currentArticleId] 当前文章 ID
  /// [feedId] 订阅源 ID
  /// [isNext] true 表示下一篇，false 表示上一篇
  Future<Either<Failure, Article?>> getAdjacentArticle(
    String currentArticleId,
    String feedId,
    bool isNext,
  );

  /// 获取订阅源未读数
  Future<Either<Failure, int>> getUnreadCountByFeed(String feedId);

  /// 获取所有未读数
  Future<Either<Failure, int>> getTotalUnreadCount();

  /// 监听订阅源文章变化
  Stream<List<Article>> watchArticlesByFeed(String feedId);

  /// 监听所有文章变化
  Stream<List<Article>> watchAllArticles();

  /// 搜索文章
  Future<Either<Failure, List<Article>>> searchArticles(
    String keyword, {
    int limit = 50,
  });

  /// 缓存文章
  Future<Either<Failure, void>> cacheArticle(String articleId);

  /// 获取已缓存文章
  Future<Either<Failure, List<Article>>> getCachedArticles();

  /// 更新阅读进度
  Future<Either<Failure, void>> updateReadProgress(
    String articleId,
    int progress,
  );
}
