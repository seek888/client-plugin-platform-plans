import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plugins_platform/plugins_platform.dart';
import 'package:rss_reader/features/feed/data/services/data_source_manager.dart';
import 'package:rss_reader/core/services/rss_parser_provider.dart';

/// DataSourceManager Provider
/// 管理所有数据源适配器的创建和缓存
final dataSourceManagerProvider = Provider<DataSourceManager>((ref) {
  final rssParserService = ref.watch(rssParserServiceProvider);
  final pluginManager = ref.watch(pluginManagerProvider);

  final manager = DataSourceManager(
    rssParserService: rssParserService,
    pluginManager: pluginManager,
  );

  // 在 provider 销毁时释放资源
  ref.onDispose(() {
    manager.dispose();
  });

  return manager;
});
