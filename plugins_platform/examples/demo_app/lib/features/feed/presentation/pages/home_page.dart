import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/core/router/routes.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/presentation/notifiers/article_list_notifier.dart';
import 'package:rss_reader/features/article/presentation/side_effects/article_side_effect.dart';
import 'package:rss_reader/features/article/presentation/states/article_list_state.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_detail_panel.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_editor_widget.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_list.dart';
import 'package:rss_reader/features/feed/presentation/notifiers/feed_list_notifier.dart';
import 'package:rss_reader/features/feed/presentation/side_effects/feed_side_effect.dart';
import 'package:rss_reader/features/feed/presentation/widgets/feed_list_panel.dart';
import 'package:rss_reader/features/feed/presentation/widgets/mobile_bottom_navigation.dart';
import 'package:rss_reader/features/feed/presentation/widgets/mobile_feed_bar.dart';
import 'package:rss_reader/shared/providers/providers.dart';
import 'package:rss_reader/shared/widgets/adaptive/adaptive_scaffold.dart';
import 'package:rss_reader/shared/widgets/adaptive/breakpoints.dart';
import 'package:rss_reader/shared/widgets/adaptive/desktop_navigation_rail.dart';
import 'package:rss_reader/shared/widgets/common/offline_aware_button.dart';

