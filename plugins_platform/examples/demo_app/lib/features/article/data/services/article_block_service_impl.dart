import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/domain/services/article_block_service.dart';

/// 文章屏蔽服务实现
class ArticleBlockServiceImpl implements ArticleBlockService {
  final ArticleDao _articleDao;

  ArticleBlockServiceImpl({required ArticleDao articleDao})
    : _articleDao = articleDao;

  @override
  Future<Either<Failure, void>> blockArticle(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'blockArticle',
          ),
        );
      }

      await _articleDao.blockArticle(articleId);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '屏蔽文章失败',
          table: 'articles',
          operation: 'blockArticle',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isBlocked(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'isBlocked',
          ),
        );
      }

      return Right(article.isBlocked);
    } catch (e) {
      return Left(
        Failure.database(
          message: '检查屏蔽状态失败',
          table: 'articles',
          operation: 'isBlocked',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getUnblockedArticles({
    String? feedId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final offset = (page - 1) * pageSize;
      List<ArticlesTableData> articlesData;

      if (feedId != null) {
        articlesData = await _articleDao.getArticlesByFeed(
          feedId,
          limit: pageSize,
          offset: offset,
        );
      } else {
        articlesData = await _articleDao.getAllArticles(
          limit: pageSize,
          offset: offset,
        );
      }

      final articles = articlesData.map(_mapToArticle).toList();
      return Right(articles);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取文章列表失败',
          table: 'articles',
          operation: 'getUnblockedArticles',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getUnblockedCount({String? feedId}) async {
    try {
      if (feedId != null) {
        final count = await _articleDao.getArticleCountByFeed(feedId);
        return Right(count);
      } else {
        final count = await _articleDao.getTotalUnreadCount();
        return Right(count);
      }
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取文章数量失败',
          table: 'articles',
          operation: 'getUnblockedCount',
        ),
      );
    }
  }

  /// 将数据库数据映射为 Article 实体
  Article _mapToArticle(ArticlesTableData data) {
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
