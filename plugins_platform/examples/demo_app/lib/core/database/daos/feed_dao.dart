import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/tables/feeds_table.dart';

part 'feed_dao.g.dart';

/// 订阅源数据访问对象
@DriftAccessor(tables: [FeedsTable])
class FeedDao extends DatabaseAccessor<AppDatabase> with _$FeedDaoMixin {
  FeedDao(super.db);

  /// 获取所有订阅源
  Future<List<FeedsTableData>> getAllFeeds() {
    return (select(
      feedsTable,
    )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  /// 根据 ID 获取订阅源
  Future<FeedsTableData?> getFeedById(String id) {
    return (select(
      feedsTable,
    )..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// 根据分类获取订阅源
  Future<List<FeedsTableData>> getFeedsByCategory(String? categoryId) {
    if (categoryId == null) {
      return (select(feedsTable)..where((t) => t.categoryId.isNull())).get();
    }
    return (select(
      feedsTable,
    )..where((t) => t.categoryId.equals(categoryId)))
        .get();
  }

  /// 根据数据源类型获取订阅源
  Future<List<FeedsTableData>> getFeedsBySourceType(String sourceType) {
    return (select(
      feedsTable,
    )..where((t) => t.sourceType.equals(sourceType)))
        .get();
  }

  /// 获取所有 RSS 订阅源
  Future<List<FeedsTableData>> getRssFeeds() {
    return getFeedsBySourceType('rss');
  }

  /// 获取所有 API 订阅源
  Future<List<FeedsTableData>> getApiFeeds() {
    return getFeedsBySourceType('api');
  }

  /// 根据插件源信息获取订阅源
  Future<FeedsTableData?> getPluginFeed(String pluginId, String feedKey) {
    return (select(feedsTable)
          ..where(
            (t) =>
                t.sourceType.equals('plugin') &
                t.pluginId.equals(pluginId) &
                t.pluginFeedKey.equals(feedKey),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// 根据插件源标识或旧版 URL 获取订阅源。
  Future<List<FeedsTableData>> getPluginFeedsByIdentity(
    String pluginId,
    String feedKey,
  ) {
    final feedUrl = 'plugin://$pluginId/$feedKey';
    return (select(feedsTable)
          ..where(
            (t) =>
                t.sourceType.equals('plugin') &
                ((t.pluginId.equals(pluginId) &
                        t.pluginFeedKey.equals(feedKey)) |
                    t.url.equals(feedUrl)),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  /// 获取某个插件的所有订阅源
  Future<List<FeedsTableData>> getPluginFeeds(String pluginId) {
    return (select(feedsTable)
          ..where(
            (t) => t.sourceType.equals('plugin') & t.pluginId.equals(pluginId),
          ))
        .get();
  }

  /// 插入订阅源
  Future<int> insertFeed(FeedsTableCompanion feed) {
    return into(feedsTable).insert(feed);
  }

  /// 更新订阅源
  Future<bool> updateFeed(FeedsTableCompanion feed) {
    return update(feedsTable).replace(feed);
  }

  /// 删除订阅源
  Future<int> deleteFeed(String id) {
    return (delete(feedsTable)..where((t) => t.id.equals(id))).go();
  }

  /// 更新未读数
  Future<int> updateUnreadCount(String feedId, int count) {
    return (update(feedsTable)..where((t) => t.id.equals(feedId))).write(
      FeedsTableCompanion(unreadCount: Value(count)),
    );
  }

  /// 更新健康状态
  Future<int> updateHealthStatus(String feedId, int status, int failureCount) {
    return (update(feedsTable)..where((t) => t.id.equals(feedId))).write(
      FeedsTableCompanion(
        healthStatus: Value(status),
        failureCount: Value(failureCount),
      ),
    );
  }

  /// 更新 API 配置
  Future<int> updateApiConfig(
    String feedId, {
    String? apiBaseUrl,
    String? apiKey,
    String? apiHeaders,
    String? apiRemoteFeedId,
    int? apiTimeout,
    int? apiMaxRetries,
  }) {
    return (update(feedsTable)..where((t) => t.id.equals(feedId))).write(
      FeedsTableCompanion(
        apiBaseUrl: Value(apiBaseUrl),
        apiKey: Value(apiKey),
        apiHeaders: Value(apiHeaders),
        apiRemoteFeedId: Value(apiRemoteFeedId),
        apiTimeout:
            apiTimeout != null ? Value(apiTimeout) : const Value.absent(),
        apiMaxRetries:
            apiMaxRetries != null ? Value(apiMaxRetries) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// 更新排序顺序
  Future<void> updateSortOrders(List<String> feedIds) async {
    await transaction(() async {
      for (var i = 0; i < feedIds.length; i++) {
        await (update(feedsTable)..where((t) => t.id.equals(feedIds[i]))).write(
          FeedsTableCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  /// 监听所有订阅源变化
  Stream<List<FeedsTableData>> watchAllFeeds() {
    return (select(
      feedsTable,
    )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  /// 监听指定类型的订阅源变化
  Stream<List<FeedsTableData>> watchFeedsBySourceType(String sourceType) {
    return (select(feedsTable)
          ..where((t) => t.sourceType.equals(sourceType))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }
}
