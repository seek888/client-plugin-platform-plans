// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_side_effect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SearchSideEffect {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool isError) showToast,
    required TResult Function(String articleId) navigateToArticle,
    required TResult Function(String feedId) navigateToFeed,
    required TResult Function() closeSearch,
    required TResult Function() clearFocus,
    required TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )
    showConfirmDialog,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool isError)? showToast,
    TResult? Function(String articleId)? navigateToArticle,
    TResult? Function(String feedId)? navigateToFeed,
    TResult? Function()? closeSearch,
    TResult? Function()? clearFocus,
    TResult? Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool isError)? showToast,
    TResult Function(String articleId)? navigateToArticle,
    TResult Function(String feedId)? navigateToFeed,
    TResult Function()? closeSearch,
    TResult Function()? clearFocus,
    TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchSideEffectShowToast value) showToast,
    required TResult Function(SearchSideEffectNavigateToArticle value)
    navigateToArticle,
    required TResult Function(SearchSideEffectNavigateToFeed value)
    navigateToFeed,
    required TResult Function(SearchSideEffectCloseSearch value) closeSearch,
    required TResult Function(SearchSideEffectClearFocus value) clearFocus,
    required TResult Function(SearchSideEffectShowConfirmDialog value)
    showConfirmDialog,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchSideEffectShowToast value)? showToast,
    TResult? Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult? Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult? Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult? Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult? Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchSideEffectShowToast value)? showToast,
    TResult Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchSideEffectCopyWith<$Res> {
  factory $SearchSideEffectCopyWith(
    SearchSideEffect value,
    $Res Function(SearchSideEffect) then,
  ) = _$SearchSideEffectCopyWithImpl<$Res, SearchSideEffect>;
}

/// @nodoc
class _$SearchSideEffectCopyWithImpl<$Res, $Val extends SearchSideEffect>
    implements $SearchSideEffectCopyWith<$Res> {
  _$SearchSideEffectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SearchSideEffectShowToastImplCopyWith<$Res> {
  factory _$$SearchSideEffectShowToastImplCopyWith(
    _$SearchSideEffectShowToastImpl value,
    $Res Function(_$SearchSideEffectShowToastImpl) then,
  ) = __$$SearchSideEffectShowToastImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, bool isError});
}

/// @nodoc
class __$$SearchSideEffectShowToastImplCopyWithImpl<$Res>
    extends
        _$SearchSideEffectCopyWithImpl<$Res, _$SearchSideEffectShowToastImpl>
    implements _$$SearchSideEffectShowToastImplCopyWith<$Res> {
  __$$SearchSideEffectShowToastImplCopyWithImpl(
    _$SearchSideEffectShowToastImpl _value,
    $Res Function(_$SearchSideEffectShowToastImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? isError = null}) {
    return _then(
      _$SearchSideEffectShowToastImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        isError: null == isError
            ? _value.isError
            : isError // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SearchSideEffectShowToastImpl
    with DiagnosticableTreeMixin
    implements SearchSideEffectShowToast {
  const _$SearchSideEffectShowToastImpl({
    required this.message,
    this.isError = false,
  });

  @override
  final String message;
  @override
  @JsonKey()
  final bool isError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchSideEffect.showToast(message: $message, isError: $isError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchSideEffect.showToast'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('isError', isError));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSideEffectShowToastImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isError, isError) || other.isError == isError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, isError);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSideEffectShowToastImplCopyWith<_$SearchSideEffectShowToastImpl>
  get copyWith =>
      __$$SearchSideEffectShowToastImplCopyWithImpl<
        _$SearchSideEffectShowToastImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool isError) showToast,
    required TResult Function(String articleId) navigateToArticle,
    required TResult Function(String feedId) navigateToFeed,
    required TResult Function() closeSearch,
    required TResult Function() clearFocus,
    required TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )
    showConfirmDialog,
  }) {
    return showToast(message, isError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool isError)? showToast,
    TResult? Function(String articleId)? navigateToArticle,
    TResult? Function(String feedId)? navigateToFeed,
    TResult? Function()? closeSearch,
    TResult? Function()? clearFocus,
    TResult? Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
  }) {
    return showToast?.call(message, isError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool isError)? showToast,
    TResult Function(String articleId)? navigateToArticle,
    TResult Function(String feedId)? navigateToFeed,
    TResult Function()? closeSearch,
    TResult Function()? clearFocus,
    TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (showToast != null) {
      return showToast(message, isError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchSideEffectShowToast value) showToast,
    required TResult Function(SearchSideEffectNavigateToArticle value)
    navigateToArticle,
    required TResult Function(SearchSideEffectNavigateToFeed value)
    navigateToFeed,
    required TResult Function(SearchSideEffectCloseSearch value) closeSearch,
    required TResult Function(SearchSideEffectClearFocus value) clearFocus,
    required TResult Function(SearchSideEffectShowConfirmDialog value)
    showConfirmDialog,
  }) {
    return showToast(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchSideEffectShowToast value)? showToast,
    TResult? Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult? Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult? Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult? Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult? Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
  }) {
    return showToast?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchSideEffectShowToast value)? showToast,
    TResult Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (showToast != null) {
      return showToast(this);
    }
    return orElse();
  }
}

