import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/app/theme/app_theme.dart';
import 'package:rss_reader/features/settings/data/services/app_settings_service_impl.dart';
import 'package:rss_reader/features/settings/domain/entities/app_settings.dart';
import 'package:rss_reader/features/settings/domain/services/app_settings_service.dart';

part 'app_settings_provider.g.dart';

/// 应用设置服务 Provider
@riverpod
AppSettingsService appSettingsService(Ref ref) {
  final service = AppSettingsServiceImpl();
  ref.onDispose(() => service.dispose());
  return service;
}

/// 应用设置状态 Notifier
@riverpod
class AppSettingsNotifier extends _$AppSettingsNotifier {
  @override
  AppSettings build() {
    final service = ref.watch(appSettingsServiceProvider);

    // 监听设置变化
    final subscription = service.watchSettings().listen((settings) {
      state = settings;
      // 同步主题模式到全局 Provider
      _syncThemeMode(settings.themeMode);
      // 同步字体缩放到全局 Provider
      _syncFontScale(settings.fontScale);
    });

    ref.onDispose(() => subscription.cancel());

    final settings = service.getSettings();
    // 初始化时同步主题和字体
    _syncThemeMode(settings.themeMode);
    _syncFontScale(settings.fontScale);

    return settings;
  }

  /// 同步主题模式到全局 Provider
  void _syncThemeMode(ThemeMode mode) {
    ref.read(themeModeProvider.notifier).state = mode;
  }

  /// 同步字体缩放到全局 Provider
  void _syncFontScale(double scale) {
    ref.read(fontScaleProvider.notifier).state = scale;
  }

  /// 设置主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    final service = ref.read(appSettingsServiceProvider);
    await service.setThemeMode(mode);
    state = service.getSettings();
  }

  /// 设置字体大小
  Future<void> setFontSize(FontSizeOption size) async {
    final service = ref.read(appSettingsServiceProvider);
    await service.setFontSize(size);
    state = service.getSettings();
  }

  /// 设置无图模式
  Future<void> setNoImageMode(bool enabled) async {
    final service = ref.read(appSettingsServiceProvider);
    await service.setNoImageMode(enabled);
    state = service.getSettings();
  }

  /// 设置刷新频率
  Future<void> setRefreshFrequency(RefreshFrequency frequency) async {
    final service = ref.read(appSettingsServiceProvider);
    await service.setRefreshFrequency(frequency);
    state = service.getSettings();
  }

  /// 设置自动标记已读
  Future<void> setAutoMarkAsRead(bool enabled) async {
    final service = ref.read(appSettingsServiceProvider);
    await service.setAutoMarkAsRead(enabled);
    state = service.getSettings();
  }

  /// 设置滑动手势
  Future<void> setSwipeGesturesEnabled(bool enabled) async {
    final service = ref.read(appSettingsServiceProvider);
    await service.setSwipeGesturesEnabled(enabled);
    state = service.getSettings();
  }

  /// 设置显示文章摘要
  Future<void> setShowArticleSummary(bool enabled) async {
    final service = ref.read(appSettingsServiceProvider);
    await service.setShowArticleSummary(enabled);
    state = service.getSettings();
  }

  /// 设置通知开关
  Future<void> setNotificationsEnabled(bool enabled) async {
    final service = ref.read(appSettingsServiceProvider);
    await service.setNotificationsEnabled(enabled);
    state = service.getSettings();
  }

  /// 设置行间距
  Future<void> setLineHeight(double height) async {
    final service = ref.read(appSettingsServiceProvider);
    await service.setLineHeight(height);
    state = service.getSettings();
  }

  /// 重置为默认设置
  Future<void> resetToDefaults() async {
    final service = ref.read(appSettingsServiceProvider);
    await service.resetToDefaults();
    state = service.getSettings();
  }
}

/// 主题模式便捷 Provider
@riverpod
ThemeMode currentThemeMode(Ref ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return settings.themeMode;
}

/// 字体大小便捷 Provider
@riverpod
FontSizeOption currentFontSize(Ref ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return settings.fontSize;
}

/// 无图模式便捷 Provider
@riverpod
bool isNoImageModeEnabled(Ref ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return settings.noImageMode;
}

/// 刷新频率便捷 Provider
@riverpod
RefreshFrequency currentRefreshFrequency(Ref ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return settings.refreshFrequency;
}

/// 字体缩放比例便捷 Provider
@riverpod
double currentFontScale(Ref ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return settings.fontScale;
}

/// 行间距便捷 Provider
@riverpod
double currentLineHeight(Ref ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return settings.lineHeight;
}
