import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/tables/articles_table.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';

part 'article_dao.g.dart';

/// 文章数据访问对象
@DriftAccessor(tables: [ArticlesTable])
class ArticleDao extends DatabaseAccessor<AppDatabase> with _$ArticleDaoMixin {
  ArticleDao(super.db);

  /// 获取订阅源的文章列表
  Future<List<ArticlesTableData>> getArticlesByFeed(
    String feedId, {
    int limit = 20,
    int offset = 0,
  }) {
    return (select(articlesTable)
          ..where((t) => t.feedId.equals(feedId) & t.isBlocked.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)])
          ..limit(limit, offset: offset))
        .get();
  }

  /// 获取订阅源的文章列表（带排序和筛选）
  Future<List<ArticlesTableData>> getArticlesByFeedWithSort(
    String feedId, {
    int limit = 20,
    int offset = 0,
    ArticleSortType sortType = ArticleSortType.timeDesc,
    ArticleFilterType filterType = ArticleFilterType.all,
  }) {
    var query = select(articlesTable)
      ..where((t) => t.feedId.equals(feedId) & t.isBlocked.equals(false));

    // 应用筛选
    query = _applyFilter(query, filterType);

    // 应用排序
    query = _applySort(query, sortType);

    return (query..limit(limit, offset: offset)).get();
  }

  /// 获取所有文章（带排序和筛选）
  Future<List<ArticlesTableData>> getAllArticlesWithSort({
    int limit = 20,
    int offset = 0,
    ArticleSortType sortType = ArticleSortType.timeDesc,
    ArticleFilterType filterType = ArticleFilterType.all,
  }) {
    var query = select(articlesTable)..where((t) => t.isBlocked.equals(false));

    // 应用筛选
    query = _applyFilter(query, filterType);

    // 应用排序
    query = _applySort(query, sortType);

    return (query..limit(limit, offset: offset)).get();
  }

  /// 应用筛选条件
  SimpleSelectStatement<$ArticlesTableTable, ArticlesTableData> _applyFilter(
    SimpleSelectStatement<$ArticlesTableTable, ArticlesTableData> query,
    ArticleFilterType filterType,
  ) {
    switch (filterType) {
      case ArticleFilterType.all:
        return query;
      case ArticleFilterType.unread:
        return query..where((t) => t.isRead.equals(false));
      case ArticleFilterType.read:
        return query..where((t) => t.isRead.equals(true));
      case ArticleFilterType.favorite:
        return query..where((t) => t.isFavorite.equals(true));
    }
  }

  /// 应用排序
  SimpleSelectStatement<$ArticlesTableTable, ArticlesTableData> _applySort(
    SimpleSelectStatement<$ArticlesTableTable, ArticlesTableData> query,
    ArticleSortType sortType,
  ) {
    switch (sortType) {
      case ArticleSortType.timeDesc:
        return query..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]);
      case ArticleSortType.timeAsc:
        return query..orderBy([(t) => OrderingTerm.asc(t.publishedAt)]);
      case ArticleSortType.unreadFirst:
        return query
          ..orderBy([
            (t) => OrderingTerm.asc(t.isRead),
            (t) => OrderingTerm.desc(t.publishedAt),
          ]);
    }
  }

  /// 获取所有文章
  Future<List<ArticlesTableData>> getAllArticles({
    int limit = 20,
    int offset = 0,
    bool unreadOnly = false,
  }) {
    var query = select(articlesTable)
      ..where((t) => t.isBlocked.equals(false))
      ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)])
      ..limit(limit, offset: offset);

    if (unreadOnly) {
      query = query..where((t) => t.isRead.equals(false));
    }

    return query.get();
  }

  /// 根据 ID 获取文章
  Future<ArticlesTableData?> getArticleById(String id) {
    return (select(
      articlesTable,
    )..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// 插入文章
  Future<int> insertArticle(ArticlesTableCompanion article) {
    return into(
      articlesTable,
    ).insert(article, mode: InsertMode.insertOrReplace);
  }

  /// 批量插入文章
  Future<void> insertArticles(List<ArticlesTableCompanion> articles) async {
    await batch((batch) {
      batch.insertAll(
        articlesTable,
        articles,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  /// 更新文章
  Future<bool> updateArticle(ArticlesTableCompanion article) {
    return update(articlesTable).replace(article);
  }

  /// 标记文章已读
  Future<int> markAsRead(String id) {
    return (update(articlesTable)..where((t) => t.id.equals(id))).write(
      const ArticlesTableCompanion(isRead: Value(true)),
    );
  }

  /// 批量标记已读
  Future<int> markAllAsReadByFeed(String feedId) {
    return (update(articlesTable)..where((t) => t.feedId.equals(feedId))).write(
      const ArticlesTableCompanion(isRead: Value(true)),
    );
  }

  /// 标记所有文章已读
  Future<int> markAllAsRead() {
    return update(
      articlesTable,
    ).write(const ArticlesTableCompanion(isRead: Value(true)));
  }

  /// 切换收藏状态
  Future<int> toggleFavorite(String id, bool isFavorite) {
    return (update(articlesTable)..where((t) => t.id.equals(id))).write(
      ArticlesTableCompanion(isFavorite: Value(isFavorite)),
    );
  }

  /// 获取收藏文章
  Future<List<ArticlesTableData>> getFavoriteArticles({
    int limit = 20,
    int offset = 0,
  }) {
    return (select(articlesTable)
          ..where((t) => t.isFavorite.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
          ..limit(limit, offset: offset))
        .get();
  }

  /// 获取已缓存文章
  Future<List<ArticlesTableData>> getCachedArticles() {
    return (select(articlesTable)..where((t) => t.isCached.equals(true))).get();
  }

  /// 标记文章已缓存
  Future<int> markAsCached(String id) {
    return (update(articlesTable)..where((t) => t.id.equals(id))).write(
      const ArticlesTableCompanion(isCached: Value(true)),
    );
  }

  /// 屏蔽文章
  Future<int> blockArticle(String id) {
    return (update(articlesTable)..where((t) => t.id.equals(id))).write(
      const ArticlesTableCompanion(isBlocked: Value(true)),
    );
  }

  /// 获取订阅源未读数
  Future<int> getUnreadCountByFeed(String feedId) async {
    final count = articlesTable.id.count();
    final query = selectOnly(articlesTable)
      ..addColumns([count])
      ..where(
        articlesTable.feedId.equals(feedId) &
            articlesTable.isRead.equals(false),
      );
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// 搜索文章
  Future<List<ArticlesTableData>> searchArticles(
    String keyword, {
    int limit = 50,
  }) {
    return (select(articlesTable)
          ..where(
            (t) =>
                t.title.contains(keyword) |
                t.summary.contains(keyword) |
                t.content.contains(keyword),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)])
          ..limit(limit))
        .get();
  }

  /// 监听订阅源文章变化
  Stream<List<ArticlesTableData>> watchArticlesByFeed(String feedId) {
    return (select(articlesTable)
          ..where((t) => t.feedId.equals(feedId) & t.isBlocked.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
        .watch();
  }

  /// 监听所有文章变化
  Stream<List<ArticlesTableData>> watchAllArticles() {
    return (select(articlesTable)
          ..where((t) => t.isBlocked.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
        .watch();
  }

  /// 删除订阅源的所有文章
  Future<int> deleteArticlesByFeed(String feedId) {
    return (delete(articlesTable)..where((t) => t.feedId.equals(feedId))).go();
  }

  /// 根据链接获取文章
  Future<ArticlesTableData?> getArticleByLink(String link) {
    return (select(
      articlesTable,
    )..where((t) => t.link.equals(link)))
        .getSingleOrNull();
  }

  /// 标记文章已读（带值）
  Future<int> markAsReadWithValue(String id, bool isRead) {
    return (update(articlesTable)..where((t) => t.id.equals(id))).write(
      ArticlesTableCompanion(isRead: Value(isRead)),
    );
  }

  /// 获取总未读数
  Future<int> getTotalUnreadCount() async {
    final count = articlesTable.id.count();
    final query = selectOnly(articlesTable)
      ..addColumns([count])
      ..where(
        articlesTable.isRead.equals(false) &
            articlesTable.isBlocked.equals(false),
      );
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// 获取相邻文章（上一篇/下一篇）
  Future<ArticlesTableData?> getAdjacentArticle(
    String currentArticleId,
    String feedId,
    bool isNext,
  ) async {
    // 首先获取当前文章的发布时间
    final currentArticle = await getArticleById(currentArticleId);
    if (currentArticle == null || currentArticle.publishedAt == null) {
      return null;
    }

    final currentTime = currentArticle.publishedAt!;

    if (isNext) {
      // 下一篇：发布时间比当前早的第一篇
      return (select(articlesTable)
            ..where(
              (t) =>
                  t.feedId.equals(feedId) &
                  t.isBlocked.equals(false) &
                  t.publishedAt.isSmallerThanValue(currentTime),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)])
            ..limit(1))
          .getSingleOrNull();
    } else {
      // 上一篇：发布时间比当前晚的第一篇
      return (select(articlesTable)
            ..where(
              (t) =>
                  t.feedId.equals(feedId) &
                  t.isBlocked.equals(false) &
                  t.publishedAt.isBiggerThanValue(currentTime),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.publishedAt)])
            ..limit(1))
          .getSingleOrNull();
    }
  }

  /// 更新阅读进度
  Future<int> updateReadProgress(String id, int progress) {
    return (update(articlesTable)..where((t) => t.id.equals(id))).write(
      ArticlesTableCompanion(readProgress: Value(progress)),
    );
  }

  /// 取消缓存文章
  Future<int> markAsUncached(String id) {
    return (update(articlesTable)..where((t) => t.id.equals(id))).write(
      const ArticlesTableCompanion(isCached: Value(false)),
    );
  }

  /// 批量标记文章为已缓存
  Future<int> markAllAsCachedByFeed(String feedId) {
    return (update(articlesTable)..where((t) => t.feedId.equals(feedId))).write(
      const ArticlesTableCompanion(isCached: Value(true)),
    );
  }

  /// 清除订阅源的缓存
  Future<int> clearCacheByFeed(String feedId) {
    return (update(articlesTable)..where((t) => t.feedId.equals(feedId))).write(
      const ArticlesTableCompanion(isCached: Value(false)),
    );
  }

  /// 清除所有缓存
  Future<int> clearAllCache() {
    return update(
      articlesTable,
    ).write(const ArticlesTableCompanion(isCached: Value(false)));
  }

  /// 获取已缓存文章（带分页）
  Future<List<ArticlesTableData>> getCachedArticlesPaginated({
    int limit = 20,
    int offset = 0,
  }) {
    return (select(articlesTable)
          ..where((t) => t.isCached.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
          ..limit(limit, offset: offset))
        .get();
  }

  /// 获取已缓存文章数量
  Future<int> getCachedCount({String? feedId}) async {
    final count = articlesTable.id.count();
    var query = selectOnly(articlesTable)..addColumns([count]);

    if (feedId != null) {
      query = query
        ..where(
          articlesTable.isCached.equals(true) &
              articlesTable.feedId.equals(feedId),
        );
    } else {
      query = query..where(articlesTable.isCached.equals(true));
    }

    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// 获取订阅源的文章数量
  Future<int> getArticleCountByFeed(String feedId) async {
    final count = articlesTable.id.count();
    final query = selectOnly(articlesTable)
      ..addColumns([count])
      ..where(articlesTable.feedId.equals(feedId));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// 更新文章内容
  Future<int> updateArticleContent(String id, String content) {
    return (update(articlesTable)..where((t) => t.id.equals(id))).write(
      ArticlesTableCompanion(
        content: Value(content),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
