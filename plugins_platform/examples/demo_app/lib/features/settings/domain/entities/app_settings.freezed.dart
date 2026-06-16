// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
  /// 主题模式
  ThemeMode get themeMode => throw _privateConstructorUsedError;

  /// 字体大小选项
  FontSizeOption get fontSize => throw _privateConstructorUsedError;

  /// 是否启用无图模式
  bool get noImageMode => throw _privateConstructorUsedError;

  /// 刷新频率
  RefreshFrequency get refreshFrequency => throw _privateConstructorUsedError;

  /// 是否启用自动标记已读（滚动超过50%）
  bool get autoMarkAsRead => throw _privateConstructorUsedError;

  /// 是否启用滑动手势
  bool get swipeGesturesEnabled => throw _privateConstructorUsedError;

  /// 是否显示文章摘要
  bool get showArticleSummary => throw _privateConstructorUsedError;

  /// 是否启用通知
  bool get notificationsEnabled => throw _privateConstructorUsedError;

  /// 阅读页行间距倍数
  double get lineHeight => throw _privateConstructorUsedError;

  /// Serializes this AppSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
    AppSettings value,
    $Res Function(AppSettings) then,
  ) = _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call({
    ThemeMode themeMode,
    FontSizeOption fontSize,
    bool noImageMode,
    RefreshFrequency refreshFrequency,
    bool autoMarkAsRead,
    bool swipeGesturesEnabled,
    bool showArticleSummary,
    bool notificationsEnabled,
    double lineHeight,
  });
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? fontSize = null,
    Object? noImageMode = null,
    Object? refreshFrequency = null,
    Object? autoMarkAsRead = null,
    Object? swipeGesturesEnabled = null,
    Object? showArticleSummary = null,
    Object? notificationsEnabled = null,
    Object? lineHeight = null,
  }) {
    return _then(
      _value.copyWith(
            themeMode: null == themeMode
                ? _value.themeMode
                : themeMode // ignore: cast_nullable_to_non_nullable
                      as ThemeMode,
            fontSize: null == fontSize
                ? _value.fontSize
                : fontSize // ignore: cast_nullable_to_non_nullable
                      as FontSizeOption,
            noImageMode: null == noImageMode
                ? _value.noImageMode
                : noImageMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            refreshFrequency: null == refreshFrequency
                ? _value.refreshFrequency
                : refreshFrequency // ignore: cast_nullable_to_non_nullable
                      as RefreshFrequency,
            autoMarkAsRead: null == autoMarkAsRead
                ? _value.autoMarkAsRead
                : autoMarkAsRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            swipeGesturesEnabled: null == swipeGesturesEnabled
                ? _value.swipeGesturesEnabled
                : swipeGesturesEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            showArticleSummary: null == showArticleSummary
                ? _value.showArticleSummary
                : showArticleSummary // ignore: cast_nullable_to_non_nullable
                      as bool,
            notificationsEnabled: null == notificationsEnabled
                ? _value.notificationsEnabled
                : notificationsEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            lineHeight: null == lineHeight
                ? _value.lineHeight
                : lineHeight // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
    _$AppSettingsImpl value,
    $Res Function(_$AppSettingsImpl) then,
  ) = __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ThemeMode themeMode,
    FontSizeOption fontSize,
    bool noImageMode,
    RefreshFrequency refreshFrequency,
    bool autoMarkAsRead,
    bool swipeGesturesEnabled,
    bool showArticleSummary,
    bool notificationsEnabled,
    double lineHeight,
  });
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
    _$AppSettingsImpl _value,
    $Res Function(_$AppSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? fontSize = null,
    Object? noImageMode = null,
    Object? refreshFrequency = null,
    Object? autoMarkAsRead = null,
    Object? swipeGesturesEnabled = null,
    Object? showArticleSummary = null,
    Object? notificationsEnabled = null,
    Object? lineHeight = null,
  }) {
    return _then(
      _$AppSettingsImpl(
        themeMode: null == themeMode
            ? _value.themeMode
            : themeMode // ignore: cast_nullable_to_non_nullable
                  as ThemeMode,
        fontSize: null == fontSize
            ? _value.fontSize
            : fontSize // ignore: cast_nullable_to_non_nullable
                  as FontSizeOption,
        noImageMode: null == noImageMode
            ? _value.noImageMode
            : noImageMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        refreshFrequency: null == refreshFrequency
            ? _value.refreshFrequency
            : refreshFrequency // ignore: cast_nullable_to_non_nullable
                  as RefreshFrequency,
        autoMarkAsRead: null == autoMarkAsRead
            ? _value.autoMarkAsRead
            : autoMarkAsRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        swipeGesturesEnabled: null == swipeGesturesEnabled
            ? _value.swipeGesturesEnabled
            : swipeGesturesEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        showArticleSummary: null == showArticleSummary
            ? _value.showArticleSummary
            : showArticleSummary // ignore: cast_nullable_to_non_nullable
                  as bool,
        notificationsEnabled: null == notificationsEnabled
            ? _value.notificationsEnabled
            : notificationsEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        lineHeight: null == lineHeight
            ? _value.lineHeight
            : lineHeight // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSettingsImpl extends _AppSettings {
  const _$AppSettingsImpl({
    this.themeMode = ThemeMode.system,
    this.fontSize = FontSizeOption.medium,
    this.noImageMode = false,
    this.refreshFrequency = RefreshFrequency.minutes30,
    this.autoMarkAsRead = true,
    this.swipeGesturesEnabled = true,
    this.showArticleSummary = true,
    this.notificationsEnabled = true,
    this.lineHeight = 1.5,
  }) : super._();

  factory _$AppSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingsImplFromJson(json);

  /// 主题模式
  @override
  @JsonKey()
  final ThemeMode themeMode;

  /// 字体大小选项
  @override
  @JsonKey()
  final FontSizeOption fontSize;

  /// 是否启用无图模式
  @override
  @JsonKey()
  final bool noImageMode;

  /// 刷新频率
  @override
  @JsonKey()
  final RefreshFrequency refreshFrequency;

  /// 是否启用自动标记已读（滚动超过50%）
  @override
  @JsonKey()
  final bool autoMarkAsRead;

  /// 是否启用滑动手势
  @override
  @JsonKey()
  final bool swipeGesturesEnabled;

  /// 是否显示文章摘要
  @override
  @JsonKey()
  final bool showArticleSummary;

  /// 是否启用通知
  @override
  @JsonKey()
  final bool notificationsEnabled;

  /// 阅读页行间距倍数
  @override
  @JsonKey()
  final double lineHeight;

  @override
  String toString() {
    return 'AppSettings(themeMode: $themeMode, fontSize: $fontSize, noImageMode: $noImageMode, refreshFrequency: $refreshFrequency, autoMarkAsRead: $autoMarkAsRead, swipeGesturesEnabled: $swipeGesturesEnabled, showArticleSummary: $showArticleSummary, notificationsEnabled: $notificationsEnabled, lineHeight: $lineHeight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.noImageMode, noImageMode) ||
                other.noImageMode == noImageMode) &&
            (identical(other.refreshFrequency, refreshFrequency) ||
                other.refreshFrequency == refreshFrequency) &&
            (identical(other.autoMarkAsRead, autoMarkAsRead) ||
                other.autoMarkAsRead == autoMarkAsRead) &&
            (identical(other.swipeGesturesEnabled, swipeGesturesEnabled) ||
                other.swipeGesturesEnabled == swipeGesturesEnabled) &&
            (identical(other.showArticleSummary, showArticleSummary) ||
                other.showArticleSummary == showArticleSummary) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.lineHeight, lineHeight) ||
                other.lineHeight == lineHeight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    themeMode,
    fontSize,
    noImageMode,
    refreshFrequency,
    autoMarkAsRead,
    swipeGesturesEnabled,
    showArticleSummary,
    notificationsEnabled,
    lineHeight,
  );

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSettingsImplToJson(this);
  }
}

abstract class _AppSettings extends AppSettings {
  const factory _AppSettings({
    final ThemeMode themeMode,
    final FontSizeOption fontSize,
    final bool noImageMode,
    final RefreshFrequency refreshFrequency,
    final bool autoMarkAsRead,
    final bool swipeGesturesEnabled,
    final bool showArticleSummary,
    final bool notificationsEnabled,
    final double lineHeight,
  }) = _$AppSettingsImpl;
  const _AppSettings._() : super._();

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$AppSettingsImpl.fromJson;

  /// 主题模式
  @override
  ThemeMode get themeMode;

  /// 字体大小选项
  @override
  FontSizeOption get fontSize;

  /// 是否启用无图模式
  @override
  bool get noImageMode;

  /// 刷新频率
  @override
  RefreshFrequency get refreshFrequency;

  /// 是否启用自动标记已读（滚动超过50%）
  @override
  bool get autoMarkAsRead;

  /// 是否启用滑动手势
  @override
  bool get swipeGesturesEnabled;

  /// 是否显示文章摘要
  @override
  bool get showArticleSummary;

  /// 是否启用通知
  @override
  bool get notificationsEnabled;

  /// 阅读页行间距倍数
  @override
  double get lineHeight;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
