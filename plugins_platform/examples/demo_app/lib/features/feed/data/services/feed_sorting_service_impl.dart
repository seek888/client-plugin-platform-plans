import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/services/feed_sorting_service.dart';

/// 订阅源排序服务实现
class FeedSortingServiceImpl implements FeedSortingService {
  final FeedDao _feedDao;

  FeedSortingServiceImpl({required FeedDao feedDao}) : _feedDao = feedDao;

  @override
  Future<Either<Failure, void>> reorderFeeds(List<String> feedIds) async {
    try {
      await _feedDao.updateSortOrders(feedIds);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '重排序订阅源失败',
          table: 'feeds',
          operation: 'reorderFeeds',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> moveFeedToIndex(
    String feedId,
    int newIndex,
  ) async {
    try {
      // 获取所有订阅源
      final feedsData = await _feedDao.getAllFeeds();
      final feedIds = feedsData.map((f) => f.id).toList();

      // 检查 feedId 是否存在
      final currentIndex = feedIds.indexOf(feedId);
      if (currentIndex == -1) {
        return Left(
          Failure.database(
            message: '订阅源不存在',
            table: 'feeds',
            operation: 'moveFeedToIndex',
          ),
        );
      }

      // 检查新索引是否有效
      if (newIndex < 0 || newIndex >= feedIds.length) {
        return Left(
          Failure.validation(
            message: '无效的目标位置',
            field: 'newIndex',
            value: newIndex,
          ),
        );
      }

      // 如果位置相同，无需操作
      if (currentIndex == newIndex) {
        return const Right(null);
      }

      // 移动元素
      feedIds.removeAt(currentIndex);
      feedIds.insert(newIndex, feedId);

      // 更新排序
      await _feedDao.updateSortOrders(feedIds);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '移动订阅源失败',
          table: 'feeds',
          operation: 'moveFeedToIndex',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> swapFeeds(
    String feedId1,
    String feedId2,
  ) async {
    try {
      // 获取所有订阅源
      final feedsData = await _feedDao.getAllFeeds();
      final feedIds = feedsData.map((f) => f.id).toList();

      // 检查两个 feedId 是否存在
      final index1 = feedIds.indexOf(feedId1);
      final index2 = feedIds.indexOf(feedId2);

      if (index1 == -1 || index2 == -1) {
        return Left(
          Failure.database(
            message: '订阅源不存在',
            table: 'feeds',
            operation: 'swapFeeds',
          ),
        );
      }

      // 如果是同一个订阅源，无需操作
      if (feedId1 == feedId2) {
        return const Right(null);
      }

      // 交换位置
      feedIds[index1] = feedId2;
      feedIds[index2] = feedId1;

      // 更新排序
      await _feedDao.updateSortOrders(feedIds);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '交换订阅源位置失败',
          table: 'feeds',
          operation: 'swapFeeds',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Feed>>> getSortedFeeds() async {
    try {
      final feedsData = await _feedDao.getAllFeeds();
      final feeds = feedsData.map(_mapFeedsTableDataToFeed).toList();
      return Right(feeds);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取订阅源列表失败',
          table: 'feeds',
          operation: 'getSortedFeeds',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Feed>>> getSortedFeedsByCategory(
    String? categoryId,
  ) async {
    try {
      final feedsData = await _feedDao.getFeedsByCategory(categoryId);
      final feeds = feedsData.map(_mapFeedsTableDataToFeed).toList();
      // 按 sortOrder 排序
      feeds.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      return Right(feeds);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取分类下的订阅源列表失败',
          table: 'feeds',
          operation: 'getSortedFeedsByCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> reorderFeedsInCategory(
    String? categoryId,
    List<String> feedIds,
  ) async {
    try {
      // 获取分类内的订阅源
      final feedsData = await _feedDao.getFeedsByCategory(categoryId);
      final existingFeedIds = feedsData.map((f) => f.id).toSet();

      // 验证所有 feedIds 都属于该分类
      for (final feedId in feedIds) {
        if (!existingFeedIds.contains(feedId)) {
          return Left(
            Failure.validation(
              message: '订阅源不属于该分类',
              field: 'feedId',
              value: feedId,
            ),
          );
        }
      }

      // 更新排序（只更新分类内的订阅源）
      for (var i = 0; i < feedIds.length; i++) {
        final feedData = feedsData.firstWhere((f) => f.id == feedIds[i]);
        await _feedDao.updateFeed(
          FeedsTableCompanion(
            id: Value(feedIds[i]),
            url: Value(feedData.url),
            title: Value(feedData.title),
            sortOrder: Value(i),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '重排序分类内订阅源失败',
          table: 'feeds',
          operation: 'reorderFeedsInCategory',
        ),
      );
    }
  }

  // ========== 私有方法 ==========

  /// 将数据库数据映射为 Feed 实体
  Feed _mapFeedsTableDataToFeed(FeedsTableData data) {
    return Feed(
      id: data.id,
      url: data.url,
      title: data.title,
      description: data.description,
      iconUrl: data.iconUrl,
      link: data.link,
      categoryId: data.categoryId,
      sortOrder: data.sortOrder,
      unreadCount: data.unreadCount,
      lastUpdated: data.lastUpdated,
      lastFetched: data.lastFetched,
      isEnabled: data.isEnabled,
      isBlocked: data.isBlocked,
      healthStatus: data.healthStatus,
      failureCount: data.failureCount,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