abstract class SearchSideEffectShowToast implements SearchSideEffect {
  const factory SearchSideEffectShowToast({
    required final String message,
    final bool isError,
  }) = _$SearchSideEffectShowToastImpl;

  String get message;
  bool get isError;

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchSideEffectShowToastImplCopyWith<_$SearchSideEffectShowToastImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchSideEffectNavigateToArticleImplCopyWith<$Res> {
  factory _$$SearchSideEffectNavigateToArticleImplCopyWith(
    _$SearchSideEffectNavigateToArticleImpl value,
    $Res Function(_$SearchSideEffectNavigateToArticleImpl) then,
  ) = __$$SearchSideEffectNavigateToArticleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String articleId});
}

/// @nodoc
class __$$SearchSideEffectNavigateToArticleImplCopyWithImpl<$Res>
    extends
        _$SearchSideEffectCopyWithImpl<
          $Res,
          _$SearchSideEffectNavigateToArticleImpl
        >
    implements _$$SearchSideEffectNavigateToArticleImplCopyWith<$Res> {
  __$$SearchSideEffectNavigateToArticleImplCopyWithImpl(
    _$SearchSideEffectNavigateToArticleImpl _value,
    $Res Function(_$SearchSideEffectNavigateToArticleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? articleId = null}) {
    return _then(
      _$SearchSideEffectNavigateToArticleImpl(
        articleId: null == articleId
            ? _value.articleId
            : articleId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchSideEffectNavigateToArticleImpl
    with DiagnosticableTreeMixin
    implements SearchSideEffectNavigateToArticle {
  const _$SearchSideEffectNavigateToArticleImpl({required this.articleId});

  @override
  final String articleId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchSideEffect.navigateToArticle(articleId: $articleId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchSideEffect.navigateToArticle'))
      ..add(DiagnosticsProperty('articleId', articleId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSideEffectNavigateToArticleImpl &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, articleId);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSideEffectNavigateToArticleImplCopyWith<
    _$SearchSideEffectNavigateToArticleImpl
  >
  get copyWith =>
      __$$SearchSideEffectNavigateToArticleImplCopyWithImpl<
        _$SearchSideEffectNavigateToArticleImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool isError) showToast,
    required TResult Function(String articleId) navigateToArticle,
    required TResult Function(String feedId) navigateToFeed,
    required TResult Function() closeSearch,
    required TResult Function() clearFocus,
    required TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )
    showConfirmDialog,
  }) {
    return navigateToArticle(articleId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool isError)? showToast,
    TResult? Function(String articleId)? navigateToArticle,
    TResult? Function(String feedId)? navigateToFeed,
    TResult? Function()? closeSearch,
    TResult? Function()? clearFocus,
    TResult? Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
  }) {
    return navigateToArticle?.call(articleId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool isError)? showToast,
    TResult Function(String articleId)? navigateToArticle,
    TResult Function(String feedId)? navigateToFeed,
    TResult Function()? closeSearch,
    TResult Function()? clearFocus,
    TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (navigateToArticle != null) {
      return navigateToArticle(articleId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchSideEffectShowToast value) showToast,
    required TResult Function(SearchSideEffectNavigateToArticle value)
    navigateToArticle,
    required TResult Function(SearchSideEffectNavigateToFeed value)
    navigateToFeed,
    required TResult Function(SearchSideEffectCloseSearch value) closeSearch,
    required TResult Function(SearchSideEffectClearFocus value) clearFocus,
    required TResult Function(SearchSideEffectShowConfirmDialog value)
    showConfirmDialog,
  }) {
    return navigateToArticle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchSideEffectShowToast value)? showToast,
    TResult? Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult? Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult? Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult? Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult? Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
  }) {
    return navigateToArticle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchSideEffectShowToast value)? showToast,
    TResult Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (navigateToArticle != null) {
      return navigateToArticle(this);
    }
    return orElse();
  }
}

