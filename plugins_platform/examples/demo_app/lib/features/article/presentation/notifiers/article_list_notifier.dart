import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/database/database_provider.dart';
import 'package:rss_reader/features/article/data/repositories/article_repository_impl.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/domain/repositories/article_repository.dart';
import 'package:rss_reader/features/article/presentation/side_effects/article_side_effect.dart';
import 'package:rss_reader/features/article/presentation/states/article_list_state.dart';
import 'package:rss_reader/features/feed/presentation/notifiers/feed_list_notifier.dart';
import 'package:rss_reader/shared/providers/providers.dart';

part 'article_list_notifier.g.dart';

/// 每页文章数量
const int _pageSize = 20;

/// 文章仓库 Provider
@riverpod
ArticleRepository articleRepository(Ref ref) {
  final articleDao = ref.watch(articleDaoProvider);
  final feedDao = ref.watch(feedDaoProvider);
  return ArticleRepositoryImpl(articleDao: articleDao, feedDao: feedDao);
}

/// 文章列表 Notifier
/// 负责管理文章列表的状态和业务逻辑
@riverpod
class ArticleListNotifier extends _$ArticleListNotifier {
  StreamController<ArticleSideEffect>? _sideEffectController;
  StreamSubscription<List<Article>>? _articlesSubscription;
  bool _isDisposed = false;

  /// 获取文章仓库
  ArticleRepository get _articleRepository =>
      ref.read(articleRepositoryProvider);

  /// 获取或创建副作用控制器
  StreamController<ArticleSideEffect> get _controller {
    _sideEffectController ??= StreamController<ArticleSideEffect>.broadcast();
    return _sideEffectController!;
  }

  /// 副作用流
  Stream<ArticleSideEffect> get sideEffect => _controller.stream;

  /// 安全地添加副作用事件
  void _addSideEffect(ArticleSideEffect effect) {
    if (!_isDisposed &&
        _sideEffectController != null &&
        !_sideEffectController!.isClosed) {
      _sideEffectController!.add(effect);
    }
  }

  @override
  ArticleListState build() {
    _isDisposed = false;

    // 确保创建新的控制器
    _sideEffectController = StreamController<ArticleSideEffect>.broadcast();

    // 监听选中的订阅源变化
    final selectedFeedId = ref.watch(selectedFeedIdProvider);

    // 清理资源
    ref.onDispose(() {
      _isDisposed = true;
      _sideEffectController?.close();
      _sideEffectController = null;
      _articlesSubscription?.cancel();
    });

    // 初始加载
    _loadArticles(feedId: selectedFeedId);

    return const ArticleListState.initial();
  }

  /// 加载文章列表
  Future<void> _loadArticles({
    String? feedId,
    ArticleSortType sortType = ArticleSortType.timeDesc,
    ArticleFilterType filterType = ArticleFilterType.all,
    int page = 1,
    bool append = false,
  }) async {
    if (!append) {
      state = const ArticleListState.loading();
    }

    final result = feedId != null
        ? await _articleRepository.getArticlesByFeed(
            feedId,
            page: page,
            pageSize: _pageSize,
            sortType: sortType,
            filterType: filterType,
          )
        : await _articleRepository.getAllArticles(
            page: page,
            pageSize: _pageSize,
            sortType: sortType,
            filterType: filterType,
          );

    result.fold(
      (failure) => state = ArticleListState.error(message: failure.userMessage),
      (articles) {
        if (append) {
          state = state.maybeMap(
            loaded: (s) => s.copyWith(
              articles: [...s.articles, ...articles],
              currentPage: page,
              hasMore: articles.length >= _pageSize,
              isLoadingMore: false,
            ),
            orElse: () => ArticleListState.loaded(
              articles: articles,
              feedId: feedId,
              sortType: sortType,
              filterType: filterType,
              currentPage: page,
              hasMore: articles.length >= _pageSize,
            ),
          );
        } else {
          state = ArticleListState.loaded(
            articles: articles,
            feedId: feedId,
            sortType: sortType,
            filterType: filterType,
            currentPage: page,
            hasMore: articles.length >= _pageSize,
          );
        }
      },
    );
  }

