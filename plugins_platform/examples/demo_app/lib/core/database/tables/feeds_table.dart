import 'package:drift/drift.dart';

/// 订阅源表
class FeedsTable extends Table {
  @override
  String get tableName => 'feeds';

  /// 主键 ID
  TextColumn get id => text()();

  /// 订阅源 URL
  TextColumn get url => text()();

  /// 订阅源标题
  TextColumn get title => text()();

  /// 订阅源描述
  TextColumn get description => text().nullable()();

  /// 订阅源图标 URL
  TextColumn get iconUrl => text().nullable()();

  /// 订阅源网站链接
  TextColumn get link => text().nullable()();

  /// 所属分类 ID
  TextColumn get categoryId => text().nullable()();

  /// 排序顺序
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// 未读数量
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();

  /// 最后更新时间
  DateTimeColumn get lastUpdated => dateTime().nullable()();

  /// 最后获取时间
  DateTimeColumn get lastFetched => dateTime().nullable()();

  /// 是否启用
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  /// 是否被屏蔽
  BoolColumn get isBlocked => boolean().withDefault(const Constant(false))();

  /// 健康状态：0-正常, 1-警告, 2-失效
  IntColumn get healthStatus => integer().withDefault(const Constant(0))();

  /// 连续失败次数
  IntColumn get failureCount => integer().withDefault(const Constant(0))();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  // ========== 数据源相关字段 ==========

  /// 数据源类型：'rss'、'api' 或 'plugin'
  TextColumn get sourceType => text().withDefault(const Constant('rss'))();

  /// API 基础 URL（仅 API 数据源）
  TextColumn get apiBaseUrl => text().nullable()();

  /// API 密钥（仅 API 数据源）
  TextColumn get apiKey => text().nullable()();

  /// API 自定义请求头（JSON 格式，仅 API 数据源）
  TextColumn get apiHeaders => text().nullable()();

  /// API 远程 Feed ID（仅 API 数据源）
  TextColumn get apiRemoteFeedId => text().nullable()();

  /// API 请求超时（秒，仅 API 数据源）
  IntColumn get apiTimeout => integer().withDefault(const Constant(30))();

  /// API 最大重试次数（仅 API 数据源）
  IntColumn get apiMaxRetries => integer().withDefault(const Constant(3))();

  /// 插件 ID（仅插件数据源）
  TextColumn get pluginId => text().nullable()();

  /// 插件内 Feed Key（仅插件数据源）
  TextColumn get pluginFeedKey => text().nullable()();

  /// 插件能力提供者 ID（仅插件数据源）
  TextColumn get pluginProvider => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
