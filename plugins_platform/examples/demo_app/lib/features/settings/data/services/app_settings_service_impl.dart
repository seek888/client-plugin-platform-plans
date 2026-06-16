import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rss_reader/features/settings/domain/entities/app_settings.dart';
import 'package:rss_reader/features/settings/domain/services/app_settings_service.dart';

/// 应用设置服务实现
///
/// 使用内存存储设置，实际应用中应该使用 SharedPreferences 持久化
class AppSettingsServiceImpl implements AppSettingsService {
  /// 当前设置
  AppSettings _settings;

  /// 设置变化流控制器
  final _settingsController = StreamController<AppSettings>.broadcast();

  AppSettingsServiceImpl({AppSettings? initialSettings})
    : _settings = initialSettings ?? const AppSettings();

  @override
  AppSettings getSettings() => _settings;

  @override
  Future<void> updateSettings(AppSettings settings) async {
    _settings = settings;
    _settingsController.add(_settings);
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    await updateSettings(_settings.copyWith(themeMode: mode));
  }

  @override
  Future<void> setFontSize(FontSizeOption size) async {
    await updateSettings(_settings.copyWith(fontSize: size));
  }

  @override
  Future<void> setNoImageMode(bool enabled) async {
    await updateSettings(_settings.copyWith(noImageMode: enabled));
  }

  @override
  Future<void> setRefreshFrequency(RefreshFrequency frequency) async {
    await updateSettings(_settings.copyWith(refreshFrequency: frequency));
  }

  @override
  Future<void> setAutoMarkAsRead(bool enabled) async {
    await updateSettings(_settings.copyWith(autoMarkAsRead: enabled));
  }

  @override
  Future<void> setSwipeGesturesEnabled(bool enabled) async {
    await updateSettings(_settings.copyWith(swipeGesturesEnabled: enabled));
  }

  @override
  Future<void> setShowArticleSummary(bool enabled) async {
    await updateSettings(_settings.copyWith(showArticleSummary: enabled));
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    await updateSettings(_settings.copyWith(notificationsEnabled: enabled));
  }

  @override
  Future<void> setLineHeight(double height) async {
    // 限制行间距范围在 1.0 到 2.0 之间
    final clampedHeight = height.clamp(1.0, 2.0);
    await updateSettings(_settings.copyWith(lineHeight: clampedHeight));
  }

  @override
  Future<void> resetToDefaults() async {
    await updateSettings(const AppSettings());
  }

  @override
  Stream<AppSettings> watchSettings() => _settingsController.stream;

  /// 释放资源
  void dispose() {
    _settingsController.close();
  }
}
