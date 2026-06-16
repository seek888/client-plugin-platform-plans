// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ImageSettings _$ImageSettingsFromJson(Map<String, dynamic> json) {
  return _ImageSettings.fromJson(json);
}

/// @nodoc
mixin _$ImageSettings {
  /// 图片加载模式
  ImageLoadingMode get loadingMode => throw _privateConstructorUsedError;

  /// 是否启用图片懒加载
  bool get lazyLoadEnabled => throw _privateConstructorUsedError;

  /// 图片加载失败时是否显示占位符
  bool get showPlaceholderOnError => throw _privateConstructorUsedError;

  /// 图片缓存大小限制（MB）
  int get cacheSizeLimitMB => throw _privateConstructorUsedError;

  /// Serializes this ImageSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageSettingsCopyWith<ImageSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageSettingsCopyWith<$Res> {
  factory $ImageSettingsCopyWith(
    ImageSettings value,
    $Res Function(ImageSettings) then,
  ) = _$ImageSettingsCopyWithImpl<$Res, ImageSettings>;
  @useResult
  $Res call({
    ImageLoadingMode loadingMode,
    bool lazyLoadEnabled,
    bool showPlaceholderOnError,
    int cacheSizeLimitMB,
  });
}

/// @nodoc
class _$ImageSettingsCopyWithImpl<$Res, $Val extends ImageSettings>
    implements $ImageSettingsCopyWith<$Res> {
  _$ImageSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingMode = null,
    Object? lazyLoadEnabled = null,
    Object? showPlaceholderOnError = null,
    Object? cacheSizeLimitMB = null,
  }) {
    return _then(
      _value.copyWith(
            loadingMode: null == loadingMode
                ? _value.loadingMode
                : loadingMode // ignore: cast_nullable_to_non_nullable
                      as ImageLoadingMode,
            lazyLoadEnabled: null == lazyLoadEnabled
                ? _value.lazyLoadEnabled
                : lazyLoadEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            showPlaceholderOnError: null == showPlaceholderOnError
                ? _value.showPlaceholderOnError
                : showPlaceholderOnError // ignore: cast_nullable_to_non_nullable
                      as bool,
            cacheSizeLimitMB: null == cacheSizeLimitMB
                ? _value.cacheSizeLimitMB
                : cacheSizeLimitMB // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImageSettingsImplCopyWith<$Res>
    implements $ImageSettingsCopyWith<$Res> {
  factory _$$ImageSettingsImplCopyWith(
    _$ImageSettingsImpl value,
    $Res Function(_$ImageSettingsImpl) then,
  ) = __$$ImageSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ImageLoadingMode loadingMode,
    bool lazyLoadEnabled,
    bool showPlaceholderOnError,
    int cacheSizeLimitMB,
  });
}

/// @nodoc
class __$$ImageSettingsImplCopyWithImpl<$Res>
    extends _$ImageSettingsCopyWithImpl<$Res, _$ImageSettingsImpl>
    implements _$$ImageSettingsImplCopyWith<$Res> {
  __$$ImageSettingsImplCopyWithImpl(
    _$ImageSettingsImpl _value,
    $Res Function(_$ImageSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingMode = null,
    Object? lazyLoadEnabled = null,
    Object? showPlaceholderOnError = null,
    Object? cacheSizeLimitMB = null,
  }) {
    return _then(
      _$ImageSettingsImpl(
        loadingMode: null == loadingMode
            ? _value.loadingMode
            : loadingMode // ignore: cast_nullable_to_non_nullable
                  as ImageLoadingMode,
        lazyLoadEnabled: null == lazyLoadEnabled
            ? _value.lazyLoadEnabled
            : lazyLoadEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        showPlaceholderOnError: null == showPlaceholderOnError
            ? _value.showPlaceholderOnError
            : showPlaceholderOnError // ignore: cast_nullable_to_non_nullable
                  as bool,
        cacheSizeLimitMB: null == cacheSizeLimitMB
            ? _value.cacheSizeLimitMB
            : cacheSizeLimitMB // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageSettingsImpl extends _ImageSettings {
  const _$ImageSettingsImpl({
    this.loadingMode = ImageLoadingMode.always,
    this.lazyLoadEnabled = true,
    this.showPlaceholderOnError = true,
    this.cacheSizeLimitMB = 100,
  }) : super._();

  factory _$ImageSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageSettingsImplFromJson(json);

  /// 图片加载模式
  @override
  @JsonKey()
  final ImageLoadingMode loadingMode;

  /// 是否启用图片懒加载
  @override
  @JsonKey()
  final bool lazyLoadEnabled;

  /// 图片加载失败时是否显示占位符
  @override
  @JsonKey()
  final bool showPlaceholderOnError;

  /// 图片缓存大小限制（MB）
  @override
  @JsonKey()
  final int cacheSizeLimitMB;

  @override
  String toString() {
    return 'ImageSettings(loadingMode: $loadingMode, lazyLoadEnabled: $lazyLoadEnabled, showPlaceholderOnError: $showPlaceholderOnError, cacheSizeLimitMB: $cacheSizeLimitMB)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageSettingsImpl &&
            (identical(other.loadingMode, loadingMode) ||
                other.loadingMode == loadingMode) &&
            (identical(other.lazyLoadEnabled, lazyLoadEnabled) ||
                other.lazyLoadEnabled == lazyLoadEnabled) &&
            (identical(other.showPlaceholderOnError, showPlaceholderOnError) ||
                other.showPlaceholderOnError == showPlaceholderOnError) &&
            (identical(other.cacheSizeLimitMB, cacheSizeLimitMB) ||
                other.cacheSizeLimitMB == cacheSizeLimitMB));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    loadingMode,
    lazyLoadEnabled,
    showPlaceholderOnError,
    cacheSizeLimitMB,
  );

  /// Create a copy of ImageSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageSettingsImplCopyWith<_$ImageSettingsImpl> get copyWith =>
      __$$ImageSettingsImplCopyWithImpl<_$ImageSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageSettingsImplToJson(this);
  }
}

abstract class _ImageSettings extends ImageSettings {
  const factory _ImageSettings({
    final ImageLoadingMode loadingMode,
    final bool lazyLoadEnabled,
    final bool showPlaceholderOnError,
    final int cacheSizeLimitMB,
  }) = _$ImageSettingsImpl;
  const _ImageSettings._() : super._();

  factory _ImageSettings.fromJson(Map<String, dynamic> json) =
      _$ImageSettingsImpl.fromJson;

  /// 图片加载模式
  @override
  ImageLoadingMode get loadingMode;

  /// 是否启用图片懒加载
  @override
  bool get lazyLoadEnabled;

  /// 图片加载失败时是否显示占位符
  @override
  bool get showPlaceholderOnError;

  /// 图片缓存大小限制（MB）
  @override
  int get cacheSizeLimitMB;

  /// Create a copy of ImageSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageSettingsImplCopyWith<_$ImageSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
