import 'package:freezed_annotation/freezed_annotation.dart';

part 'tray_settings.freezed.dart';
part 'tray_settings.g.dart';

/// 系统托盘设置
///
/// 定义 Windows 系统托盘的行为配置
/// Requirements: 6.1, 6.2, 6.3, 6.4
@freezed
class TraySettings with _$TraySettings {
  const factory TraySettings({
    /// 启动时最小化到托盘
    /// Requirements: 6.2
    @Default(false) bool startMinimized,

    /// 关闭时最小化到托盘（而非退出）
    /// Requirements: 6.3
    @Default(true) bool closeToTray,

    /// 显示桌面通知
    /// Requirements: 6.4
    @Default(true) bool showNotifications,
  }) = _TraySettings;

  factory TraySettings.fromJson(Map<String, dynamic> json) =>
      _$TraySettingsFromJson(json);
}
