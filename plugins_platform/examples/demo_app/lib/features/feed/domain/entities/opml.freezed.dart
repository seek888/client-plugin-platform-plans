// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opml.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OPMLFeed _$OPMLFeedFromJson(Map<String, dynamic> json) {
  return _OPMLFeed.fromJson(json);
}

/// @nodoc
mixin _$OPMLFeed {
  String get title => throw _privateConstructorUsedError;
  String get xmlUrl => throw _privateConstructorUsedError;
  String? get htmlUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;

  /// Serializes this OPMLFeed to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OPMLFeed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OPMLFeedCopyWith<OPMLFeed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OPMLFeedCopyWith<$Res> {
  factory $OPMLFeedCopyWith(OPMLFeed value, $Res Function(OPMLFeed) then) =
      _$OPMLFeedCopyWithImpl<$Res, OPMLFeed>;
  @useResult
  $Res call({
    String title,
    String xmlUrl,
    String? htmlUrl,
    String? description,
    String? category,
  });
}

/// @nodoc
class _$OPMLFeedCopyWithImpl<$Res, $Val extends OPMLFeed>
    implements $OPMLFeedCopyWith<$Res> {
  _$OPMLFeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OPMLFeed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? xmlUrl = null,
    Object? htmlUrl = freezed,
    Object? description = freezed,
    Object? category = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            xmlUrl: null == xmlUrl
                ? _value.xmlUrl
                : xmlUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            htmlUrl: freezed == htmlUrl
                ? _value.htmlUrl
                : htmlUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OPMLFeedImplCopyWith<$Res>
    implements $OPMLFeedCopyWith<$Res> {
  factory _$$OPMLFeedImplCopyWith(
    _$OPMLFeedImpl value,
    $Res Function(_$OPMLFeedImpl) then,
  ) = __$$OPMLFeedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String xmlUrl,
    String? htmlUrl,
    String? description,
    String? category,
  });
}

