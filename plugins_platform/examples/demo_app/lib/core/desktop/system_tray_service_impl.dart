import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:rss_reader/core/desktop/system_tray_service.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

/// 系统托盘服务实现
///
/// 使用 tray_manager 包实现 Windows 系统托盘功能
/// Requirements: 1.1, 1.2, 1.3, 1.4, 2.1, 2.2, 3.1, 3.2
class SystemTrayServiceImpl implements SystemTrayService, TrayListener {
  SystemTrayServiceImpl._();

  static final SystemTrayServiceImpl _instance = SystemTrayServiceImpl._();
  static SystemTrayServiceImpl get instance => _instance;

  bool _isInitialized = false;
  bool _notifierInitialized = false;
  String _currentTooltip = 'RSS Reader';

  // 回调函数
  void Function()? _onSyncRequested;
  void Function()? _onSettingsRequested;
  void Function()? _onExitRequested;
  void Function(String? payload)? _onNotificationClicked;

  /// 菜单项标识
  static const String _menuShowWindow = 'show_window';
  static const String _menuSync = 'sync';
  static const String _menuSettings = 'settings';
  static const String _menuExit = 'exit';

  @override
  bool get isInitialized => _isInitialized;

  @override
  set onSyncRequested(void Function()? callback) => _onSyncRequested = callback;

  @override
  set onSettingsRequested(void Function()? callback) =>
      _onSettingsRequested = callback;

  @override
  set onExitRequested(void Function()? callback) => _onExitRequested = callback;

  @override
  set onNotificationClicked(void Function(String? payload)? callback) =>
      _onNotificationClicked = callback;

  @override
  Future<bool> initialize() async {
    if (_isInitialized) return true;
    if (!Platform.isWindows) return false;

    try {
      // 初始化本地通知
      await localNotifier.setup(
        appName: 'RSS Reader',
        shortcutPolicy: ShortcutPolicy.requireCreate,
      );
      _notifierInitialized = true;

      // 设置托盘图标
      await trayManager.setIcon('windows/runner/resources/app_icon.ico');

      // 设置提示文字
      await trayManager.setToolTip(_currentTooltip);

      // 构建右键菜单
      await _buildContextMenu();

      // 添加监听器
      trayManager.addListener(this);

      _isInitialized = true;
      debugPrint('System tray initialized successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to initialize system tray: $e');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    if (!_isInitialized) return;

    try {
      trayManager.removeListener(this);
      await trayManager.destroy();
      _isInitialized = false;
    } catch (e) {
      debugPrint('Failed to dispose system tray: $e');
    }
  }

  /// 构建右键上下文菜单
  /// Requirements: 2.1, 2.2
  Future<void> _buildContextMenu() async {
    final menu = Menu(
      items: [
        MenuItem(
          key: _menuShowWindow,
          label: '打开主窗口',
        ),
        MenuItem.separator(),
        MenuItem(
          key: _menuSync,
          label: '立即同步',
        ),
        MenuItem(
          key: _menuSettings,
          label: '设置',
        ),
        MenuItem.separator(),
        MenuItem(
          key: _menuExit,
          label: '退出',
        ),
      ],
    );

    await trayManager.setContextMenu(menu);
  }

  /// 获取菜单项列表（用于测试）
  List<String> getMenuItems() {
    return [
      '打开主窗口',
      '立即同步',
      '设置',
      '退出',
    ];
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized || !Platform.isWindows || !_notifierInitialized) return;

    try {
      // 使用 local_notifier 显示 Windows Toast 通知
      final notification = LocalNotification(
        title: title,
        body: body,
      );

      // 设置点击回调
      notification.onClick = () {
        _onNotificationClicked?.call(payload);
        showMainWindow();
      };

      await notification.show();
      debugPrint('Tray notification shown: $title - $body');
    } catch (e) {
      debugPrint('Failed to show notification: $e');
    }
  }

  @override
  Future<void> showBatchNotification({
    required int totalCount,
    required int feedCount,
  }) async {
    if (!_isInitialized || !Platform.isWindows || !_notifierInitialized) return;

    try {
      final title = '新内容更新';
      final body = '$feedCount 个订阅源共有 $totalCount 篇新文章';

      final notification = LocalNotification(
        title: title,
        body: body,
      );

      notification.onClick = () {
        showMainWindow();
      };

      await notification.show();
      debugPrint('Batch notification shown: $title - $body');
    } catch (e) {
      debugPrint('Failed to show batch notification: $e');
    }
  }

  @override
  Future<void> updateTooltip(String tooltip) async {
    if (!_isInitialized) return;

    try {
      _currentTooltip = tooltip;
      await trayManager.setToolTip(tooltip);
    } catch (e) {
      debugPrint('Failed to update tooltip: $e');
    }
  }

  @override
  Future<void> setUnreadBadge(int count) async {
    if (!_isInitialized) return;

    try {
      // 更新 tooltip 显示未读数量
      final tooltip = count > 0 ? 'RSS Reader - $count 篇未读' : 'RSS Reader';
      await updateTooltip(tooltip);
    } catch (e) {
      debugPrint('Failed to set unread badge: $e');
    }
  }

  @override
  Future<void> showMainWindow() async {
    try {
      await windowManager.show();
      await windowManager.focus();
    } catch (e) {
      debugPrint('Failed to show main window: $e');
    }
  }

  @override
  Future<void> hideToTray() async {
    try {
      await windowManager.hide();
    } catch (e) {
      debugPrint('Failed to hide to tray: $e');
    }
  }

  // TrayListener 回调

  @override
  void onTrayIconMouseDown() {
    // 单击托盘图标 - 显示主窗口
    // Requirements: 1.3, 1.4
    showMainWindow();
  }

  @override
  void onTrayIconMouseUp() {
    // 单击释放 - 不做处理
  }

  @override
  void onTrayIconRightMouseDown() {
    // 右键按下 - 显示菜单
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconRightMouseUp() {
    // 右键释放 - 不做处理
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    switch (menuItem.key) {
      case _menuShowWindow:
        showMainWindow();
        break;
      case _menuSync:
        _onSyncRequested?.call();
        break;
      case _menuSettings:
        _onSettingsRequested?.call();
        break;
      case _menuExit:
        _onExitRequested?.call();
        break;
    }
  }
}
