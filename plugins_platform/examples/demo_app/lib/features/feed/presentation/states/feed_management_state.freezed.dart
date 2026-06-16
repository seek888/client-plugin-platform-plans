// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FeedManagementState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedManagementStateInitial value) initial,
    required TResult Function(FeedManagementStateLoading value) loading,
    required TResult Function(FeedManagementStateLoaded value) loaded,
    required TResult Function(FeedManagementStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedManagementStateInitial value)? initial,
    TResult? Function(FeedManagementStateLoading value)? loading,
    TResult? Function(FeedManagementStateLoaded value)? loaded,
    TResult? Function(FeedManagementStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedManagementStateInitial value)? initial,
    TResult Function(FeedManagementStateLoading value)? loading,
    TResult Function(FeedManagementStateLoaded value)? loaded,
    TResult Function(FeedManagementStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedManagementStateCopyWith<$Res> {
  factory $FeedManagementStateCopyWith(
    FeedManagementState value,
    $Res Function(FeedManagementState) then,
  ) = _$FeedManagementStateCopyWithImpl<$Res, FeedManagementState>;
}

/// @nodoc
class _$FeedManagementStateCopyWithImpl<$Res, $Val extends FeedManagementState>
    implements $FeedManagementStateCopyWith<$Res> {
  _$FeedManagementStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FeedManagementStateInitialImplCopyWith<$Res> {
  factory _$$FeedManagementStateInitialImplCopyWith(
    _$FeedManagementStateInitialImpl value,
    $Res Function(_$FeedManagementStateInitialImpl) then,
  ) = __$$FeedManagementStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FeedManagementStateInitialImplCopyWithImpl<$Res>
    extends
        _$FeedManagementStateCopyWithImpl<
          $Res,
          _$FeedManagementStateInitialImpl
        >
    implements _$$FeedManagementStateInitialImplCopyWith<$Res> {
  __$$FeedManagementStateInitialImplCopyWithImpl(
    _$FeedManagementStateInitialImpl _value,
    $Res Function(_$FeedManagementStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FeedManagementStateInitialImpl implements FeedManagementStateInitial {
  const _$FeedManagementStateInitialImpl();

  @override
  String toString() {
    return 'FeedManagementState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedManagementStateInitialImpl);
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
    required TResult Function(FeedManagementStateInitial value) initial,
    required TResult Function(FeedManagementStateLoading value) loading,
    required TResult Function(FeedManagementStateLoaded value) loaded,
    required TResult Function(FeedManagementStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedManagementStateInitial value)? initial,
    TResult? Function(FeedManagementStateLoading value)? loading,
    TResult? Function(FeedManagementStateLoaded value)? loaded,
    TResult? Function(FeedManagementStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedManagementStateInitial value)? initial,
    TResult Function(FeedManagementStateLoading value)? loading,
    TResult Function(FeedManagementStateLoaded value)? loaded,
    TResult Function(FeedManagementStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class FeedManagementStateInitial implements FeedManagementState {
  const factory FeedManagementStateInitial() = _$FeedManagementStateInitialImpl;
}

/// @nodoc
abstract class _$$FeedManagementStateLoadingImplCopyWith<$Res> {
  factory _$$FeedManagementStateLoadingImplCopyWith(
    _$FeedManagementStateLoadingImpl value,
    $Res Function(_$FeedManagementStateLoadingImpl) then,
  ) = __$$FeedManagementStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FeedManagementStateLoadingImplCopyWithImpl<$Res>
    extends
        _$FeedManagementStateCopyWithImpl<
          $Res,
          _$FeedManagementStateLoadingImpl
        >
    implements _$$FeedManagementStateLoadingImplCopyWith<$Res> {
  __$$FeedManagementStateLoadingImplCopyWithImpl(
    _$FeedManagementStateLoadingImpl _value,
    $Res Function(_$FeedManagementStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FeedManagementStateLoadingImpl implements FeedManagementStateLoading {
  const _$FeedManagementStateLoadingImpl();

  @override
  String toString() {
    return 'FeedManagementState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedManagementStateLoadingImpl);
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
    required TResult Function(FeedManagementStateInitial value) initial,
    required TResult Function(FeedManagementStateLoading value) loading,
    required TResult Function(FeedManagementStateLoaded value) loaded,
    required TResult Function(FeedManagementStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedManagementStateInitial value)? initial,
    TResult? Function(FeedManagementStateLoading value)? loading,
    TResult? Function(FeedManagementStateLoaded value)? loaded,
    TResult? Function(FeedManagementStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedManagementStateInitial value)? initial,
    TResult Function(FeedManagementStateLoading value)? loading,
    TResult Function(FeedManagementStateLoaded value)? loaded,
    TResult Function(FeedManagementStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FeedManagementStateLoading implements FeedManagementState {
  const factory FeedManagementStateLoading() = _$FeedManagementStateLoadingImpl;
}

/// @nodoc
abstract class _$$FeedManagementStateLoadedImplCopyWith<$Res> {
  factory _$$FeedManagementStateLoadedImplCopyWith(
    _$FeedManagementStateLoadedImpl value,
    $Res Function(_$FeedManagementStateLoadedImpl) then,
  ) = __$$FeedManagementStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Feed> feeds,
    List<FeedCategory> categories,
    bool isSelectionMode,
    List<String> selectedFeedIds,
    bool isImporting,
    bool isExporting,
    bool isValidating,
    FeedValidationState? validationState,
    bool isDragging,
    SourceType selectedSourceType,
  });

  $FeedValidationStateCopyWith<$Res>? get validationState;
}

/// @nodoc
class __$$FeedManagementStateLoadedImplCopyWithImpl<$Res>
    extends
        _$FeedManagementStateCopyWithImpl<$Res, _$FeedManagementStateLoadedImpl>
    implements _$$FeedManagementStateLoadedImplCopyWith<$Res> {
  __$$FeedManagementStateLoadedImplCopyWithImpl(
    _$FeedManagementStateLoadedImpl _value,
    $Res Function(_$FeedManagementStateLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feeds = null,
    Object? categories = null,
    Object? isSelectionMode = null,
    Object? selectedFeedIds = null,
    Object? isImporting = null,
    Object? isExporting = null,
    Object? isValidating = null,
    Object? validationState = freezed,
    Object? isDragging = null,
    Object? selectedSourceType = null,
  }) {
    return _then(
      _$FeedManagementStateLoadedImpl(
        feeds: null == feeds
            ? _value._feeds
            : feeds // ignore: cast_nullable_to_non_nullable
                  as List<Feed>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<FeedCategory>,
        isSelectionMode: null == isSelectionMode
            ? _value.isSelectionMode
            : isSelectionMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedFeedIds: null == selectedFeedIds
            ? _value._selectedFeedIds
            : selectedFeedIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isImporting: null == isImporting
            ? _value.isImporting
            : isImporting // ignore: cast_nullable_to_non_nullable
                  as bool,
        isExporting: null == isExporting
            ? _value.isExporting
            : isExporting // ignore: cast_nullable_to_non_nullable
                  as bool,
        isValidating: null == isValidating
            ? _value.isValidating
            : isValidating // ignore: cast_nullable_to_non_nullable
                  as bool,
        validationState: freezed == validationState
            ? _value.validationState
            : validationState // ignore: cast_nullable_to_non_nullable
                  as FeedValidationState?,
        isDragging: null == isDragging
            ? _value.isDragging
            : isDragging // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedSourceType: null == selectedSourceType
            ? _value.selectedSourceType
            : selectedSourceType // ignore: cast_nullable_to_non_nullable
                  as SourceType,
      ),
    );
  }

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeedValidationStateCopyWith<$Res>? get validationState {
    if (_value.validationState == null) {
      return null;
    }

    return $FeedValidationStateCopyWith<$Res>(_value.validationState!, (value) {
      return _then(_value.copyWith(validationState: value));
    });
  }
}

/// @nodoc

class _$FeedManagementStateLoadedImpl implements FeedManagementStateLoaded {
  const _$FeedManagementStateLoadedImpl({
    required final List<Feed> feeds,
    required final List<FeedCategory> categories,
    this.isSelectionMode = false,
    final List<String> selectedFeedIds = const [],
    this.isImporting = false,
    this.isExporting = false,
    this.isValidating = false,
    this.validationState,
    this.isDragging = false,
    this.selectedSourceType = SourceType.rss,
  }) : _feeds = feeds,
       _categories = categories,
       _selectedFeedIds = selectedFeedIds;

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

  /// 是否处于批量选择模式
  @override
  @JsonKey()
  final bool isSelectionMode;

  /// 已选中的订阅源 ID 列表
  final List<String> _selectedFeedIds;

  /// 已选中的订阅源 ID 列表
  @override
  @JsonKey()
  List<String> get selectedFeedIds {
    if (_selectedFeedIds is EqualUnmodifiableListView) return _selectedFeedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedFeedIds);
  }

  /// 是否正在导入 OPML
  @override
  @JsonKey()
  final bool isImporting;

  /// 是否正在导出 OPML
  @override
  @JsonKey()
  final bool isExporting;

  /// 是否正在验证 URL
  @override
  @JsonKey()
  final bool isValidating;

  /// URL 验证结果
  @override
  final FeedValidationState? validationState;

  /// 是否正在拖拽排序
  @override
  @JsonKey()
  final bool isDragging;

  /// 当前选择的数据源类型（添加对话框用）
  @override
  @JsonKey()
  final SourceType selectedSourceType;

  @override
  String toString() {
    return 'FeedManagementState.loaded(feeds: $feeds, categories: $categories, isSelectionMode: $isSelectionMode, selectedFeedIds: $selectedFeedIds, isImporting: $isImporting, isExporting: $isExporting, isValidating: $isValidating, validationState: $validationState, isDragging: $isDragging, selectedSourceType: $selectedSourceType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedManagementStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._feeds, _feeds) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.isSelectionMode, isSelectionMode) ||
                other.isSelectionMode == isSelectionMode) &&
            const DeepCollectionEquality().equals(
              other._selectedFeedIds,
              _selectedFeedIds,
            ) &&
            (identical(other.isImporting, isImporting) ||
                other.isImporting == isImporting) &&
            (identical(other.isExporting, isExporting) ||
                other.isExporting == isExporting) &&
            (identical(other.isValidating, isValidating) ||
                other.isValidating == isValidating) &&
            (identical(other.validationState, validationState) ||
                other.validationState == validationState) &&
            (identical(other.isDragging, isDragging) ||
                other.isDragging == isDragging) &&
            (identical(other.selectedSourceType, selectedSourceType) ||
                other.selectedSourceType == selectedSourceType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_feeds),
    const DeepCollectionEquality().hash(_categories),
    isSelectionMode,
    const DeepCollectionEquality().hash(_selectedFeedIds),
    isImporting,
    isExporting,
    isValidating,
    validationState,
    isDragging,
    selectedSourceType,
  );

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedManagementStateLoadedImplCopyWith<_$FeedManagementStateLoadedImpl>
  get copyWith =>
      __$$FeedManagementStateLoadedImplCopyWithImpl<
        _$FeedManagementStateLoadedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
      feeds,
      categories,
      isSelectionMode,
      selectedFeedIds,
      isImporting,
      isExporting,
      isValidating,
      validationState,
      isDragging,
      selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
      feeds,
      categories,
      isSelectionMode,
      selectedFeedIds,
      isImporting,
      isExporting,
      isValidating,
      validationState,
      isDragging,
      selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        feeds,
        categories,
        isSelectionMode,
        selectedFeedIds,
        isImporting,
        isExporting,
        isValidating,
        validationState,
        isDragging,
        selectedSourceType,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedManagementStateInitial value) initial,
    required TResult Function(FeedManagementStateLoading value) loading,
    required TResult Function(FeedManagementStateLoaded value) loaded,
    required TResult Function(FeedManagementStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedManagementStateInitial value)? initial,
    TResult? Function(FeedManagementStateLoading value)? loading,
    TResult? Function(FeedManagementStateLoaded value)? loaded,
    TResult? Function(FeedManagementStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedManagementStateInitial value)? initial,
    TResult Function(FeedManagementStateLoading value)? loading,
    TResult Function(FeedManagementStateLoaded value)? loaded,
    TResult Function(FeedManagementStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class FeedManagementStateLoaded implements FeedManagementState {
  const factory FeedManagementStateLoaded({
    required final List<Feed> feeds,
    required final List<FeedCategory> categories,
    final bool isSelectionMode,
    final List<String> selectedFeedIds,
    final bool isImporting,
    final bool isExporting,
    final bool isValidating,
    final FeedValidationState? validationState,
    final bool isDragging,
    final SourceType selectedSourceType,
  }) = _$FeedManagementStateLoadedImpl;

  /// 订阅源列表
  List<Feed> get feeds;

  /// 分类列表
  List<FeedCategory> get categories;

  /// 是否处于批量选择模式
  bool get isSelectionMode;

  /// 已选中的订阅源 ID 列表
  List<String> get selectedFeedIds;

  /// 是否正在导入 OPML
  bool get isImporting;

  /// 是否正在导出 OPML
  bool get isExporting;

  /// 是否正在验证 URL
  bool get isValidating;

  /// URL 验证结果
  FeedValidationState? get validationState;

  /// 是否正在拖拽排序
  bool get isDragging;

  /// 当前选择的数据源类型（添加对话框用）
  SourceType get selectedSourceType;

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedManagementStateLoadedImplCopyWith<_$FeedManagementStateLoadedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FeedManagementStateErrorImplCopyWith<$Res> {
  factory _$$FeedManagementStateErrorImplCopyWith(
    _$FeedManagementStateErrorImpl value,
    $Res Function(_$FeedManagementStateErrorImpl) then,
  ) = __$$FeedManagementStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FeedManagementStateErrorImplCopyWithImpl<$Res>
    extends
        _$FeedManagementStateCopyWithImpl<$Res, _$FeedManagementStateErrorImpl>
    implements _$$FeedManagementStateErrorImplCopyWith<$Res> {
  __$$FeedManagementStateErrorImplCopyWithImpl(
    _$FeedManagementStateErrorImpl _value,
    $Res Function(_$FeedManagementStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$FeedManagementStateErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FeedManagementStateErrorImpl implements FeedManagementStateError {
  const _$FeedManagementStateErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'FeedManagementState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedManagementStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedManagementStateErrorImplCopyWith<_$FeedManagementStateErrorImpl>
  get copyWith =>
      __$$FeedManagementStateErrorImplCopyWithImpl<
        _$FeedManagementStateErrorImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Feed> feeds,
      List<FeedCategory> categories,
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
      bool isSelectionMode,
      List<String> selectedFeedIds,
      bool isImporting,
      bool isExporting,
      bool isValidating,
      FeedValidationState? validationState,
      bool isDragging,
      SourceType selectedSourceType,
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
    required TResult Function(FeedManagementStateInitial value) initial,
    required TResult Function(FeedManagementStateLoading value) loading,
    required TResult Function(FeedManagementStateLoaded value) loaded,
    required TResult Function(FeedManagementStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedManagementStateInitial value)? initial,
    TResult? Function(FeedManagementStateLoading value)? loading,
    TResult? Function(FeedManagementStateLoaded value)? loaded,
    TResult? Function(FeedManagementStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedManagementStateInitial value)? initial,
    TResult Function(FeedManagementStateLoading value)? loading,
    TResult Function(FeedManagementStateLoaded value)? loaded,
    TResult Function(FeedManagementStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class FeedManagementStateError implements FeedManagementState {
  const factory FeedManagementStateError({required final String message}) =
      _$FeedManagementStateErrorImpl;

  String get message;

  /// Create a copy of FeedManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedManagementStateErrorImplCopyWith<_$FeedManagementStateErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FeedValidationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() validating,
    required TResult Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )
    success,
    required TResult Function(String errorMessage) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? validating,
    TResult? Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )?
    success,
    TResult? Function(String errorMessage)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? validating,
    TResult Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )?
    success,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedValidationStateValidating value) validating,
    required TResult Function(FeedValidationStateSuccess value) success,
    required TResult Function(FeedValidationStateFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedValidationStateValidating value)? validating,
    TResult? Function(FeedValidationStateSuccess value)? success,
    TResult? Function(FeedValidationStateFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedValidationStateValidating value)? validating,
    TResult Function(FeedValidationStateSuccess value)? success,
    TResult Function(FeedValidationStateFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedValidationStateCopyWith<$Res> {
  factory $FeedValidationStateCopyWith(
    FeedValidationState value,
    $Res Function(FeedValidationState) then,
  ) = _$FeedValidationStateCopyWithImpl<$Res, FeedValidationState>;
}

/// @nodoc
class _$FeedValidationStateCopyWithImpl<$Res, $Val extends FeedValidationState>
    implements $FeedValidationStateCopyWith<$Res> {
  _$FeedValidationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedValidationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FeedValidationStateValidatingImplCopyWith<$Res> {
  factory _$$FeedValidationStateValidatingImplCopyWith(
    _$FeedValidationStateValidatingImpl value,
    $Res Function(_$FeedValidationStateValidatingImpl) then,
  ) = __$$FeedValidationStateValidatingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FeedValidationStateValidatingImplCopyWithImpl<$Res>
    extends
        _$FeedValidationStateCopyWithImpl<
          $Res,
          _$FeedValidationStateValidatingImpl
        >
    implements _$$FeedValidationStateValidatingImplCopyWith<$Res> {
  __$$FeedValidationStateValidatingImplCopyWithImpl(
    _$FeedValidationStateValidatingImpl _value,
    $Res Function(_$FeedValidationStateValidatingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedValidationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FeedValidationStateValidatingImpl
    implements FeedValidationStateValidating {
  const _$FeedValidationStateValidatingImpl();

  @override
  String toString() {
    return 'FeedValidationState.validating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedValidationStateValidatingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() validating,
    required TResult Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )
    success,
    required TResult Function(String errorMessage) failure,
  }) {
    return validating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? validating,
    TResult? Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )?
    success,
    TResult? Function(String errorMessage)? failure,
  }) {
    return validating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? validating,
    TResult Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )?
    success,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) {
    if (validating != null) {
      return validating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedValidationStateValidating value) validating,
    required TResult Function(FeedValidationStateSuccess value) success,
    required TResult Function(FeedValidationStateFailure value) failure,
  }) {
    return validating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedValidationStateValidating value)? validating,
    TResult? Function(FeedValidationStateSuccess value)? success,
    TResult? Function(FeedValidationStateFailure value)? failure,
  }) {
    return validating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedValidationStateValidating value)? validating,
    TResult Function(FeedValidationStateSuccess value)? success,
    TResult Function(FeedValidationStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (validating != null) {
      return validating(this);
    }
    return orElse();
  }
}

abstract class FeedValidationStateValidating implements FeedValidationState {
  const factory FeedValidationStateValidating() =
      _$FeedValidationStateValidatingImpl;
}

/// @nodoc
abstract class _$$FeedValidationStateSuccessImplCopyWith<$Res> {
  factory _$$FeedValidationStateSuccessImplCopyWith(
    _$FeedValidationStateSuccessImpl value,
    $Res Function(_$FeedValidationStateSuccessImpl) then,
  ) = __$$FeedValidationStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String feedTitle,
    String? feedDescription,
    String? iconUrl,
    int articleCount,
    SourceType sourceType,
  });
}

/// @nodoc
class __$$FeedValidationStateSuccessImplCopyWithImpl<$Res>
    extends
        _$FeedValidationStateCopyWithImpl<
          $Res,
          _$FeedValidationStateSuccessImpl
        >
    implements _$$FeedValidationStateSuccessImplCopyWith<$Res> {
  __$$FeedValidationStateSuccessImplCopyWithImpl(
    _$FeedValidationStateSuccessImpl _value,
    $Res Function(_$FeedValidationStateSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedValidationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feedTitle = null,
    Object? feedDescription = freezed,
    Object? iconUrl = freezed,
    Object? articleCount = null,
    Object? sourceType = null,
  }) {
    return _then(
      _$FeedValidationStateSuccessImpl(
        feedTitle: null == feedTitle
            ? _value.feedTitle
            : feedTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        feedDescription: freezed == feedDescription
            ? _value.feedDescription
            : feedDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        articleCount: null == articleCount
            ? _value.articleCount
            : articleCount // ignore: cast_nullable_to_non_nullable
                  as int,
        sourceType: null == sourceType
            ? _value.sourceType
            : sourceType // ignore: cast_nullable_to_non_nullable
                  as SourceType,
      ),
    );
  }
}

/// @nodoc

class _$FeedValidationStateSuccessImpl implements FeedValidationStateSuccess {
  const _$FeedValidationStateSuccessImpl({
    required this.feedTitle,
    this.feedDescription,
    this.iconUrl,
    required this.articleCount,
    this.sourceType = SourceType.rss,
  });

  @override
  final String feedTitle;
  @override
  final String? feedDescription;
  @override
  final String? iconUrl;
  @override
  final int articleCount;
  @override
  @JsonKey()
  final SourceType sourceType;

  @override
  String toString() {
    return 'FeedValidationState.success(feedTitle: $feedTitle, feedDescription: $feedDescription, iconUrl: $iconUrl, articleCount: $articleCount, sourceType: $sourceType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedValidationStateSuccessImpl &&
            (identical(other.feedTitle, feedTitle) ||
                other.feedTitle == feedTitle) &&
            (identical(other.feedDescription, feedDescription) ||
                other.feedDescription == feedDescription) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.articleCount, articleCount) ||
                other.articleCount == articleCount) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    feedTitle,
    feedDescription,
    iconUrl,
    articleCount,
    sourceType,
  );

  /// Create a copy of FeedValidationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedValidationStateSuccessImplCopyWith<_$FeedValidationStateSuccessImpl>
  get copyWith =>
      __$$FeedValidationStateSuccessImplCopyWithImpl<
        _$FeedValidationStateSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() validating,
    required TResult Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )
    success,
    required TResult Function(String errorMessage) failure,
  }) {
    return success(
      feedTitle,
      feedDescription,
      iconUrl,
      articleCount,
      sourceType,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? validating,
    TResult? Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )?
    success,
    TResult? Function(String errorMessage)? failure,
  }) {
    return success?.call(
      feedTitle,
      feedDescription,
      iconUrl,
      articleCount,
      sourceType,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? validating,
    TResult Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )?
    success,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(
        feedTitle,
        feedDescription,
        iconUrl,
        articleCount,
        sourceType,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedValidationStateValidating value) validating,
    required TResult Function(FeedValidationStateSuccess value) success,
    required TResult Function(FeedValidationStateFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedValidationStateValidating value)? validating,
    TResult? Function(FeedValidationStateSuccess value)? success,
    TResult? Function(FeedValidationStateFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedValidationStateValidating value)? validating,
    TResult Function(FeedValidationStateSuccess value)? success,
    TResult Function(FeedValidationStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class FeedValidationStateSuccess implements FeedValidationState {
  const factory FeedValidationStateSuccess({
    required final String feedTitle,
    final String? feedDescription,
    final String? iconUrl,
    required final int articleCount,
    final SourceType sourceType,
  }) = _$FeedValidationStateSuccessImpl;

  String get feedTitle;
  String? get feedDescription;
  String? get iconUrl;
  int get articleCount;
  SourceType get sourceType;

  /// Create a copy of FeedValidationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedValidationStateSuccessImplCopyWith<_$FeedValidationStateSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FeedValidationStateFailureImplCopyWith<$Res> {
  factory _$$FeedValidationStateFailureImplCopyWith(
    _$FeedValidationStateFailureImpl value,
    $Res Function(_$FeedValidationStateFailureImpl) then,
  ) = __$$FeedValidationStateFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$FeedValidationStateFailureImplCopyWithImpl<$Res>
    extends
        _$FeedValidationStateCopyWithImpl<
          $Res,
          _$FeedValidationStateFailureImpl
        >
    implements _$$FeedValidationStateFailureImplCopyWith<$Res> {
  __$$FeedValidationStateFailureImplCopyWithImpl(
    _$FeedValidationStateFailureImpl _value,
    $Res Function(_$FeedValidationStateFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedValidationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMessage = null}) {
    return _then(
      _$FeedValidationStateFailureImpl(
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FeedValidationStateFailureImpl implements FeedValidationStateFailure {
  const _$FeedValidationStateFailureImpl({required this.errorMessage});

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'FeedValidationState.failure(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedValidationStateFailureImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of FeedValidationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedValidationStateFailureImplCopyWith<_$FeedValidationStateFailureImpl>
  get copyWith =>
      __$$FeedValidationStateFailureImplCopyWithImpl<
        _$FeedValidationStateFailureImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() validating,
    required TResult Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )
    success,
    required TResult Function(String errorMessage) failure,
  }) {
    return failure(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? validating,
    TResult? Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )?
    success,
    TResult? Function(String errorMessage)? failure,
  }) {
    return failure?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? validating,
    TResult Function(
      String feedTitle,
      String? feedDescription,
      String? iconUrl,
      int articleCount,
      SourceType sourceType,
    )?
    success,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedValidationStateValidating value) validating,
    required TResult Function(FeedValidationStateSuccess value) success,
    required TResult Function(FeedValidationStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedValidationStateValidating value)? validating,
    TResult? Function(FeedValidationStateSuccess value)? success,
    TResult? Function(FeedValidationStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedValidationStateValidating value)? validating,
    TResult Function(FeedValidationStateSuccess value)? success,
    TResult Function(FeedValidationStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FeedValidationStateFailure implements FeedValidationState {
  const factory FeedValidationStateFailure({
    required final String errorMessage,
  }) = _$FeedValidationStateFailureImpl;

  String get errorMessage;

  /// Create a copy of FeedValidationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedValidationStateFailureImplCopyWith<_$FeedValidationStateFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}
