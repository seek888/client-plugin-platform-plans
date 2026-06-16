// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiSourceConfig _$ApiSourceConfigFromJson(Map<String, dynamic> json) {
  return _ApiSourceConfig.fromJson(json);
}

/// @nodoc
mixin _$ApiSourceConfig {
  /// API 基础 URL
  String get baseUrl => throw _privateConstructorUsedError;

  /// API 密钥（可选）
  String? get apiKey => throw _privateConstructorUsedError;

  /// 自定义请求头（可选）
  Map<String, String> get customHeaders => throw _privateConstructorUsedError;

  /// 请求超时时间
  Duration get timeout => throw _privateConstructorUsedError;

  /// 最大重试次数
  int get maxRetries => throw _privateConstructorUsedError;

  /// Feed ID（API 端的标识）
  String? get remoteFeedId => throw _privateConstructorUsedError;

  /// Serializes this ApiSourceConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiSourceConfigCopyWith<ApiSourceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiSourceConfigCopyWith<$Res> {
  factory $ApiSourceConfigCopyWith(
    ApiSourceConfig value,
    $Res Function(ApiSourceConfig) then,
  ) = _$ApiSourceConfigCopyWithImpl<$Res, ApiSourceConfig>;
  @useResult
  $Res call({
    String baseUrl,
    String? apiKey,
    Map<String, String> customHeaders,
    Duration timeout,
    int maxRetries,
    String? remoteFeedId,
  });
}

