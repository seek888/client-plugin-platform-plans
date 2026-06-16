// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_management_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opmlServiceHash() => r'866725f1de95a13e1c7506d8598acf6265b0c898';

/// OPML 服务 Provider
///
/// Copied from [opmlService].
@ProviderFor(opmlService)
final opmlServiceProvider = AutoDisposeProvider<OPMLService>.internal(
  opmlService,
  name: r'opmlServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$opmlServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OpmlServiceRef = AutoDisposeProviderRef<OPMLService>;
String _$feedValidatorHash() => r'4b54cacb8a55a7c95ea4d77aafd04ba046bcefc9';

/// 订阅源验证器 Provider
///
/// Copied from [feedValidator].
@ProviderFor(feedValidator)
final feedValidatorProvider = AutoDisposeProvider<FeedValidator>.internal(
  feedValidator,
  name: r'feedValidatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedValidatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeedValidatorRef = AutoDisposeProviderRef<FeedValidator>;
String _$feedManagementSideEffectHash() =>
    r'388aaaf282ae482bd00989d5828cba3ab7bb377e';

/// 副作用 Provider
///
/// Copied from [feedManagementSideEffect].
@ProviderFor(feedManagementSideEffect)
final feedManagementSideEffectProvider =
    AutoDisposeStreamProvider<FeedManagementSideEffect>.internal(
      feedManagementSideEffect,
      name: r'feedManagementSideEffectProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$feedManagementSideEffectHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeedManagementSideEffectRef =
    AutoDisposeStreamProviderRef<FeedManagementSideEffect>;
String _$feedManagementNotifierHash() =>
    r'78105cf3d99c33c47438b4c18cca10e8587c016e';

/// 订阅源管理 Notifier
/// 负责管理订阅源管理页的状态和业务逻辑
///
/// Copied from [FeedManagementNotifier].
@ProviderFor(FeedManagementNotifier)
final feedManagementNotifierProvider =
    AutoDisposeNotifierProvider<
      FeedManagementNotifier,
      FeedManagementState
    >.internal(
      FeedManagementNotifier.new,
      name: r'feedManagementNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$feedManagementNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FeedManagementNotifier = AutoDisposeNotifier<FeedManagementState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
