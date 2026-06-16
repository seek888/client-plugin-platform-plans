// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articleCacheServiceHash() =>
    r'34d675893bd1f75ebb6cdb5e44ed0a79e8b1af27';

/// 文章缓存服务 Provider
///
/// Copied from [articleCacheService].
@ProviderFor(articleCacheService)
final articleCacheServiceProvider =
    AutoDisposeProvider<ArticleCacheService>.internal(
      articleCacheService,
      name: r'articleCacheServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$articleCacheServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticleCacheServiceRef = AutoDisposeProviderRef<ArticleCacheService>;
String _$articleNavigationServiceHash() =>
    r'b06de7144c2dd7f3ded5766a42893cbe70d38c24';

/// 文章导航服务 Provider
///
/// Copied from [articleNavigationService].
@ProviderFor(articleNavigationService)
final articleNavigationServiceProvider =
    AutoDisposeProvider<ArticleNavigationService>.internal(
      articleNavigationService,
      name: r'articleNavigationServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$articleNavigationServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticleNavigationServiceRef =
    AutoDisposeProviderRef<ArticleNavigationService>;
String _$articleFetcherServiceHash() =>
    r'e5b6e912f82be9ef395640ed0e6209069113b8ea';

/// 文章内容抓取服务 Provider
///
/// Copied from [articleFetcherService].
@ProviderFor(articleFetcherService)
final articleFetcherServiceProvider =
    AutoDisposeProvider<ArticleFetcherService>.internal(
      articleFetcherService,
      name: r'articleFetcherServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$articleFetcherServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticleFetcherServiceRef =
    AutoDisposeProviderRef<ArticleFetcherService>;
String _$articleDetailSideEffectHash() =>
    r'a51017ff75bddf6d359585063cb40bed2943eb91';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 副作用 Provider
///
/// Copied from [articleDetailSideEffect].
@ProviderFor(articleDetailSideEffect)
const articleDetailSideEffectProvider = ArticleDetailSideEffectFamily();

/// 副作用 Provider
///
/// Copied from [articleDetailSideEffect].
class ArticleDetailSideEffectFamily
    extends Family<AsyncValue<ArticleDetailSideEffect>> {
  /// 副作用 Provider
  ///
  /// Copied from [articleDetailSideEffect].
  const ArticleDetailSideEffectFamily();

  /// 副作用 Provider
  ///
  /// Copied from [articleDetailSideEffect].
  ArticleDetailSideEffectProvider call(String articleId) {
    return ArticleDetailSideEffectProvider(articleId);
  }

  @override
  ArticleDetailSideEffectProvider getProviderOverride(
    covariant ArticleDetailSideEffectProvider provider,
  ) {
    return call(provider.articleId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'articleDetailSideEffectProvider';
}

/// 副作用 Provider
///
/// Copied from [articleDetailSideEffect].
class ArticleDetailSideEffectProvider
    extends AutoDisposeStreamProvider<ArticleDetailSideEffect> {
  /// 副作用 Provider
  ///
  /// Copied from [articleDetailSideEffect].
  ArticleDetailSideEffectProvider(String articleId)
    : this._internal(
        (ref) => articleDetailSideEffect(
          ref as ArticleDetailSideEffectRef,
          articleId,
        ),
        from: articleDetailSideEffectProvider,
        name: r'articleDetailSideEffectProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$articleDetailSideEffectHash,
        dependencies: ArticleDetailSideEffectFamily._dependencies,
        allTransitiveDependencies:
            ArticleDetailSideEffectFamily._allTransitiveDependencies,
        articleId: articleId,
      );

  ArticleDetailSideEffectProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.articleId,
  }) : super.internal();

  final String articleId;

  @override
  Override overrideWith(
    Stream<ArticleDetailSideEffect> Function(
      ArticleDetailSideEffectRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ArticleDetailSideEffectProvider._internal(
        (ref) => create(ref as ArticleDetailSideEffectRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        articleId: articleId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<ArticleDetailSideEffect> createElement() {
    return _ArticleDetailSideEffectProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleDetailSideEffectProvider &&
        other.articleId == articleId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, articleId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ArticleDetailSideEffectRef
    on AutoDisposeStreamProviderRef<ArticleDetailSideEffect> {
  /// The parameter `articleId` of this provider.
  String get articleId;
}

class _ArticleDetailSideEffectProviderElement
    extends AutoDisposeStreamProviderElement<ArticleDetailSideEffect>
    with ArticleDetailSideEffectRef {
  _ArticleDetailSideEffectProviderElement(super.provider);

  @override
  String get articleId => (origin as ArticleDetailSideEffectProvider).articleId;
}

String _$articleDetailNotifierHash() =>
    r'b238d99b1814f362f00c6c1c050ec11e5b099873';

abstract class _$ArticleDetailNotifier
    extends BuildlessAutoDisposeNotifier<ArticleDetailState> {
  late final String articleId;

  ArticleDetailState build(String articleId);
}

/// 文章详情 Notifier
/// 负责管理文章详情页的状态和业务逻辑
///
/// Copied from [ArticleDetailNotifier].
@ProviderFor(ArticleDetailNotifier)
const articleDetailNotifierProvider = ArticleDetailNotifierFamily();

/// 文章详情 Notifier
/// 负责管理文章详情页的状态和业务逻辑
///
/// Copied from [ArticleDetailNotifier].
class ArticleDetailNotifierFamily extends Family<ArticleDetailState> {
  /// 文章详情 Notifier
  /// 负责管理文章详情页的状态和业务逻辑
  ///
  /// Copied from [ArticleDetailNotifier].
  const ArticleDetailNotifierFamily();

  /// 文章详情 Notifier
  /// 负责管理文章详情页的状态和业务逻辑
  ///
  /// Copied from [ArticleDetailNotifier].
  ArticleDetailNotifierProvider call(String articleId) {
    return ArticleDetailNotifierProvider(articleId);
  }

  @override
  ArticleDetailNotifierProvider getProviderOverride(
    covariant ArticleDetailNotifierProvider provider,
  ) {
    return call(provider.articleId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'articleDetailNotifierProvider';
}

/// 文章详情 Notifier
/// 负责管理文章详情页的状态和业务逻辑
///
/// Copied from [ArticleDetailNotifier].
class ArticleDetailNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          ArticleDetailNotifier,
          ArticleDetailState
        > {
  /// 文章详情 Notifier
  /// 负责管理文章详情页的状态和业务逻辑
  ///
  /// Copied from [ArticleDetailNotifier].
  ArticleDetailNotifierProvider(String articleId)
    : this._internal(
        () => ArticleDetailNotifier()..articleId = articleId,
        from: articleDetailNotifierProvider,
        name: r'articleDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$articleDetailNotifierHash,
        dependencies: ArticleDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            ArticleDetailNotifierFamily._allTransitiveDependencies,
        articleId: articleId,
      );

  ArticleDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.articleId,
  }) : super.internal();

  final String articleId;

  @override
  ArticleDetailState runNotifierBuild(
    covariant ArticleDetailNotifier notifier,
  ) {
    return notifier.build(articleId);
  }

  @override
  Override overrideWith(ArticleDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ArticleDetailNotifierProvider._internal(
        () => create()..articleId = articleId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        articleId: articleId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ArticleDetailNotifier, ArticleDetailState>
  createElement() {
    return _ArticleDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleDetailNotifierProvider &&
        other.articleId == articleId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, articleId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ArticleDetailNotifierRef
    on AutoDisposeNotifierProviderRef<ArticleDetailState> {
  /// The parameter `articleId` of this provider.
  String get articleId;
}

class _ArticleDetailNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ArticleDetailNotifier,
          ArticleDetailState
        >
    with ArticleDetailNotifierRef {
  _ArticleDetailNotifierProviderElement(super.provider);

  @override
  String get articleId => (origin as ArticleDetailNotifierProvider).articleId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
