// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> searchHistory) initial,
    required TResult Function(String query, SearchScope scope) searching,
    required TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )
    loaded,
    required TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )
    empty,
    required TResult Function(
      String message,
      String? query,
      List<String> searchHistory,
    )
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> searchHistory)? initial,
    TResult? Function(String query, SearchScope scope)? searching,
    TResult? Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult? Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult? Function(
      String message,
      String? query,
      List<String> searchHistory,
    )?
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> searchHistory)? initial,
    TResult Function(String query, SearchScope scope)? searching,
    TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult Function(String message, String? query, List<String> searchHistory)?
    error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchStateInitial value) initial,
    required TResult Function(SearchStateSearching value) searching,
    required TResult Function(SearchStateLoaded value) loaded,
    required TResult Function(SearchStateEmpty value) empty,
    required TResult Function(SearchStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchStateInitial value)? initial,
    TResult? Function(SearchStateSearching value)? searching,
    TResult? Function(SearchStateLoaded value)? loaded,
    TResult? Function(SearchStateEmpty value)? empty,
    TResult? Function(SearchStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchStateInitial value)? initial,
    TResult Function(SearchStateSearching value)? searching,
    TResult Function(SearchStateLoaded value)? loaded,
    TResult Function(SearchStateEmpty value)? empty,
    TResult Function(SearchStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
    SearchState value,
    $Res Function(SearchState) then,
  ) = _$SearchStateCopyWithImpl<$Res, SearchState>;
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SearchStateInitialImplCopyWith<$Res> {
  factory _$$SearchStateInitialImplCopyWith(
    _$SearchStateInitialImpl value,
    $Res Function(_$SearchStateInitialImpl) then,
  ) = __$$SearchStateInitialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> searchHistory});
}

/// @nodoc
class __$$SearchStateInitialImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateInitialImpl>
    implements _$$SearchStateInitialImplCopyWith<$Res> {
  __$$SearchStateInitialImplCopyWithImpl(
    _$SearchStateInitialImpl _value,
    $Res Function(_$SearchStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? searchHistory = null}) {
    return _then(
      _$SearchStateInitialImpl(
        searchHistory: null == searchHistory
            ? _value._searchHistory
            : searchHistory // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SearchStateInitialImpl implements SearchStateInitial {
  const _$SearchStateInitialImpl({final List<String> searchHistory = const []})
    : _searchHistory = searchHistory;

  /// 搜索历史
  final List<String> _searchHistory;

  /// 搜索历史
  @override
  @JsonKey()
  List<String> get searchHistory {
    if (_searchHistory is EqualUnmodifiableListView) return _searchHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchHistory);
  }

  @override
  String toString() {
    return 'SearchState.initial(searchHistory: $searchHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateInitialImpl &&
            const DeepCollectionEquality().equals(
              other._searchHistory,
              _searchHistory,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_searchHistory),
  );

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateInitialImplCopyWith<_$SearchStateInitialImpl> get copyWith =>
      __$$SearchStateInitialImplCopyWithImpl<_$SearchStateInitialImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> searchHistory) initial,
    required TResult Function(String query, SearchScope scope) searching,
    required TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )
    loaded,
    required TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )
    empty,
    required TResult Function(
      String message,
      String? query,
      List<String> searchHistory,
    )
    error,
  }) {
    return initial(searchHistory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> searchHistory)? initial,
    TResult? Function(String query, SearchScope scope)? searching,
    TResult? Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult? Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult? Function(
      String message,
      String? query,
      List<String> searchHistory,
    )?
    error,
  }) {
    return initial?.call(searchHistory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> searchHistory)? initial,
    TResult Function(String query, SearchScope scope)? searching,
    TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult Function(String message, String? query, List<String> searchHistory)?
    error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(searchHistory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchStateInitial value) initial,
    required TResult Function(SearchStateSearching value) searching,
    required TResult Function(SearchStateLoaded value) loaded,
    required TResult Function(SearchStateEmpty value) empty,
    required TResult Function(SearchStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchStateInitial value)? initial,
    TResult? Function(SearchStateSearching value)? searching,
    TResult? Function(SearchStateLoaded value)? loaded,
    TResult? Function(SearchStateEmpty value)? empty,
    TResult? Function(SearchStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchStateInitial value)? initial,
    TResult Function(SearchStateSearching value)? searching,
    TResult Function(SearchStateLoaded value)? loaded,
    TResult Function(SearchStateEmpty value)? empty,
    TResult Function(SearchStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SearchStateInitial implements SearchState {
  const factory SearchStateInitial({final List<String> searchHistory}) =
      _$SearchStateInitialImpl;

  /// 搜索历史
  List<String> get searchHistory;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStateInitialImplCopyWith<_$SearchStateInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchStateSearchingImplCopyWith<$Res> {
  factory _$$SearchStateSearchingImplCopyWith(
    _$SearchStateSearchingImpl value,
    $Res Function(_$SearchStateSearchingImpl) then,
  ) = __$$SearchStateSearchingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query, SearchScope scope});
}

/// @nodoc
class __$$SearchStateSearchingImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateSearchingImpl>
    implements _$$SearchStateSearchingImplCopyWith<$Res> {
  __$$SearchStateSearchingImplCopyWithImpl(
    _$SearchStateSearchingImpl _value,
    $Res Function(_$SearchStateSearchingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null, Object? scope = null}) {
    return _then(
      _$SearchStateSearchingImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
        scope: null == scope
            ? _value.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as SearchScope,
      ),
    );
  }
}

