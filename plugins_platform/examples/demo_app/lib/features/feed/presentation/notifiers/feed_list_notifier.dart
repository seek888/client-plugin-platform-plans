import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/database/database_provider.dart';
import 'package:rss_reader/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:rss_reader/features/feed/data/services/plugin_feed_discovery_service.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/repositories/feed_repository.dart';
import 'package:rss_reader/features/feed/presentation/providers/data_source_manager_provider.dart';
import 'package:rss_reader/features/feed/presentation/side_effects/feed_side_effect.dart';
import 'package:rss_reader/features/feed/presentation/states/feed_list_state.dart';
import 'package:rss_reader/core/services/rss_parser_provider.dart';
import 'package:rss_reader/features/notification/data/services/new_content_notifier.dart';
import 'package:rss_reader/features/notification/presentation/providers/notification_provider.dart';
import 'package:rss_reader/features/plugins/data/services/builtin_plugin_bootstrap.dart';
import 'package:plugins_platform/plugins_platform.dart';

part 'feed_list_notifier.g.dart';

/// 订阅源仓库 Provider
@riverpod
FeedRepository feedRepository(Ref ref) {
  final feedDao = ref.watch(feedDaoProvider);
  final categoryDao = ref.watch(categoryDaoProvider);
  final articleDao = ref.watch(articleDaoProvider);
  final rssParserService = ref.watch(rssParserServiceProvider);
  final pluginManager = ref.watch(pluginManagerProvider);
  final dataSourceManager = ref.watch(dataSourceManagerProvider);
  final bootstrap = BuiltinPluginBootstrap(pluginManager: pluginManager);
  final pluginFeedDiscoveryService = PluginFeedDiscoveryService(
    pluginManager: pluginManager,
    feedDao: feedDao,
    bootstrap: bootstrap,
  );
  return FeedRepositoryImpl(
    feedDao: feedDao,
    categoryDao: categoryDao,
    articleDao: articleDao,
    rssParserService: rssParserService,
    dataSourceManager: dataSourceManager,
    pluginFeedDiscoveryService: pluginFeedDiscoveryService,
  );
}

/// 订阅源列表 Notifier
/// 负责管理订阅源列表的状态和业务逻辑
@riverpod
class FeedListNotifier extends _$FeedListNotifier {
  StreamController<FeedSideEffect>? _sideEffectController;
  StreamSubscription<List<Feed>>? _feedsSubscription;
  StreamSubscription<List<FeedCategory>>? _categoriesSubscription;
  bool _isDisposed = false;

  /// 获取订阅源仓库
  FeedRepository get _feedRepository => ref.read(feedRepositoryProvider);

  /// 获取新内容通知器
  NewContentNotifier get _newContentNotifier =>
      ref.read(newContentNotifierProvider);

  /// 获取或创建副作用控制器
  StreamController<FeedSideEffect> get _controller {
    _sideEffectController ??= StreamController<FeedSideEffect>.broadcast();
    return _sideEffectController!;
  }

  /// 副作用流
  Stream<FeedSideEffect> get sideEffect => _controller.stream;

  /// 安全地添加副作用事件
  void _addSideEffect(FeedSideEffect effect) {
    if (!_isDisposed &&
        _sideEffectController != null &&
        !_sideEffectController!.isClosed) {
      _sideEffectController!.add(effect);
    }
  }

  @override
  FeedListState build() {
    _isDisposed = false;

    // 确保创建新的控制器
    _sideEffectController = StreamController<FeedSideEffect>.broadcast();

    // 监听订阅源变化
    _setupWatchers();

    // 清理资源
    ref.onDispose(() {
      _isDisposed = true;
      _sideEffectController?.close();
      _sideEffectController = null;
      _feedsSubscription?.cancel();
      _categoriesSubscription?.cancel();
    });

    // 初始加载
    _loadFeeds();

    return const FeedListState.initial();
  }

