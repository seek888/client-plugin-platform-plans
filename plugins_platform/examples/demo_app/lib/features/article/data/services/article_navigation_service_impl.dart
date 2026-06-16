import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/domain/services/article_navigation_service.dart';

/// 文章导航服务实现
class ArticleNavigationServiceImpl implements ArticleNavigationService {
  final ArticleDao _articleDao;

  ArticleNavigationServiceImpl({required ArticleDao articleDao})
    : _articleDao = articleDao;

  @override
  Future<Either<Failure, Article?>> getPreviousArticle(
    String currentArticleId,
    String feedId,
  ) async {
    try {
      final articleData = await _articleDao.getAdjacentArticle(
        currentArticleId,
        feedId,
        false, // isNext = false means previous
      );

      if (articleData == null) {
        return const Right(null);
      }

      return Right(_mapArticlesTableDataToArticle(articleData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取上一篇文章失败',
          table: 'articles',
          operation: 'getPreviousArticle',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Article?>> getNextArticle(
    String currentArticleId,
    String feedId,
  ) async {
    try {
      final articleData = await _articleDao.getAdjacentArticle(
        currentArticleId,
        feedId,
        true, // isNext = true means next
      );

      if (articleData == null) {
        return const Right(null);
      }

      return Right(_mapArticlesTableDataToArticle(articleData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取下一篇文章失败',
          table: 'articles',
          operation: 'getNextArticle',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> hasPreviousArticle(
    String currentArticleId,
    String feedId,
  ) async {
    final result = await getPreviousArticle(currentArticleId, feedId);
    return result.map((article) => article != null);
  }

  @override
  Future<Either<Failure, bool>> hasNextArticle(
    String currentArticleId,
    String feedId,
  ) async {
    final result = await getNextArticle(currentArticleId, feedId);
    return result.map((article) => article != null);
  }

  @override
  Future<Either<Failure, ArticlePosition>> getArticlePosition(
    String currentArticleId,
    String feedId,
  ) async {
    try {
      // Get all articles for the feed sorted by time descending
      final allArticles = await _articleDao.getArticlesByFeed(
        feedId,
        limit: 10000, // Get all
        offset: 0,
      );

      // Find current article index
      int currentIndex = -1;
      for (var i = 0; i < allArticles.length; i++) {
        if (allArticles[i].id == currentArticleId) {
          currentIndex = i;
          break;
        }
      }

      if (currentIndex == -1) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'getArticlePosition',
          ),
        );
      }

      return Right(
        ArticlePosition(
          currentIndex: currentIndex + 1, // 1-based index
          totalCount: allArticles.length,
          hasPrevious: currentIndex > 0,
          hasNext: currentIndex < allArticles.length - 1,
        ),
      );
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取文章位置失败',
          table: 'articles',
          operation: 'getArticlePosition',
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