/// @nodoc

class _$SearchStateSearchingImpl implements SearchStateSearching {
  const _$SearchStateSearchingImpl({required this.query, required this.scope});

  /// 当前搜索关键词
  @override
  final String query;

  /// 当前搜索范围
  @override
  final SearchScope scope;

  @override
  String toString() {
    return 'SearchState.searching(query: $query, scope: $scope)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateSearchingImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.scope, scope) || other.scope == scope));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, scope);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateSearchingImplCopyWith<_$SearchStateSearchingImpl>
  get copyWith =>
      __$$SearchStateSearchingImplCopyWithImpl<_$SearchStateSearchingImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> searchHistory) initial,
    required TResult Function(String query, SearchScope scope) searching,
    required TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )
    loaded,
    required TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )
    empty,
    required TResult Function(
      String message,
      String? query,
      List<String> searchHistory,
    )
    error,
  }) {
    return searching(query, scope);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> searchHistory)? initial,
    TResult? Function(String query, SearchScope scope)? searching,
    TResult? Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult? Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult? Function(
      String message,
      String? query,
      List<String> searchHistory,
    )?
    error,
  }) {
    return searching?.call(query, scope);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> searchHistory)? initial,
    TResult Function(String query, SearchScope scope)? searching,
    TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult Function(String message, String? query, List<String> searchHistory)?
    error,
    required TResult orElse(),
  }) {
    if (searching != null) {
      return searching(query, scope);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchStateInitial value) initial,
    required TResult Function(SearchStateSearching value) searching,
    required TResult Function(SearchStateLoaded value) loaded,
    required TResult Function(SearchStateEmpty value) empty,
    required TResult Function(SearchStateError value) error,
  }) {
    return searching(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchStateInitial value)? initial,
    TResult? Function(SearchStateSearching value)? searching,
    TResult? Function(SearchStateLoaded value)? loaded,
    TResult? Function(SearchStateEmpty value)? empty,
    TResult? Function(SearchStateError value)? error,
  }) {
    return searching?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchStateInitial value)? initial,
    TResult Function(SearchStateSearching value)? searching,
    TResult Function(SearchStateLoaded value)? loaded,
    TResult Function(SearchStateEmpty value)? empty,
    TResult Function(SearchStateError value)? error,
    required TResult orElse(),
  }) {
    if (searching != null) {
      return searching(this);
    }
    return orElse();
  }
}

abstract class SearchStateSearching implements SearchState {
  const factory SearchStateSearching({
    required final String query,
    required final SearchScope scope,
  }) = _$SearchStateSearchingImpl;

  /// 当前搜索关键词
  String get query;

