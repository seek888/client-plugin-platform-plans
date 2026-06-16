import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/sync_log_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/sync/domain/entities/sync_entities.dart';
import 'package:rss_reader/features/sync/domain/services/sync_log_service.dart';

/// 同步日志服务实现
class SyncLogServiceImpl implements SyncLogService {
  final SyncLogDao _syncLogDao;

  SyncLogServiceImpl({required SyncLogDao syncLogDao})
    : _syncLogDao = syncLogDao;

  @override
  Future<Either<Failure, int>> logSync({
    required SyncType syncType,
    required String status,
    String? message,
    int itemCount = 0,
  }) async {
    try {
      final id = await _syncLogDao.insertSyncLog(
        SyncLogsTableCompanion(
          syncType: Value(_syncTypeToString(syncType)),
          status: Value(status),
          message: Value(message),
          itemCount: Value(itemCount),
          syncedAt: Value(DateTime.now()),
        ),
      );
      return Right(id);
    } catch (e) {
      return Left(
        Failure.database(
          message: '记录同步日志失败: ${e.toString()}',
          table: 'sync_logs',
          operation: 'insert',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> logSyncFailure({
    required SyncType syncType,
    required String message,
  }) async {
    return logSync(
      syncType: syncType,
      status: 'failed',
      message: message,
      itemCount: 0,
    );
  }

  @override
  Future<Either<Failure, List<SyncLogEntry>>> getSyncLogs({
    int limit = 50,
    SyncType? syncType,
  }) async {
    try {
      List<SyncLogsTableData> logs;
      if (syncType != null) {
        logs = await _syncLogDao.getSyncLogsByType(
          _syncTypeToString(syncType),
          limit: limit,
        );
      } else {
        logs = await _syncLogDao.getAllSyncLogs(limit: limit);
      }

      final entries = logs.map(_mapToSyncLogEntry).toList();
      return Right(entries);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取同步日志失败: ${e.toString()}',
          table: 'sync_logs',
          operation: 'select',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncLogEntry?>> getLastSyncLog({
    SyncType? syncType,
  }) async {
    try {
      final log = await _syncLogDao.getLastSyncLog(
        syncType: syncType != null ? _syncTypeToString(syncType) : null,
      );

      if (log == null) {
        return const Right(null);
      }

      return Right(_mapToSyncLogEntry(log));
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取最近同步日志失败: ${e.toString()}',
          table: 'sync_logs',
          operation: 'select',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<SyncLogEntry>>> getFailedSyncLogs({
    int limit = 20,
  }) async {
    try {
      final logs = await _syncLogDao.getFailedSyncLogs(limit: limit);
      final entries = logs.map(_mapToSyncLogEntry).toList();
      return Right(entries);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取失败同步日志失败: ${e.toString()}',
          table: 'sync_logs',
          operation: 'select',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> clearOldLogs({
    required DateTime olderThan,
  }) async {
    try {
      final count = await _syncLogDao.deleteOldLogs(olderThan);
      return Right(count);
    } catch (e) {
      return Left(
        Failure.database(
          message: '清除旧日志失败: ${e.toString()}',
          table: 'sync_logs',
          operation: 'delete',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getSyncLogCount({
    SyncType? syncType,
    String? status,
  }) async {
    try {
      final count = await _syncLogDao.getSyncLogCount(
        syncType: syncType != null ? _syncTypeToString(syncType) : null,
        status: status,
      );
      return Right(count);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取同步日志数量失败: ${e.toString()}',
          table: 'sync_logs',
          operation: 'count',
        ),
      );
    }
  }

  /// 将 SyncType 转换为字符串
  String _syncTypeToString(SyncType type) {
    switch (type) {
      case SyncType.all:
        return 'all';
      case SyncType.feeds:
        return 'feeds';
      case SyncType.readStatus:
        return 'readStatus';
      case SyncType.favorites:
        return 'favorites';
    }
  }

  /// 将字符串转换为 SyncType
  SyncType _stringToSyncType(String type) {
    switch (type) {
      case 'all':
        return SyncType.all;
      case 'feeds':
        return SyncType.feeds;
      case 'readStatus':
        return SyncType.readStatus;
      case 'favorites':
        return SyncType.favorites;
      default:
        return SyncType.all;
    }
  }

  /// 将数据库数据映射为 SyncLogEntry
  SyncLogEntry _mapToSyncLogEntry(SyncLogsTableData data) {
    return SyncLogEntry(
      id: data.id,
      syncType: _stringToSyncType(data.syncType),
      status: data.status,
      message: data.message,
      itemCount: data.itemCount,
      syncedAt: data.syncedAt,
    );
  }
}
