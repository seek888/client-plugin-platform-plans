import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/router/routes.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:rss_reader/features/article/presentation/pages/article_detail_page.dart';
import 'package:rss_reader/features/article/presentation/pages/article_editor_page.dart';
import 'package:rss_reader/features/plugins/presentation/pages/plugin_extensions_page.dart';
import 'package:rss_reader/features/feed/presentation/pages/home_page.dart';
import 'package:rss_reader/features/feed/presentation/pages/feed_management_page.dart';
import 'package:rss_reader/features/search/presentation/pages/search_page.dart';
import 'package:rss_reader/features/settings/presentation/pages/settings_page.dart';
import 'package:rss_reader/shared/providers/providers.dart';
import 'package:rss_reader/app/navigation/app_navigator.dart';

part 'app_router.g.dart';

/// 应用路由配置 Provider
@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    navigatorKey: appNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      // 主页路由 - 支持桌面端嵌套导航
      ShellRoute(
        builder: (context, state, child) {
          // ShellRoute 用于桌面端三栏布局，保持外层布局不变
          return _MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const _HomePage(),
              transitionsBuilder: _fadeTransition,
            ),
            routes: [
              // 文章详情页 - 嵌套在首页下
              GoRoute(
                path: AppRoutes.articlePath,
                name: 'article',
                pageBuilder: (context, state) {
                  final articleId = state.pathParameters[RouteParams.id]!;
                  // 更新选中的文章 ID
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref.read(selectedArticleIdProvider.notifier).state =
                        articleId;
                  });
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: _ArticleDetailPage(articleId: articleId),
                    transitionsBuilder: PlatformUtils.isMobile
                        ? _slideTransition
                        : _fadeTransition,
                  );
                },
                routes: [
                  // 文章编辑页 - 嵌套在文章详情下
                  GoRoute(
                    path: 'edit',
                    name: 'articleEdit',
                    pageBuilder: (context, state) {
                      final articleId = state.pathParameters[RouteParams.id]!;
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: ArticleEditorPage(articleId: articleId),
                        transitionsBuilder: PlatformUtils.isMobile
                            ? _slideTransition
                            : _fadeTransition,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          // 订阅源详情页
          GoRoute(
            path: '/feed/:id',
            name: 'feedDetail',
            pageBuilder: (context, state) {
              final feedId = state.pathParameters[RouteParams.id]!;
              return CustomTransitionPage(
                key: state.pageKey,
                child: _FeedDetailPage(feedId: feedId),
                transitionsBuilder: _fadeTransition,
              );
            },
          ),
          // 分类页
          GoRoute(
            path: '/category/:id',
            name: 'category',
            pageBuilder: (context, state) {
              final categoryId = state.pathParameters[RouteParams.id]!;
              return CustomTransitionPage(
                key: state.pageKey,
                child: _CategoryPage(categoryId: categoryId),
                transitionsBuilder: _fadeTransition,
              );
            },
          ),
        ],
      ),
      // 搜索页 - 独立路由
      GoRoute(
        path: AppRoutes.search,
        name: 'search',
        pageBuilder: (context, state) {
          final query = state.uri.queryParameters[RouteQueryParams.search];
          return CustomTransitionPage(
            key: state.pageKey,
            child: _SearchPage(initialQuery: query),
            transitionsBuilder: PlatformUtils.isMobile
                ? _slideUpTransition
                : _fadeTransition,
          );
        },
      ),
      // 订阅源管理页
      GoRoute(
        path: AppRoutes.feedManagement,
        name: 'feedManagement',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const _FeedManagementPage(),
          transitionsBuilder: PlatformUtils.isMobile
              ? _slideTransition
              : _fadeTransition,
        ),
      ),
      // 设置页
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const _SettingsPage(),
          transitionsBuilder: PlatformUtils.isMobile
              ? _slideTransition
              : _fadeTransition,
        ),
      ),
      GoRoute(
        path: AppRoutes.plugins,
        name: 'plugins',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PluginExtensionsPage(),
          transitionsBuilder: PlatformUtils.isMobile
              ? _slideTransition
              : _fadeTransition,
        ),
      ),
      // 富文本编辑器页（新建笔记）
      GoRoute(
        path: AppRoutes.editor,
        name: 'editor',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ArticleEditorPage(articleId: ''),
          transitionsBuilder: PlatformUtils.isMobile
              ? _slideTransition
              : _fadeTransition,
        ),
      ),
      // 收藏页
      GoRoute(
        path: AppRoutes.favorites,
        name: 'favorites',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const _FavoritesPage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
    ],
    // 错误页面
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: _ErrorPage(error: state.error),
    ),
  );
}

// 页面过渡动画 - 淡入淡出
Widget _fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(opacity: animation, child: child);
}

// 页面过渡动画 - 从右滑入（移动端）
Widget _slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
    child: child,
  );
}

// 页面过渡动画 - 从下滑入（搜索页等）
Widget _slideUpTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
    child: child,
  );
}

// ============================================================================
// 临时占位页面 - 后续任务会实现具体页面
// ============================================================================

/// 主 Shell - 用于桌面端三栏布局
class _MainShell extends StatelessWidget {
  final Widget child;

  const _MainShell({required this.child});

  @override
  Widget build(BuildContext context) {
    // 桌面端使用 Shell 包裹，移动端直接返回 child
    // 具体的三栏布局在 HomePage 中实现
    return child;
  }
}

/// 首页占位
class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    // 使用新实现的 HomePage
    return const HomePage();
  }
}

/// 文章详情页
class _ArticleDetailPage extends StatelessWidget {
  final String articleId;

  const _ArticleDetailPage({required this.articleId});

  @override
  Widget build(BuildContext context) {
    return ArticleDetailPage(articleId: articleId);
  }
}

/// 订阅源详情页占位
class _FeedDetailPage extends StatelessWidget {
  final String feedId;

  const _FeedDetailPage({required this.feedId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('订阅源详情')),
      body: Center(child: Text('订阅源 ID: $feedId')),
    );
  }
}

/// 分类页占位
class _CategoryPage extends StatelessWidget {
  final String categoryId;

  const _CategoryPage({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('分类')),
      body: Center(child: Text('分类 ID: $categoryId')),
    );
  }
}

/// 搜索页占位
class _SearchPage extends StatelessWidget {
  final String? initialQuery;

  const _SearchPage({this.initialQuery});

  @override
  Widget build(BuildContext context) {
    // 使用新实现的 SearchPage
    return SearchPage(initialQuery: initialQuery);
  }
}

/// 订阅源管理页占位
class _FeedManagementPage extends StatelessWidget {
  const _FeedManagementPage();

  @override
  Widget build(BuildContext context) {
    // 使用新实现的 FeedManagementPage
    return const FeedManagementPage();
  }
}

/// 设置页占位
class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(BuildContext context) {
    // 使用新实现的 SettingsPage
    return const SettingsPage();
  }
}

/// 收藏页占位
class _FavoritesPage extends StatelessWidget {
  const _FavoritesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('收藏')),
      body: const Center(child: Text('收藏页 - 待实现')),
    );
  }
}

/// 错误页面
class _ErrorPage extends StatelessWidget {
  final Exception? error;

  const _ErrorPage({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('页面未找到')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('页面不存在', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            if (error != null)
              Text(
                error.toString(),
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }
}
