import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/domain/repositories/article_repository.dart';

/// 文章仓库实现
class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleDao _articleDao;
  final FeedDao _feedDao;

  ArticleRepositoryImpl({
    required ArticleDao articleDao,
    required FeedDao feedDao,
  }) : _articleDao = articleDao,
       _feedDao = feedDao;

  @override
  Future<Either<Failure, List<Article>>> getArticlesByFeed(
    String feedId, {
    int page = 1,
    int pageSize = 20,
    ArticleSortType sortType = ArticleSortType.timeDesc,
    ArticleFilterType filterType = ArticleFilterType.all,
  }) async {
    try {
      final offset = (page - 1) * pageSize;
      final articlesData = await _articleDao.getArticlesByFeedWithSort(
        feedId,
        limit: pageSize,
        offset: offset,
        sortType: sortType,
        filterType: filterType,
      );
      final articles = articlesData
          .map(_mapArticlesTableDataToArticle)
          .toList();
      return Right(articles);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取文章列表失败',
          table: 'articles',
          operation: 'getArticlesByFeed',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getAllArticles({
    int page = 1,
    int pageSize = 20,
    ArticleSortType sortType = ArticleSortType.timeDesc,
    ArticleFilterType filterType = ArticleFilterType.all,
  }) async {
    try {
      final offset = (page - 1) * pageSize;
      final articlesData = await _articleDao.getAllArticlesWithSort(
        limit: pageSize,
        offset: offset,
        sortType: sortType,
        filterType: filterType,
      );
      final articles = articlesData
          .map(_mapArticlesTableDataToArticle)
          .toList();
      return Right(articles);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取所有文章失败',
          table: 'articles',
          operation: 'getAllArticles',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Article>> getArticleDetail(String articleId) async {
    try {
      final articleData = await _articleDao.getArticleById(articleId);
      if (articleData == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'getArticleDetail',
          ),
        );
      }
      return Right(_mapArticlesTableDataToArticle(articleData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取文章详情失败',
          table: 'articles',
          operation: 'getArticleDetail',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(
    String articleId,
    bool isRead,
  ) async {
    try {
      await _articleDao.markAsReadWithValue(articleId, isRead);

      // 更新订阅源未读数
      final article = await _articleDao.getArticleById(articleId);
      if (article != null) {
        final unreadCount = await _articleDao.getUnreadCountByFeed(
          article.feedId,
        );
        await _feedDao.updateUnreadCount(article.feedId, unreadCount);
      }

      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '标记已读失败',
          table: 'articles',
          operation: 'markAsRead',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> markAllAsRead({String? feedId}) async {
    try {
      int count;
      if (feedId != null) {
        count = await _articleDao.markAllAsReadByFeed(feedId);
        await _feedDao.updateUnreadCount(feedId, 0);
      } else {
        count = await _articleDao.markAllAsRead();
        // 更新所有订阅源的未读数为 0
        final feeds = await _feedDao.getAllFeeds();
        for (final feed in feeds) {
          await _feedDao.updateUnreadCount(feed.id, 0);
        }
      }
      return Right(count);
    } catch (e) {
      return Left(
        Failure.database(
          message: '批量标记已读失败',
          table: 'articles',
          operation: 'markAllAsRead',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String articleId) async {
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
      await _articleDao.toggleFavorite(articleId, !article.isFavorite);
      return const Right(null);
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
  Future<Either<Failure, void>> blockArticle(String articleId) async {
    try {
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
  Future<Either<Failure, Article?>> getAdjacentArticle(
    String currentArticleId,
    String feedId,
    bool isNext,
  ) async {
    try {
      final articleData = await _articleDao.getAdjacentArticle(
        currentArticleId,
        feedId,
        isNext,
      );
      if (articleData == null) {
        return const Right(null);
      }
      return Right(_mapArticlesTableDataToArticle(articleData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取相邻文章失败',
          table: 'articles',
          operation: 'getAdjacentArticle',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCountByFeed(String feedId) async {
    try {
      final count = await _articleDao.getUnreadCountByFeed(feedId);
      return Right(count);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取未读数失败',
          table: 'articles',
          operation: 'getUnreadCountByFeed',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getTotalUnreadCount() async {
    try {
      final count = await _articleDao.getTotalUnreadCount();
      return Right(count);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取总未读数失败',
          table: 'articles',
          operation: 'getTotalUnreadCount',
        ),
      );
    }
  }

  @override
  Stream<List<Article>> watchArticlesByFeed(String feedId) {
    return _articleDao
        .watchArticlesByFeed(feedId)
        .map(
          (articlesData) =>
              articlesData.map(_mapArticlesTableDataToArticle).toList(),
        );
  }

  @override
  Stream<List<Article>> watchAllArticles() {
    return _articleDao.watchAllArticles().map(
      (articlesData) =>
          articlesData.map(_mapArticlesTableDataToArticle).toList(),
    );
  }

  @override
  Future<Either<Failure, List<Article>>> searchArticles(
    String keyword, {
    int limit = 50,
  }) async {
    try {
      final articlesData = await _articleDao.searchArticles(
        keyword,
        limit: limit,
      );
      final articles = articlesData
          .map(_mapArticlesTableDataToArticle)
          .toList();
      return Right(articles);
    } catch (e) {
      return Left(
        Failure.database(
          message: '搜索文章失败',
          table: 'articles',
          operation: 'searchArticles',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> cacheArticle(String articleId) async {
    try {
      await _articleDao.markAsCached(articleId);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '缓存文章失败',
          table: 'articles',
          operation: 'cacheArticle',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getCachedArticles() async {
    try {
      final articlesData = await _articleDao.getCachedArticles();
      final articles = articlesData
          .map(_mapArticlesTableDataToArticle)
          .toList();
      return Right(articles);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取缓存文章失败',
          table: 'articles',
          operation: 'getCachedArticles',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateReadProgress(
    String articleId,
    int progress,
  ) async {
    try {
      await _articleDao.updateReadProgress(articleId, progress);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '更新阅读进度失败',
          table: 'articles',
          operation: 'updateReadProgress',
        ),
      );
    }
  }

  // ========== 私有方法 ==========

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