  /// 设置数据监听
  void _setupWatchers() {
    _feedsSubscription = _feedRepository.watchAllFeeds().listen((feeds) {
      _updateStateWithFeeds(feeds);
    });

    _categoriesSubscription = _feedRepository.watchAllCategories().listen((
      categories,
    ) {
      _updateStateWithCategories(categories);
    });
  }

  /// 更新状态中的订阅源列表
  void _updateStateWithFeeds(List<Feed> feeds) {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(
        feeds: feeds,
        totalUnreadCount: _calculateTotalUnread(feeds),
      ),
      orElse: () => FeedListState.loaded(
        feeds: feeds,
        categories: [],
        totalUnreadCount: _calculateTotalUnread(feeds),
      ),
    );
  }

  /// 更新状态中的分类列表
  void _updateStateWithCategories(List<FeedCategory> categories) {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(categories: categories),
      orElse: () => FeedListState.loaded(feeds: [], categories: categories),
    );
  }

  /// 计算总未读数
  int _calculateTotalUnread(List<Feed> feeds) {
    return feeds.fold(0, (sum, feed) => sum + feed.unreadCount);
  }

  /// 加载订阅源列表
  Future<void> _loadFeeds() async {
    state = const FeedListState.loading();

    final feedsResult = await _feedRepository.getAllFeeds();
    final categoriesResult = await _feedRepository.getCategories();

    feedsResult.fold(
      (failure) => state = FeedListState.error(message: failure.userMessage),
      (feeds) {
        categoriesResult.fold(
          (failure) =>
              state = FeedListState.error(message: failure.userMessage),
          (categories) => state = FeedListState.loaded(
            feeds: feeds,
            categories: categories,
            totalUnreadCount: _calculateTotalUnread(feeds),
          ),
        );
      },
    );
  }

  /// Intent: 刷新所有订阅源
  Future<void> onRefresh() async {
    // 设置刷新状态
    state = state.maybeMap(
      loaded: (s) => s.copyWith(isRefreshing: true),
      orElse: () => state,
    );

    final result = await _feedRepository.refreshAllFeeds();

    result.fold(
      (failure) {
        _addSideEffect(
          FeedSideEffect.showToast(
            message: '刷新失败: ${failure.userMessage}',
            isError: true,
          ),
        );
      },
      (refreshResult) {
        _addSideEffect(
          FeedSideEffect.showToast(
            message: '已加载 ${refreshResult.newArticleCount} 条新内容',
          ),
        );

        // 如果有失败的订阅源，显示警告
        if (refreshResult.failedCount > 0) {
          _addSideEffect(
            FeedSideEffect.showToast(
              message: '${refreshResult.failedCount} 个订阅源刷新失败',
              isError: true,
            ),
          );
        }

        // 发送新内容通知（后台刷新时）
        _newContentNotifier.notifyRefreshResult(
          newArticleCount: refreshResult.newArticleCount,
          failedCount: refreshResult.failedCount,
        );
      },
    );

    // 重新加载数据
    await _loadFeeds();

    // 取消刷新状态
    state = state.maybeMap(
      loaded: (s) => s.copyWith(isRefreshing: false),
      orElse: () => state,
    );
  }

  /// Intent: 选择订阅源
  void onFeedSelected(String? feedId) {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(selectedFeedId: feedId),
      orElse: () => state,
    );
  }

  /// Intent: 添加订阅源
  Future<void> onAddFeed(String url) async {
    final result = await _feedRepository.addFeed(url);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedSideEffect.showToast(message: failure.userMessage, isError: true),
        );
      },
      (feed) {
        _addSideEffect(FeedSideEffect.showToast(message: '已添加: ${feed.title}'));
        // 数据会通过 watchAllFeeds 自动更新
      },
    );
  }

  /// Intent: 删除订阅源
  Future<void> onDeleteFeed(String feedId) async {
    // 获取订阅源信息用于显示确认对话框
    final feedResult = await _feedRepository.getFeedById(feedId);

    feedResult.fold(
      (failure) {
        _addSideEffect(
          FeedSideEffect.showToast(message: '订阅源不存在', isError: true),
        );
      },
      (feed) {
        _addSideEffect(
          FeedSideEffect.showConfirmDialog(
            title: '确认删除',
            message: '确定要取消订阅「${feed.title}」吗？',
            onConfirm: () async {
              final deleteResult = await _feedRepository.deleteFeed(feedId);
              deleteResult.fold(
                (failure) {
                  _addSideEffect(
                    FeedSideEffect.showToast(message: '删除失败', isError: true),
                  );
                },
                (_) {
                  _addSideEffect(FeedSideEffect.showToast(message: '已取消订阅'));
                  // 如果删除的是当前选中的订阅源，清除选中状态
                  state = state.maybeMap(
                    loaded: (s) => s.selectedFeedId == feedId
                        ? s.copyWith(selectedFeedId: null)
                        : s,
                    orElse: () => state,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  /// Intent: 显示添加订阅源对话框
  void onShowAddFeedDialog() {
    _addSideEffect(const FeedSideEffect.showAddFeedDialog());
  }

  /// Intent: 移动订阅源到分类
  Future<void> onMoveFeedToCategory(String feedId, String? categoryId) async {
    final result = await _feedRepository.moveFeedToCategory(feedId, categoryId);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedSideEffect.showToast(message: '移动失败', isError: true),
        );
      },
      (_) {
        _addSideEffect(FeedSideEffect.showToast(message: '已移动到分类'));
      },
    );
  }

  /// Intent: 创建分类
  Future<void> onCreateCategory(String name) async {
    final result = await _feedRepository.createCategory(name);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedSideEffect.showToast(message: '创建分类失败', isError: true),
        );
      },
      (category) {
        _addSideEffect(
          FeedSideEffect.showToast(message: '已创建分类: ${category.name}'),
        );
      },
    );
  }

  /// Intent: 删除分类
  Future<void> onDeleteCategory(String categoryId) async {
    final result = await _feedRepository.deleteCategory(categoryId);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedSideEffect.showToast(message: '删除分类失败', isError: true),
        );
      },
      (_) {
        _addSideEffect(FeedSideEffect.showToast(message: '已删除分类'));
      },
    );
  }

  /// Intent: 重排序订阅源
  Future<void> onReorderFeeds(List<String> feedIds) async {
    final result = await _feedRepository.reorderFeeds(feedIds);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedSideEffect.showToast(message: '排序失败', isError: true),
        );
      },
      (_) {
        // 排序成功，数据会通过 watchAllFeeds 自动更新
      },
    );
  }

  /// Intent: 刷新单个订阅源
  Future<void> onRefreshFeed(String feedId) async {
    final result = await _feedRepository.refreshFeed(feedId);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedSideEffect.showToast(message: '刷新失败', isError: true),
        );
      },
      (newCount) {
        _addSideEffect(FeedSideEffect.showToast(message: '已加载 $newCount 条新内容'));

        // 获取订阅源信息并发送通知
        if (newCount > 0) {
          _feedRepository.getFeedById(feedId).then((feedResult) {
            feedResult.fold((_) {}, (feed) {
              _newContentNotifier.notifyNewContent(
                feedTitle: feed.title,
                articleCount: newCount,
                feedId: feedId,
              );
            });
          });
        }
      },
    );
  }

  /// Intent: 导航到搜索页
  void onNavigateToSearch() {
    _addSideEffect(const FeedSideEffect.navigate(route: '/search'));
  }

  /// Intent: 导航到设置页
  void onNavigateToSettings() {
    _addSideEffect(const FeedSideEffect.navigate(route: '/settings'));
  }

  /// Intent: 导航到收藏页
  void onNavigateToFavorites() {
    _addSideEffect(const FeedSideEffect.navigate(route: '/favorites'));
  }

  /// Intent: 导航到订阅源管理页
  void onNavigateToFeedManagement() {
    _addSideEffect(const FeedSideEffect.navigate(route: '/feed-management'));
  }
}

/// 副作用 Provider
@riverpod
Stream<FeedSideEffect> feedSideEffect(FeedSideEffectRef ref) {
  return ref.watch(feedListNotifierProvider.notifier).sideEffect;
}
