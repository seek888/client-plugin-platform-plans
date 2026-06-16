import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

/// 订阅源排序服务接口
abstract class FeedSortingService {
  /// 重排序订阅源
  ///
  /// [feedIds] - 按新顺序排列的订阅源 ID 列表
  Future<Either<Failure, void>> reorderFeeds(List<String> feedIds);

  /// 移动订阅源到指定位置
  ///
  /// [feedId] - 要移动的订阅源 ID
  /// [newIndex] - 新位置索引
  Future<Either<Failure, void>> moveFeedToIndex(String feedId, int newIndex);

  /// 交换两个订阅源的位置
  ///
  /// [feedId1] - 第一个订阅源 ID
  /// [feedId2] - 第二个订阅源 ID
  Future<Either<Failure, void>> swapFeeds(String feedId1, String feedId2);

  /// 获取按排序顺序排列的订阅源列表
  Future<Either<Failure, List<Feed>>> getSortedFeeds();

  /// 获取分类内按排序顺序排列的订阅源列表
  Future<Either<Failure, List<Feed>>> getSortedFeedsByCategory(
    String? categoryId,
  );

  /// 重排序分类内的订阅源
  Future<Either<Failure, void>> reorderFeedsInCategory(
    String? categoryId,
    List<String> feedIds,
  );
}