/// 主页面
/// 支持移动端单栏布局和桌面端三栏布局
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(feedListNotifierProvider);
    final notifier = ref.read(feedListNotifierProvider.notifier);
    final selectedNavIndex = useState(0);
    final selectedFeedId = ref.watch(selectedFeedIdProvider);
    final selectedArticleId = ref.watch(selectedArticleIdProvider);
    final showEditorPanel = ref.watch(showEditorPanelProvider);
    final editingArticleId = ref.watch(editingArticleIdProvider);

    // 处理副作用
    _useSideEffects(context, ref);
    _useArticleSideEffects(context, ref);

    return AdaptiveScaffold(
      // PC端左侧导航栏
      navigationRail: DesktopNavigationRail(
        selectedIndex: selectedNavIndex.value,
        onDestinationSelected: (index) => selectedNavIndex.value = index,
        onAddFeedPressed: notifier.onShowAddFeedDialog,
        onNewNotePressed: () {
          // 桌面端在右侧面板显示编辑器
          if (PlatformUtils.isDesktop) {
            ref.read(editingArticleIdProvider.notifier).state = '';
            ref.read(showEditorPanelProvider.notifier).state = true;
          } else {
            // 移动端跳转到编辑器页面
            context.push(AppRoutes.editor);
          }
        },
        onFavoritesPressed: notifier.onNavigateToFavorites,
        onPluginsPressed: () => context.push(AppRoutes.plugins),
        onSettingsPressed: notifier.onNavigateToSettings,
      ),
      // 中间面板：订阅源列表（桌面端）或带横向订阅源栏的布局（移动端）
      middlePanel: state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (feeds, categories, selectedId, isRefreshing, totalUnread) {
          return _buildMiddlePanel(
            context,
            ref,
            feeds,
            categories,
            selectedFeedId,
            isRefreshing,
            totalUnread,
            notifier,
          );
        },
        error: (message) => _buildErrorView(context, message, notifier),
      ),
      // PC端右侧内容区：文章列表 + 文章详情
      detailPanel: _DesktopArticlePanel(
        selectedArticleId: selectedArticleId,
        onRefresh: notifier.onRefresh,
      ),
      emptyDetailPlaceholder: const _EmptyDetailPlaceholder(),
      // 全屏编辑器覆盖层（桌面端）
      fullScreenOverlay: showEditorPanel
          ? ArticleEditorWidget(
              articleId: editingArticleId ?? '',
              onCancelled: () {
                ref.read(showEditorPanelProvider.notifier).state = false;
                ref.read(editingArticleIdProvider.notifier).state = null;
              },
            )
          : null,
      // 移动端 AppBar
      appBar: _buildMobileAppBar(context, state, notifier),
      // 移动端底部导航
      bottomNavigationBar: MobileBottomNavigation(
        currentIndex: selectedNavIndex.value,
        onTap: (index) {
          selectedNavIndex.value = index;
          _handleBottomNavTap(context, index, notifier);
        },
      ),
    );
  }

  /// 构建中间面板
  /// 移动端：横向订阅源栏 + 内容区
  /// 桌面端：订阅源列表面板
  Widget _buildMiddlePanel(
    BuildContext context,
    WidgetRef ref,
    List feeds,
    List categories,
    String? selectedFeedId,
    bool isRefreshing,
    int totalUnread,
    FeedListNotifier notifier,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < Breakpoints.compact;

    if (isMobile) {
      // 移动端布局：横向订阅源栏 + 文章列表
      return Column(
        children: [
          // 横向订阅源栏
          MobileFeedBar(
            feeds: feeds.cast(),
            categories: categories.cast(),
            selectedFeedId: selectedFeedId,
            totalUnreadCount: totalUnread,
            onFeedSelected: (feedId) {
              ref.read(selectedFeedIdProvider.notifier).state = feedId;
              notifier.onFeedSelected(feedId);
            },
            onCategoryToggle: (categoryId) {
              // TODO: 实现分类展开/折叠
            },
            onFeedLongPress: (feed) {
              _showFeedOptionsMenu(context, ref, feed, notifier);
            },
            onCategoryLongPress: (category) {
              _showCategoryOptionsMenu(context, ref, category, notifier);
            },
          ),
          // 文章列表区域
          Expanded(child: _ArticleListSection(onRefresh: notifier.onRefresh)),
        ],
      );
    }

    // 桌面端布局：订阅源列表面板
    return FeedListPanel(
      feeds: feeds.cast(),
      categories: categories.cast(),
      selectedFeedId: selectedFeedId,
      isRefreshing: isRefreshing,
      totalUnreadCount: totalUnread,
      onFeedSelected: (feedId) {
        ref.read(selectedFeedIdProvider.notifier).state = feedId;
        notifier.onFeedSelected(feedId);
      },
      onRefresh: notifier.onRefresh,
      onAddFeed: notifier.onShowAddFeedDialog,
      onSearchPressed: notifier.onNavigateToSearch,
      onFeedLongPress: (feed) {
        _showFeedOptionsMenu(context, ref, feed, notifier);
      },
      onCategoryLongPress: (category) {
        _showCategoryOptionsMenu(context, ref, category, notifier);
      },
    );
  }

  /// 显示订阅源操作菜单
  void _showFeedOptionsMenu(
    BuildContext context,
    WidgetRef ref,
    dynamic feed,
    FeedListNotifier notifier,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('编辑订阅源'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                // TODO: 实现编辑订阅源
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('移动到分类'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                // TODO: 实现移动到分类
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('刷新订阅源'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                notifier.onRefreshFeed(feed.id);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Theme.of(sheetContext).colorScheme.error,
              ),
              title: Text(
                '取消订阅',
                style: TextStyle(
                  color: Theme.of(sheetContext).colorScheme.error,
                ),
              ),
              onTap: () {
                Navigator.of(sheetContext).pop();
                notifier.onDeleteFeed(feed.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 显示分类操作菜单
  void _showCategoryOptionsMenu(
    BuildContext context,
    WidgetRef ref,
    dynamic category,
    FeedListNotifier notifier,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('重命名分类'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                // TODO: 实现重命名分类
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Theme.of(sheetContext).colorScheme.error,
              ),
              title: Text(
                '删除分类',
                style: TextStyle(
                  color: Theme.of(sheetContext).colorScheme.error,
                ),
              ),
              onTap: () {
                Navigator.of(sheetContext).pop();
                notifier.onDeleteCategory(category.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 构建移动端 AppBar
  PreferredSizeWidget _buildMobileAppBar(
    BuildContext context,
    dynamic state,
    FeedListNotifier notifier,
  ) {
    return AppBar(
      title: const Text('RSS Reader'),
      actions: [
        // 新建笔记按钮
        IconButton(
          icon: const Icon(Icons.edit_note),
          onPressed: () => context.push(AppRoutes.editor),
          tooltip: '新建笔记',
        ),
        // 添加订阅源按钮 - 离线时禁用
        OfflineAwareIconButton(
          icon: const Icon(Icons.add),
          onPressed: notifier.onShowAddFeedDialog,
          tooltip: '添加订阅源',
          offlineTooltip: '离线模式下无法添加订阅源',
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: notifier.onNavigateToSearch,
          tooltip: '搜索',
        ),
      ],
    );
  }

  /// 构建错误视图
  Widget _buildErrorView(
    BuildContext context,
    String message,
    FeedListNotifier notifier,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          // 重试按钮 - 离线时禁用
          OfflineAwareButton(
            onPressed: notifier.onRefresh,
            offlineTooltip: '离线模式下无法刷新',
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }

  /// 处理底部导航点击
  void _handleBottomNavTap(
    BuildContext context,
    int index,
    FeedListNotifier notifier,
  ) {
    switch (index) {
      case 0:
        // 首页 - 已在当前页面
        break;
      case 1:
        // 收藏
        notifier.onNavigateToFavorites();
        break;
      case 2:
        context.push(AppRoutes.plugins);
        break;
      case 3:
        // 设置
        notifier.onNavigateToSettings();
        break;
    }
  }

  /// 使用副作用处理
  void _useSideEffects(BuildContext context, WidgetRef ref) {
    useEffect(() {
      StreamSubscription<FeedSideEffect>? subscription;

      // 延迟订阅以确保 notifier 已初始化
      Future.microtask(() {
        if (!context.mounted) return;
        final notifier = ref.read(feedListNotifierProvider.notifier);
        subscription = notifier.sideEffect.listen((sideEffect) {
          if (context.mounted) {
            _handleSideEffect(context, ref, sideEffect);
          }
        });
      });

      return () => subscription?.cancel();
    }, []);
  }

  /// 使用文章副作用处理
  void _useArticleSideEffects(BuildContext context, WidgetRef ref) {
    // 使用 ref.listen 监听 articleSideEffectProvider
    ref.listen<AsyncValue<ArticleSideEffect>>(articleSideEffectProvider, (
      _,
      next,
    ) {
      next.whenData((sideEffect) {
        if (context.mounted) {
          _handleArticleSideEffect(context, ref, sideEffect);
        }
      });
    });
  }

  /// 处理文章副作用
  void _handleArticleSideEffect(
    BuildContext context,
    WidgetRef ref,
    ArticleSideEffect sideEffect,
  ) {
    switch (sideEffect) {
      case ArticleSideEffectShowToast(:final message, :final isError):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: isError ? Colors.red : null,
          ),
        );
        break;

      case ArticleSideEffectNavigateToArticle(:final articleId):
        // 移动端导航到文章详情页
        if (PlatformUtils.isMobile) {
          context.push(AppRoutes.article(articleId));
        }
        // 桌面端不需要导航，因为文章详情在右侧面板显示
        break;

      case ArticleSideEffectNavigate(:final route):
        context.go(route);
        break;

      case ArticleSideEffectShowConfirmDialog(
          :final title,
          :final message,
          :final onConfirm,
          :final onCancel,
        ):
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onCancel?.call();
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onConfirm();
                },
                child: const Text('确定'),
              ),
            ],
          ),
        );
        break;

      case ArticleSideEffectShowBlockOptions():
        // TODO: 实现屏蔽选项对话框
        break;

      case ArticleSideEffectScrollToTop():
        // TODO: 实现滚动到顶部
        break;

      case ArticleSideEffectOpenInNewWindow():
        // TODO: 实现在新窗口打开
        break;

      case ArticleSideEffectShareArticle():
        // TODO: 实现分享
        break;
    }
  }

  /// 处理副作用
  void _handleSideEffect(
    BuildContext context,
    WidgetRef ref,
    FeedSideEffect sideEffect,
  ) {
    switch (sideEffect) {
      case FeedSideEffectShowToast(:final message, :final isError):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: isError ? Colors.red : null,
          ),
        );
        break;

      case FeedSideEffectNavigate(:final route):
        context.go(route);
        break;

      case FeedSideEffectShowDialog(:final title, :final message):
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('确定'),
              ),
            ],
          ),
        );
        break;

      case FeedSideEffectShowConfirmDialog(
          :final title,
          :final message,
          :final onConfirm,
          :final onCancel,
        ):
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onCancel?.call();
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onConfirm();
                },
                child: const Text('确定'),
              ),
            ],
          ),
        );
        break;

      case FeedSideEffectShowAddFeedDialog():
        _showAddFeedDialog(context, ref);
        break;

      case FeedSideEffectShowEditFeedDialog():
        // TODO: 实现编辑订阅源对话框
        break;

      case FeedSideEffectShowCategoryPicker():
        // TODO: 实现分类选择器
        break;

      case FeedSideEffectScrollToTop():
        // TODO: 实现滚动到顶部
        break;
    }
  }

  /// 显示添加订阅源对话框
  void _showAddFeedDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('添加订阅源'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'RSS URL',
            hintText: '请输入 RSS 订阅源地址',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final url = controller.text.trim();
              if (url.isNotEmpty) {
                Navigator.of(dialogContext).pop();
                ref.read(feedListNotifierProvider.notifier).onAddFeed(url);
              }
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }
}

