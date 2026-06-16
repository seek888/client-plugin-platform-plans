// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_editor_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articleEditorSideEffectHash() =>
    r'03fcac3227141a1ea760e60e7d625176ebea34cd';

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
/// Copied from [articleEditorSideEffect].
@ProviderFor(articleEditorSideEffect)
const articleEditorSideEffectProvider = ArticleEditorSideEffectFamily();

/// 副作用 Provider
///
/// Copied from [articleEditorSideEffect].
class ArticleEditorSideEffectFamily
    extends Family<AsyncValue<ArticleEditorSideEffect>> {
  /// 副作用 Provider
  ///
  /// Copied from [articleEditorSideEffect].
  const ArticleEditorSideEffectFamily();

  /// 副作用 Provider
  ///
  /// Copied from [articleEditorSideEffect].
  ArticleEditorSideEffectProvider call(String articleId) {
    return ArticleEditorSideEffectProvider(articleId);
  }

  @override
  ArticleEditorSideEffectProvider getProviderOverride(
    covariant ArticleEditorSideEffectProvider provider,
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
  String? get name => r'articleEditorSideEffectProvider';
}

/// 副作用 Provider
///
/// Copied from [articleEditorSideEffect].
class ArticleEditorSideEffectProvider
    extends AutoDisposeStreamProvider<ArticleEditorSideEffect> {
  /// 副作用 Provider
  ///
  /// Copied from [articleEditorSideEffect].
  ArticleEditorSideEffectProvider(String articleId)
    : this._internal(
        (ref) => articleEditorSideEffect(
          ref as ArticleEditorSideEffectRef,
          articleId,
        ),
        from: articleEditorSideEffectProvider,
        name: r'articleEditorSideEffectProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$articleEditorSideEffectHash,
        dependencies: ArticleEditorSideEffectFamily._dependencies,
        allTransitiveDependencies:
            ArticleEditorSideEffectFamily._allTransitiveDependencies,
        articleId: articleId,
      );

  ArticleEditorSideEffectProvider._internal(
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
    Stream<ArticleEditorSideEffect> Function(
      ArticleEditorSideEffectRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ArticleEditorSideEffectProvider._internal(
        (ref) => create(ref as ArticleEditorSideEffectRef),
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
  AutoDisposeStreamProviderElement<ArticleEditorSideEffect> createElement() {
    return _ArticleEditorSideEffectProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleEditorSideEffectProvider &&
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
mixin ArticleEditorSideEffectRef
    on AutoDisposeStreamProviderRef<ArticleEditorSideEffect> {
  /// The parameter `articleId` of this provider.
  String get articleId;
}

class _ArticleEditorSideEffectProviderElement
    extends AutoDisposeStreamProviderElement<ArticleEditorSideEffect>
    with ArticleEditorSideEffectRef {
  _ArticleEditorSideEffectProviderElement(super.provider);

  @override
  String get articleId => (origin as ArticleEditorSideEffectProvider).articleId;
}

String _$articleEditorNotifierHash() =>
    r'5e365ec072a0e070b0c3f66ad6ac2f3c2937a181';

abstract class _$ArticleEditorNotifier
    extends BuildlessAutoDisposeNotifier<ArticleEditorState> {
  late final String articleId;

  ArticleEditorState build(String articleId);
}

/// 文章编辑器 Notifier
/// 负责管理文章编辑器的状态和业务逻辑
///
/// Copied from [ArticleEditorNotifier].
@ProviderFor(ArticleEditorNotifier)
const articleEditorNotifierProvider = ArticleEditorNotifierFamily();

/// 文章编辑器 Notifier
/// 负责管理文章编辑器的状态和业务逻辑
///
/// Copied from [ArticleEditorNotifier].
class ArticleEditorNotifierFamily extends Family<ArticleEditorState> {
  /// 文章编辑器 Notifier
  /// 负责管理文章编辑器的状态和业务逻辑
  ///
  /// Copied from [ArticleEditorNotifier].
  const ArticleEditorNotifierFamily();

  /// 文章编辑器 Notifier
  /// 负责管理文章编辑器的状态和业务逻辑
  ///
  /// Copied from [ArticleEditorNotifier].
  ArticleEditorNotifierProvider call(String articleId) {
    return ArticleEditorNotifierProvider(articleId);
  }

  @override
  ArticleEditorNotifierProvider getProviderOverride(
    covariant ArticleEditorNotifierProvider provider,
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
  String? get name => r'articleEditorNotifierProvider';
}

/// 文章编辑器 Notifier
/// 负责管理文章编辑器的状态和业务逻辑
///
/// Copied from [ArticleEditorNotifier].
class ArticleEditorNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          ArticleEditorNotifier,
          ArticleEditorState
        > {
  /// 文章编辑器 Notifier
  /// 负责管理文章编辑器的状态和业务逻辑
  ///
  /// Copied from [ArticleEditorNotifier].
  ArticleEditorNotifierProvider(String articleId)
    : this._internal(
        () => ArticleEditorNotifier()..articleId = articleId,
        from: articleEditorNotifierProvider,
        name: r'articleEditorNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$articleEditorNotifierHash,
        dependencies: ArticleEditorNotifierFamily._dependencies,
        allTransitiveDependencies:
            ArticleEditorNotifierFamily._allTransitiveDependencies,
        articleId: articleId,
      );

  ArticleEditorNotifierProvider._internal(
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
  ArticleEditorState runNotifierBuild(
    covariant ArticleEditorNotifier notifier,
  ) {
    return notifier.build(articleId);
  }

  @override
  Override overrideWith(ArticleEditorNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ArticleEditorNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ArticleEditorNotifier, ArticleEditorState>
  createElement() {
    return _ArticleEditorNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleEditorNotifierProvider &&
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
mixin ArticleEditorNotifierRef
    on AutoDisposeNotifierProviderRef<ArticleEditorState> {
  /// The parameter `articleId` of this provider.
  String get articleId;
}

class _ArticleEditorNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ArticleEditorNotifier,
          ArticleEditorState
        >
    with ArticleEditorNotifierRef {
  _ArticleEditorNotifierProviderElement(super.provider);

  @override
  String get articleId => (origin as ArticleEditorNotifierProvider).articleId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
