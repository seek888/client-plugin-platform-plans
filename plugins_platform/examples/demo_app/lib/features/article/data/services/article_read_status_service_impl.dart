import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/services/article_read_status_service.dart';

/// 文章已读状态服务实现
class ArticleReadStatusServiceImpl implements ArticleReadStatusService {
  final ArticleDao _articleDao;
  final FeedDao _feedDao;

  ArticleReadStatusServiceImpl({
    required ArticleDao articleDao,
    required FeedDao feedDao,
  }) : _articleDao = articleDao,
       _feedDao = feedDao;

  @override
  Future<Either<Failure, void>> markAsRead(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'markAsRead',
          ),
        );
      }

      await _articleDao.markAsReadWithValue(articleId, true);

      // 更新订阅源未读数
      final unreadCount = await _articleDao.getUnreadCountByFeed(
        article.feedId,
      );
      await _feedDao.updateUnreadCount(article.feedId, unreadCount);

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
  Future<Either<Failure, void>> markAsUnread(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'markAsUnread',
          ),
        );
      }

      await _articleDao.markAsReadWithValue(articleId, false);

      // 更新订阅源未读数
      final unreadCount = await _articleDao.getUnreadCountByFeed(
        article.feedId,
      );
      await _feedDao.updateUnreadCount(article.feedId, unreadCount);

      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '标记未读失败',
          table: 'articles',
          operation: 'markAsUnread',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> toggleReadStatus(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(
          Failure.database(
            message: '文章不存在',
            table: 'articles',
            operation: 'toggleReadStatus',
          ),
        );
      }

      final newStatus = !article.isRead;
      await _articleDao.markAsReadWithValue(articleId, newStatus);

      // 更新订阅源未读数
      final unreadCount = await _articleDao.getUnreadCountByFeed(
        article.feedId,
      );
      await _feedDao.updateUnreadCount(article.feedId, unreadCount);

      return Right(newStatus);
    } catch (e) {
      return Left(
        Failure.database(
          message: '切换已读状态失败',
          table: 'articles',
          operation: 'toggleReadStatus',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> markAllAsReadByFeed(String feedId) async {
    try {
      final count = await _articleDao.markAllAsReadByFeed(feedId);
      await _feedDao.updateUnreadCount(feedId, 0);
      return Right(count);
    } catch (e) {
      return Left(
        Failure.database(
          message: '批量标记已读失败',
          table: 'articles',
          operation: 'markAllAsReadByFeed',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> markAllAsRead() async {
    try {
      final count = await _articleDao.markAllAsRead();

      // 更新所有订阅源的未读数为 0
      final feeds = await _feedDao.getAllFeeds();
      for (final feed in feeds) {
        await _feedDao.updateUnreadCount(feed.id, 0);
      }

      return Right(count);
    } catch (e) {
      return Left(
        Failure.database(
          message: '批量标记所有已读失败',
          table: 'articles',
          operation: 'markAllAsRead',
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
}
