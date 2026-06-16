import 'package:drift/drift.dart';
import 'package:plugins_platform/plugins_platform.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/plugins/data/services/builtin_plugin_bootstrap.dart';
import 'package:uuid/uuid.dart';

/// 插件订阅源发现服务
class PluginFeedDiscoveryService {
  static const providerCapability = 'rss.feed.provider';
  static const discoveryMarkerKey = 'plugin.discovery';

  final PluginManager _pluginManager;
  final FeedDao _feedDao;
  final BuiltinPluginBootstrap _bootstrap;
  final Uuid _uuid;

  bool _synced = false;

  PluginFeedDiscoveryService({
    required PluginManager pluginManager,
    required FeedDao feedDao,
    required BuiltinPluginBootstrap bootstrap,
    Uuid? uuid,
  })  : _pluginManager = pluginManager,
        _feedDao = feedDao,
        _bootstrap = bootstrap,
        _uuid = uuid ?? const Uuid();

  Future<void> syncDiscoveredFeeds() async {
    if (_synced) return;

    await _bootstrap.ensureReady();
    await _pluginManager.ready;

    final plugins = _pluginManager
        .getAllPlugins()
        .where((plugin) => plugin.isActivated)
        .where(
          (plugin) => plugin.manifest.capabilities.any(
            (capability) => capability.id == providerCapability,
          ),
        );

    for (final plugin in plugins) {
      if (!_pluginManager.isActivated(plugin.manifest.id)) {
        await _pluginManager.activate(plugin.manifest.id);
      }
      final discovered = await _pluginManager.callPluginFunction(
        plugin.manifest.id,
        'discoverFeeds',
        const [{}],
      );
      await _upsertDiscoveredFeeds(plugin.manifest.id, discovered);
      await _cleanupDuplicateFeeds(plugin.manifest.id);
    }

    _synced = true;
  }

  Future<void> _upsertDiscoveredFeeds(
    String pluginId,
    dynamic discovered,
  ) async {
    final feeds = _normalizeFeeds(discovered);
    if (feeds.isEmpty) return;

    for (final feed in feeds) {
      final feedKey = feed['feedKey']?.toString();
      if (feedKey == null || feedKey.isEmpty) continue;

      final existing = await _feedDao.getPluginFeed(pluginId, feedKey);
      if (existing != null) continue;

      final now = DateTime.now();
      await _feedDao.insertFeed(
        FeedsTableCompanion(
          id: Value(_uuid.v4()),
          url: Value('plugin://$pluginId/$feedKey'),
          title: Value(feed['title']?.toString() ?? pluginId),
          description: Value(feed['description']?.toString()),
          iconUrl: Value(feed['iconUrl']?.toString()),
          link: Value(feed['link']?.toString()),
          sourceType: const Value('plugin'),
          pluginId: Value(pluginId),
          pluginFeedKey: Value(feedKey),
          pluginProvider: Value(
            feed['provider']?.toString() ?? providerCapability,
          ),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    }
  }

  Future<void> _cleanupDuplicateFeeds(String pluginId) async {
    final feeds = await _feedDao.getAllFeeds();
    final pluginFeeds = feeds.where(
      (feed) =>
          feed.sourceType == 'plugin' &&
          feed.pluginId == pluginId &&
          feed.pluginFeedKey == BuiltinPluginBootstrap.aiNewsDailyFeedKey,
    ).toList(growable: false);

    if (pluginFeeds.length <= 1) return;

    final keep = pluginFeeds.first;
    for (final feed in pluginFeeds.skip(1)) {
      await _feedDao.deleteFeed(feed.id);
    }

    final companion = FeedsTableCompanion(
      id: Value(keep.id),
      url: Value(keep.url),
      title: const Value(BuiltinPluginBootstrap.aiNewsDailyFeedTitle),
      description: Value(keep.description),
      iconUrl: Value(keep.iconUrl),
      link: Value(keep.link),
      categoryId: Value(keep.categoryId),
      sortOrder: Value(keep.sortOrder),
      unreadCount: Value(keep.unreadCount),
      lastUpdated: Value(keep.lastUpdated),
      lastFetched: Value(keep.lastFetched),
      isEnabled: Value(keep.isEnabled),
      isBlocked: Value(keep.isBlocked),
      healthStatus: Value(keep.healthStatus),
      failureCount: Value(keep.failureCount),
      createdAt: Value(keep.createdAt),
      updatedAt: Value(DateTime.now()),
      sourceType: const Value('plugin'),
      apiBaseUrl: const Value(null),
      apiKey: const Value(null),
      apiHeaders: const Value(null),
      apiRemoteFeedId: const Value(null),
      apiTimeout: const Value(30),
      apiMaxRetries: const Value(3),
      pluginId: Value(pluginId),
      pluginFeedKey: const Value(BuiltinPluginBootstrap.aiNewsDailyFeedKey),
      pluginProvider: const Value(providerCapability),
    );

    await _feedDao.updateFeed(companion);
  }

  List<Map<String, dynamic>> _normalizeFeeds(dynamic discovered) {
    final rawFeeds = discovered is Map ? discovered['feeds'] : discovered;
    if (rawFeeds is! List) return const [];
    return rawFeeds
        .whereType<Map>()
        .map((item) => item.map((key, value) => MapEntry(key.toString(), value)))
        .toList(growable: false);
  }
}
