import 'package:freezed_annotation/freezed_annotation.dart';

part 'window_settings.freezed.dart';
part 'window_settings.g.dart';

/// 桌面端窗口设置
@freezed
class WindowSettings with _$WindowSettings {
  const WindowSettings._();

  const factory WindowSettings({
    /// 窗口宽度
    @Default(1280) double width,

    /// 窗口高度
    @Default(800) double height,

    /// 窗口X坐标（null表示居中）
    double? x,

    /// 窗口Y坐标（null表示居中）
    double? y,

    /// 是否最大化
    @Default(false) bool isMaximized,

    /// 是否全屏
    @Default(false) bool isFullScreen,
  }) = _WindowSettings;

  factory WindowSettings.fromJson(Map<String, dynamic> json) =>
      _$WindowSettingsFromJson(json);

  /// 默认设置
  static const WindowSettings defaultSettings = WindowSettings();

  /// 最小窗口宽度
  static const double minWidth = 800;

  /// 最小窗口高度
  static const double minHeight = 600;

  /// 是否有保存的位置
  bool get hasPosition => x != null && y != null;
}
