import 'package:plugins_platform/plugins_platform.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/core/services/rss_parser_service.dart';
import 'package:rss_reader/features/feed/data/adapters/api_source_adapter.dart';
import 'package:rss_reader/features/feed/data/adapters/plugin_source_adapter.dart';
import 'package:rss_reader/features/feed/data/adapters/rss_source_adapter.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/services/data_source_adapter.dart';

final _log = logger.tag(LogTags.feed);

/// 数据源管理器
/// 负责创建和管理数据源适配器实例
class DataSourceManager {
  /// RSS 解析服务
  final RssParserService _rssParserService;

  /// 插件管理器
  final PluginManager? _pluginManager;

  /// 适配器缓存（按 Feed ID 索引）
  final Map<String, DataSourceAdapter> _adapters = {};

  /// 是否已释放
  bool _disposed = false;

  DataSourceManager({
    required RssParserService rssParserService,
    PluginManager? pluginManager,
  })  : _rssParserService = rssParserService,
        _pluginManager = pluginManager;

  /// 获取或创建数据源适配器
  ///
  /// [feed] 订阅源实体
  /// 返回对应的数据源适配器实例
  DataSourceAdapter getAdapter(Feed feed) {
    if (_disposed) {
      throw StateError('DataSourceManager 已释放');
    }

    final key = feed.id;

    // 如果已有缓存的适配器，直接返回
    if (_adapters.containsKey(key)) {
      return _adapters[key]!;
    }

    // 创建新的适配器
    final adapter = _createAdapter(feed);
    _adapters[key] = adapter;

    _log.debug('创建数据源适配器: ${feed.title} (${feed.sourceType.name})');

    return adapter;
  }

  /// 根据配置创建数据源适配器
  ///
  /// [config] 数据源配置
  DataSourceAdapter createAdapterFromConfig(DataSourceConfig config) {
    if (_disposed) {
      throw StateError('DataSourceManager 已释放');
    }

    return switch (config) {
      RssSourceConfig(:final feedUrl) => RssSourceAdapter(
          feedUrl: feedUrl,
          parserService: _rssParserService,
        ),
      ApiDataSourceConfig(:final config) => ApiSourceAdapter(
          config: config,
        ),
      PluginDataSourceConfig(:final config) => PluginSourceAdapter(
          config: config,
          pluginManager: _pluginManager ??
              (throw StateError(
                'PluginManager is required for plugin data sources',
              )),
        ),
    };
  }

  /// 移除适配器
  ///
  /// [feedId] 订阅源 ID
  void removeAdapter(String feedId) {
    final adapter = _adapters.remove(feedId);
    if (adapter != null) {
      adapter.dispose();
      _log.debug('移除数据源适配器: $feedId');
    }
  }

  /// 清除所有适配器缓存
  void clearCache() {
    for (final adapter in _adapters.values) {
      adapter.dispose();
    }
    _adapters.clear();
    _log.debug('清除所有数据源适配器缓存');
  }

  /// 释放所有资源
  void dispose() {
    if (!_disposed) {
      clearCache();
      _disposed = true;
      _log.debug('DataSourceManager 已释放');
    }
  }

  /// 获取当前缓存的适配器数量
  int get adapterCount => _adapters.length;

  /// 检查是否有指定 Feed 的适配器
  bool hasAdapter(String feedId) => _adapters.containsKey(feedId);

  // ========== 私有方法 ==========

  /// 创建数据源适配器
  DataSourceAdapter _createAdapter(Feed feed) {
    switch (feed.sourceType) {
      case SourceType.rss:
        return RssSourceAdapter(
          feedUrl: feed.url,
          parserService: _rssParserService,
        );
      case SourceType.api:
        if (feed.apiConfig == null) {
          throw ArgumentError('API 数据源必须提供 apiConfig');
        }
        return ApiSourceAdapter(
          config: feed.apiConfig!,
        );
      case SourceType.plugin:
        if (feed.pluginConfig == null) {
          throw ArgumentError('插件数据源必须提供 pluginConfig');
        }
        if (_pluginManager == null) {
          throw StateError('PluginManager is required for plugin data sources');
        }
        return PluginSourceAdapter(
          config: feed.pluginConfig!,
          pluginManager: _pluginManager,
        );
    }
  }
}
