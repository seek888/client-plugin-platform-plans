// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ArticleEditorState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )
    loaded,
    required TResult Function(String message, String? articleId) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult? Function(String message, String? articleId)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult Function(String message, String? articleId)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArticleEditorInitial value) initial,
    required TResult Function(ArticleEditorLoading value) loading,
    required TResult Function(ArticleEditorLoaded value) loaded,
    required TResult Function(ArticleEditorError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleEditorInitial value)? initial,
    TResult? Function(ArticleEditorLoading value)? loading,
    TResult? Function(ArticleEditorLoaded value)? loaded,
    TResult? Function(ArticleEditorError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleEditorInitial value)? initial,
    TResult Function(ArticleEditorLoading value)? loading,
    TResult Function(ArticleEditorLoaded value)? loaded,
    TResult Function(ArticleEditorError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleEditorStateCopyWith<$Res> {
  factory $ArticleEditorStateCopyWith(
    ArticleEditorState value,
    $Res Function(ArticleEditorState) then,
  ) = _$ArticleEditorStateCopyWithImpl<$Res, ArticleEditorState>;
}

/// @nodoc
class _$ArticleEditorStateCopyWithImpl<$Res, $Val extends ArticleEditorState>
    implements $ArticleEditorStateCopyWith<$Res> {
  _$ArticleEditorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArticleEditorState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ArticleEditorInitialImplCopyWith<$Res> {
  factory _$$ArticleEditorInitialImplCopyWith(
    _$ArticleEditorInitialImpl value,
    $Res Function(_$ArticleEditorInitialImpl) then,
  ) = __$$ArticleEditorInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ArticleEditorInitialImplCopyWithImpl<$Res>
    extends _$ArticleEditorStateCopyWithImpl<$Res, _$ArticleEditorInitialImpl>
    implements _$$ArticleEditorInitialImplCopyWith<$Res> {
  __$$ArticleEditorInitialImplCopyWithImpl(
    _$ArticleEditorInitialImpl _value,
    $Res Function(_$ArticleEditorInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleEditorState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ArticleEditorInitialImpl implements ArticleEditorInitial {
  const _$ArticleEditorInitialImpl();

  @override
  String toString() {
    return 'ArticleEditorState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleEditorInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )
    loaded,
    required TResult Function(String message, String? articleId) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult? Function(String message, String? articleId)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult Function(String message, String? articleId)? error,
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
    required TResult Function(ArticleEditorInitial value) initial,
    required TResult Function(ArticleEditorLoading value) loading,
    required TResult Function(ArticleEditorLoaded value) loaded,
    required TResult Function(ArticleEditorError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleEditorInitial value)? initial,
    TResult? Function(ArticleEditorLoading value)? loading,
    TResult? Function(ArticleEditorLoaded value)? loaded,
    TResult? Function(ArticleEditorError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleEditorInitial value)? initial,
    TResult Function(ArticleEditorLoading value)? loading,
    TResult Function(ArticleEditorLoaded value)? loaded,
    TResult Function(ArticleEditorError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ArticleEditorInitial implements ArticleEditorState {
  const factory ArticleEditorInitial() = _$ArticleEditorInitialImpl;
}

/// @nodoc
abstract class _$$ArticleEditorLoadingImplCopyWith<$Res> {
  factory _$$ArticleEditorLoadingImplCopyWith(
    _$ArticleEditorLoadingImpl value,
    $Res Function(_$ArticleEditorLoadingImpl) then,
  ) = __$$ArticleEditorLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ArticleEditorLoadingImplCopyWithImpl<$Res>
    extends _$ArticleEditorStateCopyWithImpl<$Res, _$ArticleEditorLoadingImpl>
    implements _$$ArticleEditorLoadingImplCopyWith<$Res> {
  __$$ArticleEditorLoadingImplCopyWithImpl(
    _$ArticleEditorLoadingImpl _value,
    $Res Function(_$ArticleEditorLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleEditorState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ArticleEditorLoadingImpl implements ArticleEditorLoading {
  const _$ArticleEditorLoadingImpl();

  @override
  String toString() {
    return 'ArticleEditorState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleEditorLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )
    loaded,
    required TResult Function(String message, String? articleId) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult? Function(String message, String? articleId)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult Function(String message, String? articleId)? error,
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
    required TResult Function(ArticleEditorInitial value) initial,
    required TResult Function(ArticleEditorLoading value) loading,
    required TResult Function(ArticleEditorLoaded value) loaded,
    required TResult Function(ArticleEditorError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleEditorInitial value)? initial,
    TResult? Function(ArticleEditorLoading value)? loading,
    TResult? Function(ArticleEditorLoaded value)? loaded,
    TResult? Function(ArticleEditorError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleEditorInitial value)? initial,
    TResult Function(ArticleEditorLoading value)? loading,
    TResult Function(ArticleEditorLoaded value)? loaded,
    TResult Function(ArticleEditorError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ArticleEditorLoading implements ArticleEditorState {
  const factory ArticleEditorLoading() = _$ArticleEditorLoadingImpl;
}

/// @nodoc
abstract class _$$ArticleEditorLoadedImplCopyWith<$Res> {
  factory _$$ArticleEditorLoadedImplCopyWith(
    _$ArticleEditorLoadedImpl value,
    $Res Function(_$ArticleEditorLoadedImpl) then,
  ) = __$$ArticleEditorLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String articleId,
    List<Map<String, dynamic>> content,
    bool hasEditedVersion,
    bool isDirty,
    bool isSaving,
    bool isNewNote,
  });
}

/// @nodoc
class __$$ArticleEditorLoadedImplCopyWithImpl<$Res>
    extends _$ArticleEditorStateCopyWithImpl<$Res, _$ArticleEditorLoadedImpl>
    implements _$$ArticleEditorLoadedImplCopyWith<$Res> {
  __$$ArticleEditorLoadedImplCopyWithImpl(
    _$ArticleEditorLoadedImpl _value,
    $Res Function(_$ArticleEditorLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articleId = null,
    Object? content = null,
    Object? hasEditedVersion = null,
    Object? isDirty = null,
    Object? isSaving = null,
    Object? isNewNote = null,
  }) {
    return _then(
      _$ArticleEditorLoadedImpl(
        articleId: null == articleId
            ? _value.articleId
            : articleId // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value._content
            : content // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        hasEditedVersion: null == hasEditedVersion
            ? _value.hasEditedVersion
            : hasEditedVersion // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDirty: null == isDirty
            ? _value.isDirty
            : isDirty // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        isNewNote: null == isNewNote
            ? _value.isNewNote
            : isNewNote // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ArticleEditorLoadedImpl implements ArticleEditorLoaded {
  const _$ArticleEditorLoadedImpl({
    required this.articleId,
    required final List<Map<String, dynamic>> content,
    required this.hasEditedVersion,
    this.isDirty = false,
    this.isSaving = false,
    this.isNewNote = false,
  }) : _content = content;

  @override
  final String articleId;
  final List<Map<String, dynamic>> _content;
  @override
  List<Map<String, dynamic>> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  final bool hasEditedVersion;
  @override
  @JsonKey()
  final bool isDirty;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isNewNote;

  @override
  String toString() {
    return 'ArticleEditorState.loaded(articleId: $articleId, content: $content, hasEditedVersion: $hasEditedVersion, isDirty: $isDirty, isSaving: $isSaving, isNewNote: $isNewNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleEditorLoadedImpl &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.hasEditedVersion, hasEditedVersion) ||
                other.hasEditedVersion == hasEditedVersion) &&
            (identical(other.isDirty, isDirty) || other.isDirty == isDirty) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isNewNote, isNewNote) ||
                other.isNewNote == isNewNote));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    articleId,
    const DeepCollectionEquality().hash(_content),
    hasEditedVersion,
    isDirty,
    isSaving,
    isNewNote,
  );

  /// Create a copy of ArticleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleEditorLoadedImplCopyWith<_$ArticleEditorLoadedImpl> get copyWith =>
      __$$ArticleEditorLoadedImplCopyWithImpl<_$ArticleEditorLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )
    loaded,
    required TResult Function(String message, String? articleId) error,
  }) {
    return loaded(
      articleId,
      content,
      hasEditedVersion,
      isDirty,
      isSaving,
      isNewNote,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult? Function(String message, String? articleId)? error,
  }) {
    return loaded?.call(
      articleId,
      content,
      hasEditedVersion,
      isDirty,
      isSaving,
      isNewNote,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult Function(String message, String? articleId)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        articleId,
        content,
        hasEditedVersion,
        isDirty,
        isSaving,
        isNewNote,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArticleEditorInitial value) initial,
    required TResult Function(ArticleEditorLoading value) loading,
    required TResult Function(ArticleEditorLoaded value) loaded,
    required TResult Function(ArticleEditorError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleEditorInitial value)? initial,
    TResult? Function(ArticleEditorLoading value)? loading,
    TResult? Function(ArticleEditorLoaded value)? loaded,
    TResult? Function(ArticleEditorError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleEditorInitial value)? initial,
    TResult Function(ArticleEditorLoading value)? loading,
    TResult Function(ArticleEditorLoaded value)? loaded,
    TResult Function(ArticleEditorError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ArticleEditorLoaded implements ArticleEditorState {
  const factory ArticleEditorLoaded({
    required final String articleId,
    required final List<Map<String, dynamic>> content,
    required final bool hasEditedVersion,
    final bool isDirty,
    final bool isSaving,
    final bool isNewNote,
  }) = _$ArticleEditorLoadedImpl;

  String get articleId;
  List<Map<String, dynamic>> get content;
  bool get hasEditedVersion;
  bool get isDirty;
  bool get isSaving;
  bool get isNewNote;

  /// Create a copy of ArticleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleEditorLoadedImplCopyWith<_$ArticleEditorLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArticleEditorErrorImplCopyWith<$Res> {
  factory _$$ArticleEditorErrorImplCopyWith(
    _$ArticleEditorErrorImpl value,
    $Res Function(_$ArticleEditorErrorImpl) then,
  ) = __$$ArticleEditorErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String? articleId});
}

/// @nodoc
class __$$ArticleEditorErrorImplCopyWithImpl<$Res>
    extends _$ArticleEditorStateCopyWithImpl<$Res, _$ArticleEditorErrorImpl>
    implements _$$ArticleEditorErrorImplCopyWith<$Res> {
  __$$ArticleEditorErrorImplCopyWithImpl(
    _$ArticleEditorErrorImpl _value,
    $Res Function(_$ArticleEditorErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? articleId = freezed}) {
    return _then(
      _$ArticleEditorErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        articleId: freezed == articleId
            ? _value.articleId
            : articleId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ArticleEditorErrorImpl implements ArticleEditorError {
  const _$ArticleEditorErrorImpl({required this.message, this.articleId});

  @override
  final String message;
  @override
  final String? articleId;

  @override
  String toString() {
    return 'ArticleEditorState.error(message: $message, articleId: $articleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleEditorErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, articleId);

  /// Create a copy of ArticleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleEditorErrorImplCopyWith<_$ArticleEditorErrorImpl> get copyWith =>
      __$$ArticleEditorErrorImplCopyWithImpl<_$ArticleEditorErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )
    loaded,
    required TResult Function(String message, String? articleId) error,
  }) {
    return error(message, articleId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult? Function(String message, String? articleId)? error,
  }) {
    return error?.call(message, articleId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      String articleId,
      List<Map<String, dynamic>> content,
      bool hasEditedVersion,
      bool isDirty,
      bool isSaving,
      bool isNewNote,
    )?
    loaded,
    TResult Function(String message, String? articleId)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, articleId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArticleEditorInitial value) initial,
    required TResult Function(ArticleEditorLoading value) loading,
    required TResult Function(ArticleEditorLoaded value) loaded,
    required TResult Function(ArticleEditorError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArticleEditorInitial value)? initial,
    TResult? Function(ArticleEditorLoading value)? loading,
    TResult? Function(ArticleEditorLoaded value)? loaded,
    TResult? Function(ArticleEditorError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArticleEditorInitial value)? initial,
    TResult Function(ArticleEditorLoading value)? loading,
    TResult Function(ArticleEditorLoaded value)? loaded,
    TResult Function(ArticleEditorError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ArticleEditorError implements ArticleEditorState {
  const factory ArticleEditorError({
    required final String message,
    final String? articleId,
  }) = _$ArticleEditorErrorImpl;

  String get message;
  String? get articleId;

  /// Create a copy of ArticleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleEditorErrorImplCopyWith<_$ArticleEditorErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