/// @nodoc
class _$ApiSourceConfigCopyWithImpl<$Res, $Val extends ApiSourceConfig>
    implements $ApiSourceConfigCopyWith<$Res> {
  _$ApiSourceConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = null,
    Object? apiKey = freezed,
    Object? customHeaders = null,
    Object? timeout = null,
    Object? maxRetries = null,
    Object? remoteFeedId = freezed,
  }) {
    return _then(
      _value.copyWith(
            baseUrl: null == baseUrl
                ? _value.baseUrl
                : baseUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            apiKey: freezed == apiKey
                ? _value.apiKey
                : apiKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            customHeaders: null == customHeaders
                ? _value.customHeaders
                : customHeaders // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            timeout: null == timeout
                ? _value.timeout
                : timeout // ignore: cast_nullable_to_non_nullable
                      as Duration,
            maxRetries: null == maxRetries
                ? _value.maxRetries
                : maxRetries // ignore: cast_nullable_to_non_nullable
                      as int,
            remoteFeedId: freezed == remoteFeedId
                ? _value.remoteFeedId
                : remoteFeedId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiSourceConfigImplCopyWith<$Res>
    implements $ApiSourceConfigCopyWith<$Res> {
  factory _$$ApiSourceConfigImplCopyWith(
    _$ApiSourceConfigImpl value,
    $Res Function(_$ApiSourceConfigImpl) then,
  ) = __$$ApiSourceConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String baseUrl,
    String? apiKey,
    Map<String, String> customHeaders,
    Duration timeout,
    int maxRetries,
    String? remoteFeedId,
  });
}

/// @nodoc
class __$$ApiSourceConfigImplCopyWithImpl<$Res>
    extends _$ApiSourceConfigCopyWithImpl<$Res, _$ApiSourceConfigImpl>
    implements _$$ApiSourceConfigImplCopyWith<$Res> {
  __$$ApiSourceConfigImplCopyWithImpl(
    _$ApiSourceConfigImpl _value,
    $Res Function(_$ApiSourceConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = null,
    Object? apiKey = freezed,
    Object? customHeaders = null,
    Object? timeout = null,
    Object? maxRetries = null,
    Object? remoteFeedId = freezed,
  }) {
    return _then(
      _$ApiSourceConfigImpl(
        baseUrl: null == baseUrl
            ? _value.baseUrl
            : baseUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: freezed == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        customHeaders: null == customHeaders
            ? _value._customHeaders
            : customHeaders // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        timeout: null == timeout
            ? _value.timeout
            : timeout // ignore: cast_nullable_to_non_nullable
                  as Duration,
        maxRetries: null == maxRetries
            ? _value.maxRetries
            : maxRetries // ignore: cast_nullable_to_non_nullable
                  as int,
        remoteFeedId: freezed == remoteFeedId
            ? _value.remoteFeedId
            : remoteFeedId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiSourceConfigImpl extends _ApiSourceConfig {
  const _$ApiSourceConfigImpl({
    required this.baseUrl,
    this.apiKey,
    final Map<String, String> customHeaders = const {},
    this.timeout = const Duration(seconds: 30),
    this.maxRetries = 3,
    this.remoteFeedId,
  }) : _customHeaders = customHeaders,
       super._();

  factory _$ApiSourceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiSourceConfigImplFromJson(json);

  /// API 基础 URL
  @override
  final String baseUrl;

  /// API 密钥（可选）
  @override
  final String? apiKey;

  /// 自定义请求头（可选）
  final Map<String, String> _customHeaders;

  /// 自定义请求头（可选）
  @override
  @JsonKey()
  Map<String, String> get customHeaders {
    if (_customHeaders is EqualUnmodifiableMapView) return _customHeaders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customHeaders);
  }

  /// 请求超时时间
  @override
  @JsonKey()
  final Duration timeout;

  /// 最大重试次数
  @override
  @JsonKey()
  final int maxRetries;

  /// Feed ID（API 端的标识）
  @override
  final String? remoteFeedId;

  @override
  String toString() {
    return 'ApiSourceConfig(baseUrl: $baseUrl, apiKey: $apiKey, customHeaders: $customHeaders, timeout: $timeout, maxRetries: $maxRetries, remoteFeedId: $remoteFeedId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiSourceConfigImpl &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            const DeepCollectionEquality().equals(
              other._customHeaders,
              _customHeaders,
            ) &&
            (identical(other.timeout, timeout) || other.timeout == timeout) &&
            (identical(other.maxRetries, maxRetries) ||
                other.maxRetries == maxRetries) &&
            (identical(other.remoteFeedId, remoteFeedId) ||
                other.remoteFeedId == remoteFeedId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    baseUrl,
    apiKey,
    const DeepCollectionEquality().hash(_customHeaders),
    timeout,
    maxRetries,
    remoteFeedId,
  );

  /// Create a copy of ApiSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiSourceConfigImplCopyWith<_$ApiSourceConfigImpl> get copyWith =>
      __$$ApiSourceConfigImplCopyWithImpl<_$ApiSourceConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiSourceConfigImplToJson(this);
  }
}

abstract class _ApiSourceConfig extends ApiSourceConfig {
  const factory _ApiSourceConfig({
    required final String baseUrl,
    final String? apiKey,
    final Map<String, String> customHeaders,
    final Duration timeout,
    final int maxRetries,
    final String? remoteFeedId,
  }) = _$ApiSourceConfigImpl;
  const _ApiSourceConfig._() : super._();

  factory _ApiSourceConfig.fromJson(Map<String, dynamic> json) =
      _$ApiSourceConfigImpl.fromJson;

  /// API 基础 URL
  @override
  String get baseUrl;

  /// API 密钥（可选）
  @override
  String? get apiKey;

  /// 自定义请求头（可选）
  @override
  Map<String, String> get customHeaders;

  /// 请求超时时间
  @override
  Duration get timeout;

  /// 最大重试次数
  @override
  int get maxRetries;

  /// Feed ID（API 端的标识）
  @override
  String? get remoteFeedId;

  /// Create a copy of ApiSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiSourceConfigImplCopyWith<_$ApiSourceConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArticleListResult _$ArticleListResultFromJson(Map<String, dynamic> json) {
  return _ArticleListResult.fromJson(json);
}

/// @nodoc
mixin _$ArticleListResult {
  /// 文章列表
  List<ParsedArticle> get articles => throw _privateConstructorUsedError;

  /// 是否还有更多数据
  bool get hasMore => throw _privateConstructorUsedError;

  /// 总数量（可选）
  int? get totalCount => throw _privateConstructorUsedError;

  /// 下一页游标（可选，用于游标分页）
  String? get nextCursor => throw _privateConstructorUsedError;

  /// 当前页码
  int get currentPage => throw _privateConstructorUsedError;

  /// 每页数量
  int get pageSize => throw _privateConstructorUsedError;

  /// Serializes this ArticleListResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArticleListResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArticleListResultCopyWith<ArticleListResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleListResultCopyWith<$Res> {
  factory $ArticleListResultCopyWith(
    ArticleListResult value,
    $Res Function(ArticleListResult) then,
  ) = _$ArticleListResultCopyWithImpl<$Res, ArticleListResult>;
  @useResult
  $Res call({
    List<ParsedArticle> articles,
    bool hasMore,
    int? totalCount,
    String? nextCursor,
    int currentPage,
    int pageSize,
  });
}

/// @nodoc
class _$ArticleListResultCopyWithImpl<$Res, $Val extends ArticleListResult>
    implements $ArticleListResultCopyWith<$Res> {
  _$ArticleListResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArticleListResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? hasMore = null,
    Object? totalCount = freezed,
    Object? nextCursor = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
  }) {
    return _then(
      _value.copyWith(
            articles: null == articles
                ? _value.articles
                : articles // ignore: cast_nullable_to_non_nullable
                      as List<ParsedArticle>,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalCount: freezed == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            nextCursor: freezed == nextCursor
                ? _value.nextCursor
                : nextCursor // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ArticleListResultImplCopyWith<$Res>
    implements $ArticleListResultCopyWith<$Res> {
  factory _$$ArticleListResultImplCopyWith(
    _$ArticleListResultImpl value,
    $Res Function(_$ArticleListResultImpl) then,
  ) = __$$ArticleListResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ParsedArticle> articles,
    bool hasMore,
    int? totalCount,
    String? nextCursor,
    int currentPage,
    int pageSize,
  });
}

/// @nodoc
class __$$ArticleListResultImplCopyWithImpl<$Res>
    extends _$ArticleListResultCopyWithImpl<$Res, _$ArticleListResultImpl>
    implements _$$ArticleListResultImplCopyWith<$Res> {
  __$$ArticleListResultImplCopyWithImpl(
    _$ArticleListResultImpl _value,
    $Res Function(_$ArticleListResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleListResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? hasMore = null,
    Object? totalCount = freezed,
    Object? nextCursor = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
  }) {
    return _then(
      _$ArticleListResultImpl(
        articles: null == articles
            ? _value._articles
            : articles // ignore: cast_nullable_to_non_nullable
                  as List<ParsedArticle>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalCount: freezed == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        nextCursor: freezed == nextCursor
            ? _value.nextCursor
            : nextCursor // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticleListResultImpl extends _ArticleListResult {
  const _$ArticleListResultImpl({
    required final List<ParsedArticle> articles,
    required this.hasMore,
    this.totalCount,
    this.nextCursor,
    this.currentPage = 1,
    this.pageSize = 20,
  }) : _articles = articles,
       super._();

  factory _$ArticleListResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticleListResultImplFromJson(json);

  /// 文章列表
  final List<ParsedArticle> _articles;

  /// 文章列表
  @override
  List<ParsedArticle> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  /// 是否还有更多数据
  @override
  final bool hasMore;

  /// 总数量（可选）
  @override
  final int? totalCount;

  /// 下一页游标（可选，用于游标分页）
  @override
  final String? nextCursor;

  /// 当前页码
  @override
  @JsonKey()
  final int currentPage;

  /// 每页数量
  @override
  @JsonKey()
  final int pageSize;

  @override
  String toString() {
    return 'ArticleListResult(articles: $articles, hasMore: $hasMore, totalCount: $totalCount, nextCursor: $nextCursor, currentPage: $currentPage, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleListResultImpl &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_articles),
    hasMore,
    totalCount,
    nextCursor,
    currentPage,
    pageSize,
  );

  /// Create a copy of ArticleListResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleListResultImplCopyWith<_$ArticleListResultImpl> get copyWith =>
      __$$ArticleListResultImplCopyWithImpl<_$ArticleListResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticleListResultImplToJson(this);
  }
}

abstract class _ArticleListResult extends ArticleListResult {
  const factory _ArticleListResult({
    required final List<ParsedArticle> articles,
    required final bool hasMore,
    final int? totalCount,
    final String? nextCursor,
    final int currentPage,
    final int pageSize,
  }) = _$ArticleListResultImpl;
  const _ArticleListResult._() : super._();

  factory _ArticleListResult.fromJson(Map<String, dynamic> json) =
      _$ArticleListResultImpl.fromJson;

  /// 文章列表
  @override
  List<ParsedArticle> get articles;

  /// 是否还有更多数据
  @override
  bool get hasMore;

  /// 总数量（可选）
  @override
  int? get totalCount;

  /// 下一页游标（可选，用于游标分页）
  @override
  String? get nextCursor;

  /// 当前页码
  @override
  int get currentPage;

  /// 每页数量
  @override
  int get pageSize;

  /// Create a copy of ArticleListResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleListResultImplCopyWith<_$ArticleListResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PluginSourceConfig _$PluginSourceConfigFromJson(Map<String, dynamic> json) {
  return _PluginSourceConfig.fromJson(json);
}

/// @nodoc
mixin _$PluginSourceConfig {
  /// 插件 ID
  String get pluginId => throw _privateConstructorUsedError;

  /// 插件内 Feed 标识
  String get feedKey => throw _privateConstructorUsedError;

  /// 插件能力提供者 ID
  String get provider => throw _privateConstructorUsedError;

  /// Serializes this PluginSourceConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PluginSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PluginSourceConfigCopyWith<PluginSourceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PluginSourceConfigCopyWith<$Res> {
  factory $PluginSourceConfigCopyWith(
    PluginSourceConfig value,
    $Res Function(PluginSourceConfig) then,
  ) = _$PluginSourceConfigCopyWithImpl<$Res, PluginSourceConfig>;
  @useResult
  $Res call({String pluginId, String feedKey, String provider});
}

/// @nodoc
class _$PluginSourceConfigCopyWithImpl<$Res, $Val extends PluginSourceConfig>
    implements $PluginSourceConfigCopyWith<$Res> {
  _$PluginSourceConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PluginSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pluginId = null,
    Object? feedKey = null,
    Object? provider = null,
  }) {
    return _then(
      _value.copyWith(
            pluginId: null == pluginId
                ? _value.pluginId
                : pluginId // ignore: cast_nullable_to_non_nullable
                      as String,
            feedKey: null == feedKey
                ? _value.feedKey
                : feedKey // ignore: cast_nullable_to_non_nullable
                      as String,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PluginSourceConfigImplCopyWith<$Res>
    implements $PluginSourceConfigCopyWith<$Res> {
  factory _$$PluginSourceConfigImplCopyWith(
    _$PluginSourceConfigImpl value,
    $Res Function(_$PluginSourceConfigImpl) then,
  ) = __$$PluginSourceConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pluginId, String feedKey, String provider});
}

/// @nodoc
class __$$PluginSourceConfigImplCopyWithImpl<$Res>
    extends _$PluginSourceConfigCopyWithImpl<$Res, _$PluginSourceConfigImpl>
    implements _$$PluginSourceConfigImplCopyWith<$Res> {
  __$$PluginSourceConfigImplCopyWithImpl(
    _$PluginSourceConfigImpl _value,
    $Res Function(_$PluginSourceConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PluginSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pluginId = null,
    Object? feedKey = null,
    Object? provider = null,
  }) {
    return _then(
      _$PluginSourceConfigImpl(
        pluginId: null == pluginId
            ? _value.pluginId
            : pluginId // ignore: cast_nullable_to_non_nullable
                  as String,
        feedKey: null == feedKey
            ? _value.feedKey
            : feedKey // ignore: cast_nullable_to_non_nullable
                  as String,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PluginSourceConfigImpl extends _PluginSourceConfig {
  const _$PluginSourceConfigImpl({
    required this.pluginId,
    required this.feedKey,
    this.provider = 'rss.feed.provider',
  }) : super._();

  factory _$PluginSourceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$PluginSourceConfigImplFromJson(json);

  /// 插件 ID
  @override
  final String pluginId;

  /// 插件内 Feed 标识
  @override
  final String feedKey;

  /// 插件能力提供者 ID
  @override
  @JsonKey()
  final String provider;

  @override
  String toString() {
    return 'PluginSourceConfig(pluginId: $pluginId, feedKey: $feedKey, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PluginSourceConfigImpl &&
            (identical(other.pluginId, pluginId) ||
                other.pluginId == pluginId) &&
            (identical(other.feedKey, feedKey) || other.feedKey == feedKey) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pluginId, feedKey, provider);

  /// Create a copy of PluginSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PluginSourceConfigImplCopyWith<_$PluginSourceConfigImpl> get copyWith =>
      __$$PluginSourceConfigImplCopyWithImpl<_$PluginSourceConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PluginSourceConfigImplToJson(this);
  }
}

abstract class _PluginSourceConfig extends PluginSourceConfig {
  const factory _PluginSourceConfig({
    required final String pluginId,
    required final String feedKey,
    final String provider,
  }) = _$PluginSourceConfigImpl;
  const _PluginSourceConfig._() : super._();

  factory _PluginSourceConfig.fromJson(Map<String, dynamic> json) =
      _$PluginSourceConfigImpl.fromJson;

  /// 插件 ID
  @override
  String get pluginId;

  /// 插件内 Feed 标识
  @override
  String get feedKey;

  /// 插件能力提供者 ID
  @override
  String get provider;

  /// Create a copy of PluginSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PluginSourceConfigImplCopyWith<_$PluginSourceConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataSourceConfig _$DataSourceConfigFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'rss':
      return RssSourceConfig.fromJson(json);
    case 'api':
      return ApiDataSourceConfig.fromJson(json);
    case 'plugin':
      return PluginDataSourceConfig.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'DataSourceConfig',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$DataSourceConfig {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String feedUrl) rss,
    required TResult Function(ApiSourceConfig config) api,
    required TResult Function(PluginSourceConfig config) plugin,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String feedUrl)? rss,
    TResult? Function(ApiSourceConfig config)? api,
    TResult? Function(PluginSourceConfig config)? plugin,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String feedUrl)? rss,
    TResult Function(ApiSourceConfig config)? api,
    TResult Function(PluginSourceConfig config)? plugin,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RssSourceConfig value) rss,
    required TResult Function(ApiDataSourceConfig value) api,
    required TResult Function(PluginDataSourceConfig value) plugin,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RssSourceConfig value)? rss,
    TResult? Function(ApiDataSourceConfig value)? api,
    TResult? Function(PluginDataSourceConfig value)? plugin,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RssSourceConfig value)? rss,
    TResult Function(ApiDataSourceConfig value)? api,
    TResult Function(PluginDataSourceConfig value)? plugin,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this DataSourceConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSourceConfigCopyWith<$Res> {
  factory $DataSourceConfigCopyWith(
    DataSourceConfig value,
    $Res Function(DataSourceConfig) then,
  ) = _$DataSourceConfigCopyWithImpl<$Res, DataSourceConfig>;
}

/// @nodoc
class _$DataSourceConfigCopyWithImpl<$Res, $Val extends DataSourceConfig>
    implements $DataSourceConfigCopyWith<$Res> {
  _$DataSourceConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RssSourceConfigImplCopyWith<$Res> {
  factory _$$RssSourceConfigImplCopyWith(
    _$RssSourceConfigImpl value,
    $Res Function(_$RssSourceConfigImpl) then,
  ) = __$$RssSourceConfigImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String feedUrl});
}

/// @nodoc
class __$$RssSourceConfigImplCopyWithImpl<$Res>
    extends _$DataSourceConfigCopyWithImpl<$Res, _$RssSourceConfigImpl>
    implements _$$RssSourceConfigImplCopyWith<$Res> {
  __$$RssSourceConfigImplCopyWithImpl(
    _$RssSourceConfigImpl _value,
    $Res Function(_$RssSourceConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? feedUrl = null}) {
    return _then(
      _$RssSourceConfigImpl(
        feedUrl: null == feedUrl
            ? _value.feedUrl
            : feedUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RssSourceConfigImpl implements RssSourceConfig {
  const _$RssSourceConfigImpl({required this.feedUrl, final String? $type})
    : $type = $type ?? 'rss';

  factory _$RssSourceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$RssSourceConfigImplFromJson(json);

  @override
  final String feedUrl;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DataSourceConfig.rss(feedUrl: $feedUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RssSourceConfigImpl &&
            (identical(other.feedUrl, feedUrl) || other.feedUrl == feedUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, feedUrl);

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RssSourceConfigImplCopyWith<_$RssSourceConfigImpl> get copyWith =>
      __$$RssSourceConfigImplCopyWithImpl<_$RssSourceConfigImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String feedUrl) rss,
    required TResult Function(ApiSourceConfig config) api,
    required TResult Function(PluginSourceConfig config) plugin,
  }) {
    return rss(feedUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String feedUrl)? rss,
    TResult? Function(ApiSourceConfig config)? api,
    TResult? Function(PluginSourceConfig config)? plugin,
  }) {
    return rss?.call(feedUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String feedUrl)? rss,
    TResult Function(ApiSourceConfig config)? api,
    TResult Function(PluginSourceConfig config)? plugin,
    required TResult orElse(),
  }) {
    if (rss != null) {
      return rss(feedUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RssSourceConfig value) rss,
    required TResult Function(ApiDataSourceConfig value) api,
    required TResult Function(PluginDataSourceConfig value) plugin,
  }) {
    return rss(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RssSourceConfig value)? rss,
    TResult? Function(ApiDataSourceConfig value)? api,
    TResult? Function(PluginDataSourceConfig value)? plugin,
  }) {
    return rss?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RssSourceConfig value)? rss,
    TResult Function(ApiDataSourceConfig value)? api,
    TResult Function(PluginDataSourceConfig value)? plugin,
    required TResult orElse(),
  }) {
    if (rss != null) {
      return rss(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RssSourceConfigImplToJson(this);
  }
}

abstract class RssSourceConfig implements DataSourceConfig {
  const factory RssSourceConfig({required final String feedUrl}) =
      _$RssSourceConfigImpl;

  factory RssSourceConfig.fromJson(Map<String, dynamic> json) =
      _$RssSourceConfigImpl.fromJson;

  String get feedUrl;

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RssSourceConfigImplCopyWith<_$RssSourceConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiDataSourceConfigImplCopyWith<$Res> {
  factory _$$ApiDataSourceConfigImplCopyWith(
    _$ApiDataSourceConfigImpl value,
    $Res Function(_$ApiDataSourceConfigImpl) then,
  ) = __$$ApiDataSourceConfigImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiSourceConfig config});

  $ApiSourceConfigCopyWith<$Res> get config;
}

/// @nodoc
class __$$ApiDataSourceConfigImplCopyWithImpl<$Res>
    extends _$DataSourceConfigCopyWithImpl<$Res, _$ApiDataSourceConfigImpl>
    implements _$$ApiDataSourceConfigImplCopyWith<$Res> {
  __$$ApiDataSourceConfigImplCopyWithImpl(
    _$ApiDataSourceConfigImpl _value,
    $Res Function(_$ApiDataSourceConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? config = null}) {
    return _then(
      _$ApiDataSourceConfigImpl(
        config: null == config
            ? _value.config
            : config // ignore: cast_nullable_to_non_nullable
                  as ApiSourceConfig,
      ),
    );
  }

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiSourceConfigCopyWith<$Res> get config {
    return $ApiSourceConfigCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiDataSourceConfigImpl implements ApiDataSourceConfig {
  const _$ApiDataSourceConfigImpl({required this.config, final String? $type})
    : $type = $type ?? 'api';

  factory _$ApiDataSourceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiDataSourceConfigImplFromJson(json);

  @override
  final ApiSourceConfig config;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DataSourceConfig.api(config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiDataSourceConfigImpl &&
            (identical(other.config, config) || other.config == config));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, config);

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiDataSourceConfigImplCopyWith<_$ApiDataSourceConfigImpl> get copyWith =>
      __$$ApiDataSourceConfigImplCopyWithImpl<_$ApiDataSourceConfigImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String feedUrl) rss,
    required TResult Function(ApiSourceConfig config) api,
    required TResult Function(PluginSourceConfig config) plugin,
  }) {
    return api(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String feedUrl)? rss,
    TResult? Function(ApiSourceConfig config)? api,
    TResult? Function(PluginSourceConfig config)? plugin,
  }) {
    return api?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String feedUrl)? rss,
    TResult Function(ApiSourceConfig config)? api,
    TResult Function(PluginSourceConfig config)? plugin,
    required TResult orElse(),
  }) {
    if (api != null) {
      return api(config);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RssSourceConfig value) rss,
    required TResult Function(ApiDataSourceConfig value) api,
    required TResult Function(PluginDataSourceConfig value) plugin,
  }) {
    return api(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RssSourceConfig value)? rss,
    TResult? Function(ApiDataSourceConfig value)? api,
    TResult? Function(PluginDataSourceConfig value)? plugin,
  }) {
    return api?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RssSourceConfig value)? rss,
    TResult Function(ApiDataSourceConfig value)? api,
    TResult Function(PluginDataSourceConfig value)? plugin,
    required TResult orElse(),
  }) {
    if (api != null) {
      return api(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiDataSourceConfigImplToJson(this);
  }
}

abstract class ApiDataSourceConfig implements DataSourceConfig {
  const factory ApiDataSourceConfig({required final ApiSourceConfig config}) =
      _$ApiDataSourceConfigImpl;

  factory ApiDataSourceConfig.fromJson(Map<String, dynamic> json) =
      _$ApiDataSourceConfigImpl.fromJson;

  ApiSourceConfig get config;

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiDataSourceConfigImplCopyWith<_$ApiDataSourceConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PluginDataSourceConfigImplCopyWith<$Res> {
  factory _$$PluginDataSourceConfigImplCopyWith(
    _$PluginDataSourceConfigImpl value,
    $Res Function(_$PluginDataSourceConfigImpl) then,
  ) = __$$PluginDataSourceConfigImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PluginSourceConfig config});

  $PluginSourceConfigCopyWith<$Res> get config;
}

