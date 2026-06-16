import 'package:flutter/material.dart';

/// 文章渲染配置
class ArticleRenderConfig {
  /// 字体大小
  final double fontSize;

  /// 行高
  final double lineHeight;

  /// 是否启用图片
  final bool enableImages;

  /// 是否启用视频
  final bool enableVideos;

  /// 链接颜色
  final Color? linkColor;

  /// 代码块背景色
  final Color? codeBackgroundColor;

  /// 引用块边框色
  final Color? blockquoteBorderColor;

  /// 链接点击回调
  final void Function(String url)? onLinkTap;

  /// 图片点击回调
  final void Function(String imageUrl)? onImageTap;

  /// 基础 URL（用于处理相对路径）
  final String? baseUrl;

  const ArticleRenderConfig({
    this.fontSize = 16.0,
    this.lineHeight = 1.6,
    this.enableImages = true,
    this.enableVideos = false,
    this.linkColor,
    this.codeBackgroundColor,
    this.blockquoteBorderColor,
    this.onLinkTap,
    this.onImageTap,
    this.baseUrl,
  });

  /// 创建默认配置
  factory ArticleRenderConfig.defaults(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ArticleRenderConfig(
      fontSize: 16.0,
      lineHeight: 1.6,
      enableImages: true,
      enableVideos: false,
      linkColor: theme.colorScheme.primary,
      codeBackgroundColor: isDark
          ? const Color(0xFF2D2D2D)
          : const Color(0xFFF5F5F5),
      blockquoteBorderColor: isDark
          ? const Color(0xFF616161)
          : const Color(0xFFBDBDBD),
    );
  }

  /// 复制并修改配置
  ArticleRenderConfig copyWith({
    double? fontSize,
    double? lineHeight,
    bool? enableImages,
    bool? enableVideos,
    Color? linkColor,
    Color? codeBackgroundColor,
    Color? blockquoteBorderColor,
    void Function(String url)? onLinkTap,
    void Function(String imageUrl)? onImageTap,
    String? baseUrl,
  }) {
    return ArticleRenderConfig(
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      enableImages: enableImages ?? this.enableImages,
      enableVideos: enableVideos ?? this.enableVideos,
      linkColor: linkColor ?? this.linkColor,
      codeBackgroundColor: codeBackgroundColor ?? this.codeBackgroundColor,
      blockquoteBorderColor:
          blockquoteBorderColor ?? this.blockquoteBorderColor,
      onLinkTap: onLinkTap ?? this.onLinkTap,
      onImageTap: onImageTap ?? this.onImageTap,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }
}

/// 文章内容渲染器接口
///
/// 负责将 HTML 内容渲染为 Flutter Widget
abstract class ArticleContentRenderer {
  /// 渲染文章 HTML 内容
  ///
  /// [htmlContent] 原始 HTML 内容
  /// [config] 渲染配置
  /// 返回渲染后的 Widget
  Widget renderContent(String htmlContent, ArticleRenderConfig config);

  /// 预处理 HTML 内容
  ///
  /// 清理脚本、空标签等不需要的内容
  /// [rawHtml] 原始 HTML
  /// 返回处理后的 HTML
  String preprocessHtml(String rawHtml);
}