/// 空详情占位组件
class _EmptyDetailPlaceholder extends StatelessWidget {
  const _EmptyDetailPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            '选择一篇文章开始阅读',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}

/// 桌面端文章面板
/// 显示文章列表，选中文章后显示文章详情
class _DesktopArticlePanel extends HookConsumerWidget {
  final String? selectedArticleId;
  final VoidCallback onRefresh;

  const _DesktopArticlePanel({
    this.selectedArticleId,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleState = ref.watch(articleListNotifierProvider);
    final articleNotifier = ref.read(articleListNotifierProvider.notifier);

    return Row(
      children: [
        // 文章列表（固定宽度）
        SizedBox(
          width: 350,
          child: Column(
            children: [
              // 文章列表工具栏
              _buildArticleListToolbar(
                  context, ref, articleState, articleNotifier),
              const Divider(height: 1),
              // 文章列表内容
              Expanded(
                child: articleState.when(
                  initial: () =>
                      const Center(child: CircularProgressIndicator()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (
                    articles,
                    feedId,
                    sortType,
                    filterType,
                    currentPage,
                    hasMore,
                    isLoadingMore,
                    isRefreshing,
                    selectedId,
                  ) {
                    return Stack(
                      children: [
                        ArticleList(
                          articles: articles,
                          isLoading: false,
                          isLoadingMore: isLoadingMore,
                          hasMore: hasMore,
                          selectedArticleId: selectedArticleId,
                          onLoadMore: articleNotifier.onLoadMore,
                          onRefresh: () async => articleNotifier.onRefresh(),
                          onArticleTap: (article) {
                            articleNotifier.onArticleSelected(article.id);
                          },
                          onMarkAsRead: articleNotifier.onMarkAsRead,
                          onMarkAsUnread: articleNotifier.onMarkAsUnread,
                          onToggleFavorite: articleNotifier.onToggleFavorite,
                          onBlockArticle: articleNotifier.onBlockArticle,
                        ),
                        // 刷新指示器
                        if (isRefreshing)
                          const Positioned(
                            top: 8,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(message, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: onRefresh, child: const Text('重试')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        // 右侧面板：文章详情
        Expanded(
          child: selectedArticleId != null
              ? ArticleDetailPanel(articleId: selectedArticleId!)
              : const _EmptyDetailPlaceholder(),
        ),
      ],
    );
  }

  /// 构建文章列表工具栏
  Widget _buildArticleListToolbar(
    BuildContext context,
    WidgetRef ref,
    dynamic articleState,
    ArticleListNotifier articleNotifier,
  ) {
    final isRefreshing =
        articleState is ArticleListStateLoaded && articleState.isRefreshing;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          // 刷新按钮
          IconButton(
            icon: isRefreshing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh, size: 20),
            tooltip: '刷新 (从网络获取新文章)',
            onPressed: isRefreshing ? null : () => articleNotifier.onRefresh(),
          ),
          const SizedBox(width: 4),
          // 全部标记已读按钮
          IconButton(
            icon: const Icon(Icons.done_all, size: 20),
            tooltip: '全部标记已读',
            onPressed: () => articleNotifier.onMarkAllAsRead(),
          ),
          const Spacer(),
          // 排序按钮
          PopupMenuButton<ArticleSortType>(
            icon: const Icon(Icons.sort, size: 20),
            tooltip: '排序',
            onSelected: (sortType) =>
                articleNotifier.onSortTypeChanged(sortType),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ArticleSortType.timeDesc,
                child: Text('最新优先'),
              ),
              const PopupMenuItem(
                value: ArticleSortType.timeAsc,
                child: Text('最早优先'),
              ),
              const PopupMenuItem(
                value: ArticleSortType.unreadFirst,
                child: Text('未读优先'),
              ),
            ],
          ),
          // 筛选按钮
          PopupMenuButton<ArticleFilterType>(
            icon: const Icon(Icons.filter_list, size: 20),
            tooltip: '筛选',
            onSelected: (filterType) =>
                articleNotifier.onFilterTypeChanged(filterType),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ArticleFilterType.all,
                child: Text('全部'),
              ),
              const PopupMenuItem(
                value: ArticleFilterType.unread,
                child: Text('仅未读'),
              ),
              const PopupMenuItem(
                value: ArticleFilterType.favorite,
                child: Text('仅收藏'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 文章列表区块组件
/// 用于显示当前选中订阅源的文章列表
class _ArticleListSection extends HookConsumerWidget {
  final VoidCallback onRefresh;

  const _ArticleListSection({required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleState = ref.watch(articleListNotifierProvider);
    final articleNotifier = ref.read(articleListNotifierProvider.notifier);

    return articleState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (
        articles,
        feedId,
        sortType,
        filterType,
        currentPage,
        hasMore,
        isLoadingMore,
        isRefreshing,
        selectedArticleId,
      ) {
        return ArticleList(
          articles: articles,
          isLoading: false,
          isLoadingMore: isLoadingMore,
          hasMore: hasMore,
          selectedArticleId: selectedArticleId,
          onLoadMore: articleNotifier.onLoadMore,
          onRefresh: () async => articleNotifier.onRefresh(),
          onArticleTap: (article) {
            // 更新选中状态
            articleNotifier.onArticleSelected(article.id);
            // 移动端直接导航到文章详情页
            if (PlatformUtils.isMobile) {
              context.push(AppRoutes.article(article.id));
            }
          },
          onMarkAsRead: articleNotifier.onMarkAsRead,
          onMarkAsUnread: articleNotifier.onMarkAsUnread,
          onToggleFavorite: articleNotifier.onToggleFavorite,
          onBlockArticle: articleNotifier.onBlockArticle,
        );
      },
      error: (message) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRefresh, child: const Text('重试')),
          ],
        ),
      ),
    );
  }
}