  /// 当前搜索范围
  SearchScope get scope;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStateSearchingImplCopyWith<_$SearchStateSearchingImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchStateLoadedImplCopyWith<$Res> {
  factory _$$SearchStateLoadedImplCopyWith(
    _$SearchStateLoadedImpl value,
    $Res Function(_$SearchStateLoadedImpl) then,
  ) = __$$SearchStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    SearchResult result,
    List<String> searchHistory,
    List<String> suggestions,
  });

  $SearchResultCopyWith<$Res> get result;
}

/// @nodoc
class __$$SearchStateLoadedImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateLoadedImpl>
    implements _$$SearchStateLoadedImplCopyWith<$Res> {
  __$$SearchStateLoadedImplCopyWithImpl(
    _$SearchStateLoadedImpl _value,
    $Res Function(_$SearchStateLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? searchHistory = null,
    Object? suggestions = null,
  }) {
    return _then(
      _$SearchStateLoadedImpl(
        result: null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as SearchResult,
        searchHistory: null == searchHistory
            ? _value._searchHistory
            : searchHistory // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        suggestions: null == suggestions
            ? _value._suggestions
            : suggestions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SearchResultCopyWith<$Res> get result {
    return $SearchResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$SearchStateLoadedImpl implements SearchStateLoaded {
  const _$SearchStateLoadedImpl({
    required this.result,
    final List<String> searchHistory = const [],
    final List<String> suggestions = const [],
  }) : _searchHistory = searchHistory,
       _suggestions = suggestions;

  /// 搜索结果
  @override
  final SearchResult result;

  /// 搜索历史
  final List<String> _searchHistory;

  /// 搜索历史
  @override
  @JsonKey()
  List<String> get searchHistory {
    if (_searchHistory is EqualUnmodifiableListView) return _searchHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchHistory);
  }

  /// 搜索建议
  final List<String> _suggestions;

  /// 搜索建议
  @override
  @JsonKey()
  List<String> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  @override
  String toString() {
    return 'SearchState.loaded(result: $result, searchHistory: $searchHistory, suggestions: $suggestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateLoadedImpl &&
            (identical(other.result, result) || other.result == result) &&
            const DeepCollectionEquality().equals(
              other._searchHistory,
              _searchHistory,
            ) &&
            const DeepCollectionEquality().equals(
              other._suggestions,
              _suggestions,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    result,
    const DeepCollectionEquality().hash(_searchHistory),
    const DeepCollectionEquality().hash(_suggestions),
  );

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateLoadedImplCopyWith<_$SearchStateLoadedImpl> get copyWith =>
      __$$SearchStateLoadedImplCopyWithImpl<_$SearchStateLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> searchHistory) initial,
    required TResult Function(String query, SearchScope scope) searching,
    required TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )
    loaded,
    required TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )
    empty,
    required TResult Function(
      String message,
      String? query,
      List<String> searchHistory,
    )
    error,
  }) {
    return loaded(result, searchHistory, suggestions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> searchHistory)? initial,
    TResult? Function(String query, SearchScope scope)? searching,
    TResult? Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult? Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult? Function(
      String message,
      String? query,
      List<String> searchHistory,
    )?
    error,
  }) {
    return loaded?.call(result, searchHistory, suggestions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> searchHistory)? initial,
    TResult Function(String query, SearchScope scope)? searching,
    TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult Function(String message, String? query, List<String> searchHistory)?
    error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(result, searchHistory, suggestions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchStateInitial value) initial,
    required TResult Function(SearchStateSearching value) searching,
    required TResult Function(SearchStateLoaded value) loaded,
    required TResult Function(SearchStateEmpty value) empty,
    required TResult Function(SearchStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchStateInitial value)? initial,
    TResult? Function(SearchStateSearching value)? searching,
    TResult? Function(SearchStateLoaded value)? loaded,
    TResult? Function(SearchStateEmpty value)? empty,
    TResult? Function(SearchStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchStateInitial value)? initial,
    TResult Function(SearchStateSearching value)? searching,
    TResult Function(SearchStateLoaded value)? loaded,
    TResult Function(SearchStateEmpty value)? empty,
    TResult Function(SearchStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SearchStateLoaded implements SearchState {
  const factory SearchStateLoaded({
    required final SearchResult result,
    final List<String> searchHistory,
    final List<String> suggestions,
  }) = _$SearchStateLoadedImpl;

  /// 搜索结果
  SearchResult get result;

  /// 搜索历史
  List<String> get searchHistory;

  /// 搜索建议
  List<String> get suggestions;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStateLoadedImplCopyWith<_$SearchStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchStateEmptyImplCopyWith<$Res> {
  factory _$$SearchStateEmptyImplCopyWith(
    _$SearchStateEmptyImpl value,
    $Res Function(_$SearchStateEmptyImpl) then,
  ) = __$$SearchStateEmptyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query, SearchScope scope, List<String> searchHistory});
}

/// @nodoc
class __$$SearchStateEmptyImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateEmptyImpl>
    implements _$$SearchStateEmptyImplCopyWith<$Res> {
  __$$SearchStateEmptyImplCopyWithImpl(
    _$SearchStateEmptyImpl _value,
    $Res Function(_$SearchStateEmptyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? scope = null,
    Object? searchHistory = null,
  }) {
    return _then(
      _$SearchStateEmptyImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
        scope: null == scope
            ? _value.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as SearchScope,
        searchHistory: null == searchHistory
            ? _value._searchHistory
            : searchHistory // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SearchStateEmptyImpl implements SearchStateEmpty {
  const _$SearchStateEmptyImpl({
    required this.query,
    required this.scope,
    final List<String> searchHistory = const [],
  }) : _searchHistory = searchHistory;

  /// 搜索关键词
  @override
  final String query;

  /// 搜索范围
  @override
  final SearchScope scope;

  /// 搜索历史
  final List<String> _searchHistory;

  /// 搜索历史
  @override
  @JsonKey()
  List<String> get searchHistory {
    if (_searchHistory is EqualUnmodifiableListView) return _searchHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchHistory);
  }

  @override
  String toString() {
    return 'SearchState.empty(query: $query, scope: $scope, searchHistory: $searchHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateEmptyImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.scope, scope) || other.scope == scope) &&
            const DeepCollectionEquality().equals(
              other._searchHistory,
              _searchHistory,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    query,
    scope,
    const DeepCollectionEquality().hash(_searchHistory),
  );

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateEmptyImplCopyWith<_$SearchStateEmptyImpl> get copyWith =>
      __$$SearchStateEmptyImplCopyWithImpl<_$SearchStateEmptyImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> searchHistory) initial,
    required TResult Function(String query, SearchScope scope) searching,
    required TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )
    loaded,
    required TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )
    empty,
    required TResult Function(
      String message,
      String? query,
      List<String> searchHistory,
    )
    error,
  }) {
    return empty(query, scope, searchHistory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> searchHistory)? initial,
    TResult? Function(String query, SearchScope scope)? searching,
    TResult? Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult? Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult? Function(
      String message,
      String? query,
      List<String> searchHistory,
    )?
    error,
  }) {
    return empty?.call(query, scope, searchHistory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> searchHistory)? initial,
    TResult Function(String query, SearchScope scope)? searching,
    TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult Function(String message, String? query, List<String> searchHistory)?
    error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(query, scope, searchHistory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchStateInitial value) initial,
    required TResult Function(SearchStateSearching value) searching,
    required TResult Function(SearchStateLoaded value) loaded,
    required TResult Function(SearchStateEmpty value) empty,
    required TResult Function(SearchStateError value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchStateInitial value)? initial,
    TResult? Function(SearchStateSearching value)? searching,
    TResult? Function(SearchStateLoaded value)? loaded,
    TResult? Function(SearchStateEmpty value)? empty,
    TResult? Function(SearchStateError value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchStateInitial value)? initial,
    TResult Function(SearchStateSearching value)? searching,
    TResult Function(SearchStateLoaded value)? loaded,
    TResult Function(SearchStateEmpty value)? empty,
    TResult Function(SearchStateError value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class SearchStateEmpty implements SearchState {
  const factory SearchStateEmpty({
    required final String query,
    required final SearchScope scope,
    final List<String> searchHistory,
  }) = _$SearchStateEmptyImpl;

  /// 搜索关键词
  String get query;

  /// 搜索范围
  SearchScope get scope;

  /// 搜索历史
  List<String> get searchHistory;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStateEmptyImplCopyWith<_$SearchStateEmptyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchStateErrorImplCopyWith<$Res> {
  factory _$$SearchStateErrorImplCopyWith(
    _$SearchStateErrorImpl value,
    $Res Function(_$SearchStateErrorImpl) then,
  ) = __$$SearchStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String? query, List<String> searchHistory});
}

/// @nodoc
class __$$SearchStateErrorImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateErrorImpl>
    implements _$$SearchStateErrorImplCopyWith<$Res> {
  __$$SearchStateErrorImplCopyWithImpl(
    _$SearchStateErrorImpl _value,
    $Res Function(_$SearchStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? query = freezed,
    Object? searchHistory = null,
  }) {
    return _then(
      _$SearchStateErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        query: freezed == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String?,
        searchHistory: null == searchHistory
            ? _value._searchHistory
            : searchHistory // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SearchStateErrorImpl implements SearchStateError {
  const _$SearchStateErrorImpl({
    required this.message,
    this.query,
    final List<String> searchHistory = const [],
  }) : _searchHistory = searchHistory;

  @override
  final String message;

  /// 搜索关键词
  @override
  final String? query;

  /// 搜索历史
  final List<String> _searchHistory;

  /// 搜索历史
  @override
  @JsonKey()
  List<String> get searchHistory {
    if (_searchHistory is EqualUnmodifiableListView) return _searchHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchHistory);
  }

  @override
  String toString() {
    return 'SearchState.error(message: $message, query: $query, searchHistory: $searchHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(
              other._searchHistory,
              _searchHistory,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    query,
    const DeepCollectionEquality().hash(_searchHistory),
  );

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateErrorImplCopyWith<_$SearchStateErrorImpl> get copyWith =>
      __$$SearchStateErrorImplCopyWithImpl<_$SearchStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> searchHistory) initial,
    required TResult Function(String query, SearchScope scope) searching,
    required TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )
    loaded,
    required TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )
    empty,
    required TResult Function(
      String message,
      String? query,
      List<String> searchHistory,
    )
    error,
  }) {
    return error(message, query, searchHistory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> searchHistory)? initial,
    TResult? Function(String query, SearchScope scope)? searching,
    TResult? Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult? Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult? Function(
      String message,
      String? query,
      List<String> searchHistory,
    )?
    error,
  }) {
    return error?.call(message, query, searchHistory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> searchHistory)? initial,
    TResult Function(String query, SearchScope scope)? searching,
    TResult Function(
      SearchResult result,
      List<String> searchHistory,
      List<String> suggestions,
    )?
    loaded,
    TResult Function(
      String query,
      SearchScope scope,
      List<String> searchHistory,
    )?
    empty,
    TResult Function(String message, String? query, List<String> searchHistory)?
    error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, query, searchHistory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchStateInitial value) initial,
    required TResult Function(SearchStateSearching value) searching,
    required TResult Function(SearchStateLoaded value) loaded,
    required TResult Function(SearchStateEmpty value) empty,
    required TResult Function(SearchStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchStateInitial value)? initial,
    TResult? Function(SearchStateSearching value)? searching,
    TResult? Function(SearchStateLoaded value)? loaded,
    TResult? Function(SearchStateEmpty value)? empty,
    TResult? Function(SearchStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchStateInitial value)? initial,
    TResult Function(SearchStateSearching value)? searching,
    TResult Function(SearchStateLoaded value)? loaded,
    TResult Function(SearchStateEmpty value)? empty,
    TResult Function(SearchStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SearchStateError implements SearchState {
  const factory SearchStateError({
    required final String message,
    final String? query,
    final List<String> searchHistory,
  }) = _$SearchStateErrorImpl;

  String get message;

  /// 搜索关键词
  String? get query;

  /// 搜索历史
  List<String> get searchHistory;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStateErrorImplCopyWith<_$SearchStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
