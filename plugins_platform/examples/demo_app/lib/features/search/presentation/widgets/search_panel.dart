import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/features/search/domain/entities/search_result.dart';
import 'package:rss_reader/features/search/presentation/notifiers/search_notifier.dart';
import 'package:rss_reader/features/search/presentation/states/search_state.dart';
import 'package:rss_reader/features/search/presentation/widgets/search_result_item.dart';

/// 搜索面板（桌面端）
/// 用于在三栏布局中显示搜索功能
/// Requirements: 8.1, 8.3, 8.4
class SearchPanel extends HookConsumerWidget {
  /// 初始搜索关键词
  final String? initialQuery;

  /// 关闭回调
  final VoidCallback? onClose;

  const SearchPanel({super.key, this.initialQuery, this.onClose});

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
            // 桌面端：更新选中状态，由父组件处理导航
          },
          navigateToFeed: (feedId) {
            // 桌面端：更新选中状态，由父组件处理导航
          },
          closeSearch: () {
            onClose?.call();
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

    return Column(
      children: [
        // 搜索栏
        _buildSearchBar(
          context,
          searchController,
          focusNode,
          notifier,
          selectedScope,
        ),
        // 筛选标签
        _buildScopeFilter(
          context,
          selectedScope,
          notifier,
          searchController.text,
        ),
        // 搜索结果
        Expanded(
          child: _buildBody(
            context,
            state,
            notifier,
            searchController.text,
            selectedScope,
          ),
        ),
      ],
    );
  }

  /// 构建搜索栏
  Widget _buildSearchBar(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
    SearchNotifier notifier,
    ValueNotifier<SearchScope> selectedScope,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          if (onClose != null)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onClose,
              tooltip: '关闭搜索',
            ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              decoration: InputDecoration(
                hintText: '搜索文章或订阅源...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          notifier.onClearSearch();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                notifier.onSearch(value, scope: selectedScope.value);
              },
              onChanged: (value) {
                (context as Element).markNeedsBuild();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 构建搜索范围筛选器
  Widget _buildScopeFilter(
    BuildContext context,
    ValueNotifier<SearchScope> selectedScope,
    SearchNotifier notifier,
    String query,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
          _buildInitialView(context, searchHistory, notifier),
      searching: (query, scope) =>
          const Center(child: CircularProgressIndicator()),
      loaded: (result, searchHistory, suggestions) =>
          _buildResultsView(context, result, notifier),
      empty: (query, scope, searchHistory) => _buildEmptyView(context, query),
      error: (message, query, searchHistory) =>
          _buildErrorView(context, message, notifier, query ?? ''),
    );
  }

  /// 构建初始视图
  Widget _buildInitialView(
    BuildContext context,
    List<String> searchHistory,
    SearchNotifier notifier,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    if (searchHistory.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 48, color: colorScheme.outline),
            const SizedBox(height: 12),
            Text(
              '输入关键词搜索',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '搜索历史',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              TextButton(
                onPressed: () => notifier.onClearSearchHistory(),
                child: const Text('清除', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        ...searchHistory.map(
          (query) => ListTile(
            dense: true,
            leading: const Icon(Icons.history, size: 18),
            title: Text(query, style: const TextStyle(fontSize: 14)),
            trailing: IconButton(
              icon: const Icon(Icons.close, size: 16),
              onPressed: () => notifier.onRemoveSearchHistory(query),
            ),
            onTap: () => notifier.onSearchFromHistory(query),
          ),
        ),
      ],
    );
  }

  /// 构建搜索结果视图
  Widget _buildResultsView(
    BuildContext context,
    SearchResult result,
    SearchNotifier notifier,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              '找到 ${result.totalCount} 个结果',
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        if (result.hasFeeds) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: Text(
                '订阅源 (${result.feeds.length})',
                style: TextStyle(
                  fontSize: 13,
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
        if (result.hasArticles) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
              child: Text(
                '文章 (${result.articles.length})',
                style: TextStyle(
                  fontSize: 13,
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
          Icon(Icons.search_off, size: 48, color: colorScheme.outline),
          const SizedBox(height: 12),
          Text(
            '未找到 "$query" 相关结果',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
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
          Icon(Icons.error_outline, size: 48, color: colorScheme.error),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => notifier.onSearch(query),
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }
}
