// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edited_article_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EditedArticleContent _$EditedArticleContentFromJson(Map<String, dynamic> json) {
  return _EditedArticleContent.fromJson(json);
}

/// @nodoc
mixin _$EditedArticleContent {
  /// 文章 ID（关联原始文章）
  String get articleId => throw _privateConstructorUsedError;

  /// Quill Delta JSON 格式的编辑内容
  String get deltaJson => throw _privateConstructorUsedError;

  /// 转换后的 HTML 内容（用于显示）
  String get htmlContent => throw _privateConstructorUsedError;

  /// 编辑时间
  DateTime get editedAt => throw _privateConstructorUsedError;

  /// 从内容提取的摘要
  String? get summary => throw _privateConstructorUsedError;

  /// Serializes this EditedArticleContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EditedArticleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditedArticleContentCopyWith<EditedArticleContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditedArticleContentCopyWith<$Res> {
  factory $EditedArticleContentCopyWith(
    EditedArticleContent value,
    $Res Function(EditedArticleContent) then,
  ) = _$EditedArticleContentCopyWithImpl<$Res, EditedArticleContent>;
  @useResult
  $Res call({
    String articleId,
    String deltaJson,
    String htmlContent,
    DateTime editedAt,
    String? summary,
  });
}

/// @nodoc
class _$EditedArticleContentCopyWithImpl<
  $Res,
  $Val extends EditedArticleContent
>
    implements $EditedArticleContentCopyWith<$Res> {
  _$EditedArticleContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditedArticleContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articleId = null,
    Object? deltaJson = null,
    Object? htmlContent = null,
    Object? editedAt = null,
    Object? summary = freezed,
  }) {
    return _then(
      _value.copyWith(
            articleId: null == articleId
                ? _value.articleId
                : articleId // ignore: cast_nullable_to_non_nullable
                      as String,
            deltaJson: null == deltaJson
                ? _value.deltaJson
                : deltaJson // ignore: cast_nullable_to_non_nullable
                      as String,
            htmlContent: null == htmlContent
                ? _value.htmlContent
                : htmlContent // ignore: cast_nullable_to_non_nullable
                      as String,
            editedAt: null == editedAt
                ? _value.editedAt
                : editedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EditedArticleContentImplCopyWith<$Res>
    implements $EditedArticleContentCopyWith<$Res> {
  factory _$$EditedArticleContentImplCopyWith(
    _$EditedArticleContentImpl value,
    $Res Function(_$EditedArticleContentImpl) then,
  ) = __$$EditedArticleContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String articleId,
    String deltaJson,
    String htmlContent,
    DateTime editedAt,
    String? summary,
  });
}

/// @nodoc
class __$$EditedArticleContentImplCopyWithImpl<$Res>
    extends _$EditedArticleContentCopyWithImpl<$Res, _$EditedArticleContentImpl>
    implements _$$EditedArticleContentImplCopyWith<$Res> {
  __$$EditedArticleContentImplCopyWithImpl(
    _$EditedArticleContentImpl _value,
    $Res Function(_$EditedArticleContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditedArticleContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articleId = null,
    Object? deltaJson = null,
    Object? htmlContent = null,
    Object? editedAt = null,
    Object? summary = freezed,
  }) {
    return _then(
      _$EditedArticleContentImpl(
        articleId: null == articleId
            ? _value.articleId
            : articleId // ignore: cast_nullable_to_non_nullable
                  as String,
        deltaJson: null == deltaJson
            ? _value.deltaJson
            : deltaJson // ignore: cast_nullable_to_non_nullable
                  as String,
        htmlContent: null == htmlContent
            ? _value.htmlContent
            : htmlContent // ignore: cast_nullable_to_non_nullable
                  as String,
        editedAt: null == editedAt
            ? _value.editedAt
            : editedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EditedArticleContentImpl extends _EditedArticleContent {
  const _$EditedArticleContentImpl({
    required this.articleId,
    required this.deltaJson,
    required this.htmlContent,
    required this.editedAt,
    this.summary,
  }) : super._();

  factory _$EditedArticleContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$EditedArticleContentImplFromJson(json);

  /// 文章 ID（关联原始文章）
  @override
  final String articleId;

  /// Quill Delta JSON 格式的编辑内容
  @override
  final String deltaJson;

  /// 转换后的 HTML 内容（用于显示）
  @override
  final String htmlContent;

  /// 编辑时间
  @override
  final DateTime editedAt;

  /// 从内容提取的摘要
  @override
  final String? summary;

  @override
  String toString() {
    return 'EditedArticleContent(articleId: $articleId, deltaJson: $deltaJson, htmlContent: $htmlContent, editedAt: $editedAt, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditedArticleContentImpl &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId) &&
            (identical(other.deltaJson, deltaJson) ||
                other.deltaJson == deltaJson) &&
            (identical(other.htmlContent, htmlContent) ||
                other.htmlContent == htmlContent) &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    articleId,
    deltaJson,
    htmlContent,
    editedAt,
    summary,
  );

  /// Create a copy of EditedArticleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditedArticleContentImplCopyWith<_$EditedArticleContentImpl>
  get copyWith =>
      __$$EditedArticleContentImplCopyWithImpl<_$EditedArticleContentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EditedArticleContentImplToJson(this);
  }
}

abstract class _EditedArticleContent extends EditedArticleContent {
  const factory _EditedArticleContent({
    required final String articleId,
    required final String deltaJson,
    required final String htmlContent,
    required final DateTime editedAt,
    final String? summary,
  }) = _$EditedArticleContentImpl;
  const _EditedArticleContent._() : super._();

  factory _EditedArticleContent.fromJson(Map<String, dynamic> json) =
      _$EditedArticleContentImpl.fromJson;

  /// 文章 ID（关联原始文章）
  @override
  String get articleId;

  /// Quill Delta JSON 格式的编辑内容
  @override
  String get deltaJson;

  /// 转换后的 HTML 内容（用于显示）
  @override
  String get htmlContent;

  /// 编辑时间
  @override
  DateTime get editedAt;

  /// 从内容提取的摘要
  @override
  String? get summary;

  /// Create a copy of EditedArticleContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditedArticleContentImplCopyWith<_$EditedArticleContentImpl>
  get copyWith => throw _privateConstructorUsedError;
}
