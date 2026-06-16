import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

/// 订阅源实体
@freezed
class Feed with _$Feed {
  const Feed._();

  const factory Feed({
    required String id,
    required String url,
    required String title,
    String? description,
    String? iconUrl,
    String? link,
    String? categoryId,
    @Default(0) int sortOrder,
    @Default(0) int unreadCount,
    DateTime? lastUpdated,
    DateTime? lastFetched,
    @Default(true) bool isEnabled,
    @Default(false) bool isBlocked,
    @Default(0) int healthStatus,
    @Default(0) int failureCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    // 数据源相关字段
    /// 数据源类型（默认为 RSS）
    @Default(SourceType.rss) SourceType sourceType,

    /// API 数据源配置（仅当 sourceType 为 api 时有效）
    ApiSourceConfig? apiConfig,

    /// 插件数据源配置（仅当 sourceType 为 plugin 时有效）
    PluginSourceConfig? pluginConfig,
  }) = _Feed;

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);

  /// 是否健康
  bool get isHealthy => healthStatus == 0;

  /// 是否有警告
  bool get hasWarning => healthStatus == 1;

  /// 是否失效
  bool get isInvalid => healthStatus == 2;

  /// 是否为 RSS 数据源
  bool get isRssSource => sourceType == SourceType.rss;

  /// 是否为 API 数据源
  bool get isApiSource => sourceType == SourceType.api;

  /// 是否为插件数据源
  bool get isPluginSource => sourceType == SourceType.plugin;

  /// 获取数据源配置
  DataSourceConfig get dataSourceConfig {
    if (sourceType == SourceType.api && apiConfig != null) {
      return DataSourceConfig.api(config: apiConfig!);
    }
    if (sourceType == SourceType.plugin && pluginConfig != null) {
      return DataSourceConfig.plugin(config: pluginConfig!);
    }
    return DataSourceConfig.rss(feedUrl: url);
  }
}

/// 订阅源分类实体
@freezed
class FeedCategory with _$FeedCategory {
  const factory FeedCategory({
    required String id,
    required String name,
    String? description,
    @Default(0) int sortOrder,
    @Default(true) bool isExpanded,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeedCategory;

  factory FeedCategory.fromJson(Map<String, dynamic> json) =>
      _$FeedCategoryFromJson(json);
}
