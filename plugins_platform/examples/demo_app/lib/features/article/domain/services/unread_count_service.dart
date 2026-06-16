import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';

/// 未读数服务接口
abstract class UnreadCountService {
  /// 获取单个订阅源的未读数
  Future<Either<Failure, int>> getUnreadCountByFeed(String feedId);

  /// 获取所有订阅源的未读数汇总
  Future<Either<Failure, int>> getTotalUnreadCount();

  /// 获取所有订阅源的未读数映射
  Future<Either<Failure, Map<String, int>>> getAllUnreadCounts();

  /// 重新计算并更新订阅源的未读数
  Future<Either<Failure, int>> recalculateUnreadCount(String feedId);

  /// 重新计算并更新所有订阅源的未读数
  Future<Either<Failure, void>> recalculateAllUnreadCounts();
}
