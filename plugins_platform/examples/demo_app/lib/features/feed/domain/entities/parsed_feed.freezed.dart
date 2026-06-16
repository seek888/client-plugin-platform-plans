// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ParsedFeed _$ParsedFeedFromJson(Map<String, dynamic> json) {
  return _ParsedFeed.fromJson(json);
}

/// @nodoc
mixin _$ParsedFeed {
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  List<ParsedArticle> get articles => throw _privateConstructorUsedError;
  FeedType get feedType => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this ParsedFeed to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParsedFeed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParsedFeedCopyWith<ParsedFeed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedFeedCopyWith<$Res> {
  factory $ParsedFeedCopyWith(
    ParsedFeed value,
    $Res Function(ParsedFeed) then,
  ) = _$ParsedFeedCopyWithImpl<$Res, ParsedFeed>;
  @useResult
  $Res call({
    String title,
    String? description,
    String? link,
    String? iconUrl,
    List<ParsedArticle> articles,
    FeedType feedType,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class _$ParsedFeedCopyWithImpl<$Res, $Val extends ParsedFeed>
    implements $ParsedFeedCopyWith<$Res> {
  _$ParsedFeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParsedFeed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? link = freezed,
    Object? iconUrl = freezed,
    Object? articles = null,
    Object? feedType = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            link: freezed == link
                ? _value.link
                : link // ignore: cast_nullable_to_non_nullable
                      as String?,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            articles: null == articles
                ? _value.articles
                : articles // ignore: cast_nullable_to_non_nullable
                      as List<ParsedArticle>,
            feedType: null == feedType
                ? _value.feedType
                : feedType // ignore: cast_nullable_to_non_nullable
                      as FeedType,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParsedFeedImplCopyWith<$Res>
    implements $ParsedFeedCopyWith<$Res> {
  factory _$$ParsedFeedImplCopyWith(
    _$ParsedFeedImpl value,
    $Res Function(_$ParsedFeedImpl) then,
  ) = __$$ParsedFeedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String? description,
    String? link,
    String? iconUrl,
    List<ParsedArticle> articles,
    FeedType feedType,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class __$$ParsedFeedImplCopyWithImpl<$Res>
    extends _$ParsedFeedCopyWithImpl<$Res, _$ParsedFeedImpl>
    implements _$$ParsedFeedImplCopyWith<$Res> {
  __$$ParsedFeedImplCopyWithImpl(
    _$ParsedFeedImpl _value,
    $Res Function(_$ParsedFeedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParsedFeed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? link = freezed,
    Object? iconUrl = freezed,
    Object? articles = null,
    Object? feedType = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _$ParsedFeedImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        link: freezed == link
            ? _value.link
            : link // ignore: cast_nullable_to_non_nullable
                  as String?,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        articles: null == articles
            ? _value._articles
            : articles // ignore: cast_nullable_to_non_nullable
                  as List<ParsedArticle>,
        feedType: null == feedType
            ? _value.feedType
            : feedType // ignore: cast_nullable_to_non_nullable
                  as FeedType,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedFeedImpl extends _ParsedFeed {
  const _$ParsedFeedImpl({
    required this.title,
    this.description,
    this.link,
    this.iconUrl,
    required final List<ParsedArticle> articles,
    required this.feedType,
    this.lastUpdated,
  }) : _articles = articles,
       super._();

  factory _$ParsedFeedImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParsedFeedImplFromJson(json);

  @override
  final String title;
  @override
  final String? description;
  @override
  final String? link;
  @override
  final String? iconUrl;
  final List<ParsedArticle> _articles;
  @override
  List<ParsedArticle> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  final FeedType feedType;
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'ParsedFeed(title: $title, description: $description, link: $link, iconUrl: $iconUrl, articles: $articles, feedType: $feedType, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedFeedImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.feedType, feedType) ||
                other.feedType == feedType) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    link,
    iconUrl,
    const DeepCollectionEquality().hash(_articles),
    feedType,
    lastUpdated,
  );

  /// Create a copy of ParsedFeed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedFeedImplCopyWith<_$ParsedFeedImpl> get copyWith =>
      __$$ParsedFeedImplCopyWithImpl<_$ParsedFeedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedFeedImplToJson(this);
  }
}

abstract class _ParsedFeed extends ParsedFeed {
  const factory _ParsedFeed({
    required final String title,
    final String? description,
    final String? link,
    final String? iconUrl,
    required final List<ParsedArticle> articles,
    required final FeedType feedType,
    final DateTime? lastUpdated,
  }) = _$ParsedFeedImpl;
  const _ParsedFeed._() : super._();

  factory _ParsedFeed.fromJson(Map<String, dynamic> json) =
      _$ParsedFeedImpl.fromJson;

  @override
  String get title;
  @override
  String? get description;
  @override
  String? get link;
  @override
  String? get iconUrl;
  @override
  List<ParsedArticle> get articles;
  @override
  FeedType get feedType;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of ParsedFeed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParsedFeedImplCopyWith<_$ParsedFeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParsedArticle _$ParsedArticleFromJson(Map<String, dynamic> json) {
  return _ParsedArticle.fromJson(json);
}

/// @nodoc
mixin _$ParsedArticle {
  String? get guid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;

  /// Serializes this ParsedArticle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParsedArticle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParsedArticleCopyWith<ParsedArticle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedArticleCopyWith<$Res> {
  factory $ParsedArticleCopyWith(
    ParsedArticle value,
    $Res Function(ParsedArticle) then,
  ) = _$ParsedArticleCopyWithImpl<$Res, ParsedArticle>;
  @useResult
  $Res call({
    String? guid,
    String title,
    String? summary,
    String? content,
    String? author,
    String? link,
    String? imageUrl,
    DateTime? publishedAt,
    List<String> categories,
  });
}

/// @nodoc
class _$ParsedArticleCopyWithImpl<$Res, $Val extends ParsedArticle>
    implements $ParsedArticleCopyWith<$Res> {
  _$ParsedArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParsedArticle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guid = freezed,
    Object? title = null,
    Object? summary = freezed,
    Object? content = freezed,
    Object? author = freezed,
    Object? link = freezed,
    Object? imageUrl = freezed,
    Object? publishedAt = freezed,
    Object? categories = null,
  }) {
    return _then(
      _value.copyWith(
            guid: freezed == guid
                ? _value.guid
                : guid // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            link: freezed == link
                ? _value.link
                : link // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            publishedAt: freezed == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParsedArticleImplCopyWith<$Res>
    implements $ParsedArticleCopyWith<$Res> {
  factory _$$ParsedArticleImplCopyWith(
    _$ParsedArticleImpl value,
    $Res Function(_$ParsedArticleImpl) then,
  ) = __$$ParsedArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? guid,
    String title,
    String? summary,
    String? content,
    String? author,
    String? link,
    String? imageUrl,
    DateTime? publishedAt,
    List<String> categories,
  });
}

/// @nodoc
class __$$ParsedArticleImplCopyWithImpl<$Res>
    extends _$ParsedArticleCopyWithImpl<$Res, _$ParsedArticleImpl>
    implements _$$ParsedArticleImplCopyWith<$Res> {
  __$$ParsedArticleImplCopyWithImpl(
    _$ParsedArticleImpl _value,
    $Res Function(_$ParsedArticleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParsedArticle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guid = freezed,
    Object? title = null,
    Object? summary = freezed,
    Object? content = freezed,
    Object? author = freezed,
    Object? link = freezed,
    Object? imageUrl = freezed,
    Object? publishedAt = freezed,
    Object? categories = null,
  }) {
    return _then(
      _$ParsedArticleImpl(
        guid: freezed == guid
            ? _value.guid
            : guid // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        link: freezed == link
            ? _value.link
            : link // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        publishedAt: freezed == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedArticleImpl extends _ParsedArticle {
  const _$ParsedArticleImpl({
    this.guid,
    required this.title,
    this.summary,
    this.content,
    this.author,
    this.link,
    this.imageUrl,
    this.publishedAt,
    final List<String> categories = const [],
  }) : _categories = categories,
       super._();

  factory _$ParsedArticleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParsedArticleImplFromJson(json);

  @override
  final String? guid;
  @override
  final String title;
  @override
  final String? summary;
  @override
  final String? content;
  @override
  final String? author;
  @override
  final String? link;
  @override
  final String? imageUrl;
  @override
  final DateTime? publishedAt;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  String toString() {
    return 'ParsedArticle(guid: $guid, title: $title, summary: $summary, content: $content, author: $author, link: $link, imageUrl: $imageUrl, publishedAt: $publishedAt, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedArticleImpl &&
            (identical(other.guid, guid) || other.guid == guid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    guid,
    title,
    summary,
    content,
    author,
    link,
    imageUrl,
    publishedAt,
    const DeepCollectionEquality().hash(_categories),
  );

  /// Create a copy of ParsedArticle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedArticleImplCopyWith<_$ParsedArticleImpl> get copyWith =>
      __$$ParsedArticleImplCopyWithImpl<_$ParsedArticleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedArticleImplToJson(this);
  }
}

abstract class _ParsedArticle extends ParsedArticle {
  const factory _ParsedArticle({
    final String? guid,
    required final String title,
    final String? summary,
    final String? content,
    final String? author,
    final String? link,
    final String? imageUrl,
    final DateTime? publishedAt,
    final List<String> categories,
  }) = _$ParsedArticleImpl;
  const _ParsedArticle._() : super._();

  factory _ParsedArticle.fromJson(Map<String, dynamic> json) =
      _$ParsedArticleImpl.fromJson;

  @override
  String? get guid;
  @override
  String get title;
  @override
  String? get summary;
  @override
  String? get content;
  @override
  String? get author;
  @override
  String? get link;
  @override
  String? get imageUrl;
  @override
  DateTime? get publishedAt;
  @override
  List<String> get categories;

  /// Create a copy of ParsedArticle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParsedArticleImplCopyWith<_$ParsedArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
