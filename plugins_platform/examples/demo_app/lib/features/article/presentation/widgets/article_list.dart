import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_card.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_context_menu.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_skeleton.dart';
import 'package:rss_reader/features/article/presentation/widgets/swipeable_article_card.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

/// 文章列表组件
/// 支持懒加载、骨架屏、移动端滑动操作、桌面端右键菜单
class ArticleList extends HookConsumerWidget {
  /// 文章列表
  final List<Article> articles;

  /// 订阅源映射（用于显示订阅源信息）
  final Map<String, Feed>? feedMap;

  /// 是否正在加载
  final bool isLoading;

  /// 是否正在加载更多
  final bool isLoadingMore;

  /// 是否还有更多数据
  final bool hasMore;

  /// 当前选中的文章 ID
  final String? selectedArticleId;

  /// 加载更多回调
  final VoidCallback? onLoadMore;

  /// 刷新回调
  final Future<void> Function()? onRefresh;

  /// 文章点击回调
  final void Function(Article article)? onArticleTap;

  /// 标记已读回调
  final void Function(String articleId)? onMarkAsRead;

  /// 标记未读回调
  final void Function(String articleId)? onMarkAsUnread;

  /// 切换收藏回调
  final void Function(String articleId)? onToggleFavorite;

  /// 屏蔽文章回调
  final void Function(String articleId)? onBlockArticle;

  /// 屏蔽订阅源回调
  final void Function(String feedId)? onBlockFeed;

  /// 在新窗口打开回调（桌面端）
  final void Function(String articleId)? onOpenInNewWindow;

  /// 复制链接回调
  final void Function(String link)? onCopyLink;

  /// 分享回调
  final void Function(Article article)? onShare;

  /// 滚动控制器
  final ScrollController? scrollController;

  const ArticleList({
    super.key,
    required this.articles,
    this.feedMap,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.selectedArticleId,
    this.onLoadMore,
    this.onRefresh,
    this.onArticleTap,
    this.onMarkAsRead,
    this.onMarkAsUnread,
    this.onToggleFavorite,
    this.onBlockArticle,
    this.onBlockFeed,
    this.onOpenInNewWindow,
    this.onCopyLink,
    this.onShare,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 加载中状态显示骨架屏
    if (isLoading) {
      return const ArticleListSkeleton(count: 8);
    }

    // 空状态
    if (articles.isEmpty) {
      return _buildEmptyState(context);
    }

    // 文章列表
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          // 滚动到底部时加载更多
          if (notification.metrics.extentAfter < 200 &&
              hasMore &&
              !isLoadingMore) {
            onLoadMore?.call();
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        child: ListView.builder(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: articles.length + 1, // +1 for load more indicator
          itemBuilder: (context, index) {
            if (index == articles.length) {
              return LoadMoreIndicator(
                isLoading: isLoadingMore,
                hasMore: hasMore,
              );
            }

            final article = articles[index];
            final feed = feedMap?[article.feedId];

            return _buildArticleItem(context, article, feed);
          },
        ),
      ),
    );
  }

  /// 构建文章项
  Widget _buildArticleItem(BuildContext context, Article article, Feed? feed) {
    final isSelected = article.id == selectedArticleId;

    // 移动端使用可滑动卡片
    if (PlatformUtils.isMobile) {
      return SwipeableArticleCard(
        article: article,
        feedIconUrl: feed?.iconUrl,
        feedTitle: feed?.title,
        isSelected: isSelected,
        onTap: () => onArticleTap?.call(article),
        onLongPress: () => _showMobileOptions(context, article),
        onMarkAsRead: () => onMarkAsRead?.call(article.id),
        onMarkAsUnread: () => onMarkAsUnread?.call(article.id),
        onToggleFavorite: () => onToggleFavorite?.call(article.id),
        onBlockArticle: () => onBlockArticle?.call(article.id),
        onBlockFeed: () => onBlockFeed?.call(article.feedId),
      );
    }

    // 桌面端使用带右键菜单的卡片
    return ArticleCardWithContextMenu(
      article: article,
      onMarkAsRead: () => onMarkAsRead?.call(article.id),
      onMarkAsUnread: () => onMarkAsUnread?.call(article.id),
      onToggleFavorite: () => onToggleFavorite?.call(article.id),
      onBlockArticle: () => onBlockArticle?.call(article.id),
      onBlockFeed: () => onBlockFeed?.call(article.feedId),
      onOpenInNewWindow: onOpenInNewWindow != null
          ? () => onOpenInNewWindow?.call(article.id)
          : null,
      onCopyLink: onCopyLink != null
          ? () {
              Clipboard.setData(ClipboardData(text: article.link));
              onCopyLink?.call(article.link);
            }
          : null,
      onShare: onShare != null ? () => onShare?.call(article) : null,
      child: ArticleCard(
        article: article,
        feedIconUrl: feed?.iconUrl,
        feedTitle: feed?.title,
        isSelected: isSelected,
        onTap: () => onArticleTap?.call(article),
      ),
    );
  }

  /// 显示移动端选项菜单
  void _showMobileOptions(BuildContext context, Article article) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                article.isRead
                    ? Icons.mark_email_unread
                    : Icons.mark_email_read,
              ),
              title: Text(article.isRead ? '标记为未读' : '标记为已读'),
              onTap: () {
                Navigator.pop(context);
                if (article.isRead) {
                  onMarkAsUnread?.call(article.id);
                } else {
                  onMarkAsRead?.call(article.id);
                }
              },
            ),
            ListTile(
              leading: Icon(
                article.isFavorite ? Icons.star_outline : Icons.star,
                color: article.isFavorite ? null : Colors.amber,
              ),
              title: Text(article.isFavorite ? '取消收藏' : '收藏'),
              onTap: () {
                Navigator.pop(context);
                onToggleFavorite?.call(article.id);
              },
            ),
            if (onShare != null)
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('分享'),
                onTap: () {
                  Navigator.pop(context);
                  onShare?.call(article);
                },
              ),
            if (onCopyLink != null)
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('复制链接'),
                onTap: () {
                  Navigator.pop(context);
                  Clipboard.setData(ClipboardData(text: article.link));
                  onCopyLink?.call(article.link);
                },
              ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.visibility_off,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                '屏蔽这篇文章',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () {
                Navigator.pop(context);
                onBlockArticle?.call(article.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('取消'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.article_outlined, size: 64, color: colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            '暂无文章',
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          Text(
            '下拉刷新获取最新内容',
            style: TextStyle(fontSize: 14, color: colorScheme.outline),
          ),
        ],
      ),
    );
  }
}
