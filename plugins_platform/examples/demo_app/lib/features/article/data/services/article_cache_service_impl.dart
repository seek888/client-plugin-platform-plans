import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/domain/services/article_cache_service.dart';

/// 文章缓存服务实现
class ArticleCacheServiceImpl implements ArticleCacheService {
  final ArticleDao _articleDao;

  ArticleCacheServiceImpl({required ArticleDao articleDao})
    : _articleDao = articleDao;

  @override
  Future<Either<Failure, void>> cacheArticle(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'cacheArticle',
          ),
        );
      }

      await _articleDao.markAsCached(articleId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.cache(message: '缓存文章失败', key: articleId));
    }
  }

  @override
  Future<Either<Failure, int>> cacheArticlesByFeed(String feedId) async {
    try {
      // 获取订阅源的文章数量
      final articleCount = await _articleDao.getArticleCountByFeed(feedId);
      if (articleCount == 0) {
        return const Right(0);
      }

      // 批量标记为已缓存
      await _articleDao.markAllAsCachedByFeed(feedId);
      return Right(articleCount);
    } catch (e) {
      return Left(Failure.cache(message: '批量缓存文章失败', key: feedId));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getCachedArticles({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final offset = (page - 1) * pageSize;
      final articlesData = await _articleDao.getCachedArticlesPaginated(
        limit: pageSize,
        offset: offset,
      );
      final articles = articlesData
          .map(_mapArticlesTableDataToArticle)
          .toList();
      return Right(articles);
    } catch (e) {
      return Left(Failure.cache(message: '获取缓存文章失败'));
    }
  }

  @override
  Future<Either<Failure, bool>> isArticleCached(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'isArticleCached',
          ),
        );
      }

      return Right(article.isCached);
    } catch (e) {
      return Left(Failure.cache(message: '检查缓存状态失败', key: articleId));
    }
  }

  @override
  Future<Either<Failure, void>> uncacheArticle(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'uncacheArticle',
          ),
        );
      }

      await _articleDao.markAsUncached(articleId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.cache(message: '取消缓存失败', key: articleId));
    }
  }

  @override
  Future<Either<Failure, int>> clearCache({String? feedId}) async {
    try {
      int clearedCount;
      if (feedId != null) {
        // 先获取该订阅源的缓存数量
        clearedCount = await _articleDao.getCachedCount(feedId: feedId);
        await _articleDao.clearCacheByFeed(feedId);
      } else {
        // 先获取所有缓存数量
        clearedCount = await _articleDao.getCachedCount();
        await _articleDao.clearAllCache();
      }
      return Right(clearedCount);
    } catch (e) {
      return Left(Failure.cache(message: '清除缓存失败', key: feedId));
    }
  }

  @override
  Future<Either<Failure, int>> getCachedCount({String? feedId}) async {
    try {
      final count = await _articleDao.getCachedCount(feedId: feedId);
      return Right(count);
    } catch (e) {
      return Left(Failure.cache(message: '获取缓存数量失败', key: feedId));
    }
  }

  /// 将数据库数据映射为 Article 实体
  Article _mapArticlesTableDataToArticle(ArticlesTableData data) {
    return Article(
      id: data.id,
      feedId: data.feedId,
      title: data.title,
      summary: data.summary,
      content: data.content,
      author: data.author,
      link: data.link,
      imageUrl: data.imageUrl,
      publishedAt: data.publishedAt,
      isRead: data.isRead,
      isFavorite: data.isFavorite,
      isCached: data.isCached,
      isBlocked: data.isBlocked,
      readProgress: data.readProgress,
      favoriteFolderId: data.favoriteFolderId,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
