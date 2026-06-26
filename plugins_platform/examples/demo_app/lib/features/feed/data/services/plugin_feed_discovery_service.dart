import 'package:drift/drift.dart';
import 'package:plugins_platform/plugins_platform.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/plugins/data/services/builtin_plugin_bootstrap.dart';
import 'package:uuid/uuid.dart';

/// 插件订阅源发现服务
class PluginFeedDiscoveryService {
  static const providerCapability = 'rss.feed.provider';

  final PluginManager _pluginManager;
  final FeedDao _feedDao;
  final BuiltinPluginBootstrap _bootstrap;
  final Uuid _uuid;
  Future<void>? _syncInFlight;

  PluginFeedDiscoveryService({
    required PluginManager pluginManager,
    required FeedDao feedDao,
    required BuiltinPluginBootstrap bootstrap,
    Uuid? uuid,
  }) : _pluginManager = pluginManager,
       _feedDao = feedDao,
       _bootstrap = bootstrap,
       _uuid = uuid ?? const Uuid();

  Future<void> syncDiscoveredFeeds() async {
    final inFlight = _syncInFlight;
    if (inFlight != null) return inFlight;

    final sync = _syncDiscoveredFeeds();
    _syncInFlight = sync;
    try {
      await sync;
    } finally {
      if (identical(_syncInFlight, sync)) {
        _syncInFlight = null;
      }
    }
  }

  Future<void> _syncDiscoveredFeeds() async {
    await _bootstrap.ensureInstalled();
    await _pluginManager.ready;

    final plugins = _pluginManager.getAllPlugins().where(
      (plugin) =>
          plugin.isActivated &&
          plugin.manifest.capabilities.any(
            (capability) => capability.id == providerCapability,
          ),
    );

    for (final plugin in plugins) {
      final discovered = await _pluginManager.callPluginFunction(
        plugin.manifest.id,
        'discoverFeeds',
        const [{}],
      );
      final feeds = _extractFeeds(discovered);
      await _upsertDiscoveredFeeds(plugin.manifest.id, feeds);
      await _cleanupDuplicateFeeds(plugin.manifest.id, feeds);
    }
  }

  Future<void> _upsertDiscoveredFeeds(
    String pluginId,
    List<Map<String, dynamic>> feeds,
  ) async {
    for (final feed in feeds) {
      final feedKey = feed['feedKey']?.toString();
      final title = feed['title']?.toString();
      if (feedKey == null ||
          feedKey.isEmpty ||
          title == null ||
          title.isEmpty) {
        continue;
      }

      final existingFeeds = await _feedDao.getPluginFeedsByIdentity(
        pluginId,
        feedKey,
      );
      if (existingFeeds.isNotEmpty) {
        await _normalizeDiscoveredFeed(
          keep: existingFeeds.first,
          duplicates: existingFeeds.skip(1),
          pluginId: pluginId,
          feedKey: feedKey,
          feed: feed,
        );
        continue;
      }

      final now = DateTime.now();
      await _feedDao.insertFeed(
        FeedsTableCompanion(
          id: Value(_uuid.v4()),
          url: Value('plugin://$pluginId/$feedKey'),
          title: Value(title),
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

  Future<void> _normalizeDiscoveredFeed({
    required FeedsTableData keep,
    required Iterable<FeedsTableData> duplicates,
    required String pluginId,
    required String feedKey,
    required Map<String, dynamic> feed,
  }) async {
    for (final duplicate in duplicates) {
      await _feedDao.deleteFeed(duplicate.id);
    }

    final title = feed['title']?.toString();
    final now = DateTime.now();
    await _feedDao.updateFeed(
      FeedsTableCompanion(
        id: Value(keep.id),
        url: Value('plugin://$pluginId/$feedKey'),
        title: Value(title == null || title.isEmpty ? keep.title : title),
        description: Value(feed['description']?.toString() ?? keep.description),
        iconUrl: Value(feed['iconUrl']?.toString() ?? keep.iconUrl),
        link: Value(feed['link']?.toString() ?? keep.link),
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
        updatedAt: Value(now),
        sourceType: const Value('plugin'),
        apiBaseUrl: const Value(null),
        apiKey: const Value(null),
        apiHeaders: const Value(null),
        apiRemoteFeedId: const Value(null),
        apiTimeout: const Value(30),
        apiMaxRetries: const Value(3),
        pluginId: Value(pluginId),
        pluginFeedKey: Value(feedKey),
        pluginProvider: Value(
          feed['provider']?.toString() ?? providerCapability,
        ),
      ),
    );
  }

  Future<void> _cleanupDuplicateFeeds(
    String pluginId,
    List<Map<String, dynamic>> discoveredFeeds,
  ) async {
    for (final discoveredFeed in discoveredFeeds) {
      final feedKey = discoveredFeed['feedKey']?.toString();
      if (feedKey == null || feedKey.isEmpty) continue;

      final feeds = await _feedDao.getPluginFeedsByIdentity(pluginId, feedKey);
      if (feeds.length <= 1) continue;

      final keep = feeds.first;
      for (final feed in feeds.skip(1)) {
        await _feedDao.deleteFeed(feed.id);
      }

      await _feedDao.updateFeed(
        FeedsTableCompanion(
          id: Value(keep.id),
          url: Value(keep.url),
          title: Value(keep.title),
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
          pluginFeedKey: Value(feedKey),
          pluginProvider: const Value(providerCapability),
        ),
      );
    }
  }

  List<Map<String, dynamic>> _extractFeeds(dynamic discovered) {
    final rawFeeds = discovered is Map ? discovered['feeds'] : discovered;
    if (rawFeeds is! List) return const [];
    return rawFeeds
        .whereType<Map>()
        .map(
          (item) => item.map((key, value) => MapEntry(key.toString(), value)),
        )
        .toList(growable: false);
  }
}
