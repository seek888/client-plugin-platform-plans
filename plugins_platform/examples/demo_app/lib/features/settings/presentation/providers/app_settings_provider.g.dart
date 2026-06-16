// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appSettingsServiceHash() =>
    r'da017f38fdb1b0ed045e0f0aa9040df9f11bf568';

/// 应用设置服务 Provider
///
/// Copied from [appSettingsService].
@ProviderFor(appSettingsService)
final appSettingsServiceProvider =
    AutoDisposeProvider<AppSettingsService>.internal(
      appSettingsService,
      name: r'appSettingsServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appSettingsServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppSettingsServiceRef = AutoDisposeProviderRef<AppSettingsService>;
String _$currentThemeModeHash() => r'3e612869ea12e6f1be13e7e6857224372670fed9';

/// 主题模式便捷 Provider
///
/// Copied from [currentThemeMode].
@ProviderFor(currentThemeMode)
final currentThemeModeProvider = AutoDisposeProvider<ThemeMode>.internal(
  currentThemeMode,
  name: r'currentThemeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentThemeModeRef = AutoDisposeProviderRef<ThemeMode>;
String _$currentFontSizeHash() => r'd9eab0d2d61582c49948ace84f1895f019ac7d11';

/// 字体大小便捷 Provider
///
/// Copied from [currentFontSize].
@ProviderFor(currentFontSize)
final currentFontSizeProvider = AutoDisposeProvider<FontSizeOption>.internal(
  currentFontSize,
  name: r'currentFontSizeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentFontSizeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentFontSizeRef = AutoDisposeProviderRef<FontSizeOption>;
String _$isNoImageModeEnabledHash() =>
    r'83ae41af45043ae2044cf4c7188849ed82fb5959';

/// 无图模式便捷 Provider
///
/// Copied from [isNoImageModeEnabled].
@ProviderFor(isNoImageModeEnabled)
final isNoImageModeEnabledProvider = AutoDisposeProvider<bool>.internal(
  isNoImageModeEnabled,
  name: r'isNoImageModeEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isNoImageModeEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsNoImageModeEnabledRef = AutoDisposeProviderRef<bool>;
String _$currentRefreshFrequencyHash() =>
    r'a815312661a042fba4cd3012134ef7f8460e3d94';

/// 刷新频率便捷 Provider
///
/// Copied from [currentRefreshFrequency].
@ProviderFor(currentRefreshFrequency)
final currentRefreshFrequencyProvider =
    AutoDisposeProvider<RefreshFrequency>.internal(
      currentRefreshFrequency,
      name: r'currentRefreshFrequencyProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentRefreshFrequencyHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentRefreshFrequencyRef = AutoDisposeProviderRef<RefreshFrequency>;
String _$currentFontScaleHash() => r'06d67af1b82bce76026b1b0d5ed85ba855b18794';

/// 字体缩放比例便捷 Provider
///
/// Copied from [currentFontScale].
@ProviderFor(currentFontScale)
final currentFontScaleProvider = AutoDisposeProvider<double>.internal(
  currentFontScale,
  name: r'currentFontScaleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentFontScaleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentFontScaleRef = AutoDisposeProviderRef<double>;
String _$currentLineHeightHash() => r'5ed0aae2fb21758937e7126afedf605492389b43';

/// 行间距便捷 Provider
///
/// Copied from [currentLineHeight].
@ProviderFor(currentLineHeight)
final currentLineHeightProvider = AutoDisposeProvider<double>.internal(
  currentLineHeight,
  name: r'currentLineHeightProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLineHeightHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentLineHeightRef = AutoDisposeProviderRef<double>;
String _$appSettingsNotifierHash() =>
    r'051f4b492128833147cc26334ff75123a6ac2a0f';

/// 应用设置状态 Notifier
///
/// Copied from [AppSettingsNotifier].
@ProviderFor(AppSettingsNotifier)
final appSettingsNotifierProvider =
    AutoDisposeNotifierProvider<AppSettingsNotifier, AppSettings>.internal(
      AppSettingsNotifier.new,
      name: r'appSettingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appSettingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppSettingsNotifier = AutoDisposeNotifier<AppSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
