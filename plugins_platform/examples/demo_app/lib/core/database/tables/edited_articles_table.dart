import 'package:drift/drift.dart';

/// 已编辑文章内容表
/// 存储用户对 RSS 文章的编辑内容
class EditedArticlesTable extends Table {
  @override
  String get tableName => 'edited_articles';

  /// 文章 ID（主键，关联 articles 表）
  TextColumn get articleId => text()();

  /// Quill Delta JSON 格式的编辑内容
  TextColumn get deltaJson => text()();

  /// 转换后的 HTML 内容（用于显示）
  TextColumn get htmlContent => text()();

  /// 从内容提取的摘要
  TextColumn get summary => text().nullable()();

  /// 编辑时间
  DateTimeColumn get editedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {articleId};
}
