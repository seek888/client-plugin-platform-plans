// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tray_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TraySettings _$TraySettingsFromJson(Map<String, dynamic> json) {
  return _TraySettings.fromJson(json);
}

/// @nodoc
mixin _$TraySettings {
  /// 启动时最小化到托盘
  /// Requirements: 6.2
  bool get startMinimized => throw _privateConstructorUsedError;

  /// 关闭时最小化到托盘（而非退出）
  /// Requirements: 6.3
  bool get closeToTray => throw _privateConstructorUsedError;

  /// 显示桌面通知
  /// Requirements: 6.4
  bool get showNotifications => throw _privateConstructorUsedError;

  /// Serializes this TraySettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TraySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TraySettingsCopyWith<TraySettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TraySettingsCopyWith<$Res> {
  factory $TraySettingsCopyWith(
    TraySettings value,
    $Res Function(TraySettings) then,
  ) = _$TraySettingsCopyWithImpl<$Res, TraySettings>;
  @useResult
  $Res call({bool startMinimized, bool closeToTray, bool showNotifications});
}

/// @nodoc
class _$TraySettingsCopyWithImpl<$Res, $Val extends TraySettings>
    implements $TraySettingsCopyWith<$Res> {
  _$TraySettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TraySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startMinimized = null,
    Object? closeToTray = null,
    Object? showNotifications = null,
  }) {
    return _then(
      _value.copyWith(
            startMinimized: null == startMinimized
                ? _value.startMinimized
                : startMinimized // ignore: cast_nullable_to_non_nullable
                      as bool,
            closeToTray: null == closeToTray
                ? _value.closeToTray
                : closeToTray // ignore: cast_nullable_to_non_nullable
                      as bool,
            showNotifications: null == showNotifications
                ? _value.showNotifications
                : showNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TraySettingsImplCopyWith<$Res>
    implements $TraySettingsCopyWith<$Res> {
  factory _$$TraySettingsImplCopyWith(
    _$TraySettingsImpl value,
    $Res Function(_$TraySettingsImpl) then,
  ) = __$$TraySettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool startMinimized, bool closeToTray, bool showNotifications});
}

/// @nodoc
class __$$TraySettingsImplCopyWithImpl<$Res>
    extends _$TraySettingsCopyWithImpl<$Res, _$TraySettingsImpl>
    implements _$$TraySettingsImplCopyWith<$Res> {
  __$$TraySettingsImplCopyWithImpl(
    _$TraySettingsImpl _value,
    $Res Function(_$TraySettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TraySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startMinimized = null,
    Object? closeToTray = null,
    Object? showNotifications = null,
  }) {
    return _then(
      _$TraySettingsImpl(
        startMinimized: null == startMinimized
            ? _value.startMinimized
            : startMinimized // ignore: cast_nullable_to_non_nullable
                  as bool,
        closeToTray: null == closeToTray
            ? _value.closeToTray
            : closeToTray // ignore: cast_nullable_to_non_nullable
                  as bool,
        showNotifications: null == showNotifications
            ? _value.showNotifications
            : showNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TraySettingsImpl implements _TraySettings {
  const _$TraySettingsImpl({
    this.startMinimized = false,
    this.closeToTray = true,
    this.showNotifications = true,
  });

  factory _$TraySettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TraySettingsImplFromJson(json);

  /// 启动时最小化到托盘
  /// Requirements: 6.2
  @override
  @JsonKey()
  final bool startMinimized;

  /// 关闭时最小化到托盘（而非退出）
  /// Requirements: 6.3
  @override
  @JsonKey()
  final bool closeToTray;

  /// 显示桌面通知
  /// Requirements: 6.4
  @override
  @JsonKey()
  final bool showNotifications;

  @override
  String toString() {
    return 'TraySettings(startMinimized: $startMinimized, closeToTray: $closeToTray, showNotifications: $showNotifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TraySettingsImpl &&
            (identical(other.startMinimized, startMinimized) ||
                other.startMinimized == startMinimized) &&
            (identical(other.closeToTray, closeToTray) ||
                other.closeToTray == closeToTray) &&
            (identical(other.showNotifications, showNotifications) ||
                other.showNotifications == showNotifications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startMinimized, closeToTray, showNotifications);

  /// Create a copy of TraySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TraySettingsImplCopyWith<_$TraySettingsImpl> get copyWith =>
      __$$TraySettingsImplCopyWithImpl<_$TraySettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TraySettingsImplToJson(this);
  }
}

abstract class _TraySettings implements TraySettings {
  const factory _TraySettings({
    final bool startMinimized,
    final bool closeToTray,
    final bool showNotifications,
  }) = _$TraySettingsImpl;

  factory _TraySettings.fromJson(Map<String, dynamic> json) =
      _$TraySettingsImpl.fromJson;

  /// 启动时最小化到托盘
  /// Requirements: 6.2
  @override
  bool get startMinimized;

  /// 关闭时最小化到托盘（而非退出）
  /// Requirements: 6.3
  @override
  bool get closeToTray;

  /// 显示桌面通知
  /// Requirements: 6.4
  @override
  bool get showNotifications;

  /// Create a copy of TraySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TraySettingsImplCopyWith<_$TraySettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
