import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/sync/domain/entities/sync_entities.dart';

/// 同步服务接口
///
/// 负责订阅源、阅读状态、收藏等数据的云端同步
abstract class SyncService {
  /// 同步所有数据
  ///
  /// 包括订阅源、阅读状态和收藏
  /// 返回同步结果
  Future<Either<Failure, SyncResult>> syncAll();

  /// 同步订阅源
  ///
  /// 将本地订阅源与云端同步
  Future<Either<Failure, int>> syncFeeds();

  /// 同步阅读状态
  ///
  /// 将本地阅读状态与云端同步
  Future<Either<Failure, int>> syncReadStatus();

  /// 同步收藏
  ///
  /// 将本地收藏与云端同步
  Future<Either<Failure, int>> syncFavorites();

  /// 获取同步状态流
  ///
  /// 返回实时同步状态更新
  Stream<SyncStatus> get syncStatusStream;

  /// 获取当前同步状态
  SyncStatus get currentStatus;

  /// 解决同步冲突
  ///
  /// [conflict] 同步冲突信息
  /// [useLocal] 是否使用本地值
  Future<Either<Failure, void>> resolveConflict(
    SyncConflict conflict, {
    required bool useLocal,
  });

  /// 取消当前同步
  Future<void> cancelSync();

  /// 获取上次同步时间
  Future<DateTime?> getLastSyncTime();

  /// 检查是否需要同步
  ///
  /// 根据上次同步时间和配置判断
  Future<bool> needsSync();
}
