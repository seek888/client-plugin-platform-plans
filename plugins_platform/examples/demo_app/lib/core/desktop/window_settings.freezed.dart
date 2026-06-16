// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'window_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WindowSettings _$WindowSettingsFromJson(Map<String, dynamic> json) {
  return _WindowSettings.fromJson(json);
}

/// @nodoc
mixin _$WindowSettings {
  /// 窗口宽度
  double get width => throw _privateConstructorUsedError;

  /// 窗口高度
  double get height => throw _privateConstructorUsedError;

  /// 窗口X坐标（null表示居中）
  double? get x => throw _privateConstructorUsedError;

  /// 窗口Y坐标（null表示居中）
  double? get y => throw _privateConstructorUsedError;

  /// 是否最大化
  bool get isMaximized => throw _privateConstructorUsedError;

  /// 是否全屏
  bool get isFullScreen => throw _privateConstructorUsedError;

  /// Serializes this WindowSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WindowSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WindowSettingsCopyWith<WindowSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WindowSettingsCopyWith<$Res> {
  factory $WindowSettingsCopyWith(
    WindowSettings value,
    $Res Function(WindowSettings) then,
  ) = _$WindowSettingsCopyWithImpl<$Res, WindowSettings>;
  @useResult
  $Res call({
    double width,
    double height,
    double? x,
    double? y,
    bool isMaximized,
    bool isFullScreen,
  });
}

/// @nodoc
class _$WindowSettingsCopyWithImpl<$Res, $Val extends WindowSettings>
    implements $WindowSettingsCopyWith<$Res> {
  _$WindowSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WindowSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? x = freezed,
    Object? y = freezed,
    Object? isMaximized = null,
    Object? isFullScreen = null,
  }) {
    return _then(
      _value.copyWith(
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as double,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as double,
            x: freezed == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                      as double?,
            y: freezed == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                      as double?,
            isMaximized: null == isMaximized
                ? _value.isMaximized
                : isMaximized // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFullScreen: null == isFullScreen
                ? _value.isFullScreen
                : isFullScreen // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WindowSettingsImplCopyWith<$Res>
    implements $WindowSettingsCopyWith<$Res> {
  factory _$$WindowSettingsImplCopyWith(
    _$WindowSettingsImpl value,
    $Res Function(_$WindowSettingsImpl) then,
  ) = __$$WindowSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double width,
    double height,
    double? x,
    double? y,
    bool isMaximized,
    bool isFullScreen,
  });
}

/// @nodoc
class __$$WindowSettingsImplCopyWithImpl<$Res>
    extends _$WindowSettingsCopyWithImpl<$Res, _$WindowSettingsImpl>
    implements _$$WindowSettingsImplCopyWith<$Res> {
  __$$WindowSettingsImplCopyWithImpl(
    _$WindowSettingsImpl _value,
    $Res Function(_$WindowSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WindowSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? x = freezed,
    Object? y = freezed,
    Object? isMaximized = null,
    Object? isFullScreen = null,
  }) {
    return _then(
      _$WindowSettingsImpl(
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as double,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as double,
        x: freezed == x
            ? _value.x
            : x // ignore: cast_nullable_to_non_nullable
                  as double?,
        y: freezed == y
            ? _value.y
            : y // ignore: cast_nullable_to_non_nullable
                  as double?,
        isMaximized: null == isMaximized
            ? _value.isMaximized
            : isMaximized // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFullScreen: null == isFullScreen
            ? _value.isFullScreen
            : isFullScreen // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WindowSettingsImpl extends _WindowSettings {
  const _$WindowSettingsImpl({
    this.width = 1280,
    this.height = 800,
    this.x,
    this.y,
    this.isMaximized = false,
    this.isFullScreen = false,
  }) : super._();

  factory _$WindowSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$WindowSettingsImplFromJson(json);

  /// 窗口宽度
  @override
  @JsonKey()
  final double width;

  /// 窗口高度
  @override
  @JsonKey()
  final double height;

  /// 窗口X坐标（null表示居中）
  @override
  final double? x;

  /// 窗口Y坐标（null表示居中）
  @override
  final double? y;

  /// 是否最大化
  @override
  @JsonKey()
  final bool isMaximized;

  /// 是否全屏
  @override
  @JsonKey()
  final bool isFullScreen;

  @override
  String toString() {
    return 'WindowSettings(width: $width, height: $height, x: $x, y: $y, isMaximized: $isMaximized, isFullScreen: $isFullScreen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WindowSettingsImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.isMaximized, isMaximized) ||
                other.isMaximized == isMaximized) &&
            (identical(other.isFullScreen, isFullScreen) ||
                other.isFullScreen == isFullScreen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, width, height, x, y, isMaximized, isFullScreen);

  /// Create a copy of WindowSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WindowSettingsImplCopyWith<_$WindowSettingsImpl> get copyWith =>
      __$$WindowSettingsImplCopyWithImpl<_$WindowSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WindowSettingsImplToJson(this);
  }
}

abstract class _WindowSettings extends WindowSettings {
  const factory _WindowSettings({
    final double width,
    final double height,
    final double? x,
    final double? y,
    final bool isMaximized,
    final bool isFullScreen,
  }) = _$WindowSettingsImpl;
  const _WindowSettings._() : super._();

  factory _WindowSettings.fromJson(Map<String, dynamic> json) =
      _$WindowSettingsImpl.fromJson;

  /// 窗口宽度
  @override
  double get width;

  /// 窗口高度
  @override
  double get height;

  /// 窗口X坐标（null表示居中）
  @override
  double? get x;

  /// 窗口Y坐标（null表示居中）
  @override
  double? get y;

  /// 是否最大化
  @override
  bool get isMaximized;

  /// 是否全屏
  @override
  bool get isFullScreen;

  /// Create a copy of WindowSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WindowSettingsImplCopyWith<_$WindowSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
