import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/desktop/system_tray_service_impl.dart';
import 'package:rss_reader/core/desktop/tray_state.dart';
import 'package:rss_reader/core/desktop/window_manager_service.dart';
import 'package:rss_reader/features/settings/domain/entities/tray_settings.dart';

part 'system_tray_provider.g.dart';

/// 系统托盘状态 Provider
///
/// 管理系统托盘的运行时状态
/// Requirements: 1.1, 6.5
@riverpod
class SystemTrayNotifier extends _$SystemTrayNotifier {
  @override
  TrayState build() {
    return const TrayState();
  }

  /// 初始化系统托盘
  Future<bool> initialize({
    required TraySettings settings,
    void Function()? onSyncRequested,
    void Function()? onSettingsRequested,
    void Function()? onExitRequested,
  }) async {
    if (!Platform.isWindows) return false;

    final trayService = SystemTrayServiceImpl.instance;

    // 设置回调
    trayService.onSyncRequested = onSyncRequested;
    trayService.onSettingsRequested = onSettingsRequested;
    trayService.onExitRequested = onExitRequested;

    // 设置通知点击回调
    trayService.onNotificationClicked = (payload) {
      debugPrint('Notification clicked with payload: $payload');
    };

    // 初始化托盘
    final success = await trayService.initialize();

    if (success) {
      // 配置窗口管理器的关闭行为
      final windowService = WindowManagerService.instance;
      windowService.closeToTray = settings.closeToTray;
      windowService.onCloseToTray = () {
        trayService.hideToTray();
      };

      state = state.copyWith(isInitialized: true);
    }

    return success;
  }

  /// 更新托盘设置
  void updateSettings(TraySettings settings) {
    if (!Platform.isWindows) return;

    final windowService = WindowManagerService.instance;
    windowService.closeToTray = settings.closeToTray;
  }

  /// 设置同步状态
  Future<void> setSyncing(bool isSyncing) async {
    state = state.copyWith(isSyncing: isSyncing);
    await _updateTooltip();
  }

  /// 设置最后同步时间
  Future<void> setLastSyncTime(DateTime time) async {
    state = state.copyWith(
      lastSyncTime: time,
      errorMessage: null,
    );
    await _updateTooltip();
  }

  /// 设置错误信息
  Future<void> setError(String? error) async {
    state = state.copyWith(errorMessage: error);
    await _updateTooltip();
  }

  /// 设置未读数量
  Future<void> setUnreadCount(int count) async {
    state = state.copyWith(unreadCount: count);
    await _updateTooltip();
  }

  /// 显示新内容通知
  Future<void> showNewContentNotification({
    required String feedTitle,
    required int articleCount,
    required bool showNotifications,
  }) async {
    if (!Platform.isWindows || !showNotifications) return;

    final trayService = SystemTrayServiceImpl.instance;
    await trayService.showNotification(
      title: '新内容更新',
      body: '$feedTitle 有 $articleCount 篇新文章',
    );
  }

  /// 显示批量新内容通知
  Future<void> showBatchNotification({
    required int totalCount,
    required int feedCount,
    required bool showNotifications,
  }) async {
    if (!Platform.isWindows || !showNotifications) return;

    final trayService = SystemTrayServiceImpl.instance;
    await trayService.showBatchNotification(
      totalCount: totalCount,
      feedCount: feedCount,
    );
  }

  /// 更新托盘提示文字
  Future<void> _updateTooltip() async {
    if (!Platform.isWindows) return;

    final trayService = SystemTrayServiceImpl.instance;
    await trayService.updateTooltip(state.tooltipText);
  }

  /// 释放资源
  Future<void> dispose() async {
    if (!Platform.isWindows) return;

    final trayService = SystemTrayServiceImpl.instance;
    await trayService.dispose();
  }
}
