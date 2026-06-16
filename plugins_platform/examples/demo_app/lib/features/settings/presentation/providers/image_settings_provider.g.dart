// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imageSettingsServiceHash() =>
    r'3126352be3e8bb3cf3eb4dd648bf40d177f1a1da';

/// 图片设置服务 Provider
///
/// Copied from [imageSettingsService].
@ProviderFor(imageSettingsService)
final imageSettingsServiceProvider =
    AutoDisposeProvider<ImageSettingsService>.internal(
      imageSettingsService,
      name: r'imageSettingsServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$imageSettingsServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ImageSettingsServiceRef = AutoDisposeProviderRef<ImageSettingsService>;
String _$isImageLoadingEnabledHash() =>
    r'adc2664cf1d556600d3d45a6cc8c4b4811f5f8a6';

/// 是否启用图片加载的便捷 Provider
///
/// Copied from [isImageLoadingEnabled].
@ProviderFor(isImageLoadingEnabled)
final isImageLoadingEnabledProvider = AutoDisposeProvider<bool>.internal(
  isImageLoadingEnabled,
  name: r'isImageLoadingEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isImageLoadingEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsImageLoadingEnabledRef = AutoDisposeProviderRef<bool>;
String _$isNoImageModeHash() => r'3d43f6dad4a1638d36bbd2006141e4490cecbb3b';

/// 是否为无图模式的便捷 Provider
///
/// Copied from [isNoImageMode].
@ProviderFor(isNoImageMode)
final isNoImageModeProvider = AutoDisposeProvider<bool>.internal(
  isNoImageMode,
  name: r'isNoImageModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isNoImageModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsNoImageModeRef = AutoDisposeProviderRef<bool>;
String _$imageSettingsNotifierHash() =>
    r'392a272eb0af7b506a3588bc9bd74eb67f5484a0';

/// 图片设置状态 Provider
///
/// Copied from [ImageSettingsNotifier].
@ProviderFor(ImageSettingsNotifier)
final imageSettingsNotifierProvider =
    AutoDisposeNotifierProvider<ImageSettingsNotifier, ImageSettings>.internal(
      ImageSettingsNotifier.new,
      name: r'imageSettingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$imageSettingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ImageSettingsNotifier = AutoDisposeNotifier<ImageSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
