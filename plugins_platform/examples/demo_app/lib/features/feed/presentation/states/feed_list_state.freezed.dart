// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FeedListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedListStateInitial value) initial,
    required TResult Function(FeedListStateLoading value) loading,
    required TResult Function(FeedListStateLoaded value) loaded,
    required TResult Function(FeedListStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedListStateInitial value)? initial,
    TResult? Function(FeedListStateLoading value)? loading,
    TResult? Function(FeedListStateLoaded value)? loaded,
    TResult? Function(FeedListStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedListStateInitial value)? initial,
    TResult Function(FeedListStateLoading value)? loading,
    TResult Function(FeedListStateLoaded value)? loaded,
    TResult Function(FeedListStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedListStateCopyWith<$Res> {
  factory $FeedListStateCopyWith(
    FeedListState value,
    $Res Function(FeedListState) then,
  ) = _$FeedListStateCopyWithImpl<$Res, FeedListState>;
}

/// @nodoc
class _$FeedListStateCopyWithImpl<$Res, $Val extends FeedListState>
    implements $FeedListStateCopyWith<$Res> {
  _$FeedListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FeedListStateInitialImplCopyWith<$Res> {
  factory _$$FeedListStateInitialImplCopyWith(
    _$FeedListStateInitialImpl value,
    $Res Function(_$FeedListStateInitialImpl) then,
  ) = __$$FeedListStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FeedListStateInitialImplCopyWithImpl<$Res>
    extends _$FeedListStateCopyWithImpl<$Res, _$FeedListStateInitialImpl>
    implements _$$FeedListStateInitialImplCopyWith<$Res> {
  __$$FeedListStateInitialImplCopyWithImpl(
    _$FeedListStateInitialImpl _value,
    $Res Function(_$FeedListStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FeedListStateInitialImpl implements FeedListStateInitial {
  const _$FeedListStateInitialImpl();

  @override
  String toString() {
    return 'FeedListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedListStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
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
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
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
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
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
    required TResult Function(FeedListStateInitial value) initial,
    required TResult Function(FeedListStateLoading value) loading,
    required TResult Function(FeedListStateLoaded value) loaded,
    required TResult Function(FeedListStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedListStateInitial value)? initial,
    TResult? Function(FeedListStateLoading value)? loading,
    TResult? Function(FeedListStateLoaded value)? loaded,
    TResult? Function(FeedListStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedListStateInitial value)? initial,
    TResult Function(FeedListStateLoading value)? loading,
    TResult Function(FeedListStateLoaded value)? loaded,
    TResult Function(FeedListStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class FeedListStateInitial implements FeedListState {
  const factory FeedListStateInitial() = _$FeedListStateInitialImpl;
}

/// @nodoc
abstract class _$$FeedListStateLoadingImplCopyWith<$Res> {
  factory _$$FeedListStateLoadingImplCopyWith(
    _$FeedListStateLoadingImpl value,
    $Res Function(_$FeedListStateLoadingImpl) then,
  ) = __$$FeedListStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FeedListStateLoadingImplCopyWithImpl<$Res>
    extends _$FeedListStateCopyWithImpl<$Res, _$FeedListStateLoadingImpl>
    implements _$$FeedListStateLoadingImplCopyWith<$Res> {
  __$$FeedListStateLoadingImplCopyWithImpl(
    _$FeedListStateLoadingImpl _value,
    $Res Function(_$FeedListStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FeedListStateLoadingImpl implements FeedListStateLoading {
  const _$FeedListStateLoadingImpl();

  @override
  String toString() {
    return 'FeedListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedListStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
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
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
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
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
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
    required TResult Function(FeedListStateInitial value) initial,
    required TResult Function(FeedListStateLoading value) loading,
    required TResult Function(FeedListStateLoaded value) loaded,
    required TResult Function(FeedListStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedListStateInitial value)? initial,
    TResult? Function(FeedListStateLoading value)? loading,
    TResult? Function(FeedListStateLoaded value)? loaded,
    TResult? Function(FeedListStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedListStateInitial value)? initial,
    TResult Function(FeedListStateLoading value)? loading,
    TResult Function(FeedListStateLoaded value)? loaded,
    TResult Function(FeedListStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FeedListStateLoading implements FeedListState {
  const factory FeedListStateLoading() = _$FeedListStateLoadingImpl;
}

/// @nodoc
abstract class _$$FeedListStateLoadedImplCopyWith<$Res> {
  factory _$$FeedListStateLoadedImplCopyWith(
    _$FeedListStateLoadedImpl value,
    $Res Function(_$FeedListStateLoadedImpl) then,
  ) = __$$FeedListStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Feed> feeds,
    List<FeedCategory> categories,
    String? selectedFeedId,
    bool isRefreshing,
    int totalUnreadCount,
  });
}

/// @nodoc
class __$$FeedListStateLoadedImplCopyWithImpl<$Res>
    extends _$FeedListStateCopyWithImpl<$Res, _$FeedListStateLoadedImpl>
    implements _$$FeedListStateLoadedImplCopyWith<$Res> {
  __$$FeedListStateLoadedImplCopyWithImpl(
    _$FeedListStateLoadedImpl _value,
    $Res Function(_$FeedListStateLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feeds = null,
    Object? categories = null,
    Object? selectedFeedId = freezed,
    Object? isRefreshing = null,
    Object? totalUnreadCount = null,
  }) {
    return _then(
      _$FeedListStateLoadedImpl(
        feeds: null == feeds
            ? _value._feeds
            : feeds // ignore: cast_nullable_to_non_nullable
                  as List<Feed>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<FeedCategory>,
        selectedFeedId: freezed == selectedFeedId
            ? _value.selectedFeedId
            : selectedFeedId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isRefreshing: null == isRefreshing
            ? _value.isRefreshing
            : isRefreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalUnreadCount: null == totalUnreadCount
            ? _value.totalUnreadCount
            : totalUnreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$FeedListStateLoadedImpl implements FeedListStateLoaded {
  const _$FeedListStateLoadedImpl({
    required final List<Feed> feeds,
    required final List<FeedCategory> categories,
    this.selectedFeedId,
    this.isRefreshing = false,
    this.totalUnreadCount = 0,
  }) : _feeds = feeds,
       _categories = categories;

  /// 订阅源列表
  final List<Feed> _feeds;

  /// 订阅源列表
  @override
  List<Feed> get feeds {
    if (_feeds is EqualUnmodifiableListView) return _feeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feeds);
  }

  /// 分类列表
  final List<FeedCategory> _categories;

  /// 分类列表
  @override
  List<FeedCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  /// 当前选中的订阅源 ID
  @override
  final String? selectedFeedId;

  /// 是否正在刷新
  @override
  @JsonKey()
  final bool isRefreshing;

  /// 总未读数
  @override
  @JsonKey()
  final int totalUnreadCount;

  @override
  String toString() {
    return 'FeedListState.loaded(feeds: $feeds, categories: $categories, selectedFeedId: $selectedFeedId, isRefreshing: $isRefreshing, totalUnreadCount: $totalUnreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedListStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._feeds, _feeds) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.selectedFeedId, selectedFeedId) ||
                other.selectedFeedId == selectedFeedId) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.totalUnreadCount, totalUnreadCount) ||
                other.totalUnreadCount == totalUnreadCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_feeds),
    const DeepCollectionEquality().hash(_categories),
    selectedFeedId,
    isRefreshing,
    totalUnreadCount,
  );

  /// Create a copy of FeedListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedListStateLoadedImplCopyWith<_$FeedListStateLoadedImpl> get copyWith =>
      __$$FeedListStateLoadedImplCopyWithImpl<_$FeedListStateLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
      feeds,
      categories,
      selectedFeedId,
      isRefreshing,
      totalUnreadCount,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
      feeds,
      categories,
      selectedFeedId,
      isRefreshing,
      totalUnreadCount,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        feeds,
        categories,
        selectedFeedId,
        isRefreshing,
        totalUnreadCount,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedListStateInitial value) initial,
    required TResult Function(FeedListStateLoading value) loading,
    required TResult Function(FeedListStateLoaded value) loaded,
    required TResult Function(FeedListStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedListStateInitial value)? initial,
    TResult? Function(FeedListStateLoading value)? loading,
    TResult? Function(FeedListStateLoaded value)? loaded,
    TResult? Function(FeedListStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedListStateInitial value)? initial,
    TResult Function(FeedListStateLoading value)? loading,
    TResult Function(FeedListStateLoaded value)? loaded,
    TResult Function(FeedListStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class FeedListStateLoaded implements FeedListState {
  const factory FeedListStateLoaded({
    required final List<Feed> feeds,
    required final List<FeedCategory> categories,
    final String? selectedFeedId,
    final bool isRefreshing,
    final int totalUnreadCount,
  }) = _$FeedListStateLoadedImpl;

  /// 订阅源列表
  List<Feed> get feeds;

  /// 分类列表
  List<FeedCategory> get categories;

  /// 当前选中的订阅源 ID
  String? get selectedFeedId;

  /// 是否正在刷新
  bool get isRefreshing;

  /// 总未读数
  int get totalUnreadCount;

  /// Create a copy of FeedListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedListStateLoadedImplCopyWith<_$FeedListStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FeedListStateErrorImplCopyWith<$Res> {
  factory _$$FeedListStateErrorImplCopyWith(
    _$FeedListStateErrorImpl value,
    $Res Function(_$FeedListStateErrorImpl) then,
  ) = __$$FeedListStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FeedListStateErrorImplCopyWithImpl<$Res>
    extends _$FeedListStateCopyWithImpl<$Res, _$FeedListStateErrorImpl>
    implements _$$FeedListStateErrorImplCopyWith<$Res> {
  __$$FeedListStateErrorImplCopyWithImpl(
    _$FeedListStateErrorImpl _value,
    $Res Function(_$FeedListStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$FeedListStateErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FeedListStateErrorImpl implements FeedListStateError {
  const _$FeedListStateErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'FeedListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedListStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of FeedListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedListStateErrorImplCopyWith<_$FeedListStateErrorImpl> get copyWith =>
      __$$FeedListStateErrorImplCopyWithImpl<_$FeedListStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
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
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
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
      List<Feed> feeds,
      List<FeedCategory> categories,
      String? selectedFeedId,
      bool isRefreshing,
      int totalUnreadCount,
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
    required TResult Function(FeedListStateInitial value) initial,
    required TResult Function(FeedListStateLoading value) loading,
    required TResult Function(FeedListStateLoaded value) loaded,
    required TResult Function(FeedListStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedListStateInitial value)? initial,
    TResult? Function(FeedListStateLoading value)? loading,
    TResult? Function(FeedListStateLoaded value)? loaded,
    TResult? Function(FeedListStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedListStateInitial value)? initial,
    TResult Function(FeedListStateLoading value)? loading,
    TResult Function(FeedListStateLoaded value)? loaded,
    TResult Function(FeedListStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class FeedListStateError implements FeedListState {
  const factory FeedListStateError({required final String message}) =
      _$FeedListStateErrorImpl;

  String get message;

  /// Create a copy of FeedListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedListStateErrorImplCopyWith<_$FeedListStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
