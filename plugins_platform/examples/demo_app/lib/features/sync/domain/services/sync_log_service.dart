import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/sync/domain/entities/sync_entities.dart';

/// 同步日志服务接口
///
/// 负责记录和查询同步日志
abstract class SyncLogService {
  /// 记录同步日志
  ///
  /// [syncType] 同步类型
  /// [status] 同步状态（success, failed, partial）
  /// [message] 可选的消息
  /// [itemCount] 同步的项目数量
  Future<Either<Failure, int>> logSync({
    required SyncType syncType,
    required String status,
    String? message,
    int itemCount = 0,
  });

  /// 记录同步失败
  ///
  /// [syncType] 同步类型
  /// [message] 失败消息
  Future<Either<Failure, int>> logSyncFailure({
    required SyncType syncType,
    required String message,
  });

  /// 获取同步日志列表
  ///
  /// [limit] 返回的最大数量
  /// [syncType] 可选的同步类型筛选
  Future<Either<Failure, List<SyncLogEntry>>> getSyncLogs({
    int limit = 50,
    SyncType? syncType,
  });

  /// 获取最近一次同步日志
  ///
  /// [syncType] 可选的同步类型筛选
  Future<Either<Failure, SyncLogEntry?>> getLastSyncLog({SyncType? syncType});

  /// 获取失败的同步日志
  ///
  /// [limit] 返回的最大数量
  Future<Either<Failure, List<SyncLogEntry>>> getFailedSyncLogs({
    int limit = 20,
  });

  /// 清除旧的同步日志
  ///
  /// [olderThan] 清除早于此时间的日志
  Future<Either<Failure, int>> clearOldLogs({required DateTime olderThan});

  /// 获取同步日志数量
  Future<Either<Failure, int>> getSyncLogCount({
    SyncType? syncType,
    String? status,
  });
}
