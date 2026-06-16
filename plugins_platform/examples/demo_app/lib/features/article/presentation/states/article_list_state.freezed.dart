// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ArticleListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArticleListStateInitial value) initial,
    required TResult Function(ArticleListStateLoading value) loading,
    required TResult Function(ArticleListStateLoaded value) loaded,
    required TResult Function(ArticleListStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleListStateInitial value)? initial,
    TResult? Function(ArticleListStateLoading value)? loading,
    TResult? Function(ArticleListStateLoaded value)? loaded,
    TResult? Function(ArticleListStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleListStateInitial value)? initial,
    TResult Function(ArticleListStateLoading value)? loading,
    TResult Function(ArticleListStateLoaded value)? loaded,
    TResult Function(ArticleListStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleListStateCopyWith<$Res> {
  factory $ArticleListStateCopyWith(
    ArticleListState value,
    $Res Function(ArticleListState) then,
  ) = _$ArticleListStateCopyWithImpl<$Res, ArticleListState>;
}

/// @nodoc
class _$ArticleListStateCopyWithImpl<$Res, $Val extends ArticleListState>
    implements $ArticleListStateCopyWith<$Res> {
  _$ArticleListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArticleListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ArticleListStateInitialImplCopyWith<$Res> {
  factory _$$ArticleListStateInitialImplCopyWith(
    _$ArticleListStateInitialImpl value,
    $Res Function(_$ArticleListStateInitialImpl) then,
  ) = __$$ArticleListStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ArticleListStateInitialImplCopyWithImpl<$Res>
    extends _$ArticleListStateCopyWithImpl<$Res, _$ArticleListStateInitialImpl>
    implements _$$ArticleListStateInitialImplCopyWith<$Res> {
  __$$ArticleListStateInitialImplCopyWithImpl(
    _$ArticleListStateInitialImpl _value,
    $Res Function(_$ArticleListStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ArticleListStateInitialImpl implements ArticleListStateInitial {
  const _$ArticleListStateInitialImpl();

  @override
  String toString() {
    return 'ArticleListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleListStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArticleListStateInitial value) initial,
    required TResult Function(ArticleListStateLoading value) loading,
    required TResult Function(ArticleListStateLoaded value) loaded,
    required TResult Function(ArticleListStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleListStateInitial value)? initial,
    TResult? Function(ArticleListStateLoading value)? loading,
    TResult? Function(ArticleListStateLoaded value)? loaded,
    TResult? Function(ArticleListStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleListStateInitial value)? initial,
    TResult Function(ArticleListStateLoading value)? loading,
    TResult Function(ArticleListStateLoaded value)? loaded,
    TResult Function(ArticleListStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ArticleListStateInitial implements ArticleListState {
  const factory ArticleListStateInitial() = _$ArticleListStateInitialImpl;
}

/// @nodoc
abstract class _$$ArticleListStateLoadingImplCopyWith<$Res> {
  factory _$$ArticleListStateLoadingImplCopyWith(
    _$ArticleListStateLoadingImpl value,
    $Res Function(_$ArticleListStateLoadingImpl) then,
  ) = __$$ArticleListStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ArticleListStateLoadingImplCopyWithImpl<$Res>
    extends _$ArticleListStateCopyWithImpl<$Res, _$ArticleListStateLoadingImpl>
    implements _$$ArticleListStateLoadingImplCopyWith<$Res> {
  __$$ArticleListStateLoadingImplCopyWithImpl(
    _$ArticleListStateLoadingImpl _value,
    $Res Function(_$ArticleListStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ArticleListStateLoadingImpl implements ArticleListStateLoading {
  const _$ArticleListStateLoadingImpl();

  @override
  String toString() {
    return 'ArticleListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleListStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArticleListStateInitial value) initial,
    required TResult Function(ArticleListStateLoading value) loading,
    required TResult Function(ArticleListStateLoaded value) loaded,
    required TResult Function(ArticleListStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleListStateInitial value)? initial,
    TResult? Function(ArticleListStateLoading value)? loading,
    TResult? Function(ArticleListStateLoaded value)? loaded,
    TResult? Function(ArticleListStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleListStateInitial value)? initial,
    TResult Function(ArticleListStateLoading value)? loading,
    TResult Function(ArticleListStateLoaded value)? loaded,
    TResult Function(ArticleListStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ArticleListStateLoading implements ArticleListState {
  const factory ArticleListStateLoading() = _$ArticleListStateLoadingImpl;
}

/// @nodoc
abstract class _$$ArticleListStateLoadedImplCopyWith<$Res> {
  factory _$$ArticleListStateLoadedImplCopyWith(
    _$ArticleListStateLoadedImpl value,
    $Res Function(_$ArticleListStateLoadedImpl) then,
  ) = __$$ArticleListStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Article> articles,
    String? feedId,
    ArticleSortType sortType,
    ArticleFilterType filterType,
    int currentPage,
    bool hasMore,
    bool isLoadingMore,
    bool isRefreshing,
    String? selectedArticleId,
  });
}

/// @nodoc
class __$$ArticleListStateLoadedImplCopyWithImpl<$Res>
    extends _$ArticleListStateCopyWithImpl<$Res, _$ArticleListStateLoadedImpl>
    implements _$$ArticleListStateLoadedImplCopyWith<$Res> {
  __$$ArticleListStateLoadedImplCopyWithImpl(
    _$ArticleListStateLoadedImpl _value,
    $Res Function(_$ArticleListStateLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? feedId = freezed,
    Object? sortType = null,
    Object? filterType = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
    Object? isRefreshing = null,
    Object? selectedArticleId = freezed,
  }) {
    return _then(
      _$ArticleListStateLoadedImpl(
        articles: null == articles
            ? _value._articles
            : articles // ignore: cast_nullable_to_non_nullable
                  as List<Article>,
        feedId: freezed == feedId
            ? _value.feedId
            : feedId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortType: null == sortType
            ? _value.sortType
            : sortType // ignore: cast_nullable_to_non_nullable
                  as ArticleSortType,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as ArticleFilterType,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRefreshing: null == isRefreshing
            ? _value.isRefreshing
            : isRefreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedArticleId: freezed == selectedArticleId
            ? _value.selectedArticleId
            : selectedArticleId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ArticleListStateLoadedImpl implements ArticleListStateLoaded {
  const _$ArticleListStateLoadedImpl({
    required final List<Article> articles,
    this.feedId,
    this.sortType = ArticleSortType.timeDesc,
    this.filterType = ArticleFilterType.all,
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.selectedArticleId,
  }) : _articles = articles;

  /// 文章列表
  final List<Article> _articles;

  /// 文章列表
  @override
  List<Article> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  /// 当前订阅源 ID（null 表示全部）
  @override
  final String? feedId;

  /// 当前排序类型
  @override
  @JsonKey()
  final ArticleSortType sortType;

  /// 当前筛选类型
  @override
  @JsonKey()
  final ArticleFilterType filterType;

  /// 当前页码
  @override
  @JsonKey()
  final int currentPage;

  /// 是否还有更多数据
  @override
  @JsonKey()
  final bool hasMore;

  /// 是否正在加载更多
  @override
  @JsonKey()
  final bool isLoadingMore;

  /// 是否正在刷新
  @override
  @JsonKey()
  final bool isRefreshing;

  /// 当前选中的文章 ID
  @override
  final String? selectedArticleId;

  @override
  String toString() {
    return 'ArticleListState.loaded(articles: $articles, feedId: $feedId, sortType: $sortType, filterType: $filterType, currentPage: $currentPage, hasMore: $hasMore, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, selectedArticleId: $selectedArticleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleListStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.feedId, feedId) || other.feedId == feedId) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.selectedArticleId, selectedArticleId) ||
                other.selectedArticleId == selectedArticleId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_articles),
    feedId,
    sortType,
    filterType,
    currentPage,
    hasMore,
    isLoadingMore,
    isRefreshing,
    selectedArticleId,
  );

  /// Create a copy of ArticleListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleListStateLoadedImplCopyWith<_$ArticleListStateLoadedImpl>
  get copyWith =>
      __$$ArticleListStateLoadedImplCopyWithImpl<_$ArticleListStateLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
      articles,
      feedId,
      sortType,
      filterType,
      currentPage,
      hasMore,
      isLoadingMore,
      isRefreshing,
      selectedArticleId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
      articles,
      feedId,
      sortType,
      filterType,
      currentPage,
      hasMore,
      isLoadingMore,
      isRefreshing,
      selectedArticleId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        articles,
        feedId,
        sortType,
        filterType,
        currentPage,
        hasMore,
        isLoadingMore,
        isRefreshing,
        selectedArticleId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArticleListStateInitial value) initial,
    required TResult Function(ArticleListStateLoading value) loading,
    required TResult Function(ArticleListStateLoaded value) loaded,
    required TResult Function(ArticleListStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleListStateInitial value)? initial,
    TResult? Function(ArticleListStateLoading value)? loading,
    TResult? Function(ArticleListStateLoaded value)? loaded,
    TResult? Function(ArticleListStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleListStateInitial value)? initial,
    TResult Function(ArticleListStateLoading value)? loading,
    TResult Function(ArticleListStateLoaded value)? loaded,
    TResult Function(ArticleListStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ArticleListStateLoaded implements ArticleListState {
  const factory ArticleListStateLoaded({
    required final List<Article> articles,
    final String? feedId,
    final ArticleSortType sortType,
    final ArticleFilterType filterType,
    final int currentPage,
    final bool hasMore,
    final bool isLoadingMore,
    final bool isRefreshing,
    final String? selectedArticleId,
  }) = _$ArticleListStateLoadedImpl;

  /// 文章列表
  List<Article> get articles;

  /// 当前订阅源 ID（null 表示全部）
  String? get feedId;

  /// 当前排序类型
  ArticleSortType get sortType;

  /// 当前筛选类型
  ArticleFilterType get filterType;

  /// 当前页码
  int get currentPage;

  /// 是否还有更多数据
  bool get hasMore;

  /// 是否正在加载更多
  bool get isLoadingMore;

  /// 是否正在刷新
  bool get isRefreshing;

  /// 当前选中的文章 ID
  String? get selectedArticleId;

  /// Create a copy of ArticleListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleListStateLoadedImplCopyWith<_$ArticleListStateLoadedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArticleListStateErrorImplCopyWith<$Res> {
  factory _$$ArticleListStateErrorImplCopyWith(
    _$ArticleListStateErrorImpl value,
    $Res Function(_$ArticleListStateErrorImpl) then,
  ) = __$$ArticleListStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ArticleListStateErrorImplCopyWithImpl<$Res>
    extends _$ArticleListStateCopyWithImpl<$Res, _$ArticleListStateErrorImpl>
    implements _$$ArticleListStateErrorImplCopyWith<$Res> {
  __$$ArticleListStateErrorImplCopyWithImpl(
    _$ArticleListStateErrorImpl _value,
    $Res Function(_$ArticleListStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ArticleListStateErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ArticleListStateErrorImpl implements ArticleListStateError {
  const _$ArticleListStateErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ArticleListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleListStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ArticleListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleListStateErrorImplCopyWith<_$ArticleListStateErrorImpl>
  get copyWith =>
      __$$ArticleListStateErrorImplCopyWithImpl<_$ArticleListStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      String? feedId,
      ArticleSortType sortType,
      ArticleFilterType filterType,
      int currentPage,
      bool hasMore,
      bool isLoadingMore,
      bool isRefreshing,
      String? selectedArticleId,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArticleListStateInitial value) initial,
    required TResult Function(ArticleListStateLoading value) loading,
    required TResult Function(ArticleListStateLoaded value) loaded,
    required TResult Function(ArticleListStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleListStateInitial value)? initial,
    TResult? Function(ArticleListStateLoading value)? loading,
    TResult? Function(ArticleListStateLoaded value)? loaded,
    TResult? Function(ArticleListStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleListStateInitial value)? initial,
    TResult Function(ArticleListStateLoading value)? loading,
    TResult Function(ArticleListStateLoaded value)? loaded,
    TResult Function(ArticleListStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ArticleListStateError implements ArticleListState {
  const factory ArticleListStateError({required final String message}) =
      _$ArticleListStateErrorImpl;

  String get message;

  /// Create a copy of ArticleListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleListStateErrorImplCopyWith<_$ArticleListStateErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
