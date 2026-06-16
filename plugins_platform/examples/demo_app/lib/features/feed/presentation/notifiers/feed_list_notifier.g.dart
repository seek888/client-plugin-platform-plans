// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedRepositoryHash() => r'451bb8e6adbb426f60ea62d24450883bd68f5a8e';

/// 订阅源仓库 Provider
///
/// Copied from [feedRepository].
@ProviderFor(feedRepository)
final feedRepositoryProvider = AutoDisposeProvider<FeedRepository>.internal(
  feedRepository,
  name: r'feedRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeedRepositoryRef = AutoDisposeProviderRef<FeedRepository>;
String _$feedSideEffectHash() => r'd89f015ff18be321b18c4b79d0fe8734473fcf6a';

/// 副作用 Provider
///
/// Copied from [feedSideEffect].
@ProviderFor(feedSideEffect)
final feedSideEffectProvider =
    AutoDisposeStreamProvider<FeedSideEffect>.internal(
      feedSideEffect,
      name: r'feedSideEffectProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$feedSideEffectHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeedSideEffectRef = AutoDisposeStreamProviderRef<FeedSideEffect>;
String _$feedListNotifierHash() => r'063d450022f50383d23bec0bfc06100e22fd9c88';

/// 订阅源列表 Notifier
/// 负责管理订阅源列表的状态和业务逻辑
///
/// Copied from [FeedListNotifier].
@ProviderFor(FeedListNotifier)
final feedListNotifierProvider =
    AutoDisposeNotifierProvider<FeedListNotifier, FeedListState>.internal(
      FeedListNotifier.new,
      name: r'feedListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$feedListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FeedListNotifier = AutoDisposeNotifier<FeedListState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
