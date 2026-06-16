// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'window_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WindowSettingsImpl _$$WindowSettingsImplFromJson(Map<String, dynamic> json) =>
    _$WindowSettingsImpl(
      width: (json['width'] as num?)?.toDouble() ?? 1280,
      height: (json['height'] as num?)?.toDouble() ?? 800,
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
      isMaximized: json['isMaximized'] as bool? ?? false,
      isFullScreen: json['isFullScreen'] as bool? ?? false,
    );

Map<String, dynamic> _$$WindowSettingsImplToJson(
  _$WindowSettingsImpl instance,
) => <String, dynamic>{
  'width': instance.width,
  'height': instance.height,
  'x': instance.x,
  'y': instance.y,
  'isMaximized': instance.isMaximized,
  'isFullScreen': instance.isFullScreen,
};