  /// Intent: 刷新文章列表（从网络拉取新数据）
  Future<void> onRefresh() async {
    final currentState = state;
    if (currentState is! ArticleListStateLoaded) return;

    state = currentState.copyWith(isRefreshing: true);

    // 调用 FeedListNotifier 从网络刷新数据
    final feedListNotifier = ref.read(feedListNotifierProvider.notifier);

    if (currentState.feedId != null) {
      // 刷新单个订阅源
      await feedListNotifier.onRefreshFeed(currentState.feedId!);
    } else {
      // 刷新所有订阅源
      await feedListNotifier.onRefresh();
    }

    // 重新加载文章列表
    await _loadArticles(
      feedId: currentState.feedId,
      sortType: currentState.sortType,
      filterType: currentState.filterType,
      page: 1,
    );
  }

  /// Intent: 加载更多文章
  Future<void> onLoadMore() async {
    final currentState = state;
    if (currentState is! ArticleListStateLoaded) return;
    if (currentState.isLoadingMore || !currentState.hasMore) return;

    state = currentState.copyWith(isLoadingMore: true);

    await _loadArticles(
      feedId: currentState.feedId,
      sortType: currentState.sortType,
      filterType: currentState.filterType,
      page: currentState.currentPage + 1,
      append: true,
    );
  }

  /// Intent: 切换排序方式
  Future<void> onSortTypeChanged(ArticleSortType sortType) async {
    final currentState = state;
    if (currentState is! ArticleListStateLoaded) return;

    await _loadArticles(
      feedId: currentState.feedId,
      sortType: sortType,
      filterType: currentState.filterType,
      page: 1,
    );

    _addSideEffect(const ArticleSideEffect.scrollToTop());
  }

  /// Intent: 切换筛选类型
  Future<void> onFilterTypeChanged(ArticleFilterType filterType) async {
    final currentState = state;
    if (currentState is! ArticleListStateLoaded) return;

    await _loadArticles(
      feedId: currentState.feedId,
      sortType: currentState.sortType,
      filterType: filterType,
      page: 1,
    );

    _addSideEffect(const ArticleSideEffect.scrollToTop());
  }

  /// Intent: 切换订阅源
  Future<void> onFeedChanged(String? feedId) async {
    final currentState = state;
    final sortType = currentState is ArticleListStateLoaded
        ? currentState.sortType
        : ArticleSortType.timeDesc;
    final filterType = currentState is ArticleListStateLoaded
        ? currentState.filterType
        : ArticleFilterType.all;

    await _loadArticles(
      feedId: feedId,
      sortType: sortType,
      filterType: filterType,
      page: 1,
    );

    _addSideEffect(const ArticleSideEffect.scrollToTop());
  }

  /// Intent: 选择文章
  void onArticleSelected(String articleId) {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(selectedArticleId: articleId),
      orElse: () => state,
    );

    // 更新全局选中状态
    ref.read(selectedArticleIdProvider.notifier).state = articleId;

