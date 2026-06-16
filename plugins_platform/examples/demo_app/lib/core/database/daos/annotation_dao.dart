import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/tables/annotations_table.dart';

part 'annotation_dao.g.dart';

/// 批注数据访问对象
@DriftAccessor(tables: [AnnotationsTable, SyncLogsTable])
class AnnotationDao extends DatabaseAccessor<AppDatabase>
    with _$AnnotationDaoMixin {
  AnnotationDao(super.db);

  /// 获取文章的所有批注
  Future<List<AnnotationsTableData>> getAnnotationsByArticle(String articleId) {
    return (select(annotationsTable)
          ..where((t) => t.articleId.equals(articleId))
          ..orderBy([(t) => OrderingTerm.asc(t.startOffset)]))
        .get();
  }

  /// 根据 ID 获取批注
  Future<AnnotationsTableData?> getAnnotationById(String id) {
    return (select(
      annotationsTable,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// 插入批注
  Future<int> insertAnnotation(AnnotationsTableCompanion annotation) {
    return into(annotationsTable).insert(annotation);
  }

  /// 更新批注
  Future<bool> updateAnnotation(AnnotationsTableCompanion annotation) {
    return update(annotationsTable).replace(annotation);
  }

  /// 删除批注
  Future<int> deleteAnnotation(String id) {
    return (delete(annotationsTable)..where((t) => t.id.equals(id))).go();
  }

  /// 删除文章的所有批注
  Future<int> deleteAnnotationsByArticle(String articleId) {
    return (delete(
      annotationsTable,
    )..where((t) => t.articleId.equals(articleId))).go();
  }

  /// 监听文章批注变化
  Stream<List<AnnotationsTableData>> watchAnnotationsByArticle(
    String articleId,
  ) {
    return (select(annotationsTable)
          ..where((t) => t.articleId.equals(articleId))
          ..orderBy([(t) => OrderingTerm.asc(t.startOffset)]))
        .watch();
  }

  // ========== 同步日志相关 ==========

  /// 插入同步日志
  Future<int> insertSyncLog(SyncLogsTableCompanion log) {
    return into(syncLogsTable).insert(log);
  }

  /// 获取最近的同步日志
  Future<List<SyncLogsTableData>> getRecentSyncLogs({int limit = 50}) {
    return (select(syncLogsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
          ..limit(limit))
        .get();
  }

  /// 获取最后一次成功同步时间
  Future<DateTime?> getLastSuccessfulSyncTime(String syncType) async {
    final query = select(syncLogsTable)
      ..where((t) => t.syncType.equals(syncType) & t.status.equals('success'))
      ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.syncedAt;
  }

  /// 清理旧的同步日志
  Future<int> cleanOldSyncLogs(int keepDays) {
    final cutoffDate = DateTime.now().subtract(Duration(days: keepDays));
    return (delete(
      syncLogsTable,
    )..where((t) => t.syncedAt.isSmallerThanValue(cutoffDate))).go();
  }
}