/// @nodoc
class __$$PluginDataSourceConfigImplCopyWithImpl<$Res>
    extends _$DataSourceConfigCopyWithImpl<$Res, _$PluginDataSourceConfigImpl>
    implements _$$PluginDataSourceConfigImplCopyWith<$Res> {
  __$$PluginDataSourceConfigImplCopyWithImpl(
    _$PluginDataSourceConfigImpl _value,
    $Res Function(_$PluginDataSourceConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? config = null}) {
    return _then(
      _$PluginDataSourceConfigImpl(
        config: null == config
            ? _value.config
            : config // ignore: cast_nullable_to_non_nullable
                  as PluginSourceConfig,
      ),
    );
  }

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PluginSourceConfigCopyWith<$Res> get config {
    return $PluginSourceConfigCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$PluginDataSourceConfigImpl implements PluginDataSourceConfig {
  const _$PluginDataSourceConfigImpl({
    required this.config,
    final String? $type,
  }) : $type = $type ?? 'plugin';

  factory _$PluginDataSourceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$PluginDataSourceConfigImplFromJson(json);

  @override
  final PluginSourceConfig config;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DataSourceConfig.plugin(config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PluginDataSourceConfigImpl &&
            (identical(other.config, config) || other.config == config));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, config);

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PluginDataSourceConfigImplCopyWith<_$PluginDataSourceConfigImpl>
  get copyWith =>
      __$$PluginDataSourceConfigImplCopyWithImpl<_$PluginDataSourceConfigImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String feedUrl) rss,
    required TResult Function(ApiSourceConfig config) api,
    required TResult Function(PluginSourceConfig config) plugin,
  }) {
    return plugin(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String feedUrl)? rss,
    TResult? Function(ApiSourceConfig config)? api,
    TResult? Function(PluginSourceConfig config)? plugin,
  }) {
    return plugin?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String feedUrl)? rss,
    TResult Function(ApiSourceConfig config)? api,
    TResult Function(PluginSourceConfig config)? plugin,
    required TResult orElse(),
  }) {
    if (plugin != null) {
      return plugin(config);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RssSourceConfig value) rss,
    required TResult Function(ApiDataSourceConfig value) api,
    required TResult Function(PluginDataSourceConfig value) plugin,
  }) {
    return plugin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RssSourceConfig value)? rss,
    TResult? Function(ApiDataSourceConfig value)? api,
    TResult? Function(PluginDataSourceConfig value)? plugin,
  }) {
    return plugin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RssSourceConfig value)? rss,
    TResult Function(ApiDataSourceConfig value)? api,
    TResult Function(PluginDataSourceConfig value)? plugin,
    required TResult orElse(),
  }) {
    if (plugin != null) {
      return plugin(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PluginDataSourceConfigImplToJson(this);
  }
}

abstract class PluginDataSourceConfig implements DataSourceConfig {
  const factory PluginDataSourceConfig({
    required final PluginSourceConfig config,
  }) = _$PluginDataSourceConfigImpl;

  factory PluginDataSourceConfig.fromJson(Map<String, dynamic> json) =
      _$PluginDataSourceConfigImpl.fromJson;

  PluginSourceConfig get config;

  /// Create a copy of DataSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PluginDataSourceConfigImplCopyWith<_$PluginDataSourceConfigImpl>
  get copyWith => throw _privateConstructorUsedError;
}
