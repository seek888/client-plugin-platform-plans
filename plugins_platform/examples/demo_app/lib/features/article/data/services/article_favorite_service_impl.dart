import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/domain/services/article_favorite_service.dart';

/// 文章收藏服务实现
class ArticleFavoriteServiceImpl implements ArticleFavoriteService {
  final ArticleDao _articleDao;

  ArticleFavoriteServiceImpl({required ArticleDao articleDao})
    : _articleDao = articleDao;

  @override
  Future<Either<Failure, void>> addToFavorites(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'addToFavorites',
          ),
        );
      }

      await _articleDao.toggleFavorite(articleId, true);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '收藏失败',
          table: 'articles',
          operation: 'addToFavorites',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'removeFromFavorites',
          ),
        );
      }

      await _articleDao.toggleFavorite(articleId, false);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '取消收藏失败',
          table: 'articles',
          operation: 'removeFromFavorites',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'toggleFavorite',
          ),
        );
      }

      final newStatus = !article.isFavorite;
      await _articleDao.toggleFavorite(articleId, newStatus);
      return Right(newStatus);
    } catch (e) {
      return Left(
        Failure.database(
          message: '切换收藏状态失败',
          table: 'articles',
          operation: 'toggleFavorite',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'isFavorite',
          ),
        );
      }

      return Right(article.isFavorite);
    } catch (e) {
      return Left(
        Failure.database(
          message: '检查收藏状态失败',
          table: 'articles',
          operation: 'isFavorite',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getFavoriteArticles({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final offset = (page - 1) * pageSize;
      final articlesData = await _articleDao.getFavoriteArticles(
        limit: pageSize,
        offset: offset,
      );
      final articles = articlesData
          .map(_mapArticlesTableDataToArticle)
          .toList();
      return Right(articles);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取收藏文章失败',
          table: 'articles',
          operation: 'getFavoriteArticles',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getFavoriteCount() async {
    try {
      final articles = await _articleDao.getFavoriteArticles(limit: 10000);
      return Right(articles.length);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取收藏数量失败',
          table: 'articles',
          operation: 'getFavoriteCount',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> moveToFolder(
    String articleId,
    String? folderId,
  ) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'moveToFolder',
          ),
        );
      }

      await _articleDao.updateArticle(
        ArticlesTableCompanion(
          id: Value(articleId),
          feedId: Value(article.feedId),
          title: Value(article.title),
          link: Value(article.link),
          favoriteFolderId: Value(folderId),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '移动到收藏夹失败',
          table: 'articles',
          operation: 'moveToFolder',
        ),
      );
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
