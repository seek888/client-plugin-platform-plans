import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/services/unread_count_service.dart';

/// 未读数服务实现
class UnreadCountServiceImpl implements UnreadCountService {
  final ArticleDao _articleDao;
  final FeedDao _feedDao;

  UnreadCountServiceImpl({
    required ArticleDao articleDao,
    required FeedDao feedDao,
  }) : _articleDao = articleDao,
       _feedDao = feedDao;

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
  Future<Either<Failure, Map<String, int>>> getAllUnreadCounts() async {
    try {
      final feeds = await _feedDao.getAllFeeds();
      final counts = <String, int>{};

      for (final feed in feeds) {
        final count = await _articleDao.getUnreadCountByFeed(feed.id);
        counts[feed.id] = count;
      }

      return Right(counts);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取所有未读数失败',
          table: 'articles',
          operation: 'getAllUnreadCounts',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> recalculateUnreadCount(String feedId) async {
    try {
      final count = await _articleDao.getUnreadCountByFeed(feedId);
      await _feedDao.updateUnreadCount(feedId, count);
      return Right(count);
    } catch (e) {
      return Left(
        Failure.database(
          message: '重新计算未读数失败',
          table: 'articles',
          operation: 'recalculateUnreadCount',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> recalculateAllUnreadCounts() async {
    try {
      final feeds = await _feedDao.getAllFeeds();

      for (final feed in feeds) {
        final count = await _articleDao.getUnreadCountByFeed(feed.id);
        await _feedDao.updateUnreadCount(feed.id, count);
      }

      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '重新计算所有未读数失败',
          table: 'articles',
          operation: 'recalculateAllUnreadCounts',
        ),
      );
    }
  }
}
