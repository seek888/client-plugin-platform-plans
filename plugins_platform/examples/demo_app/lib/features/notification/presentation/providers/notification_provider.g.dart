// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationServiceHash() =>
    r'aa8e09f76cb9f465c1763011e57dabb12efd5061';

/// 通知服务 Provider
///
/// 提供全局单例的通知服务实例
///
/// Copied from [notificationService].
@ProviderFor(notificationService)
final notificationServiceProvider = Provider<NotificationService>.internal(
  notificationService,
  name: r'notificationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationServiceRef = ProviderRef<NotificationService>;
String _$newContentNotifierHash() =>
    r'506afa7113cece04eee8934184f0d036698c2e7b';

/// 新内容通知器 Provider
///
/// 提供新内容通知功能，会检查用户设置中是否启用了通知
///
/// Copied from [newContentNotifier].
@ProviderFor(newContentNotifier)
final newContentNotifierProvider =
    AutoDisposeProvider<NewContentNotifier>.internal(
      newContentNotifier,
      name: r'newContentNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$newContentNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NewContentNotifierRef = AutoDisposeProviderRef<NewContentNotifier>;
String _$notificationPermissionHash() =>
    r'679b48cc8e56bcd53ff6aa6cd1521491dbb8c25c';

/// 通知权限状态 Provider
///
/// 检查当前是否有通知权限
///
/// Copied from [notificationPermission].
@ProviderFor(notificationPermission)
final notificationPermissionProvider = AutoDisposeFutureProvider<bool>.internal(
  notificationPermission,
  name: r'notificationPermissionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationPermissionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationPermissionRef = AutoDisposeFutureProviderRef<bool>;
String _$notificationEnabledHash() =>
    r'2a7b787e09f4e5b5c8e4b22850334ad66a3f273f';

/// 通知启用状态 Provider
///
/// 检查用户是否启用了通知
///
/// Copied from [notificationEnabled].
@ProviderFor(notificationEnabled)
final notificationEnabledProvider = AutoDisposeFutureProvider<bool>.internal(
  notificationEnabled,
  name: r'notificationEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationEnabledRef = AutoDisposeFutureProviderRef<bool>;
String _$notificationInitializerHash() =>
    r'e006dfb338fd5b54c7738935d4287f1c1babe4ea';

/// 通知初始化状态 Notifier
///
/// 管理通知服务的初始化状态
///
/// Copied from [NotificationInitializer].
@ProviderFor(NotificationInitializer)
final notificationInitializerProvider =
    AutoDisposeAsyncNotifierProvider<NotificationInitializer, bool>.internal(
      NotificationInitializer.new,
      name: r'notificationInitializerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationInitializerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationInitializer = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