/// @nodoc
class __$$OPMLFeedImplCopyWithImpl<$Res>
    extends _$OPMLFeedCopyWithImpl<$Res, _$OPMLFeedImpl>
    implements _$$OPMLFeedImplCopyWith<$Res> {
  __$$OPMLFeedImplCopyWithImpl(
    _$OPMLFeedImpl _value,
    $Res Function(_$OPMLFeedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OPMLFeed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? xmlUrl = null,
    Object? htmlUrl = freezed,
    Object? description = freezed,
    Object? category = freezed,
  }) {
    return _then(
      _$OPMLFeedImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        xmlUrl: null == xmlUrl
            ? _value.xmlUrl
            : xmlUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        htmlUrl: freezed == htmlUrl
            ? _value.htmlUrl
            : htmlUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OPMLFeedImpl extends _OPMLFeed {
  const _$OPMLFeedImpl({
    required this.title,
    required this.xmlUrl,
    this.htmlUrl,
    this.description,
    this.category,
  }) : super._();

  factory _$OPMLFeedImpl.fromJson(Map<String, dynamic> json) =>
      _$$OPMLFeedImplFromJson(json);

  @override
  final String title;
  @override
  final String xmlUrl;
  @override
  final String? htmlUrl;
  @override
  final String? description;
  @override
  final String? category;

  @override
  String toString() {
    return 'OPMLFeed(title: $title, xmlUrl: $xmlUrl, htmlUrl: $htmlUrl, description: $description, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OPMLFeedImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.xmlUrl, xmlUrl) || other.xmlUrl == xmlUrl) &&
            (identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, xmlUrl, htmlUrl, description, category);

  /// Create a copy of OPMLFeed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OPMLFeedImplCopyWith<_$OPMLFeedImpl> get copyWith =>
      __$$OPMLFeedImplCopyWithImpl<_$OPMLFeedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OPMLFeedImplToJson(this);
  }
}

abstract class _OPMLFeed extends OPMLFeed {
  const factory _OPMLFeed({
    required final String title,
    required final String xmlUrl,
    final String? htmlUrl,
    final String? description,
    final String? category,
  }) = _$OPMLFeedImpl;
  const _OPMLFeed._() : super._();

  factory _OPMLFeed.fromJson(Map<String, dynamic> json) =
      _$OPMLFeedImpl.fromJson;

  @override
  String get title;
  @override
  String get xmlUrl;
  @override
  String? get htmlUrl;
  @override
  String? get description;
  @override
  String? get category;

  /// Create a copy of OPMLFeed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OPMLFeedImplCopyWith<_$OPMLFeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OPMLDocument _$OPMLDocumentFromJson(Map<String, dynamic> json) {
  return _OPMLDocument.fromJson(json);
}

/// @nodoc
mixin _$OPMLDocument {
  String get title => throw _privateConstructorUsedError;
  DateTime? get dateCreated => throw _privateConstructorUsedError;
  List<OPMLFeed> get feeds => throw _privateConstructorUsedError;
  Map<String, List<OPMLFeed>> get categorizedFeeds =>
      throw _privateConstructorUsedError;

  /// Serializes this OPMLDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OPMLDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OPMLDocumentCopyWith<OPMLDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OPMLDocumentCopyWith<$Res> {
  factory $OPMLDocumentCopyWith(
    OPMLDocument value,
    $Res Function(OPMLDocument) then,
  ) = _$OPMLDocumentCopyWithImpl<$Res, OPMLDocument>;
  @useResult
  $Res call({
    String title,
    DateTime? dateCreated,
    List<OPMLFeed> feeds,
    Map<String, List<OPMLFeed>> categorizedFeeds,
  });
}

/// @nodoc
class _$OPMLDocumentCopyWithImpl<$Res, $Val extends OPMLDocument>
    implements $OPMLDocumentCopyWith<$Res> {
  _$OPMLDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OPMLDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? dateCreated = freezed,
    Object? feeds = null,
    Object? categorizedFeeds = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            dateCreated: freezed == dateCreated
                ? _value.dateCreated
                : dateCreated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            feeds: null == feeds
                ? _value.feeds
                : feeds // ignore: cast_nullable_to_non_nullable
                      as List<OPMLFeed>,
            categorizedFeeds: null == categorizedFeeds
                ? _value.categorizedFeeds
                : categorizedFeeds // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<OPMLFeed>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OPMLDocumentImplCopyWith<$Res>
    implements $OPMLDocumentCopyWith<$Res> {
  factory _$$OPMLDocumentImplCopyWith(
    _$OPMLDocumentImpl value,
    $Res Function(_$OPMLDocumentImpl) then,
  ) = __$$OPMLDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    DateTime? dateCreated,
    List<OPMLFeed> feeds,
    Map<String, List<OPMLFeed>> categorizedFeeds,
  });
}

/// @nodoc
class __$$OPMLDocumentImplCopyWithImpl<$Res>
    extends _$OPMLDocumentCopyWithImpl<$Res, _$OPMLDocumentImpl>
    implements _$$OPMLDocumentImplCopyWith<$Res> {
  __$$OPMLDocumentImplCopyWithImpl(
    _$OPMLDocumentImpl _value,
    $Res Function(_$OPMLDocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OPMLDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? dateCreated = freezed,
    Object? feeds = null,
    Object? categorizedFeeds = null,
  }) {
    return _then(
      _$OPMLDocumentImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        dateCreated: freezed == dateCreated
            ? _value.dateCreated
            : dateCreated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        feeds: null == feeds
            ? _value._feeds
            : feeds // ignore: cast_nullable_to_non_nullable
                  as List<OPMLFeed>,
        categorizedFeeds: null == categorizedFeeds
            ? _value._categorizedFeeds
            : categorizedFeeds // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<OPMLFeed>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OPMLDocumentImpl extends _OPMLDocument {
  const _$OPMLDocumentImpl({
    this.title = 'RSS Reader Export',
    this.dateCreated,
    final List<OPMLFeed> feeds = const [],
    final Map<String, List<OPMLFeed>> categorizedFeeds = const {},
  }) : _feeds = feeds,
       _categorizedFeeds = categorizedFeeds,
       super._();

  factory _$OPMLDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$OPMLDocumentImplFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  final DateTime? dateCreated;
  final List<OPMLFeed> _feeds;
  @override
  @JsonKey()
  List<OPMLFeed> get feeds {
    if (_feeds is EqualUnmodifiableListView) return _feeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feeds);
  }

  final Map<String, List<OPMLFeed>> _categorizedFeeds;
  @override
  @JsonKey()
  Map<String, List<OPMLFeed>> get categorizedFeeds {
    if (_categorizedFeeds is EqualUnmodifiableMapView) return _categorizedFeeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categorizedFeeds);
  }

  @override
  String toString() {
    return 'OPMLDocument(title: $title, dateCreated: $dateCreated, feeds: $feeds, categorizedFeeds: $categorizedFeeds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OPMLDocumentImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated) &&
            const DeepCollectionEquality().equals(other._feeds, _feeds) &&
            const DeepCollectionEquality().equals(
              other._categorizedFeeds,
              _categorizedFeeds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    dateCreated,
    const DeepCollectionEquality().hash(_feeds),
    const DeepCollectionEquality().hash(_categorizedFeeds),
  );

  /// Create a copy of OPMLDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OPMLDocumentImplCopyWith<_$OPMLDocumentImpl> get copyWith =>
      __$$OPMLDocumentImplCopyWithImpl<_$OPMLDocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OPMLDocumentImplToJson(this);
  }
}

abstract class _OPMLDocument extends OPMLDocument {
  const factory _OPMLDocument({
    final String title,
    final DateTime? dateCreated,
    final List<OPMLFeed> feeds,
    final Map<String, List<OPMLFeed>> categorizedFeeds,
  }) = _$OPMLDocumentImpl;
  const _OPMLDocument._() : super._();

  factory _OPMLDocument.fromJson(Map<String, dynamic> json) =
      _$OPMLDocumentImpl.fromJson;

  @override
  String get title;
  @override
  DateTime? get dateCreated;
  @override
  List<OPMLFeed> get feeds;
  @override
  Map<String, List<OPMLFeed>> get categorizedFeeds;

  /// Create a copy of OPMLDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OPMLDocumentImplCopyWith<_$OPMLDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
