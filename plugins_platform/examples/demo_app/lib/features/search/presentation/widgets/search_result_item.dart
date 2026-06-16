import 'package:flutter/material.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

/// 搜索结果文章项组件
/// 支持关键词高亮显示
/// Requirements: 8.3
class SearchArticleItem extends StatelessWidget {
  /// 文章数据
  final Article article;

  /// 搜索关键词（用于高亮）
  final String query;

  /// 点击回调
  final VoidCallback onTap;

  const SearchArticleItem({
    super.key,
    required this.article,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
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
            // 文章图标
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.article_outlined,
                color: colorScheme.onSecondaryContainer,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // 文章信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题（带高亮）
                  _buildHighlightedText(
                    article.title,
                    query,
                    TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: article.isRead
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onSurface,
                    ),
                    colorScheme,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  // 摘要（带高亮）
                  if (article.summary != null && article.summary!.isNotEmpty)
                    _buildHighlightedText(
                      article.summary!,
                      query,
                      TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      colorScheme,
                      maxLines: 2,
                    ),
                  const SizedBox(height: 4),
                  // 时间
                  Text(
                    _formatTime(article.publishedAt),
                    style: TextStyle(fontSize: 12, color: colorScheme.outline),
                  ),
                ],
              ),
            ),
            // 封面图
            if (article.hasImage) ...[
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  article.imageUrl!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 60,
                    height: 60,
                    color: colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: colorScheme.outline,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 构建带高亮的文本
  Widget _buildHighlightedText(
    String text,
    String query,
    TextStyle baseStyle,
    ColorScheme colorScheme, {
    int maxLines = 1,
  }) {
    if (query.isEmpty) {
      return Text(
        text,
        style: baseStyle,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }

    final spans = <TextSpan>[];
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        // 添加剩余文本
        if (start < text.length) {
          spans.add(TextSpan(text: text.substring(start)));
        }
        break;
      }

      // 添加匹配前的文本
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      // 添加高亮文本
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: TextStyle(
            backgroundColor: colorScheme.primaryContainer,
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

      start = index + query.length;
    }

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
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

/// 搜索结果订阅源项组件
/// 支持关键词高亮显示
/// Requirements: 8.3
class SearchFeedItem extends StatelessWidget {
  /// 订阅源数据
  final Feed feed;

  /// 搜索关键词（用于高亮）
  final String query;

  /// 点击回调
  final VoidCallback onTap;

  const SearchFeedItem({
    super.key,
    required this.feed,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // 订阅源图标
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: feed.iconUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        feed.iconUrl!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.rss_feed,
                          color: colorScheme.onSecondaryContainer,
                          size: 20,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.rss_feed,
                      color: colorScheme.onSecondaryContainer,
                      size: 20,
                    ),
            ),
            const SizedBox(width: 12),
            // 订阅源信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 名称（带高亮）
                  _buildHighlightedText(
                    feed.title,
                    query,
                    TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                    colorScheme,
                  ),
                  if (feed.description != null &&
                      feed.description!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    // 描述（带高亮）
                    _buildHighlightedText(
                      feed.description!,
                      query,
                      TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      colorScheme,
                      maxLines: 2,
                    ),
                  ],
                ],
              ),
            ),
            // 未读数
            if (feed.unreadCount > 0)
              Badge(
                label: Text(
                  feed.unreadCount > 99 ? '99+' : feed.unreadCount.toString(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 构建带高亮的文本
  Widget _buildHighlightedText(
    String text,
    String query,
    TextStyle baseStyle,
    ColorScheme colorScheme, {
    int maxLines = 1,
  }) {
    if (query.isEmpty) {
      return Text(
        text,
        style: baseStyle,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }

    final spans = <TextSpan>[];
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        if (start < text.length) {
          spans.add(TextSpan(text: text.substring(start)));
        }
        break;
      }

      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: TextStyle(
            backgroundColor: colorScheme.primaryContainer,
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

      start = index + query.length;
    }

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