abstract class SearchSideEffectNavigateToArticle implements SearchSideEffect {
  const factory SearchSideEffectNavigateToArticle({
    required final String articleId,
  }) = _$SearchSideEffectNavigateToArticleImpl;

  String get articleId;

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchSideEffectNavigateToArticleImplCopyWith<
    _$SearchSideEffectNavigateToArticleImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchSideEffectNavigateToFeedImplCopyWith<$Res> {
  factory _$$SearchSideEffectNavigateToFeedImplCopyWith(
    _$SearchSideEffectNavigateToFeedImpl value,
    $Res Function(_$SearchSideEffectNavigateToFeedImpl) then,
  ) = __$$SearchSideEffectNavigateToFeedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String feedId});
}

/// @nodoc
class __$$SearchSideEffectNavigateToFeedImplCopyWithImpl<$Res>
    extends
        _$SearchSideEffectCopyWithImpl<
          $Res,
          _$SearchSideEffectNavigateToFeedImpl
        >
    implements _$$SearchSideEffectNavigateToFeedImplCopyWith<$Res> {
  __$$SearchSideEffectNavigateToFeedImplCopyWithImpl(
    _$SearchSideEffectNavigateToFeedImpl _value,
    $Res Function(_$SearchSideEffectNavigateToFeedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? feedId = null}) {
    return _then(
      _$SearchSideEffectNavigateToFeedImpl(
        feedId: null == feedId
            ? _value.feedId
            : feedId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchSideEffectNavigateToFeedImpl
    with DiagnosticableTreeMixin
    implements SearchSideEffectNavigateToFeed {
  const _$SearchSideEffectNavigateToFeedImpl({required this.feedId});

  @override
  final String feedId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchSideEffect.navigateToFeed(feedId: $feedId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchSideEffect.navigateToFeed'))
      ..add(DiagnosticsProperty('feedId', feedId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSideEffectNavigateToFeedImpl &&
            (identical(other.feedId, feedId) || other.feedId == feedId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, feedId);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSideEffectNavigateToFeedImplCopyWith<
    _$SearchSideEffectNavigateToFeedImpl
  >
  get copyWith =>
      __$$SearchSideEffectNavigateToFeedImplCopyWithImpl<
        _$SearchSideEffectNavigateToFeedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool isError) showToast,
    required TResult Function(String articleId) navigateToArticle,
    required TResult Function(String feedId) navigateToFeed,
    required TResult Function() closeSearch,
    required TResult Function() clearFocus,
    required TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )
    showConfirmDialog,
  }) {
    return navigateToFeed(feedId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool isError)? showToast,
    TResult? Function(String articleId)? navigateToArticle,
    TResult? Function(String feedId)? navigateToFeed,
    TResult? Function()? closeSearch,
    TResult? Function()? clearFocus,
    TResult? Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
  }) {
    return navigateToFeed?.call(feedId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool isError)? showToast,
    TResult Function(String articleId)? navigateToArticle,
    TResult Function(String feedId)? navigateToFeed,
    TResult Function()? closeSearch,
    TResult Function()? clearFocus,
    TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (navigateToFeed != null) {
      return navigateToFeed(feedId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchSideEffectShowToast value) showToast,
    required TResult Function(SearchSideEffectNavigateToArticle value)
    navigateToArticle,
    required TResult Function(SearchSideEffectNavigateToFeed value)
    navigateToFeed,
    required TResult Function(SearchSideEffectCloseSearch value) closeSearch,
    required TResult Function(SearchSideEffectClearFocus value) clearFocus,
    required TResult Function(SearchSideEffectShowConfirmDialog value)
    showConfirmDialog,
  }) {
    return navigateToFeed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchSideEffectShowToast value)? showToast,
    TResult? Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult? Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult? Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult? Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult? Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
  }) {
    return navigateToFeed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchSideEffectShowToast value)? showToast,
    TResult Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (navigateToFeed != null) {
      return navigateToFeed(this);
    }
    return orElse();
  }
}