    // 导航到文章详情
    _addSideEffect(ArticleSideEffect.navigateToArticle(articleId: articleId));
  }

  /// Intent: 标记文章已读
  /// [skipDatabase] 为 true 时只更新本地状态，不调用数据库（用于从其他地方同步状态）
  Future<void> onMarkAsRead(String articleId,
      {bool skipDatabase = false}) async {
    if (!skipDatabase) {
      final result = await _articleRepository.markAsRead(articleId, true);

      result.fold(
        (failure) {
          _addSideEffect(
            ArticleSideEffect.showToast(message: '标记已读失败', isError: true),
          );
          return;
        },
        (_) {},
      );
    }

    // 更新本地状态
    state = state.maybeMap(
      loaded: (s) => s.copyWith(
        articles: s.articles.map((article) {
          if (article.id == articleId) {
            return article.copyWith(isRead: true);
          }
          return article;
        }).toList(),
      ),
      orElse: () => state,
    );
  }

  /// Intent: 标记文章未读
  Future<void> onMarkAsUnread(String articleId) async {
    final result = await _articleRepository.markAsRead(articleId, false);

    result.fold(
      (failure) {
        _addSideEffect(
          ArticleSideEffect.showToast(message: '标记未读失败', isError: true),
        );
      },
      (_) {
        // 更新本地状态
        state = state.maybeMap(
          loaded: (s) => s.copyWith(
            articles: s.articles.map((article) {
              if (article.id == articleId) {
                return article.copyWith(isRead: false);
              }
              return article;
            }).toList(),
          ),
          orElse: () => state,
        );
      },
    );
  }

  /// Intent: 切换收藏状态
  Future<void> onToggleFavorite(String articleId) async {
    final result = await _articleRepository.toggleFavorite(articleId);

    result.fold(
      (failure) {
        _addSideEffect(
          ArticleSideEffect.showToast(message: '操作失败', isError: true),
        );
      },
      (_) {
        // 更新本地状态
        state = state.maybeMap(
          loaded: (s) => s.copyWith(
            articles: s.articles.map((article) {
              if (article.id == articleId) {
                return article.copyWith(isFavorite: !article.isFavorite);
              }
              return article;
            }).toList(),
          ),
          orElse: () => state,
        );

        // 显示提示
        final article = state.maybeMap(
          loaded: (s) => s.articles.firstWhere(
            (a) => a.id == articleId,
            orElse: () => throw Exception('Article not found'),
          ),
          orElse: () => throw Exception('State not loaded'),
        );

        _addSideEffect(
          ArticleSideEffect.showToast(
            message: article.isFavorite ? '已收藏' : '已取消收藏',
          ),
        );
      },
    );
  }

  /// Intent: 屏蔽文章
  Future<void> onBlockArticle(String articleId) async {
    final result = await _articleRepository.blockArticle(articleId);

    result.fold(
      (failure) {
        _addSideEffect(
          ArticleSideEffect.showToast(message: '屏蔽失败', isError: true),
        );
      },
      (_) {
        // 从列表中移除
        state = state.maybeMap(
          loaded: (s) => s.copyWith(
            articles: s.articles.where((a) => a.id != articleId).toList(),
          ),
          orElse: () => state,
        );

        _addSideEffect(const ArticleSideEffect.showToast(message: '已屏蔽文章'));
      },
    );
  }

  /// Intent: 显示屏蔽选项
  void onShowBlockOptions(String articleId, String feedId) {
    _addSideEffect(
      ArticleSideEffect.showBlockOptions(articleId: articleId, feedId: feedId),
    );
  }

  /// Intent: 批量标记已读
  Future<void> onMarkAllAsRead() async {
    final currentState = state;
    if (currentState is! ArticleListStateLoaded) return;

    final result = await _articleRepository.markAllAsRead(
      feedId: currentState.feedId,
    );

    result.fold(
      (failure) {
        _addSideEffect(
          ArticleSideEffect.showToast(message: '标记失败', isError: true),
        );
      },
      (count) {
        // 更新本地状态
        state = currentState.copyWith(
          articles: currentState.articles
              .map((a) => a.copyWith(isRead: true))
              .toList(),
        );

        _addSideEffect(
          ArticleSideEffect.showToast(message: '已标记 $count 篇文章为已读'),
        );
      },
    );
  }

  /// Intent: 在新窗口打开文章（桌面端）
  void onOpenInNewWindow(String articleId) {
    _addSideEffect(ArticleSideEffect.openInNewWindow(articleId: articleId));
  }

  /// Intent: 分享文章
  void onShareArticle(String articleId, String title, String link) {
    _addSideEffect(
      ArticleSideEffect.shareArticle(
        articleId: articleId,
        title: title,
        link: link,
      ),
    );
  }
}

/// 副作用 Provider
@riverpod
Stream<ArticleSideEffect> articleSideEffect(Ref ref) {
  return ref.watch(articleListNotifierProvider.notifier).sideEffect;
}
