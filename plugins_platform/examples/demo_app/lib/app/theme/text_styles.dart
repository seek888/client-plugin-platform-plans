import 'package:flutter/material.dart';

/// 应用文字样式定义
class AppTextStyles {
  AppTextStyles._();

  // ============================================================================
  // 文章相关样式
  // ============================================================================

  /// 文章标题样式
  static const TextStyle articleTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// 文章摘要样式
  static const TextStyle articleSummary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: Colors.grey,
  );

  /// 文章正文样式 - 默认行间距 1.5 倍（Requirements 10.4）
  static const TextStyle articleBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  /// 文章正文样式 - 桌面端（稍大字号）
  static const TextStyle articleBodyDesktop = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    height: 1.6,
  );

  // ============================================================================
  // 订阅源相关样式
  // ============================================================================

  /// 订阅源名称样式
  static const TextStyle feedTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// 订阅源名称样式 - 桌面端
  static const TextStyle feedTitleDesktop = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  // ============================================================================
  // 通用样式
  // ============================================================================

  /// 时间戳样式
  static const TextStyle timestamp = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );

  /// 未读数角标样式
  static const TextStyle unreadBadge = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// 搜索关键词高亮样式
  static const TextStyle searchHighlight = TextStyle(
    backgroundColor: Color(0xFFFFEB3B),
    fontWeight: FontWeight.w500,
  );

  /// 代码块样式
  static const TextStyle codeBlock = TextStyle(
    fontFamily: 'monospace',
    fontSize: 14,
    height: 1.4,
  );

  /// 引用块样式
  static const TextStyle blockquote = TextStyle(
    fontSize: 15,
    fontStyle: FontStyle.italic,
    height: 1.5,
    color: Colors.grey,
  );

  // ============================================================================
  // 字体大小缩放
  // ============================================================================

  /// 最小字体缩放比例
  static const double minFontScale = 0.8;

  /// 最大字体缩放比例
  static const double maxFontScale = 1.5;

  /// 默认字体缩放比例
  static const double defaultFontScale = 1.0;

  /// 根据缩放比例获取文章正文样式
  static TextStyle articleBodyScaled(double scale) {
    return articleBody.copyWith(fontSize: articleBody.fontSize! * scale);
  }

  /// 根据缩放比例获取桌面端文章正文样式
  static TextStyle articleBodyDesktopScaled(double scale) {
    return articleBodyDesktop.copyWith(
      fontSize: articleBodyDesktop.fontSize! * scale,
    );
  }

  // ============================================================================
  // 应用文字主题
  // ============================================================================

  /// 应用文字主题
  static TextTheme get textTheme {
    return const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, height: 1.5),
      bodySmall: TextStyle(fontSize: 12, height: 1.4),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
    );
  }

  /// 桌面端文字主题（稍大字号）
  static TextTheme get textThemeDesktop {
    return const TextTheme(
      headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 17, height: 1.5),
      bodyMedium: TextStyle(fontSize: 15, height: 1.5),
      bodySmall: TextStyle(fontSize: 13, height: 1.4),
      labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    );
  }
}