abstract class SearchSideEffectNavigateToFeed implements SearchSideEffect {
  const factory SearchSideEffectNavigateToFeed({required final String feedId}) =
      _$SearchSideEffectNavigateToFeedImpl;

  String get feedId;

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchSideEffectNavigateToFeedImplCopyWith<
    _$SearchSideEffectNavigateToFeedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchSideEffectCloseSearchImplCopyWith<$Res> {
  factory _$$SearchSideEffectCloseSearchImplCopyWith(
    _$SearchSideEffectCloseSearchImpl value,
    $Res Function(_$SearchSideEffectCloseSearchImpl) then,
  ) = __$$SearchSideEffectCloseSearchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchSideEffectCloseSearchImplCopyWithImpl<$Res>
    extends
        _$SearchSideEffectCopyWithImpl<$Res, _$SearchSideEffectCloseSearchImpl>
    implements _$$SearchSideEffectCloseSearchImplCopyWith<$Res> {
  __$$SearchSideEffectCloseSearchImplCopyWithImpl(
    _$SearchSideEffectCloseSearchImpl _value,
    $Res Function(_$SearchSideEffectCloseSearchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SearchSideEffectCloseSearchImpl
    with DiagnosticableTreeMixin
    implements SearchSideEffectCloseSearch {
  const _$SearchSideEffectCloseSearchImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchSideEffect.closeSearch()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchSideEffect.closeSearch'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSideEffectCloseSearchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool isError) showToast,
    required TResult Function(String articleId) navigateToArticle,
    required TResult Function(String feedId) navigateToFeed,
    required TResult Function() closeSearch,
    required TResult Function() clearFocus,
    required TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )
    showConfirmDialog,
  }) {
    return closeSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool isError)? showToast,
    TResult? Function(String articleId)? navigateToArticle,
    TResult? Function(String feedId)? navigateToFeed,
    TResult? Function()? closeSearch,
    TResult? Function()? clearFocus,
    TResult? Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
  }) {
    return closeSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool isError)? showToast,
    TResult Function(String articleId)? navigateToArticle,
    TResult Function(String feedId)? navigateToFeed,
    TResult Function()? closeSearch,
    TResult Function()? clearFocus,
    TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (closeSearch != null) {
      return closeSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchSideEffectShowToast value) showToast,
    required TResult Function(SearchSideEffectNavigateToArticle value)
    navigateToArticle,
    required TResult Function(SearchSideEffectNavigateToFeed value)
    navigateToFeed,
    required TResult Function(SearchSideEffectCloseSearch value) closeSearch,
    required TResult Function(SearchSideEffectClearFocus value) clearFocus,
    required TResult Function(SearchSideEffectShowConfirmDialog value)
    showConfirmDialog,
  }) {
    return closeSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchSideEffectShowToast value)? showToast,
    TResult? Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult? Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult? Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult? Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult? Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
  }) {
    return closeSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchSideEffectShowToast value)? showToast,
    TResult Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (closeSearch != null) {
      return closeSearch(this);
    }
    return orElse();
  }
}

abstract class SearchSideEffectCloseSearch implements SearchSideEffect {
  const factory SearchSideEffectCloseSearch() =
      _$SearchSideEffectCloseSearchImpl;
}

