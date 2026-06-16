import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rss_reader/app/theme/colors.dart';
import 'package:rss_reader/app/theme/text_styles.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';

/// 主题模式 Provider
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

/// 字体缩放比例 Provider（用于阅读页双指缩放）
final fontScaleProvider = StateProvider<double>(
  (ref) => AppTextStyles.defaultFontScale,
);

/// 应用主题配置
class AppTheme {
  AppTheme._();

  // ============================================================================
  // 主题常量
  // ============================================================================

  /// 卡片圆角
  static const double cardRadius = 12.0;

  /// 按钮圆角
  static const double buttonRadius = 8.0;

  /// 输入框圆角
  static const double inputRadius = 8.0;

  /// 对话框圆角
  static const double dialogRadius = 16.0;

  /// 底部导航栏高度
  static const double bottomNavHeight = 56.0;

  /// 导航栏宽度（桌面端）
  static const double navigationRailWidth = 72.0;

  /// 中间面板默认宽度（桌面端）
  static const double middlePanelWidth = 320.0;

  /// 中间面板最小宽度（桌面端）
  static const double middlePanelMinWidth = 280.0;

  /// 中间面板最大宽度（桌面端）
  static const double middlePanelMaxWidth = 400.0;

  // ============================================================================
  // 亮色主题
  // ============================================================================

  /// 亮色主题
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: PlatformUtils.isDesktop
          ? AppTextStyles.textThemeDesktop
          : AppTextStyles.textTheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // AppBar 主题
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: AppColors.surfaceLight,
        foregroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // 卡片主题
      cardTheme: CardThemeData(
        elevation: 1,
        color: AppColors.cardLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // 导航栏主题（桌面端）
      navigationRailTheme: NavigationRailThemeData(
        labelType: NavigationRailLabelType.all,
        backgroundColor: AppColors.navigationRailLight,
        selectedIconTheme: IconThemeData(color: colorScheme.primary),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        indicatorColor: colorScheme.primaryContainer,
      ),

      // 底部导航栏主题（移动端）
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // 分隔线主题
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: 1,
        space: 1,
      ),

      // 列表瓦片主题
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 12,
      ),

      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
      ),

      // 对话框主题
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dialogRadius),
        ),
        backgroundColor: AppColors.surfaceLight,
      ),

      // 底部弹出框主题
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),

      // Snackbar 主题
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
      ),

      // 进度指示器主题
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),

      // 滑动操作主题（文章卡片滑动）
      // 使用 colorScheme 中的颜色
    );
  }

  // ============================================================================
  // 暗色主题
  // ============================================================================

  /// 暗色主题
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: PlatformUtils.isDesktop
          ? AppTextStyles.textThemeDesktop
          : AppTextStyles.textTheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // AppBar 主题
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // 卡片主题
      cardTheme: CardThemeData(
        elevation: 1,
        color: AppColors.cardDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // 导航栏主题（桌面端）
      navigationRailTheme: NavigationRailThemeData(
        labelType: NavigationRailLabelType.all,
        backgroundColor: AppColors.navigationRailDark,
        selectedIconTheme: IconThemeData(color: colorScheme.primary),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        indicatorColor: colorScheme.primaryContainer,
      ),

      // 底部导航栏主题（移动端）
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // 分隔线主题
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      // 列表瓦片主题
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 12,
      ),

      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade900,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
      ),

      // 对话框主题
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dialogRadius),
        ),
        backgroundColor: AppColors.surfaceDark,
      ),

      // 底部弹出框主题
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),

      // Snackbar 主题
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
      ),

      // 进度指示器主题
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),
    );
  }

  // ============================================================================
  // 主题工具方法
  // ============================================================================

  /// 获取当前主题的亮度
  static Brightness getBrightness(BuildContext context) {
    return Theme.of(context).brightness;
  }

  /// 是否为暗色模式
  static bool isDarkMode(BuildContext context) {
    return getBrightness(context) == Brightness.dark;
  }

  /// 获取卡片背景色
  static Color getCardColor(BuildContext context) {
    return isDarkMode(context) ? AppColors.cardDark : AppColors.cardLight;
  }

  /// 获取背景色
  static Color getBackgroundColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
  }

  /// 获取分隔线颜色
  static Color getDividerColor(BuildContext context) {
    return isDarkMode(context) ? AppColors.dividerDark : AppColors.dividerLight;
  }

  /// 获取代码块背景色
  static Color getCodeBackgroundColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.codeBackgroundDark
        : AppColors.codeBackgroundLight;
  }
}
