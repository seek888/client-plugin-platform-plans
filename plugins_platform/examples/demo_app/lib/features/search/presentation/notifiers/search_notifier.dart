import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/database/database_provider.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/search/domain/entities/search_result.dart';
import 'package:rss_reader/features/search/presentation/side_effects/search_side_effect.dart';
import 'package:rss_reader/features/search/presentation/states/search_state.dart';
import 'package:rss_reader/shared/providers/providers.dart';

part 'search_notifier.g.dart';

/// 搜索 Notifier
/// 负责管理搜索页的状态和业务逻辑
/// Requirements: 8.1, 8.2, 8.3, 8.4, 8.5
@riverpod
class SearchNotifier extends _$SearchNotifier {
  StreamController<SearchSideEffect>? _sideEffectController;
  bool _isDisposed = false;

  // 缓存的文章和订阅源数据
  List<Article> _articles = [];
  List<Feed> _feeds = [];

  /// 获取或创建副作用控制器
  StreamController<SearchSideEffect> get _controller {
    _sideEffectController ??= StreamController<SearchSideEffect>.broadcast();
    return _sideEffectController!;
  }

  /// 副作用流
  Stream<SearchSideEffect> get sideEffect => _controller.stream;

  /// 安全地添加副作用事件
  void _addSideEffect(SearchSideEffect effect) {
    if (!_isDisposed &&
        _sideEffectController != null &&
        !_sideEffectController!.isClosed) {
      _sideEffectController!.add(effect);
    }
  }

  @override
  SearchState build() {
    _isDisposed = false;

    // 确保创建新的控制器
    _sideEffectController = StreamController<SearchSideEffect>.broadcast();

    // 清理资源
    ref.onDispose(() {
      _isDisposed = true;
      _sideEffectController?.close();
      _sideEffectController = null;
    });

    // 初始化时加载数据和搜索历史
    _loadData();
    _loadSearchHistory();

    return const SearchState.initial();
  }

  /// 加载文章和订阅源数据
  Future<void> _loadData() async {
    final articleDao = ref.read(articleDaoProvider);
    final feedDao = ref.read(feedDaoProvider);

    try {
      // 获取所有文章
      final articlesData = await articleDao.getAllArticles(limit: 1000);
      _articles = articlesData
          .map(
            (data) => Article(
              id: data.id,
              feedId: data.feedId,
              title: data.title,
              link: data.link,
              summary: data.summary,
              content: data.content,
              author: data.author,
              imageUrl: data.imageUrl,
              publishedAt: data.publishedAt,
              isRead: data.isRead,
              isFavorite: data.isFavorite,
              isCached: data.isCached,
              isBlocked: data.isBlocked,
              readProgress: data.readProgress,
              createdAt: data.createdAt,
              updatedAt: data.updatedAt,
            ),
          )
          .toList();

      // 获取所有订阅源
      final feedsData = await feedDao.getAllFeeds();
      _feeds = feedsData
          .map(
            (data) => Feed(
              id: data.id,
              title: data.title,
              url: data.url,
              link: data.link,
              description: data.description,
              iconUrl: data.iconUrl,
              categoryId: data.categoryId,
              unreadCount: data.unreadCount,
              sortOrder: data.sortOrder,
              healthStatus: data.healthStatus,
              failureCount: data.failureCount,
              lastFetched: data.lastFetched,
              lastUpdated: data.lastUpdated,
              isEnabled: data.isEnabled,
              isBlocked: data.isBlocked,
              createdAt: data.createdAt,
              updatedAt: data.updatedAt,
            ),
          )
          .toList();
    } catch (e) {
      // 忽略加载错误，搜索时会重试
    }
  }

  /// 加载搜索历史
  Future<void> _loadSearchHistory() async {
    // 搜索历史存储在内存中，实际应用中可以持久化
    state = state.maybeMap(
      initial: (s) => s.copyWith(searchHistory: []),
      orElse: () => state,
    );
  }

  /// Intent: 执行搜索
  /// Requirements: 8.2, 8.5
  Future<void> onSearch(
    String query, {
    SearchScope scope = SearchScope.all,
  }) async {
    final trimmedQuery = query.trim();

    // 空查询返回初始状态
    if (trimmedQuery.isEmpty) {
      final history = _getSearchHistory();
      state = SearchState.initial(searchHistory: history);
      return;
    }

    // 设置搜索中状态
    state = SearchState.searching(query: trimmedQuery, scope: scope);

    try {
      // 重新加载数据以确保最新
      await _loadData();

      // 执行搜索
      final result = await _performSearch(trimmedQuery, scope);

      // 添加到搜索历史
      _addToSearchHistory(trimmedQuery);

      if (result.hasResults) {
        state = SearchState.loaded(
          result: result,
          searchHistory: _getSearchHistory(),
        );
      } else {
        state = SearchState.empty(
          query: trimmedQuery,
          scope: scope,
          searchHistory: _getSearchHistory(),
        );
      }
    } catch (e) {
      state = SearchState.error(
        message: '搜索失败: ${e.toString()}',
        query: trimmedQuery,
        searchHistory: _getSearchHistory(),
      );
    }
  }