/// @nodoc
abstract class _$$SearchSideEffectClearFocusImplCopyWith<$Res> {
  factory _$$SearchSideEffectClearFocusImplCopyWith(
    _$SearchSideEffectClearFocusImpl value,
    $Res Function(_$SearchSideEffectClearFocusImpl) then,
  ) = __$$SearchSideEffectClearFocusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchSideEffectClearFocusImplCopyWithImpl<$Res>
    extends
        _$SearchSideEffectCopyWithImpl<$Res, _$SearchSideEffectClearFocusImpl>
    implements _$$SearchSideEffectClearFocusImplCopyWith<$Res> {
  __$$SearchSideEffectClearFocusImplCopyWithImpl(
    _$SearchSideEffectClearFocusImpl _value,
    $Res Function(_$SearchSideEffectClearFocusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SearchSideEffectClearFocusImpl
    with DiagnosticableTreeMixin
    implements SearchSideEffectClearFocus {
  const _$SearchSideEffectClearFocusImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchSideEffect.clearFocus()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'SearchSideEffect.clearFocus'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSideEffectClearFocusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool isError) showToast,
    required TResult Function(String articleId) navigateToArticle,
    required TResult Function(String feedId) navigateToFeed,
    required TResult Function() closeSearch,
    required TResult Function() clearFocus,
    required TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )
    showConfirmDialog,
  }) {
    return clearFocus();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool isError)? showToast,
    TResult? Function(String articleId)? navigateToArticle,
    TResult? Function(String feedId)? navigateToFeed,
    TResult? Function()? closeSearch,
    TResult? Function()? clearFocus,
    TResult? Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
  }) {
    return clearFocus?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool isError)? showToast,
    TResult Function(String articleId)? navigateToArticle,
    TResult Function(String feedId)? navigateToFeed,
    TResult Function()? closeSearch,
    TResult Function()? clearFocus,
    TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (clearFocus != null) {
      return clearFocus();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchSideEffectShowToast value) showToast,
    required TResult Function(SearchSideEffectNavigateToArticle value)
    navigateToArticle,
    required TResult Function(SearchSideEffectNavigateToFeed value)
    navigateToFeed,
    required TResult Function(SearchSideEffectCloseSearch value) closeSearch,
    required TResult Function(SearchSideEffectClearFocus value) clearFocus,
    required TResult Function(SearchSideEffectShowConfirmDialog value)
    showConfirmDialog,
  }) {
    return clearFocus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchSideEffectShowToast value)? showToast,
    TResult? Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult? Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult? Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult? Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult? Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
  }) {
    return clearFocus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchSideEffectShowToast value)? showToast,
    TResult Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (clearFocus != null) {
      return clearFocus(this);
    }
    return orElse();
  }
}

abstract class SearchSideEffectClearFocus implements SearchSideEffect {
  const factory SearchSideEffectClearFocus() = _$SearchSideEffectClearFocusImpl;
}

/// @nodoc
abstract class _$$SearchSideEffectShowConfirmDialogImplCopyWith<$Res> {
  factory _$$SearchSideEffectShowConfirmDialogImplCopyWith(
    _$SearchSideEffectShowConfirmDialogImpl value,
    $Res Function(_$SearchSideEffectShowConfirmDialogImpl) then,
  ) = __$$SearchSideEffectShowConfirmDialogImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String title,
    String message,
    VoidCallback onConfirm,
    VoidCallback? onCancel,
  });
}

/// @nodoc
class __$$SearchSideEffectShowConfirmDialogImplCopyWithImpl<$Res>
    extends
        _$SearchSideEffectCopyWithImpl<
          $Res,
          _$SearchSideEffectShowConfirmDialogImpl
        >
    implements _$$SearchSideEffectShowConfirmDialogImplCopyWith<$Res> {
  __$$SearchSideEffectShowConfirmDialogImplCopyWithImpl(
    _$SearchSideEffectShowConfirmDialogImpl _value,
    $Res Function(_$SearchSideEffectShowConfirmDialogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? onConfirm = null,
    Object? onCancel = freezed,
  }) {
    return _then(
      _$SearchSideEffectShowConfirmDialogImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        onConfirm: null == onConfirm
            ? _value.onConfirm
            : onConfirm // ignore: cast_nullable_to_non_nullable
                  as VoidCallback,
        onCancel: freezed == onCancel
            ? _value.onCancel
            : onCancel // ignore: cast_nullable_to_non_nullable
                  as VoidCallback?,
      ),
    );
  }
}

