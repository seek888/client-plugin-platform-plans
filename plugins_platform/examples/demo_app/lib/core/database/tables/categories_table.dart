import 'package:drift/drift.dart';

/// 分类表
class CategoriesTable extends Table {
  @override
  String get tableName => 'categories';

  /// 主键 ID
  TextColumn get id => text()();

  /// 分类名称
  TextColumn get name => text()();

  /// 分类描述
  TextColumn get description => text().nullable()();

  /// 排序顺序
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// 是否展开（UI状态）
  BoolColumn get isExpanded => boolean().withDefault(const Constant(true))();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 收藏夹表
class FavoriteFoldersTable extends Table {
  @override
  String get tableName => 'favorite_folders';

  /// 主键 ID
  TextColumn get id => text()();

  /// 收藏夹名称
  TextColumn get name => text()();

  /// 排序顺序
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
