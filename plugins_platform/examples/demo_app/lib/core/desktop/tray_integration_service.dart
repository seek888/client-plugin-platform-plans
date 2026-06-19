import 'dart:async';
import 'dart:io';

import 'package:rss_reader/core/desktop/system_tray_service_impl.dart';
import 'package:rss_reader/core/desktop/tray_state.dart';
import 'package:rss_reader/features/settings/domain/entities/tray_settings.dart';

/// 托盘集成服务
///
/// 负责将系统托盘与应用其他服务（同步、通知等）集成
/// Requirements: 2.4, 5.2, 5.3, 5.4, 3.1, 3.4
class TrayIntegrationService {
  TrayIntegrationService._();

  static final TrayIntegrationService _instance = TrayIntegrationService._();
  static TrayIntegrationService get instance => _instance;

  TrayState _state = const TrayState();
  TraySettings _settings = const TraySettings();

  /// 获取当前状态
  TrayState get state => _state;

  /// 设置同步回调
  set onSyncRequested(void Function()? callback) {
    if (Platform.isWindows) {
      SystemTrayServiceImpl.instance.onSyncRequested = callback;
    }
  }

  /// 设置设置页面回调
  set onSettingsRequested(void Function()? callback) {
    if (Platform.isWindows) {
      SystemTrayServiceImpl.instance.onSettingsRequested = callback;
    }
  }

  /// 更新托盘设置
  void updateSettings(TraySettings settings) {
    _settings = settings;
  }

  /// 设置同步状态
  /// Requirements: 5.2
  Future<void> setSyncing(bool isSyncing) async {
    _state = _state.copyWith(isSyncing: isSyncing);
    await _updateTooltip();
  }

  /// 设置最后同步时间
  /// Requirements: 5.3
  Future<void> setLastSyncTime(DateTime time) async {
    _state = _state.copyWith(
      lastSyncTime: time,
      errorMessage: null,
    );
    await _updateTooltip();
  }

  /// 设置错误信息
  /// Requirements: 5.4
  Future<void> setError(String? error) async {
    _state = _state.copyWith(errorMessage: error);
    await _updateTooltip();
  }

  /// 设置未读数量
  /// Requirements: 5.1
  Future<void> setUnreadCount(int count) async {
    _state = _state.copyWith(unreadCount: count);
    await _updateTooltip();
  }

  /// 显示新内容通知
  /// Requirements: 3.1, 3.2
  Future<void> showNewContentNotification({
    required String feedTitle,
    required int articleCount,
  }) async {
    if (!Platform.isWindows || !_settings.showNotifications) return;

    final trayService = SystemTrayServiceImpl.instance;
    await trayService.showNotification(
      title: '新内容更新',
      body: '$feedTitle 有 $articleCount 篇新文章',
    );
  }

  /// 显示批量新内容通知
  /// Requirements: 3.4
  Future<void> showBatchNotification({
    required int totalCount,
    required int feedCount,
  }) async {
    if (!Platform.isWindows || !_settings.showNotifications) return;

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
    await trayService.updateTooltip(_state.tooltipText);
  }
}