  /// 执行搜索逻辑
  Future<SearchResult> _performSearch(String query, SearchScope scope) async {
    final lowerQuery = query.toLowerCase();

    List<Article> matchedArticles = [];
    List<Feed> matchedFeeds = [];

    switch (scope) {
      case SearchScope.all:
        matchedArticles = _searchArticles(
          lowerQuery,
          searchTitle: true,
          searchContent: true,
        );
        matchedFeeds = _searchFeeds(lowerQuery);
        break;
      case SearchScope.title:
        matchedArticles = _searchArticles(
          lowerQuery,
          searchTitle: true,
          searchContent: false,
        );
        break;
      case SearchScope.content:
        matchedArticles = _searchArticles(
          lowerQuery,
          searchTitle: false,
          searchContent: true,
        );
        break;
      case SearchScope.feed:
        matchedFeeds = _searchFeeds(lowerQuery);
        break;
    }

    return SearchResult(
      articles: matchedArticles,
      feeds: matchedFeeds,
      query: query,
      scope: scope,
      totalCount: matchedArticles.length + matchedFeeds.length,
    );
  }

  /// 搜索文章
  List<Article> _searchArticles(
    String query, {
    required bool searchTitle,
    required bool searchContent,
  }) {
    return _articles.where((article) {
      if (article.isBlocked) return false;

      bool matches = false;

      if (searchTitle) {
        final title = article.title.toLowerCase();
        if (title.contains(query)) {
          matches = true;
        }
      }

      if (searchContent && !matches) {
        final summary = article.summary?.toLowerCase() ?? '';
        final content = article.content?.toLowerCase() ?? '';
        if (summary.contains(query) || content.contains(query)) {
          matches = true;
        }
      }

      return matches;
    }).toList();
  }

  /// 搜索订阅源
  List<Feed> _searchFeeds(String query) {
    return _feeds.where((feed) {
      if (feed.isBlocked) return false;

      final title = feed.title.toLowerCase();
      if (title.contains(query)) {
        return true;
      }

      final description = feed.description?.toLowerCase() ?? '';
      if (description.contains(query)) {
        return true;
      }

      return false;
    }).toList();
  }

  /// Intent: 切换搜索范围
  /// Requirements: 8.5
  Future<void> onScopeChanged(SearchScope scope) async {
    final currentQuery = state.maybeMap(
      searching: (s) => s.query,
      loaded: (s) => s.result.query,
      empty: (s) => s.query,
      error: (s) => s.query,
      orElse: () => null,
    );

    if (currentQuery != null && currentQuery.isNotEmpty) {
      await onSearch(currentQuery, scope: scope);
    }
  }

  /// Intent: 选择文章
  void onArticleSelected(String articleId) {
    // 更新全局选中状态
    ref.read(selectedArticleIdProvider.notifier).state = articleId;

    // 导航到文章详情
    _addSideEffect(SearchSideEffect.navigateToArticle(articleId: articleId));
  }

  /// Intent: 选择订阅源
  void onFeedSelected(String feedId) {
    // 更新全局选中状态
    ref.read(selectedFeedIdProvider.notifier).state = feedId;

    // 导航到订阅源
    _addSideEffect(SearchSideEffect.navigateToFeed(feedId: feedId));
  }

  /// Intent: 清除搜索
  void onClearSearch() {
    final history = _getSearchHistory();
    state = SearchState.initial(searchHistory: history);
  }

  /// Intent: 从历史记录搜索
  Future<void> onSearchFromHistory(String query) async {
    await onSearch(query);
  }

  /// Intent: 删除单条搜索历史
  void onRemoveSearchHistory(String query) {
    _searchHistory.remove(query);
    _updateStateWithHistory();
  }

  /// Intent: 清除所有搜索历史
  void onClearSearchHistory() {
    _addSideEffect(
      SearchSideEffect.showConfirmDialog(
        title: '清除搜索历史',
        message: '确定要清除所有搜索历史吗？',
        onConfirm: () {
          _searchHistory.clear();
          _updateStateWithHistory();
          _addSideEffect(const SearchSideEffect.showToast(message: '搜索历史已清除'));
        },
      ),
    );
  }

  /// Intent: 关闭搜索页
  void onClose() {
    _addSideEffect(const SearchSideEffect.closeSearch());
  }

  // 搜索历史存储
  final List<String> _searchHistory = [];
  static const int _maxHistoryCount = 20;

  /// 获取搜索历史
  List<String> _getSearchHistory() {
    return List.unmodifiable(_searchHistory);
  }

  /// 添加到搜索历史
  void _addToSearchHistory(String query) {
    _searchHistory.remove(query);
    _searchHistory.insert(0, query);
    if (_searchHistory.length > _maxHistoryCount) {
      _searchHistory.removeRange(_maxHistoryCount, _searchHistory.length);
    }
  }

  /// 更新状态中的搜索历史
  void _updateStateWithHistory() {
    final history = _getSearchHistory();
    state = state.maybeMap(
      initial: (s) => s.copyWith(searchHistory: history),
      loaded: (s) => s.copyWith(searchHistory: history),
      empty: (s) => s.copyWith(searchHistory: history),
      error: (s) => s.copyWith(searchHistory: history),
      orElse: () => state,
    );
  }
}

/// 搜索副作用 Provider
@riverpod
Stream<SearchSideEffect> searchSideEffect(Ref ref) {
  return ref.watch(searchNotifierProvider.notifier).sideEffect;
}
