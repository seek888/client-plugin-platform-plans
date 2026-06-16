import 'package:drift/drift.dart';

/// 批注表
class AnnotationsTable extends Table {
  @override
  String get tableName => 'annotations';

  /// 主键 ID
  TextColumn get id => text()();

  /// 所属文章 ID
  TextColumn get articleId => text()();

  /// 批注内容
  TextColumn get content => text()();

  /// 选中的文本
  TextColumn get selectedText => text().nullable()();

  /// 选中文本的起始位置
  IntColumn get startOffset => integer().nullable()();

  /// 选中文本的结束位置
  IntColumn get endOffset => integer().nullable()();

  /// 高亮颜色
  TextColumn get highlightColor => text().nullable()();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 同步日志表
class SyncLogsTable extends Table {
  @override
  String get tableName => 'sync_logs';

  /// 主键 ID
  IntColumn get id => integer().autoIncrement()();

  /// 同步类型
  TextColumn get syncType => text()();

  /// 同步状态：success, failed, partial
  TextColumn get status => text()();

  /// 同步消息
  TextColumn get message => text().nullable()();

  /// 同步的项目数量
  IntColumn get itemCount => integer().withDefault(const Constant(0))();

  /// 同步时间
  DateTimeColumn get syncedAt => dateTime().withDefault(currentDateAndTime)();
}
