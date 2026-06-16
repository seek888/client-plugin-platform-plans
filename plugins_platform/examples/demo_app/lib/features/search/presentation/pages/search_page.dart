import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/core/router/routes.dart';
import 'package:rss_reader/features/search/domain/entities/search_result.dart';
import 'package:rss_reader/features/search/presentation/notifiers/search_notifier.dart';
import 'package:rss_reader/features/search/presentation/states/search_state.dart';
import 'package:rss_reader/features/search/presentation/widgets/search_result_item.dart';

/// 搜索页面
/// 支持移动端全屏页面和桌面端面板
/// Requirements: 8.1, 8.3, 8.4
class SearchPage extends HookConsumerWidget {
  /// 初始搜索关键词
  final String? initialQuery;

  const SearchPage({super.key, this.initialQuery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchNotifierProvider);
    final notifier = ref.read(searchNotifierProvider.notifier);
    final searchController = useTextEditingController(text: initialQuery);
    final focusNode = useFocusNode();
    final selectedScope = useState(SearchScope.all);

    // 处理副作用
    useEffect(() {
      final notifierInstance = ref.read(searchNotifierProvider.notifier);
      final subscription = notifierInstance.sideEffect.listen((sideEffect) {
        sideEffect.when(
          showToast: (message, isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: isError ? Colors.red : null,
              ),
            );
          },
          navigateToArticle: (articleId) {
            context.go(AppRoutes.article(articleId));
          },
          navigateToFeed: (feedId) {
            context.go('/feed/$feedId');
          },
          closeSearch: () {
            context.pop();
          },
          clearFocus: () {
            focusNode.unfocus();
          },
          showConfirmDialog: (title, message, onConfirm, onCancel) {
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
          },
        );
      });
      return () => subscription.cancel();
    }, []);

    // 初始搜索
    useEffect(() {
      if (initialQuery != null && initialQuery!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifier.onSearch(initialQuery!);
        });
      }
      return null;
    }, [initialQuery]);

    return Scaffold(
      appBar: _buildAppBar(
        context,
        searchController,
        focusNode,
        notifier,
        selectedScope,
      ),
      body: _buildBody(
        context,
        state,
        notifier,
        searchController.text,
        selectedScope,
      ),
    );
  }

  /// 构建 AppBar
  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
    SearchNotifier notifier,
    ValueNotifier<SearchScope> selectedScope,
  ) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.go('/'),
      ),
      title: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        decoration: InputDecoration(
          hintText: '搜索文章或订阅源...',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: false,
          contentPadding: EdgeInsets.zero,
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    notifier.onClearSearch();
                  },
                )
              : null,
        ),
        style: const TextStyle(fontSize: 16),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          notifier.onSearch(value, scope: selectedScope.value);
        },
        onChanged: (value) {
          // 触发重建以更新清除按钮
          (context as Element).markNeedsBuild();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            notifier.onSearch(controller.text, scope: selectedScope.value);
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: _buildScopeFilter(
          context,
          selectedScope,
          notifier,
          controller.text,
        ),
      ),
    );
  }

  /// 构建搜索范围筛选器
  /// Requirements: 8.4
  Widget _buildScopeFilter(
    BuildContext context,
    ValueNotifier<SearchScope> selectedScope,
    SearchNotifier notifier,
    String query,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: SearchScope.values.map((scope) {
          final isSelected = selectedScope.value == scope;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_getScopeLabel(scope)),
              selected: isSelected,
              onSelected: (selected) {
                selectedScope.value = scope;
                if (query.isNotEmpty) {
                  notifier.onSearch(query, scope: scope);
                }
              },
              selectedColor: colorScheme.primaryContainer,
              checkmarkColor: colorScheme.onPrimaryContainer,
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 获取搜索范围标签
  String _getScopeLabel(SearchScope scope) {
    switch (scope) {
      case SearchScope.all:
        return '全部';
      case SearchScope.title:
        return '标题';
      case SearchScope.content:
        return '内容';
      case SearchScope.feed:
        return '订阅源';
    }
  }

  /// 构建主体内容
  Widget _buildBody(
    BuildContext context,
    SearchState state,
    SearchNotifier notifier,
    String query,
    ValueNotifier<SearchScope> selectedScope,
  ) {
    return state.when(
      initial: (searchHistory) =>
          _buildInitialView(context, searchHistory, notifier, selectedScope),
      searching: (query, scope) =>
          const Center(child: CircularProgressIndicator()),
      loaded: (result, searchHistory, suggestions) =>
          _buildResultsView(context, result, notifier),
      empty: (query, scope, searchHistory) => _buildEmptyView(context, query),
      error: (message, query, searchHistory) =>
          _buildErrorView(context, message, notifier, query ?? ''),
    );
  }

  /// 构建初始视图（显示搜索历史）
  Widget _buildInitialView(
    BuildContext context,
    List<String> searchHistory,
    SearchNotifier notifier,
    ValueNotifier<SearchScope> selectedScope,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    if (searchHistory.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              '输入关键词搜索文章或订阅源',
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '搜索历史',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              TextButton(
                onPressed: () => notifier.onClearSearchHistory(),
                child: const Text('清除'),
              ),
            ],
          ),
        ),
        ...searchHistory.map(
          (query) => ListTile(
            leading: const Icon(Icons.history),
            title: Text(query),
            trailing: IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: () => notifier.onRemoveSearchHistory(query),
            ),
            onTap: () => notifier.onSearchFromHistory(query),
          ),
        ),
      ],
    );
  }

  /// 构建搜索结果视图
  /// Requirements: 8.3
  Widget _buildResultsView(
    BuildContext context,
    SearchResult result,
    SearchNotifier notifier,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        // 结果统计
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '找到 ${result.totalCount} 个结果',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        // 订阅源结果
        if (result.hasFeeds) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                '订阅源 (${result.feeds.length})',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SearchFeedItem(
                feed: result.feeds[index],
                query: result.query,
                onTap: () => notifier.onFeedSelected(result.feeds[index].id),
              ),
              childCount: result.feeds.length,
            ),
          ),
        ],
        // 文章结果
        if (result.hasArticles) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                '文章 (${result.articles.length})',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SearchArticleItem(
                article: result.articles[index],
                query: result.query,
                onTap: () =>
                    notifier.onArticleSelected(result.articles[index].id),
              ),
              childCount: result.articles.length,
            ),
          ),
        ],
      ],
    );
  }

  /// 构建空结果视图
  Widget _buildEmptyView(BuildContext context, String query) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            '未找到 "$query" 相关结果',
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          Text(
            '尝试使用其他关键词搜索',
            style: TextStyle(fontSize: 14, color: colorScheme.outline),
          ),
        ],
      ),
    );
  }

  /// 构建错误视图
  Widget _buildErrorView(
    BuildContext context,
    String message,
    SearchNotifier notifier,
    String query,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: colorScheme.error),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => notifier.onSearch(query),
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }
}
