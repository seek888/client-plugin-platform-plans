import 'package:flutter/material.dart';
import 'package:rss_reader/features/settings/domain/entities/app_settings.dart';

/// 应用设置服务接口
abstract class AppSettingsService {
  /// 获取当前应用设置
  AppSettings getSettings();

  /// 更新应用设置
  Future<void> updateSettings(AppSettings settings);

  /// 设置主题模式
  Future<void> setThemeMode(ThemeMode mode);

  /// 设置字体大小
  Future<void> setFontSize(FontSizeOption size);

  /// 设置无图模式
  Future<void> setNoImageMode(bool enabled);

  /// 设置刷新频率
  Future<void> setRefreshFrequency(RefreshFrequency frequency);

  /// 设置自动标记已读
  Future<void> setAutoMarkAsRead(bool enabled);

  /// 设置滑动手势
  Future<void> setSwipeGesturesEnabled(bool enabled);

  /// 设置显示文章摘要
  Future<void> setShowArticleSummary(bool enabled);

  /// 设置通知开关
  Future<void> setNotificationsEnabled(bool enabled);

  /// 设置行间距
  Future<void> setLineHeight(double height);

  /// 重置为默认设置
  Future<void> resetToDefaults();

  /// 监听设置变化
  Stream<AppSettings> watchSettings();
}
