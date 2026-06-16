// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Feed _$FeedFromJson(Map<String, dynamic> json) {
  return _Feed.fromJson(json);
}

/// @nodoc
mixin _$Feed {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  DateTime? get lastFetched => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;
  int get healthStatus => throw _privateConstructorUsedError;
  int get failureCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError; // 数据源相关字段
  /// 数据源类型（默认为 RSS）
  SourceType get sourceType => throw _privateConstructorUsedError;

  /// API 数据源配置（仅当 sourceType 为 api 时有效）
  ApiSourceConfig? get apiConfig => throw _privateConstructorUsedError;

  /// 插件数据源配置（仅当 sourceType 为 plugin 时有效）
  PluginSourceConfig? get pluginConfig => throw _privateConstructorUsedError;

  /// Serializes this Feed to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedCopyWith<Feed> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedCopyWith<$Res> {
  factory $FeedCopyWith(Feed value, $Res Function(Feed) then) =
      _$FeedCopyWithImpl<$Res, Feed>;
  @useResult
  $Res call({
    String id,
    String url,
    String title,
    String? description,
    String? iconUrl,
    String? link,
    String? categoryId,
    int sortOrder,
    int unreadCount,
    DateTime? lastUpdated,
    DateTime? lastFetched,
    bool isEnabled,
    bool isBlocked,
    int healthStatus,
    int failureCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    SourceType sourceType,
    ApiSourceConfig? apiConfig,
    PluginSourceConfig? pluginConfig,
  });

  $ApiSourceConfigCopyWith<$Res>? get apiConfig;
  $PluginSourceConfigCopyWith<$Res>? get pluginConfig;
}

