// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageSettingsImpl _$$ImageSettingsImplFromJson(Map<String, dynamic> json) =>
    _$ImageSettingsImpl(
      loadingMode:
          $enumDecodeNullable(_$ImageLoadingModeEnumMap, json['loadingMode']) ??
          ImageLoadingMode.always,
      lazyLoadEnabled: json['lazyLoadEnabled'] as bool? ?? true,
      showPlaceholderOnError: json['showPlaceholderOnError'] as bool? ?? true,
      cacheSizeLimitMB: (json['cacheSizeLimitMB'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$ImageSettingsImplToJson(_$ImageSettingsImpl instance) =>
    <String, dynamic>{
      'loadingMode': _$ImageLoadingModeEnumMap[instance.loadingMode]!,
      'lazyLoadEnabled': instance.lazyLoadEnabled,
      'showPlaceholderOnError': instance.showPlaceholderOnError,
      'cacheSizeLimitMB': instance.cacheSizeLimitMB,
    };

const _$ImageLoadingModeEnumMap = {
  ImageLoadingMode.always: 'always',
  ImageLoadingMode.wifiOnly: 'wifiOnly',
  ImageLoadingMode.never: 'never',
};
