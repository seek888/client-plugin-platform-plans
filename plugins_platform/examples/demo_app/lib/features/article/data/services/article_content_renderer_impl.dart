import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:rss_reader/features/article/data/services/article_style_builder.dart';
import 'package:rss_reader/features/article/domain/services/article_content_renderer.dart';

/// 文章内容渲染器实现
///
/// 使用 flutter_widget_from_html 将 HTML 内容渲染为原生 Flutter Widget
class ArticleContentRendererImpl implements ArticleContentRenderer {
  /// 样式构建器（可选，用于自定义样式）
  final ArticleStyleBuilder? styleBuilder;

  ArticleContentRendererImpl({this.styleBuilder});

  @override
  Widget renderContent(String htmlContent, ArticleRenderConfig config) {
    final processedHtml = preprocessHtml(htmlContent);

    return Builder(
      builder: (context) {
        // 创建样式构建器
        final effectiveStyleBuilder =
            styleBuilder ??
            ArticleStyleBuilder.fromContext(
              context,
              fontSize: config.fontSize,
              lineHeight: config.lineHeight,
              linkColor: config.linkColor,
              codeBackgroundColor: config.codeBackgroundColor,
              blockquoteBorderColor: config.blockquoteBorderColor,
            );

        return HtmlWidget(
          processedHtml,
          // 使用 Column 渲染模式，适合嵌入 ScrollView
          renderMode: RenderMode.column,
          // 文字样式
          textStyle: TextStyle(
            fontSize: config.fontSize,
            height: config.lineHeight,
          ),
          // 自定义样式构建器
          customStylesBuilder: (element) =>
              _buildCustomStyles(element, effectiveStyleBuilder),
          // 自定义 Widget 构建器
          customWidgetBuilder: (element) => _buildCustomWidget(element, config),
          // 链接点击处理
          onTapUrl: (url) {
            config.onLinkTap?.call(url);
            return true; // 返回 true 表示已处理
          },
          // 图片加载错误处理
          onLoadingBuilder: (context, element, loadingProgress) {
            return Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress,
                ),
              ),
            );
          },
          // 图片加载失败处理
          onErrorBuilder: (context, element, error) {
            return _buildImageErrorPlaceholder(context);
          },
          // 工厂构建器（用于无图模式）
          factoryBuilder: () => _ArticleWidgetFactory(
            enableImages: config.enableImages,
            enableVideos: config.enableVideos,
            onImageTap: config.onImageTap,
          ),
        );
      },
    );
  }

  @override
  String preprocessHtml(String rawHtml) {
    var html = rawHtml;

    // 1. 移除脚本标签
    html = html.replaceAll(
      RegExp(r'<script[^>]*>[\s\S]*?</script>', caseSensitive: false),
      '',
    );

    // 2. 移除样式标签（使用自定义样式）
    html = html.replaceAll(
      RegExp(r'<style[^>]*>[\s\S]*?</style>', caseSensitive: false),
      '',
    );

    // 3. 移除 noscript 标签
    html = html.replaceAll(
      RegExp(r'<noscript[^>]*>[\s\S]*?</noscript>', caseSensitive: false),
      '',
    );

    // 4. 处理 iframe（保留视频，移除其他）
    html = html.replaceAllMapped(
      RegExp(
        r'<iframe[^>]*src="([^"]*)"[^>]*>[\s\S]*?</iframe>',
        caseSensitive: false,
      ),
      (match) {
        final src = match.group(1) ?? '';
        // 保留 YouTube/Bilibili/Vimeo 等视频 iframe
        if (_isVideoUrl(src)) {
          return match.group(0)!;
        }
        return '';
      },
    );

    // 5. 移除空段落
    html = html.replaceAll(RegExp(r'<p>\s*</p>', caseSensitive: false), '');

    // 6. 移除空 div
    html = html.replaceAll(RegExp(r'<div>\s*</div>', caseSensitive: false), '');

    // 7. 移除空 span
    html = html.replaceAll(
      RegExp(r'<span>\s*</span>', caseSensitive: false),
      '',
    );

    // 8. 移除注释
    html = html.replaceAll(
      RegExp(r'<!--[\s\S]*?-->', caseSensitive: false),
      '',
    );

    // 9. 规范化换行（多个换行合并为两个）
    html = html.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    // 10. 移除行内样式中的字体大小（使用配置的字体大小）
    html = html.replaceAll(
      RegExp(r'font-size:\s*[^;]+;?', caseSensitive: false),
      '',
    );

    // 11. 移除行内样式中的字体族（使用系统字体）
    html = html.replaceAll(
      RegExp(r'font-family:\s*[^;]+;?', caseSensitive: false),
      '',
    );

    return html.trim();
  }

  /// 判断是否为视频 URL
  bool _isVideoUrl(String url) {
    final videoHosts = [
      'youtube.com',
      'youtu.be',
      'bilibili.com',
      'vimeo.com',
      'dailymotion.com',
      'player.bilibili.com',
    ];
    return videoHosts.any((host) => url.contains(host));
  }

  /// 构建自定义样式（使用样式构建器）
  Map<String, String>? _buildCustomStyles(
    dynamic element,
    ArticleStyleBuilder styleBuilder,
  ) {
    final localName = element.localName as String?;
    final parentName = element.parent?.localName as String?;

    // 使用样式构建器获取样式
    return styleBuilder.buildStyles(localName, parentName);
  }

  /// 构建自定义 Widget
  Widget? _buildCustomWidget(dynamic element, ArticleRenderConfig config) {
    // 可以在这里处理特殊标签
    // 例如：自定义视频播放器、特殊嵌入内容等
    return null;
  }

  /// 构建图片加载失败占位符
  Widget _buildImageErrorPlaceholder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.broken_image_outlined,
            color: isDark ? Colors.grey[400] : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            '图片加载失败',
            style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// 自定义 Widget 工厂
///
/// 用于实现无图模式和自定义图片处理
class _ArticleWidgetFactory extends WidgetFactory {
  final bool enableImages;
  final bool enableVideos;
  final void Function(String imageUrl)? onImageTap;

  _ArticleWidgetFactory({
    required this.enableImages,
    required this.enableVideos,
    this.onImageTap,
  });

  @override
  Widget? buildImageWidget(BuildTree meta, ImageSource src) {
    if (!enableImages) {
      // 无图模式：显示占位符
      return _buildImagePlaceholder();
    }

    // 使用默认图片构建，但包装点击事件
    final defaultWidget = super.buildImageWidget(meta, src);
    if (defaultWidget != null && onImageTap != null && src.url.isNotEmpty) {
      return GestureDetector(
        onTap: () => onImageTap!(src.url),
        child: defaultWidget,
      );
    }
    return defaultWidget;
  }

  /// 构建无图模式占位符
  Widget _buildImagePlaceholder() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.image_outlined, color: Colors.grey),
          SizedBox(width: 8),
          Text('图片已隐藏', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
