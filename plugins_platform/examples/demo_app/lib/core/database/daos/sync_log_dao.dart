import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/tables/annotations_table.dart';

part 'sync_log_dao.g.dart';

/// 同步日志数据访问对象
@DriftAccessor(tables: [SyncLogsTable])
class SyncLogDao extends DatabaseAccessor<AppDatabase> with _$SyncLogDaoMixin {
  SyncLogDao(super.db);

  /// 插入同步日志
  Future<int> insertSyncLog(SyncLogsTableCompanion log) {
    return into(syncLogsTable).insert(log);
  }

  /// 获取所有同步日志（按时间倒序）
  Future<List<SyncLogsTableData>> getAllSyncLogs({int limit = 50}) {
    return (select(syncLogsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
          ..limit(limit))
        .get();
  }

  /// 根据同步类型获取日志
  Future<List<SyncLogsTableData>> getSyncLogsByType(
    String syncType, {
    int limit = 50,
  }) {
    return (select(syncLogsTable)
          ..where((t) => t.syncType.equals(syncType))
          ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
          ..limit(limit))
        .get();
  }

  /// 获取最近一次同步日志
  Future<SyncLogsTableData?> getLastSyncLog({String? syncType}) {
    final query = select(syncLogsTable)
      ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
      ..limit(1);

    if (syncType != null) {
      query.where((t) => t.syncType.equals(syncType));
    }

    return query.getSingleOrNull();
  }

  /// 获取失败的同步日志
  Future<List<SyncLogsTableData>> getFailedSyncLogs({int limit = 20}) {
    return (select(syncLogsTable)
          ..where((t) => t.status.equals('failed'))
          ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
          ..limit(limit))
        .get();
  }

  /// 删除旧的同步日志
  Future<int> deleteOldLogs(DateTime olderThan) {
    return (delete(
      syncLogsTable,
    )..where((t) => t.syncedAt.isSmallerThanValue(olderThan))).go();
  }

  /// 获取同步日志数量
  Future<int> getSyncLogCount({String? syncType, String? status}) async {
    final query = selectOnly(syncLogsTable)
      ..addColumns([syncLogsTable.id.count()]);

    if (syncType != null) {
      query.where(syncLogsTable.syncType.equals(syncType));
    }
    if (status != null) {
      query.where(syncLogsTable.status.equals(status));
    }

    final result = await query.getSingle();
    return result.read(syncLogsTable.id.count()) ?? 0;
  }

  /// 监听同步日志变化
  Stream<List<SyncLogsTableData>> watchSyncLogs({int limit = 50}) {
    return (select(syncLogsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
          ..limit(limit))
        .watch();
  }
}