/// @nodoc
class _$FeedCopyWithImpl<$Res, $Val extends Feed>
    implements $FeedCopyWith<$Res> {
  _$FeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? link = freezed,
    Object? categoryId = freezed,
    Object? sortOrder = null,
    Object? unreadCount = null,
    Object? lastUpdated = freezed,
    Object? lastFetched = freezed,
    Object? isEnabled = null,
    Object? isBlocked = null,
    Object? healthStatus = null,
    Object? failureCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? sourceType = null,
    Object? apiConfig = freezed,
    Object? pluginConfig = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            link: freezed == link
                ? _value.link
                : link // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastFetched: freezed == lastFetched
                ? _value.lastFetched
                : lastFetched // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isBlocked: null == isBlocked
                ? _value.isBlocked
                : isBlocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            healthStatus: null == healthStatus
                ? _value.healthStatus
                : healthStatus // ignore: cast_nullable_to_non_nullable
                      as int,
            failureCount: null == failureCount
                ? _value.failureCount
                : failureCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            sourceType: null == sourceType
                ? _value.sourceType
                : sourceType // ignore: cast_nullable_to_non_nullable
                      as SourceType,
            apiConfig: freezed == apiConfig
                ? _value.apiConfig
                : apiConfig // ignore: cast_nullable_to_non_nullable
                      as ApiSourceConfig?,
            pluginConfig: freezed == pluginConfig
                ? _value.pluginConfig
                : pluginConfig // ignore: cast_nullable_to_non_nullable
                      as PluginSourceConfig?,
          )
          as $Val,
    );
  }

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiSourceConfigCopyWith<$Res>? get apiConfig {
    if (_value.apiConfig == null) {
      return null;
    }

    return $ApiSourceConfigCopyWith<$Res>(_value.apiConfig!, (value) {
      return _then(_value.copyWith(apiConfig: value) as $Val);
    });
  }

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PluginSourceConfigCopyWith<$Res>? get pluginConfig {
    if (_value.pluginConfig == null) {
      return null;
    }

    return $PluginSourceConfigCopyWith<$Res>(_value.pluginConfig!, (value) {
      return _then(_value.copyWith(pluginConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FeedImplCopyWith<$Res> implements $FeedCopyWith<$Res> {
  factory _$$FeedImplCopyWith(
    _$FeedImpl value,
    $Res Function(_$FeedImpl) then,
  ) = __$$FeedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String url,
    String title,
    String? description,
    String? iconUrl,
    String? link,
    String? categoryId,
    int sortOrder,
    int unreadCount,
    DateTime? lastUpdated,
    DateTime? lastFetched,
    bool isEnabled,
    bool isBlocked,
    int healthStatus,
    int failureCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    SourceType sourceType,
    ApiSourceConfig? apiConfig,
    PluginSourceConfig? pluginConfig,
  });

  @override
  $ApiSourceConfigCopyWith<$Res>? get apiConfig;
  @override
  $PluginSourceConfigCopyWith<$Res>? get pluginConfig;
}

/// @nodoc
class __$$FeedImplCopyWithImpl<$Res>
    extends _$FeedCopyWithImpl<$Res, _$FeedImpl>
    implements _$$FeedImplCopyWith<$Res> {
  __$$FeedImplCopyWithImpl(_$FeedImpl _value, $Res Function(_$FeedImpl) _then)
    : super(_value, _then);

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? link = freezed,
    Object? categoryId = freezed,
    Object? sortOrder = null,
    Object? unreadCount = null,
    Object? lastUpdated = freezed,
    Object? lastFetched = freezed,
    Object? isEnabled = null,
    Object? isBlocked = null,
    Object? healthStatus = null,
    Object? failureCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? sourceType = null,
    Object? apiConfig = freezed,
    Object? pluginConfig = freezed,
  }) {
    return _then(
      _$FeedImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        link: freezed == link
            ? _value.link
            : link // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastFetched: freezed == lastFetched
            ? _value.lastFetched
            : lastFetched // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isBlocked: null == isBlocked
            ? _value.isBlocked
            : isBlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        healthStatus: null == healthStatus
            ? _value.healthStatus
            : healthStatus // ignore: cast_nullable_to_non_nullable
                  as int,
        failureCount: null == failureCount
            ? _value.failureCount
            : failureCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        sourceType: null == sourceType
            ? _value.sourceType
            : sourceType // ignore: cast_nullable_to_non_nullable
                  as SourceType,
        apiConfig: freezed == apiConfig
            ? _value.apiConfig
            : apiConfig // ignore: cast_nullable_to_non_nullable
                  as ApiSourceConfig?,
        pluginConfig: freezed == pluginConfig
            ? _value.pluginConfig
            : pluginConfig // ignore: cast_nullable_to_non_nullable
                  as PluginSourceConfig?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedImpl extends _Feed {
  const _$FeedImpl({
    required this.id,
    required this.url,
    required this.title,
    this.description,
    this.iconUrl,
    this.link,
    this.categoryId,
    this.sortOrder = 0,
    this.unreadCount = 0,
    this.lastUpdated,
    this.lastFetched,
    this.isEnabled = true,
    this.isBlocked = false,
    this.healthStatus = 0,
    this.failureCount = 0,
    this.createdAt,
    this.updatedAt,
    this.sourceType = SourceType.rss,
    this.apiConfig,
    this.pluginConfig,
  }) : super._();

  factory _$FeedImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? iconUrl;
  @override
  final String? link;
  @override
  final String? categoryId;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  final DateTime? lastUpdated;
  @override
  final DateTime? lastFetched;
  @override
  @JsonKey()
  final bool isEnabled;
  @override
  @JsonKey()
  final bool isBlocked;
  @override
  @JsonKey()
  final int healthStatus;
  @override
  @JsonKey()
  final int failureCount;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  // 数据源相关字段
  /// 数据源类型（默认为 RSS）
  @override
  @JsonKey()
  final SourceType sourceType;

  /// API 数据源配置（仅当 sourceType 为 api 时有效）
  @override
  final ApiSourceConfig? apiConfig;

  /// 插件数据源配置（仅当 sourceType 为 plugin 时有效）
  @override
  final PluginSourceConfig? pluginConfig;

  @override
  String toString() {
    return 'Feed(id: $id, url: $url, title: $title, description: $description, iconUrl: $iconUrl, link: $link, categoryId: $categoryId, sortOrder: $sortOrder, unreadCount: $unreadCount, lastUpdated: $lastUpdated, lastFetched: $lastFetched, isEnabled: $isEnabled, isBlocked: $isBlocked, healthStatus: $healthStatus, failureCount: $failureCount, createdAt: $createdAt, updatedAt: $updatedAt, sourceType: $sourceType, apiConfig: $apiConfig, pluginConfig: $pluginConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.lastFetched, lastFetched) ||
                other.lastFetched == lastFetched) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.healthStatus, healthStatus) ||
                other.healthStatus == healthStatus) &&
            (identical(other.failureCount, failureCount) ||
                other.failureCount == failureCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.apiConfig, apiConfig) ||
                other.apiConfig == apiConfig) &&
            (identical(other.pluginConfig, pluginConfig) ||
                other.pluginConfig == pluginConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    url,
    title,
    description,
    iconUrl,
    link,
    categoryId,
    sortOrder,
    unreadCount,
    lastUpdated,
    lastFetched,
    isEnabled,
    isBlocked,
    healthStatus,
    failureCount,
    createdAt,
    updatedAt,
    sourceType,
    apiConfig,
    pluginConfig,
  ]);

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedImplCopyWith<_$FeedImpl> get copyWith =>
      __$$FeedImplCopyWithImpl<_$FeedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedImplToJson(this);
  }
}

