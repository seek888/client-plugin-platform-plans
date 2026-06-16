// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tray_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$traySettingsNotifierHash() =>
    r'cafd06f11b584d54fcec8e103bca559591b6cf51';

/// 托盘设置 Provider
///
/// 管理托盘设置的读取和保存
/// Requirements: 6.1, 6.5
///
/// Copied from [TraySettingsNotifier].
@ProviderFor(TraySettingsNotifier)
final traySettingsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      TraySettingsNotifier,
      TraySettings
    >.internal(
      TraySettingsNotifier.new,
      name: r'traySettingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$traySettingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TraySettingsNotifier = AutoDisposeAsyncNotifier<TraySettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
