import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugins_platform/plugins_platform.dart';
import 'package:rss_reader/app/app.dart';
import 'package:rss_reader/app/navigation/app_navigator.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/desktop/system_tray_service_impl.dart';
import 'package:rss_reader/core/desktop/window_manager_service.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:rss_reader/features/notification/data/services/notification_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化日志系统
  _initLogger();
  logger.info('应用启动', tag: 'App');

  // Windows 平台初始化本地 SQLite
  setupWindowsSqlite();

  // 设置系统 UI 样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // 移动端设置支持的屏幕方向
  if (PlatformUtils.isMobile) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // 桌面端窗口初始化（使用 WindowManagerService）
  if (PlatformUtils.isDesktop) {
    await WindowManagerService.instance.initialize();
  }

  // Windows 系统托盘初始化
  if (Platform.isWindows) {
    await _initSystemTray();
  }

  // 初始化通知服务（移动端）
  if (PlatformUtils.isMobile) {
    await _initNotificationService();
  }

  runApp(
    ProviderScope(
      overrides: [
        hostBridgeProvider.overrideWithValue(
          HostBridge(navigatorKey: appNavigatorKey),
        ),
      ],
      child: const RssReaderApp(),
    ),
  );
}

/// 初始化通知服务
Future<void> _initNotificationService() async {
  final notificationService = NotificationServiceImpl();
  await notificationService.initialize();
  // 请求通知权限（用户可以稍后在设置中授权）
  await notificationService.requestPermission();
}

/// 初始化 Windows 系统托盘
/// Requirements: 1.1
Future<void> _initSystemTray() async {
  final trayService = SystemTrayServiceImpl.instance;

  // 设置退出回调
  trayService.onExitRequested = () {
    WindowManagerService.instance.forceClose();
  };

  // 设置关闭到托盘的回调
  WindowManagerService.instance.onCloseToTray = () {
    trayService.hideToTray();
  };

  // 初始化托盘
  final success = await trayService.initialize();
  if (success) {
    logger.info('系统托盘初始化成功', tag: 'SystemTray');
  } else {
    logger.warning('系统托盘初始化失败', tag: 'SystemTray');
  }
}

/// 初始化日志系统
void _initLogger() {
  final config = kDebugMode ? LogConfig.debug : LogConfig.release;
  logger.init(config);
}
