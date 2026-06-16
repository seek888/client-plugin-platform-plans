// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tray_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TraySettingsImpl _$$TraySettingsImplFromJson(Map<String, dynamic> json) =>
    _$TraySettingsImpl(
      startMinimized: json['startMinimized'] as bool? ?? false,
      closeToTray: json['closeToTray'] as bool? ?? true,
      showNotifications: json['showNotifications'] as bool? ?? true,
    );

Map<String, dynamic> _$$TraySettingsImplToJson(_$TraySettingsImpl instance) =>
    <String, dynamic>{
      'startMinimized': instance.startMinimized,
      'closeToTray': instance.closeToTray,
      'showNotifications': instance.showNotifications,
    };