abstract class _Feed extends Feed {
  const factory _Feed({
    required final String id,
    required final String url,
    required final String title,
    final String? description,
    final String? iconUrl,
    final String? link,
    final String? categoryId,
    final int sortOrder,
    final int unreadCount,
    final DateTime? lastUpdated,
    final DateTime? lastFetched,
    final bool isEnabled,
    final bool isBlocked,
    final int healthStatus,
    final int failureCount,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final SourceType sourceType,
    final ApiSourceConfig? apiConfig,
    final PluginSourceConfig? pluginConfig,
  }) = _$FeedImpl;
  const _Feed._() : super._();

  factory _Feed.fromJson(Map<String, dynamic> json) = _$FeedImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get iconUrl;
  @override
  String? get link;
  @override
  String? get categoryId;
  @override
  int get sortOrder;
  @override
  int get unreadCount;
  @override
  DateTime? get lastUpdated;
  @override
  DateTime? get lastFetched;
  @override
  bool get isEnabled;
  @override
  bool get isBlocked;
  @override
  int get healthStatus;
  @override
  int get failureCount;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt; // 数据源相关字段
  /// 数据源类型（默认为 RSS）
  @override
  SourceType get sourceType;

  /// API 数据源配置（仅当 sourceType 为 api 时有效）
  @override
  ApiSourceConfig? get apiConfig;

  /// 插件数据源配置（仅当 sourceType 为 plugin 时有效）
  @override
  PluginSourceConfig? get pluginConfig;

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedImplCopyWith<_$FeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeedCategory _$FeedCategoryFromJson(Map<String, dynamic> json) {
  return _FeedCategory.fromJson(json);
}

/// @nodoc
mixin _$FeedCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  bool get isExpanded => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this FeedCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedCategoryCopyWith<FeedCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedCategoryCopyWith<$Res> {
  factory $FeedCategoryCopyWith(
    FeedCategory value,
    $Res Function(FeedCategory) then,
  ) = _$FeedCategoryCopyWithImpl<$Res, FeedCategory>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    int sortOrder,
    bool isExpanded,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$FeedCategoryCopyWithImpl<$Res, $Val extends FeedCategory>
    implements $FeedCategoryCopyWith<$Res> {
  _$FeedCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? sortOrder = null,
    Object? isExpanded = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isExpanded: null == isExpanded
                ? _value.isExpanded
                : isExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$FeedCategoryImplCopyWith<$Res>
    implements $FeedCategoryCopyWith<$Res> {
  factory _$$FeedCategoryImplCopyWith(
    _$FeedCategoryImpl value,
    $Res Function(_$FeedCategoryImpl) then,
  ) = __$$FeedCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    int sortOrder,
    bool isExpanded,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$FeedCategoryImplCopyWithImpl<$Res>
    extends _$FeedCategoryCopyWithImpl<$Res, _$FeedCategoryImpl>
    implements _$$FeedCategoryImplCopyWith<$Res> {
  __$$FeedCategoryImplCopyWithImpl(
    _$FeedCategoryImpl _value,
    $Res Function(_$FeedCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? sortOrder = null,
    Object? isExpanded = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$FeedCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isExpanded: null == isExpanded
            ? _value.isExpanded
            : isExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$FeedCategoryImpl implements _FeedCategory {
  const _$FeedCategoryImpl({
    required this.id,
    required this.name,
    this.description,
    this.sortOrder = 0,
    this.isExpanded = true,
    this.createdAt,
    this.updatedAt,
  });

  factory _$FeedCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  @JsonKey()
  final bool isExpanded;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'FeedCategory(id: $id, name: $name, description: $description, sortOrder: $sortOrder, isExpanded: $isExpanded, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isExpanded, isExpanded) ||
                other.isExpanded == isExpanded) &&
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
    name,
    description,
    sortOrder,
    isExpanded,
    createdAt,
    updatedAt,
  );

  /// Create a copy of FeedCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedCategoryImplCopyWith<_$FeedCategoryImpl> get copyWith =>
      __$$FeedCategoryImplCopyWithImpl<_$FeedCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedCategoryImplToJson(this);
  }
}

abstract class _FeedCategory implements FeedCategory {
  const factory _FeedCategory({
    required final String id,
    required final String name,
    final String? description,
    final int sortOrder,
    final bool isExpanded,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$FeedCategoryImpl;

  factory _FeedCategory.fromJson(Map<String, dynamic> json) =
      _$FeedCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get sortOrder;
  @override
  bool get isExpanded;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of FeedCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedCategoryImplCopyWith<_$FeedCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
