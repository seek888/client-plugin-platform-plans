import 'package:flutter/material.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_card.dart';

/// 可滑动的文章卡片组件（移动端）
/// 左滑：标记已读/收藏
/// 右滑：屏蔽文章/订阅源
class SwipeableArticleCard extends StatelessWidget {
  /// 文章数据
  final Article article;

  /// 订阅源图标 URL
  final String? feedIconUrl;

  /// 订阅源名称
  final String? feedTitle;

  /// 是否选中
  final bool isSelected;

  /// 点击回调
  final VoidCallback onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  /// 标记已读回调
  final VoidCallback? onMarkAsRead;

  /// 标记未读回调
  final VoidCallback? onMarkAsUnread;

  /// 收藏回调
  final VoidCallback? onToggleFavorite;

  /// 屏蔽文章回调
  final VoidCallback? onBlockArticle;

  /// 屏蔽订阅源回调
  final VoidCallback? onBlockFeed;

  const SwipeableArticleCard({
    super.key,
    required this.article,
    this.feedIconUrl,
    this.feedTitle,
    this.isSelected = false,
    required this.onTap,
    this.onLongPress,
    this.onMarkAsRead,
    this.onMarkAsUnread,
    this.onToggleFavorite,
    this.onBlockArticle,
    this.onBlockFeed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: Key('article_${article.id}'),
      background: _buildLeftSwipeBackground(colorScheme),
      secondaryBackground: _buildRightSwipeBackground(colorScheme),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // 右滑 - 显示屏蔽选项
          _showBlockOptions(context, colorScheme);
          return false;
        } else {
          // 左滑 - 显示已读/收藏选项
          _showReadFavoriteOptions(context, colorScheme);
          return false;
        }
      },
      child: ArticleCard(
        article: article,
        feedIconUrl: feedIconUrl,
        feedTitle: feedTitle,
        isSelected: isSelected,
        onTap: onTap,
        onLongPress: onLongPress,
        onMarkAsRead: onMarkAsRead,
        onToggleFavorite: onToggleFavorite,
        onBlock: onBlockArticle,
      ),
    );
  }

  /// 构建左滑背景（标记已读/收藏）
  Widget _buildLeftSwipeBackground(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.primaryContainer,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            article.isRead ? Icons.mark_email_unread : Icons.mark_email_read,
            color: colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 8),
          Text(
            article.isRead ? '标记未读' : '标记已读',
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 24),
          Icon(
            article.isFavorite ? Icons.star_outline : Icons.star,
            color: colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 8),
          Text(
            article.isFavorite ? '取消收藏' : '收藏',
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建右滑背景（屏蔽）
  Widget _buildRightSwipeBackground(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.errorContainer,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '屏蔽',
            style: TextStyle(
              color: colorScheme.onErrorContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.block, color: colorScheme.onErrorContainer),
        ],
      ),
    );
  }

  /// 显示屏蔽选项
  void _showBlockOptions(BuildContext context, ColorScheme colorScheme) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.article_outlined),
              title: const Text('屏蔽这篇文章'),
              subtitle: const Text('不再显示这篇文章'),
              onTap: () {
                Navigator.pop(context);
                onBlockArticle?.call();
              },
            ),
            ListTile(
              leading: const Icon(Icons.rss_feed),
              title: const Text('屏蔽此订阅源'),
              subtitle: Text('不再显示来自「${feedTitle ?? '未知'}」的文章'),
              onTap: () {
                Navigator.pop(context);
                onBlockFeed?.call();
              },
            ),
            const SizedBox(height: 8),
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

  /// 显示已读/收藏选项
  void _showReadFavoriteOptions(BuildContext context, ColorScheme colorScheme) {
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
                  onMarkAsUnread?.call();
                } else {
                  onMarkAsRead?.call();
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
                onToggleFavorite?.call();
              },
            ),
            const SizedBox(height: 8),
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
}
