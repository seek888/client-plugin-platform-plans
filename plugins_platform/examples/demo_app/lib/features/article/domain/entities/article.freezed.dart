// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
mixin _$Article {
  String get id => throw _privateConstructorUsedError;
  String get feedId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  bool get isCached => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;
  int get readProgress => throw _privateConstructorUsedError;
  String? get favoriteFolderId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Article to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res, Article>;
  @useResult
  $Res call({
    String id,
    String feedId,
    String title,
    String? summary,
    String? content,
    String? author,
    String link,
    String? imageUrl,
    DateTime? publishedAt,
    bool isRead,
    bool isFavorite,
    bool isCached,
    bool isBlocked,
    int readProgress,
    String? favoriteFolderId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res, $Val extends Article>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? feedId = null,
    Object? title = null,
    Object? summary = freezed,
    Object? content = freezed,
    Object? author = freezed,
    Object? link = null,
    Object? imageUrl = freezed,
    Object? publishedAt = freezed,
    Object? isRead = null,
    Object? isFavorite = null,
    Object? isCached = null,
    Object? isBlocked = null,
    Object? readProgress = null,
    Object? favoriteFolderId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            feedId: null == feedId
                ? _value.feedId
                : feedId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as String?,
            link: null == link
                ? _value.link
                : link // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            publishedAt: freezed == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFavorite: null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCached: null == isCached
                ? _value.isCached
                : isCached // ignore: cast_nullable_to_non_nullable
                      as bool,
            isBlocked: null == isBlocked
                ? _value.isBlocked
                : isBlocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            readProgress: null == readProgress
                ? _value.readProgress
                : readProgress // ignore: cast_nullable_to_non_nullable
                      as int,
            favoriteFolderId: freezed == favoriteFolderId
                ? _value.favoriteFolderId
                : favoriteFolderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ArticleImplCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$$ArticleImplCopyWith(
    _$ArticleImpl value,
    $Res Function(_$ArticleImpl) then,
  ) = __$$ArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String feedId,
    String title,
    String? summary,
    String? content,
    String? author,
    String link,
    String? imageUrl,
    DateTime? publishedAt,
    bool isRead,
    bool isFavorite,
    bool isCached,
    bool isBlocked,
    int readProgress,
    String? favoriteFolderId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ArticleImplCopyWithImpl<$Res>
    extends _$ArticleCopyWithImpl<$Res, _$ArticleImpl>
    implements _$$ArticleImplCopyWith<$Res> {
  __$$ArticleImplCopyWithImpl(
    _$ArticleImpl _value,
    $Res Function(_$ArticleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? feedId = null,
    Object? title = null,
    Object? summary = freezed,
    Object? content = freezed,
    Object? author = freezed,
    Object? link = null,
    Object? imageUrl = freezed,
    Object? publishedAt = freezed,
    Object? isRead = null,
    Object? isFavorite = null,
    Object? isCached = null,
    Object? isBlocked = null,
    Object? readProgress = null,
    Object? favoriteFolderId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ArticleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        feedId: null == feedId
            ? _value.feedId
            : feedId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as String?,
        link: null == link
            ? _value.link
            : link // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        publishedAt: freezed == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCached: null == isCached
            ? _value.isCached
            : isCached // ignore: cast_nullable_to_non_nullable
                  as bool,
        isBlocked: null == isBlocked
            ? _value.isBlocked
            : isBlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        readProgress: null == readProgress
            ? _value.readProgress
            : readProgress // ignore: cast_nullable_to_non_nullable
                  as int,
        favoriteFolderId: freezed == favoriteFolderId
            ? _value.favoriteFolderId
            : favoriteFolderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticleImpl extends _Article {
  const _$ArticleImpl({
    required this.id,
    required this.feedId,
    required this.title,
    this.summary,
    this.content,
    this.author,
    required this.link,
    this.imageUrl,
    this.publishedAt,
    this.isRead = false,
    this.isFavorite = false,
    this.isCached = false,
    this.isBlocked = false,
    this.readProgress = 0,
    this.favoriteFolderId,
    this.createdAt,
    this.updatedAt,
  }) : super._();

  factory _$ArticleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticleImplFromJson(json);

  @override
  final String id;
  @override
  final String feedId;
  @override
  final String title;
  @override
  final String? summary;
  @override
  final String? content;
  @override
  final String? author;
  @override
  final String link;
  @override
  final String? imageUrl;
  @override
  final DateTime? publishedAt;
  @override
  @JsonKey()
  final bool isRead;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  @JsonKey()
  final bool isCached;
  @override
  @JsonKey()
  final bool isBlocked;
  @override
  @JsonKey()
  final int readProgress;
  @override
  final String? favoriteFolderId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Article(id: $id, feedId: $feedId, title: $title, summary: $summary, content: $content, author: $author, link: $link, imageUrl: $imageUrl, publishedAt: $publishedAt, isRead: $isRead, isFavorite: $isFavorite, isCached: $isCached, isBlocked: $isBlocked, readProgress: $readProgress, favoriteFolderId: $favoriteFolderId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.feedId, feedId) || other.feedId == feedId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.isCached, isCached) ||
                other.isCached == isCached) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.readProgress, readProgress) ||
                other.readProgress == readProgress) &&
            (identical(other.favoriteFolderId, favoriteFolderId) ||
                other.favoriteFolderId == favoriteFolderId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    feedId,
    title,
    summary,
    content,
    author,
    link,
    imageUrl,
    publishedAt,
    isRead,
    isFavorite,
    isCached,
    isBlocked,
    readProgress,
    favoriteFolderId,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      __$$ArticleImplCopyWithImpl<_$ArticleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticleImplToJson(this);
  }
}

abstract class _Article extends Article {
  const factory _Article({
    required final String id,
    required final String feedId,
    required final String title,
    final String? summary,
    final String? content,
    final String? author,
    required final String link,
    final String? imageUrl,
    final DateTime? publishedAt,
    final bool isRead,
    final bool isFavorite,
    final bool isCached,
    final bool isBlocked,
    final int readProgress,
    final String? favoriteFolderId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$ArticleImpl;
  const _Article._() : super._();

  factory _Article.fromJson(Map<String, dynamic> json) = _$ArticleImpl.fromJson;

  @override
  String get id;
  @override
  String get feedId;
  @override
  String get title;
  @override
  String? get summary;
  @override
  String? get content;
  @override
  String? get author;
  @override
  String get link;
  @override
  String? get imageUrl;
  @override
  DateTime? get publishedAt;
  @override
  bool get isRead;
  @override
  bool get isFavorite;
  @override
  bool get isCached;
  @override
  bool get isBlocked;
  @override
  int get readProgress;
  @override
  String? get favoriteFolderId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
