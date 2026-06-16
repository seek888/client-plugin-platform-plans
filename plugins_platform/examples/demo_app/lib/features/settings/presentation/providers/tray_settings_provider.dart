import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/features/settings/domain/entities/tray_settings.dart';

part 'tray_settings_provider.g.dart';

/// 托盘设置 Provider
///
/// 管理托盘设置的读取和保存
/// Requirements: 6.1, 6.5
@riverpod
class TraySettingsNotifier extends _$TraySettingsNotifier {
  static const String _settingsFileName = 'tray_settings.json';

  @override
  Future<TraySettings> build() async {
    return await _loadSettings();
  }

  /// 加载设置
  Future<TraySettings> _loadSettings() async {
    try {
      final file = await _getSettingsFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;
        return TraySettings.fromJson(json);
      }
    } catch (e) {
      debugPrint('Failed to load tray settings: $e');
    }
    return const TraySettings();
  }

  /// 保存设置
  Future<void> _saveSettings(TraySettings settings) async {
    try {
      final file = await _getSettingsFile();
      final json = jsonEncode(settings.toJson());
      await file.writeAsString(json);
    } catch (e) {
      debugPrint('Failed to save tray settings: $e');
    }
  }

  /// 获取设置文件
  Future<File> _getSettingsFile() async {
    final directory = await getApplicationSupportDirectory();
    return File('${directory.path}/$_settingsFileName');
  }

  /// 设置启动时最小化到托盘
  /// Requirements: 6.2
  Future<void> setStartMinimized(bool value) async {
    final current = state.valueOrNull ?? const TraySettings();
    final updated = current.copyWith(startMinimized: value);
    state = AsyncData(updated);
    await _saveSettings(updated);
  }

  /// 设置关闭时最小化到托盘
  /// Requirements: 6.3
  Future<void> setCloseToTray(bool value) async {
    final current = state.valueOrNull ?? const TraySettings();
    final updated = current.copyWith(closeToTray: value);
    state = AsyncData(updated);
    await _saveSettings(updated);
  }

  /// 设置显示桌面通知
  /// Requirements: 6.4
  Future<void> setShowNotifications(bool value) async {
    final current = state.valueOrNull ?? const TraySettings();
    final updated = current.copyWith(showNotifications: value);
    state = AsyncData(updated);
    await _saveSettings(updated);
  }

  /// 更新所有设置
  Future<void> updateSettings(TraySettings settings) async {
    state = AsyncData(settings);
    await _saveSettings(settings);
  }
}
