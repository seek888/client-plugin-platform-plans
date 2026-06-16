// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      themeMode:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      fontSize:
          $enumDecodeNullable(_$FontSizeOptionEnumMap, json['fontSize']) ??
          FontSizeOption.medium,
      noImageMode: json['noImageMode'] as bool? ?? false,
      refreshFrequency:
          $enumDecodeNullable(
            _$RefreshFrequencyEnumMap,
            json['refreshFrequency'],
          ) ??
          RefreshFrequency.minutes30,
      autoMarkAsRead: json['autoMarkAsRead'] as bool? ?? true,
      swipeGesturesEnabled: json['swipeGesturesEnabled'] as bool? ?? true,
      showArticleSummary: json['showArticleSummary'] as bool? ?? true,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      lineHeight: (json['lineHeight'] as num?)?.toDouble() ?? 1.5,
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'fontSize': _$FontSizeOptionEnumMap[instance.fontSize]!,
      'noImageMode': instance.noImageMode,
      'refreshFrequency': _$RefreshFrequencyEnumMap[instance.refreshFrequency]!,
      'autoMarkAsRead': instance.autoMarkAsRead,
      'swipeGesturesEnabled': instance.swipeGesturesEnabled,
      'showArticleSummary': instance.showArticleSummary,
      'notificationsEnabled': instance.notificationsEnabled,
      'lineHeight': instance.lineHeight,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$FontSizeOptionEnumMap = {
  FontSizeOption.small: 'small',
  FontSizeOption.medium: 'medium',
  FontSizeOption.large: 'large',
  FontSizeOption.extraLarge: 'extraLarge',
};

const _$RefreshFrequencyEnumMap = {
  RefreshFrequency.manual: 'manual',
  RefreshFrequency.minutes15: 'minutes15',
  RefreshFrequency.minutes30: 'minutes30',
  RefreshFrequency.hourly: 'hourly',
  RefreshFrequency.hours2: 'hours2',
  RefreshFrequency.hours6: 'hours6',
  RefreshFrequency.hours12: 'hours12',
  RefreshFrequency.daily: 'daily',
};