/// @nodoc

class _$SearchSideEffectShowConfirmDialogImpl
    with DiagnosticableTreeMixin
    implements SearchSideEffectShowConfirmDialog {
  const _$SearchSideEffectShowConfirmDialogImpl({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  final String title;
  @override
  final String message;
  @override
  final VoidCallback onConfirm;
  @override
  final VoidCallback? onCancel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchSideEffect.showConfirmDialog(title: $title, message: $message, onConfirm: $onConfirm, onCancel: $onCancel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchSideEffect.showConfirmDialog'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('onConfirm', onConfirm))
      ..add(DiagnosticsProperty('onCancel', onCancel));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSideEffectShowConfirmDialogImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.onConfirm, onConfirm) ||
                other.onConfirm == onConfirm) &&
            (identical(other.onCancel, onCancel) ||
                other.onCancel == onCancel));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, message, onConfirm, onCancel);

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSideEffectShowConfirmDialogImplCopyWith<
    _$SearchSideEffectShowConfirmDialogImpl
  >
  get copyWith =>
      __$$SearchSideEffectShowConfirmDialogImplCopyWithImpl<
        _$SearchSideEffectShowConfirmDialogImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool isError) showToast,
    required TResult Function(String articleId) navigateToArticle,
    required TResult Function(String feedId) navigateToFeed,
    required TResult Function() closeSearch,
    required TResult Function() clearFocus,
    required TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )
    showConfirmDialog,
  }) {
    return showConfirmDialog(title, message, onConfirm, onCancel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool isError)? showToast,
    TResult? Function(String articleId)? navigateToArticle,
    TResult? Function(String feedId)? navigateToFeed,
    TResult? Function()? closeSearch,
    TResult? Function()? clearFocus,
    TResult? Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
  }) {
    return showConfirmDialog?.call(title, message, onConfirm, onCancel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool isError)? showToast,
    TResult Function(String articleId)? navigateToArticle,
    TResult Function(String feedId)? navigateToFeed,
    TResult Function()? closeSearch,
    TResult Function()? clearFocus,
    TResult Function(
      String title,
      String message,
      VoidCallback onConfirm,
      VoidCallback? onCancel,
    )?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (showConfirmDialog != null) {
      return showConfirmDialog(title, message, onConfirm, onCancel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchSideEffectShowToast value) showToast,
    required TResult Function(SearchSideEffectNavigateToArticle value)
    navigateToArticle,
    required TResult Function(SearchSideEffectNavigateToFeed value)
    navigateToFeed,
    required TResult Function(SearchSideEffectCloseSearch value) closeSearch,
    required TResult Function(SearchSideEffectClearFocus value) clearFocus,
    required TResult Function(SearchSideEffectShowConfirmDialog value)
    showConfirmDialog,
  }) {
    return showConfirmDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchSideEffectShowToast value)? showToast,
    TResult? Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult? Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult? Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult? Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult? Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
  }) {
    return showConfirmDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchSideEffectShowToast value)? showToast,
    TResult Function(SearchSideEffectNavigateToArticle value)?
    navigateToArticle,
    TResult Function(SearchSideEffectNavigateToFeed value)? navigateToFeed,
    TResult Function(SearchSideEffectCloseSearch value)? closeSearch,
    TResult Function(SearchSideEffectClearFocus value)? clearFocus,
    TResult Function(SearchSideEffectShowConfirmDialog value)?
    showConfirmDialog,
    required TResult orElse(),
  }) {
    if (showConfirmDialog != null) {
      return showConfirmDialog(this);
    }
    return orElse();
  }
}

abstract class SearchSideEffectShowConfirmDialog implements SearchSideEffect {
  const factory SearchSideEffectShowConfirmDialog({
    required final String title,
    required final String message,
    required final VoidCallback onConfirm,
    final VoidCallback? onCancel,
  }) = _$SearchSideEffectShowConfirmDialogImpl;

  String get title;
  String get message;
  VoidCallback get onConfirm;
  VoidCallback? get onCancel;

  /// Create a copy of SearchSideEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchSideEffectShowConfirmDialogImplCopyWith<
    _$SearchSideEffectShowConfirmDialogImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
