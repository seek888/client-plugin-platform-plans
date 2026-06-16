import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';

part 'data_source.freezed.dart';
part 'data_source.g.dart';

/// 数据源类型枚举
enum SourceType {
  /// RSS/Atom 订阅源
  rss,

  /// 后台 API 数据源
  api,

  /// 插件提供的数据源
  plugin,
}

/// API 数据源配置
@freezed
class ApiSourceConfig with _$ApiSourceConfig {
  const ApiSourceConfig._();

  const factory ApiSourceConfig({
    /// API 基础 URL
    required String baseUrl,

    /// API 密钥（可选）
    String? apiKey,

    /// 自定义请求头（可选）
    @Default({}) Map<String, String> customHeaders,

    /// 请求超时时间
    @Default(Duration(seconds: 30)) Duration timeout,

    /// 最大重试次数
    @Default(3) int maxRetries,

    /// Feed ID（API 端的标识）
    String? remoteFeedId,
  }) = _ApiSourceConfig;

  factory ApiSourceConfig.fromJson(Map<String, dynamic> json) =>
      _$ApiSourceConfigFromJson(json);

  /// 验证配置是否有效
  bool get isValid => baseUrl.isNotEmpty && Uri.tryParse(baseUrl) != null;
}

/// 文章列表结果（支持分页）
@freezed
class ArticleListResult with _$ArticleListResult {
  const ArticleListResult._();

  const factory ArticleListResult({
    /// 文章列表
    required List<ParsedArticle> articles,

    /// 是否还有更多数据
    required bool hasMore,

    /// 总数量（可选）
    int? totalCount,

    /// 下一页游标（可选，用于游标分页）
    String? nextCursor,

    /// 当前页码
    @Default(1) int currentPage,

    /// 每页数量
    @Default(20) int pageSize,
  }) = _ArticleListResult;

  factory ArticleListResult.fromJson(Map<String, dynamic> json) =>
      _$ArticleListResultFromJson(json);

  /// 是否为空结果
  bool get isEmpty => articles.isEmpty;

  /// 文章数量
  int get articleCount => articles.length;

  /// 是否为第一页
  bool get isFirstPage => currentPage == 1;
}

/// 插件数据源配置
@freezed
class PluginSourceConfig with _$PluginSourceConfig {
  const PluginSourceConfig._();

  const factory PluginSourceConfig({
    /// 插件 ID
    required String pluginId,

    /// 插件内 Feed 标识
    required String feedKey,

    /// 插件能力提供者 ID
    @Default('rss.feed.provider') String provider,
  }) = _PluginSourceConfig;

  factory PluginSourceConfig.fromJson(Map<String, dynamic> json) =>
      _$PluginSourceConfigFromJson(json);
}

/// 数据源配置（联合类型）
@freezed
sealed class DataSourceConfig with _$DataSourceConfig {
  /// RSS 数据源配置
  const factory DataSourceConfig.rss({
    required String feedUrl,
  }) = RssSourceConfig;

  /// API 数据源配置
  const factory DataSourceConfig.api({
    required ApiSourceConfig config,
  }) = ApiDataSourceConfig;

  /// 插件数据源配置
  const factory DataSourceConfig.plugin({
    required PluginSourceConfig config,
  }) = PluginDataSourceConfig;

  factory DataSourceConfig.fromJson(Map<String, dynamic> json) =>
      _$DataSourceConfigFromJson(json);
}
