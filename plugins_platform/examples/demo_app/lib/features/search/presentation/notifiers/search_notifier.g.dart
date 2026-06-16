// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchSideEffectHash() => r'b575c0fc6108716013479cea4317ffcf57d8a22f';

/// 搜索副作用 Provider
///
/// Copied from [searchSideEffect].
@ProviderFor(searchSideEffect)
final searchSideEffectProvider =
    AutoDisposeStreamProvider<SearchSideEffect>.internal(
      searchSideEffect,
      name: r'searchSideEffectProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchSideEffectHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchSideEffectRef = AutoDisposeStreamProviderRef<SearchSideEffect>;
String _$searchNotifierHash() => r'fd52cf904bcf538b79fcb0b5dd57e9146f0a4492';

/// 搜索 Notifier
/// 负责管理搜索页的状态和业务逻辑
/// Requirements: 8.1, 8.2, 8.3, 8.4, 8.5
///
/// Copied from [SearchNotifier].
@ProviderFor(SearchNotifier)
final searchNotifierProvider =
    AutoDisposeNotifierProvider<SearchNotifier, SearchState>.internal(
      SearchNotifier.new,
      name: r'searchNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SearchNotifier = AutoDisposeNotifier<SearchState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
