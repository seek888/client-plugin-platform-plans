import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_settings.freezed.dart';
part 'image_settings.g.dart';

/// 图片加载模式
enum ImageLoadingMode {
  /// 始终加载图片
  always,

  /// 仅在 WiFi 下加载图片
  wifiOnly,

  /// 从不加载图片（无图模式）
  never,
}

/// 图片设置
@freezed
class ImageSettings with _$ImageSettings {
  const ImageSettings._();

  const factory ImageSettings({
    /// 图片加载模式
    @Default(ImageLoadingMode.always) ImageLoadingMode loadingMode,

    /// 是否启用图片懒加载
    @Default(true) bool lazyLoadEnabled,

    /// 图片加载失败时是否显示占位符
    @Default(true) bool showPlaceholderOnError,

    /// 图片缓存大小限制（MB）
    @Default(100) int cacheSizeLimitMB,
  }) = _ImageSettings;

  factory ImageSettings.fromJson(Map<String, dynamic> json) =>
      _$ImageSettingsFromJson(json);

  /// 是否启用图片加载
  bool get isImageLoadingEnabled => loadingMode != ImageLoadingMode.never;

  /// 是否为无图模式
  bool get isNoImageMode => loadingMode == ImageLoadingMode.never;

  /// 是否仅在 WiFi 下加载
  bool get isWifiOnlyMode => loadingMode == ImageLoadingMode.wifiOnly;
}
