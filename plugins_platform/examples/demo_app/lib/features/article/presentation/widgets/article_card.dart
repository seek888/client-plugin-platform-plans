import 'package:flutter/material.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';

/// 文章卡片组件
/// 支持移动端和桌面端不同的交互方式
class ArticleCard extends StatefulWidget {
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

  /// 长按回调（移动端）
  final VoidCallback? onLongPress;

  /// 标记已读回调
  final VoidCallback? onMarkAsRead;

  /// 收藏回调
  final VoidCallback? onToggleFavorite;

  /// 屏蔽回调
  final VoidCallback? onBlock;

  /// 右键菜单回调（桌面端）
  final void Function(Offset position)? onContextMenu;

  const ArticleCard({
    super.key,
    required this.article,
    this.feedIconUrl,
    this.feedTitle,
    this.isSelected = false,
    required this.onTap,
    this.onLongPress,
    this.onMarkAsRead,
    this.onToggleFavorite,
    this.onBlock,
    this.onContextMenu,
  });

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget card = _buildCard(context, colorScheme);

    // 桌面端添加鼠标悬停效果
    if (PlatformUtils.supportsHover) {
      card = MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: card,
      );
    }

    // 桌面端添加右键菜单
    if (PlatformUtils.isDesktop && widget.onContextMenu != null) {
      card = GestureDetector(
        onSecondaryTapUp: (details) {
          widget.onContextMenu?.call(details.globalPosition);
        },
        child: card,
      );
    }

    return card;
  }

  Widget _buildCard(BuildContext context, ColorScheme colorScheme) {
    return InkWell(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: _getBackgroundColor(colorScheme),
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 未读标记（左侧红色竖条）
            _buildUnreadIndicator(colorScheme),
            // 主内容区
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 订阅源图标
                    _buildFeedIcon(colorScheme),
                    const SizedBox(width: 12),
                    // 文章信息
                    Expanded(child: _buildArticleInfo(colorScheme)),
                    // 封面图（如果有）
                    if (widget.article.hasImage) ...[
                      const SizedBox(width: 12),
                      _buildCoverImage(colorScheme),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取背景颜色
  Color _getBackgroundColor(ColorScheme colorScheme) {
    if (widget.isSelected) {
      return colorScheme.secondaryContainer.withValues(alpha: 0.5);
    }
    if (_isHovered) {
      return colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);
    }
    // 已读文章使用更淡的背景色
    if (widget.article.isRead) {
      return colorScheme.surfaceContainerHighest.withValues(alpha: 0.2);
    }
    return Colors.transparent;
  }

  /// 构建未读标记
  Widget _buildUnreadIndicator(ColorScheme colorScheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 4,
      height: widget.article.isRead ? 0 : 80,
      decoration: BoxDecoration(
        color: widget.article.isRead ? Colors.transparent : colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(2),
          bottomRight: Radius.circular(2),
        ),
      ),
    );
  }

  /// 构建订阅源图标
  Widget _buildFeedIcon(ColorScheme colorScheme) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: widget.feedIconUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.feedIconUrl!,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    _buildDefaultFeedIcon(colorScheme),
              ),
            )
          : _buildDefaultFeedIcon(colorScheme),
    );
  }

  /// 构建默认订阅源图标
  Widget _buildDefaultFeedIcon(ColorScheme colorScheme) {
    return Icon(
      Icons.rss_feed,
      size: 20,
      color: colorScheme.onSecondaryContainer,
    );
  }

  /// 构建文章信息
  Widget _buildArticleInfo(ColorScheme colorScheme) {
    final isRead = widget.article.isRead;
    final titleColor =
        isRead ? colorScheme.onSurfaceVariant : colorScheme.onSurface;
    final titleWeight = isRead ? FontWeight.normal : FontWeight.w600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 订阅源名称和时间
        Row(
          children: [
            if (widget.feedTitle != null) ...[
              Flexible(
                child: Text(
                  widget.feedTitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              _formatTime(widget.article.publishedAt),
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            // 未读圆点标记
            if (!isRead)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            // 收藏图标
            if (widget.article.isFavorite)
              const Icon(Icons.star, size: 16, color: Colors.amber),
          ],
        ),
        const SizedBox(height: 4),
        // 标题
        Text(
          widget.article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            fontWeight: titleWeight,
            color: titleColor,
          ),
        ),
        // 摘要
        if (widget.article.summary != null &&
            widget.article.summary!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            widget.article.summary!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant,
              fontWeight: isRead ? FontWeight.w300 : FontWeight.normal,
            ),
          ),
        ],
      ],
    );
  }

  /// 构建封面图
  Widget _buildCoverImage(ColorScheme colorScheme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        widget.article.imageUrl!,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.image_not_supported_outlined,
            color: colorScheme.outline,
          ),
        ),
      ),
    );
  }

  /// 格式化时间
  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) {
      return '刚刚';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes}分钟前';
    } else if (diff.inDays < 1) {
      return '${diff.inHours}小时前';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}天前';
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }
}
