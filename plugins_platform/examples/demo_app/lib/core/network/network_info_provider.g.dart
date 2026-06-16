// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkInfoServiceHash() =>
    r'127ab276fd2479c42a953d795aa0a953b0355dc6';

/// 网络信息服务 Provider
///
/// Copied from [networkInfoService].
@ProviderFor(networkInfoService)
final networkInfoServiceProvider = Provider<NetworkInfoService>.internal(
  networkInfoService,
  name: r'networkInfoServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkInfoServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NetworkInfoServiceRef = ProviderRef<NetworkInfoService>;
String _$isOfflineHash() => r'9d1a721378797a22d1b07914892cd8999c691ad5';

/// 是否离线的便捷 Provider
///
/// Copied from [isOffline].
@ProviderFor(isOffline)
final isOfflineProvider = AutoDisposeProvider<bool>.internal(
  isOffline,
  name: r'isOfflineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isOfflineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsOfflineRef = AutoDisposeProviderRef<bool>;
String _$isOnlineHash() => r'9fde86c2a9dee7df8ae5c47f7e557d7b933295a1';

/// 是否在线的便捷 Provider
///
/// Copied from [isOnline].
@ProviderFor(isOnline)
final isOnlineProvider = AutoDisposeProvider<bool>.internal(
  isOnline,
  name: r'isOnlineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isOnlineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsOnlineRef = AutoDisposeProviderRef<bool>;
String _$networkStatusNotifierHash() =>
    r'8c3e03d64a087aec8e15668927c64a6bd8826209';

/// 网络状态 Provider
/// 监听网络状态变化并更新状态
///
/// Copied from [NetworkStatusNotifier].
@ProviderFor(NetworkStatusNotifier)
final networkStatusNotifierProvider =
    AutoDisposeNotifierProvider<NetworkStatusNotifier, NetworkStatus>.internal(
      NetworkStatusNotifier.new,
      name: r'networkStatusNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$networkStatusNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NetworkStatusNotifier = AutoDisposeNotifier<NetworkStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
