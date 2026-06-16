// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articleRepositoryHash() => r'c85f461ecb45d5c44477ee91d5717ab8da178c49';

/// 文章仓库 Provider
///
/// Copied from [articleRepository].
@ProviderFor(articleRepository)
final articleRepositoryProvider =
    AutoDisposeProvider<ArticleRepository>.internal(
      articleRepository,
      name: r'articleRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$articleRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticleRepositoryRef = AutoDisposeProviderRef<ArticleRepository>;
String _$articleSideEffectHash() => r'68ab5fded7a275951ffcae65d910b435d6b31cdd';

/// 副作用 Provider
///
/// Copied from [articleSideEffect].
@ProviderFor(articleSideEffect)
final articleSideEffectProvider =
    AutoDisposeStreamProvider<ArticleSideEffect>.internal(
      articleSideEffect,
      name: r'articleSideEffectProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$articleSideEffectHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticleSideEffectRef = AutoDisposeStreamProviderRef<ArticleSideEffect>;
String _$articleListNotifierHash() =>
    r'3154d7cc6d7946928e1e076e8a2820c952b4c4e9';

/// 文章列表 Notifier
/// 负责管理文章列表的状态和业务逻辑
///
/// Copied from [ArticleListNotifier].
@ProviderFor(ArticleListNotifier)
final articleListNotifierProvider =
    AutoDisposeNotifierProvider<ArticleListNotifier, ArticleListState>.internal(
      ArticleListNotifier.new,
      name: r'articleListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$articleListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ArticleListNotifier = AutoDisposeNotifier<ArticleListState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
