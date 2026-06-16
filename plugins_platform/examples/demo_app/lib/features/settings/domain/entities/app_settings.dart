import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

/// 刷新频率选项
enum RefreshFrequency {
  /// 手动刷新
  manual(0, '手动'),

  /// 每15分钟
  minutes15(15, '15分钟'),

  /// 每30分钟
  minutes30(30, '30分钟'),

  /// 每小时
  hourly(60, '1小时'),

  /// 每2小时
  hours2(120, '2小时'),

  /// 每6小时
  hours6(360, '6小时'),

  /// 每12小时
  hours12(720, '12小时'),

  /// 每天
  daily(1440, '每天');

  const RefreshFrequency(this.minutes, this.label);

  /// 刷新间隔（分钟），0表示手动刷新
  final int minutes;

  /// 显示标签
  final String label;

  /// 是否为自动刷新
  bool get isAutoRefresh => minutes > 0;
}

/// 字体大小选项
enum FontSizeOption {
  /// 小
  small(0.85, '小'),

  /// 标准
  medium(1.0, '标准'),

  /// 大
  large(1.15, '大'),

  /// 特大
  extraLarge(1.3, '特大');

  const FontSizeOption(this.scale, this.label);

  /// 字体缩放比例
  final double scale;

  /// 显示标签
  final String label;
}

/// 应用设置
@freezed
class AppSettings with _$AppSettings {
  const AppSettings._();

  const factory AppSettings({
    /// 主题模式
    @Default(ThemeMode.system) ThemeMode themeMode,

    /// 字体大小选项
    @Default(FontSizeOption.medium) FontSizeOption fontSize,

    /// 是否启用无图模式
    @Default(false) bool noImageMode,

    /// 刷新频率
    @Default(RefreshFrequency.minutes30) RefreshFrequency refreshFrequency,

    /// 是否启用自动标记已读（滚动超过50%）
    @Default(true) bool autoMarkAsRead,

    /// 是否启用滑动手势
    @Default(true) bool swipeGesturesEnabled,

    /// 是否显示文章摘要
    @Default(true) bool showArticleSummary,

    /// 是否启用通知
    @Default(true) bool notificationsEnabled,

    /// 阅读页行间距倍数
    @Default(1.5) double lineHeight,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);

  /// 获取字体缩放比例
  double get fontScale => fontSize.scale;

  /// 是否为自动刷新
  bool get isAutoRefresh => refreshFrequency.isAutoRefresh;

  /// 获取刷新间隔（分钟）
  int get refreshIntervalMinutes => refreshFrequency.minutes;

  /// 主题模式显示名称
  String get themeModeLabel {
    switch (themeMode) {
      case ThemeMode.system:
        return '跟随系统';
      case ThemeMode.light:
        return '浅色';
      case ThemeMode.dark:
        return '深色';
    }
  }
}
