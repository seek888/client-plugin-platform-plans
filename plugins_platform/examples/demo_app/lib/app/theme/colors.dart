import 'package:flutter/material.dart';

/// 应用颜色定义
class AppColors {
  AppColors._();

  /// 主色调
  static const Color primary = Color(0xFF2196F3);

  /// 次要色调
  static const Color secondary = Color(0xFF03DAC6);

  /// 错误色
  static const Color error = Color(0xFFB00020);

  /// 未读标记色
  static const Color unreadIndicator = Color(0xFFE53935);

  /// 收藏色
  static const Color favorite = Color(0xFFFFB300);

  /// 成功色
  static const Color success = Color(0xFF4CAF50);

  /// 警告色
  static const Color warning = Color(0xFFFF9800);

  /// 分隔线颜色 - 亮色模式
  static const Color dividerLight = Color(0xFFE0E0E0);

  /// 分隔线颜色 - 暗色模式
  static const Color dividerDark = Color(0xFF424242);

  /// 背景色 - 亮色模式
  static const Color backgroundLight = Color(0xFFFAFAFA);

  /// 背景色 - 暗色模式
  static const Color backgroundDark = Color(0xFF121212);

  /// 卡片背景色 - 亮色模式
  static const Color cardLight = Color(0xFFFFFFFF);

  /// 卡片背景色 - 暗色模式
  static const Color cardDark = Color(0xFF1E1E1E);

  /// 表面色 - 亮色模式
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// 表面色 - 暗色模式
  static const Color surfaceDark = Color(0xFF1E1E1E);

  /// 导航栏背景色 - 亮色模式
  static const Color navigationRailLight = Color(0xFFF5F5F5);

  /// 导航栏背景色 - 暗色模式
  static const Color navigationRailDark = Color(0xFF1A1A1A);

  /// 文章未读指示条颜色
  static const Color unreadBar = Color(0xFFE53935);

  /// 文章未读指示条宽度
  static const double unreadBarWidth = 4.0;

  /// 代码块背景色 - 亮色模式
  static const Color codeBackgroundLight = Color(0xFFF5F5F5);

  /// 代码块背景色 - 暗色模式
  static const Color codeBackgroundDark = Color(0xFF2D2D2D);

  /// 引用块边框色
  static const Color blockquoteBorder = Color(0xFFBDBDBD);

  /// 链接颜色
  static const Color link = Color(0xFF1976D2);

  /// 获取分隔线颜色
  static Color divider(Brightness brightness) =>
      brightness == Brightness.light ? dividerLight : dividerDark;

  /// 获取背景色
  static Color background(Brightness brightness) =>
      brightness == Brightness.light ? backgroundLight : backgroundDark;

  /// 获取卡片背景色
  static Color card(Brightness brightness) =>
      brightness == Brightness.light ? cardLight : cardDark;

  /// 获取表面色
  static Color surface(Brightness brightness) =>
      brightness == Brightness.light ? surfaceLight : surfaceDark;

  /// 获取导航栏背景色
  static Color navigationRail(Brightness brightness) =>
      brightness == Brightness.light ? navigationRailLight : navigationRailDark;

  /// 获取代码块背景色
  static Color codeBackground(Brightness brightness) =>
      brightness == Brightness.light ? codeBackgroundLight : codeBackgroundDark;
}
