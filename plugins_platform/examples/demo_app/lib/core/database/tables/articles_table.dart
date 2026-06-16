import 'package:drift/drift.dart';

/// 文章表
class ArticlesTable extends Table {
  @override
  String get tableName => 'articles';

  /// 主键 ID
  TextColumn get id => text()();

  /// 所属订阅源 ID
  TextColumn get feedId => text()();

  /// 文章标题
  TextColumn get title => text()();

  /// 文章链接
  TextColumn get link => text()();

  /// 文章摘要
  TextColumn get summary => text().nullable()();

  /// 文章内容（HTML）
  TextColumn get content => text().nullable()();

  /// 作者
  TextColumn get author => text().nullable()();

  /// 封面图 URL
  TextColumn get imageUrl => text().nullable()();

  /// 发布时间
  DateTimeColumn get publishedAt => dateTime().nullable()();

  /// 是否已读
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();

  /// 是否已收藏
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  /// 是否已缓存
  BoolColumn get isCached => boolean().withDefault(const Constant(false))();

  /// 是否被屏蔽
  BoolColumn get isBlocked => boolean().withDefault(const Constant(false))();

  /// 阅读进度（0-100）
  IntColumn get readProgress => integer().withDefault(const Constant(0))();

  /// 收藏夹 ID
  TextColumn get favoriteFolderId => text().nullable()();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
