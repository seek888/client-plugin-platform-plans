import 'package:flutter/material.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';

/// 文章右键菜单项
class ArticleContextMenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDanger;

  const ArticleContextMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDanger = false,
  });
}

/// 文章右键菜单（桌面端）
class ArticleContextMenu {
  /// 显示右键菜单
  static Future<void> show({
    required BuildContext context,
    required Offset position,
    required Article article,
    VoidCallback? onMarkAsRead,
    VoidCallback? onMarkAsUnread,
    VoidCallback? onToggleFavorite,
    VoidCallback? onBlockArticle,
    VoidCallback? onBlockFeed,
    VoidCallback? onOpenInNewWindow,
    VoidCallback? onCopyLink,
    VoidCallback? onShare,
  }) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final items = <PopupMenuEntry<String>>[
      // 已读/未读
      PopupMenuItem<String>(
        value: 'read',
        child: _buildMenuItem(
          icon: article.isRead
              ? Icons.mark_email_unread
              : Icons.mark_email_read,
          label: article.isRead ? '标记为未读' : '标记为已读',
          colorScheme: colorScheme,
        ),
      ),
      // 收藏
      PopupMenuItem<String>(
        value: 'favorite',
        child: _buildMenuItem(
          icon: article.isFavorite ? Icons.star_outline : Icons.star,
          label: article.isFavorite ? '取消收藏' : '收藏',
          iconColor: article.isFavorite ? null : Colors.amber,
          colorScheme: colorScheme,
        ),
      ),
      const PopupMenuDivider(),
      // 在新窗口打开
      if (onOpenInNewWindow != null)
        PopupMenuItem<String>(
          value: 'newWindow',
          child: _buildMenuItem(
            icon: Icons.open_in_new,
            label: '在新窗口打开',
            colorScheme: colorScheme,
          ),
        ),
      // 复制链接
      if (onCopyLink != null)
        PopupMenuItem<String>(
          value: 'copyLink',
          child: _buildMenuItem(
            icon: Icons.link,
            label: '复制链接',
            colorScheme: colorScheme,
          ),
        ),
      // 分享
      if (onShare != null)
        PopupMenuItem<String>(
          value: 'share',
          child: _buildMenuItem(
            icon: Icons.share,
            label: '分享',
            colorScheme: colorScheme,
          ),
        ),
      const PopupMenuDivider(),
      // 屏蔽文章
      PopupMenuItem<String>(
        value: 'blockArticle',
        child: _buildMenuItem(
          icon: Icons.visibility_off,
          label: '屏蔽这篇文章',
          colorScheme: colorScheme,
          isDanger: true,
        ),
      ),
      // 屏蔽订阅源
      PopupMenuItem<String>(
        value: 'blockFeed',
        child: _buildMenuItem(
          icon: Icons.block,
          label: '屏蔽此订阅源',
          colorScheme: colorScheme,
          isDanger: true,
        ),
      ),
    ];

    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(position.dx, position.dy, 0, 0),
        Offset.zero & overlay.size,
      ),
      items: items,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

    if (result == null) return;

    switch (result) {
      case 'read':
        if (article.isRead) {
          onMarkAsUnread?.call();
        } else {
          onMarkAsRead?.call();
        }
        break;
      case 'favorite':
        onToggleFavorite?.call();
        break;
      case 'newWindow':
        onOpenInNewWindow?.call();
        break;
      case 'copyLink':
        onCopyLink?.call();
        break;
      case 'share':
        onShare?.call();
        break;
      case 'blockArticle':
        onBlockArticle?.call();
        break;
      case 'blockFeed':
        onBlockFeed?.call();
        break;
    }
  }

  /// 构建菜单项
  static Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required ColorScheme colorScheme,
    Color? iconColor,
    bool isDanger = false,
  }) {
    final color = isDanger ? colorScheme.error : null;
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor ?? color),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}

/// 带右键菜单的文章卡片包装器（桌面端）
class ArticleCardWithContextMenu extends StatelessWidget {
  /// 文章数据
  final Article article;

  /// 子组件
  final Widget child;

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

  /// 在新窗口打开回调
  final VoidCallback? onOpenInNewWindow;

  /// 复制链接回调
  final VoidCallback? onCopyLink;

  /// 分享回调
  final VoidCallback? onShare;

  const ArticleCardWithContextMenu({
    super.key,
    required this.article,
    required this.child,
    this.onMarkAsRead,
    this.onMarkAsUnread,
    this.onToggleFavorite,
    this.onBlockArticle,
    this.onBlockFeed,
    this.onOpenInNewWindow,
    this.onCopyLink,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapUp: (details) {
        ArticleContextMenu.show(
          context: context,
          position: details.globalPosition,
          article: article,
          onMarkAsRead: onMarkAsRead,
          onMarkAsUnread: onMarkAsUnread,
          onToggleFavorite: onToggleFavorite,
          onBlockArticle: onBlockArticle,
          onBlockFeed: onBlockFeed,
          onOpenInNewWindow: onOpenInNewWindow,
          onCopyLink: onCopyLink,
          onShare: onShare,
        );
      },
      child: child,
    );
  }
}
