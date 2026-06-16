import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/app/theme/app_theme.dart';
import 'package:rss_reader/core/desktop/desktop_menu_bar.dart';
import 'package:rss_reader/core/router/app_router.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';

/// RSS Reader 应用主入口 Widget
class RssReaderApp extends ConsumerWidget {
  const RssReaderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    Widget app = MaterialApp.router(
      title: 'RSS Reader',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      // 构建器 - 用于全局配置
      builder: (context, child) {
        // 限制字体缩放范围，防止系统字体设置影响布局
        final mediaQueryData = MediaQuery.of(context);
        final constrainedTextScaler = mediaQueryData.textScaler.clamp(
          minScaleFactor: 0.8,
          maxScaleFactor: 1.3,
        );

        return MediaQuery(
          data: mediaQueryData.copyWith(textScaler: constrainedTextScaler),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    // 桌面端添加菜单栏
    if (PlatformUtils.isDesktop) {
      app = DesktopMenuBar(child: app);
    }

    return app;
  }
}
