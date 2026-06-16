// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_tray_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$systemTrayNotifierHash() =>
    r'227f3d0535a140c2ba9383150e756887855f569a';

/// 系统托盘状态 Provider
///
/// 管理系统托盘的运行时状态
/// Requirements: 1.1, 6.5
///
/// Copied from [SystemTrayNotifier].
@ProviderFor(SystemTrayNotifier)
final systemTrayNotifierProvider =
    AutoDisposeNotifierProvider<SystemTrayNotifier, TrayState>.internal(
      SystemTrayNotifier.new,
      name: r'systemTrayNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$systemTrayNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SystemTrayNotifier = AutoDisposeNotifier<TrayState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
