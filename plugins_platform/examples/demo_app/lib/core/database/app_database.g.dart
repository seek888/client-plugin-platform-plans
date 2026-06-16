// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FeedsTableTable extends FeedsTable
    with TableInfo<$FeedsTableTable, FeedsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconUrlMeta = const VerificationMeta(
    'iconUrl',
  );
  @override
  late final GeneratedColumn<String> iconUrl = GeneratedColumn<String>(
    'icon_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastFetchedMeta = const VerificationMeta(
    'lastFetched',
  );
  @override
  late final GeneratedColumn<DateTime> lastFetched = GeneratedColumn<DateTime>(
    'last_fetched',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isBlockedMeta = const VerificationMeta(
    'isBlocked',
  );
  @override
  late final GeneratedColumn<bool> isBlocked = GeneratedColumn<bool>(
    'is_blocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_blocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _healthStatusMeta = const VerificationMeta(
    'healthStatus',
  );
  @override
  late final GeneratedColumn<int> healthStatus = GeneratedColumn<int>(
    'health_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _failureCountMeta = const VerificationMeta(
    'failureCount',
  );
  @override
  late final GeneratedColumn<int> failureCount = GeneratedColumn<int>(
    'failure_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('rss'),
  );
  static const VerificationMeta _apiBaseUrlMeta = const VerificationMeta(
    'apiBaseUrl',
  );
  @override
  late final GeneratedColumn<String> apiBaseUrl = GeneratedColumn<String>(
    'api_base_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  @override
  late final GeneratedColumn<String> apiKey = GeneratedColumn<String>(
    'api_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _apiHeadersMeta = const VerificationMeta(
    'apiHeaders',
  );
  @override
  late final GeneratedColumn<String> apiHeaders = GeneratedColumn<String>(
    'api_headers',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _apiRemoteFeedIdMeta = const VerificationMeta(
    'apiRemoteFeedId',
  );
  @override
  late final GeneratedColumn<String> apiRemoteFeedId = GeneratedColumn<String>(
    'api_remote_feed_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _apiTimeoutMeta = const VerificationMeta(
    'apiTimeout',
  );
  @override
  late final GeneratedColumn<int> apiTimeout = GeneratedColumn<int>(
    'api_timeout',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _apiMaxRetriesMeta = const VerificationMeta(
    'apiMaxRetries',
  );
  @override
  late final GeneratedColumn<int> apiMaxRetries = GeneratedColumn<int>(
    'api_max_retries',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _pluginIdMeta = const VerificationMeta(
    'pluginId',
  );
  @override
  late final GeneratedColumn<String> pluginId = GeneratedColumn<String>(
    'plugin_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pluginFeedKeyMeta = const VerificationMeta(
    'pluginFeedKey',
  );
  @override
  late final GeneratedColumn<String> pluginFeedKey = GeneratedColumn<String>(
    'plugin_feed_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pluginProviderMeta = const VerificationMeta(
    'pluginProvider',
  );
  @override
  late final GeneratedColumn<String> pluginProvider = GeneratedColumn<String>(
    'plugin_provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
    apiBaseUrl,
    apiKey,
    apiHeaders,
    apiRemoteFeedId,
    apiTimeout,
    apiMaxRetries,
    pluginId,
    pluginFeedKey,
    pluginProvider,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeds';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('icon_url')) {
      context.handle(
        _iconUrlMeta,
        iconUrl.isAcceptableOrUnknown(data['icon_url']!, _iconUrlMeta),
      );
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    }
    if (data.containsKey('last_fetched')) {
      context.handle(
        _lastFetchedMeta,
        lastFetched.isAcceptableOrUnknown(
          data['last_fetched']!,
          _lastFetchedMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('is_blocked')) {
      context.handle(
        _isBlockedMeta,
        isBlocked.isAcceptableOrUnknown(data['is_blocked']!, _isBlockedMeta),
      );
    }
    if (data.containsKey('health_status')) {
      context.handle(
        _healthStatusMeta,
        healthStatus.isAcceptableOrUnknown(
          data['health_status']!,
          _healthStatusMeta,
        ),
      );
    }
    if (data.containsKey('failure_count')) {
      context.handle(
        _failureCountMeta,
        failureCount.isAcceptableOrUnknown(
          data['failure_count']!,
          _failureCountMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    }
    if (data.containsKey('api_base_url')) {
      context.handle(
        _apiBaseUrlMeta,
        apiBaseUrl.isAcceptableOrUnknown(
          data['api_base_url']!,
          _apiBaseUrlMeta,
        ),
      );
    }
    if (data.containsKey('api_key')) {
      context.handle(
        _apiKeyMeta,
        apiKey.isAcceptableOrUnknown(data['api_key']!, _apiKeyMeta),
      );
    }
    if (data.containsKey('api_headers')) {
      context.handle(
        _apiHeadersMeta,
        apiHeaders.isAcceptableOrUnknown(data['api_headers']!, _apiHeadersMeta),
      );
    }
    if (data.containsKey('api_remote_feed_id')) {
      context.handle(
        _apiRemoteFeedIdMeta,
        apiRemoteFeedId.isAcceptableOrUnknown(
          data['api_remote_feed_id']!,
          _apiRemoteFeedIdMeta,
        ),
      );
    }
    if (data.containsKey('api_timeout')) {
      context.handle(
        _apiTimeoutMeta,
        apiTimeout.isAcceptableOrUnknown(data['api_timeout']!, _apiTimeoutMeta),
      );
    }
    if (data.containsKey('api_max_retries')) {
      context.handle(
        _apiMaxRetriesMeta,
        apiMaxRetries.isAcceptableOrUnknown(
          data['api_max_retries']!,
          _apiMaxRetriesMeta,
        ),
      );
    }
    if (data.containsKey('plugin_id')) {
      context.handle(
        _pluginIdMeta,
        pluginId.isAcceptableOrUnknown(data['plugin_id']!, _pluginIdMeta),
      );
    }
    if (data.containsKey('plugin_feed_key')) {
      context.handle(
        _pluginFeedKeyMeta,
        pluginFeedKey.isAcceptableOrUnknown(
          data['plugin_feed_key']!,
          _pluginFeedKeyMeta,
        ),
      );
    }
    if (data.containsKey('plugin_provider')) {
      context.handle(
        _pluginProviderMeta,
        pluginProvider.isAcceptableOrUnknown(
          data['plugin_provider']!,
          _pluginProviderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      iconUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_url'],
      ),
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      ),
      lastFetched: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_fetched'],
      ),
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      isBlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_blocked'],
      )!,
      healthStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}health_status'],
      )!,
      failureCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failure_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      apiBaseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_base_url'],
      ),
      apiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_key'],
      ),
      apiHeaders: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_headers'],
      ),
      apiRemoteFeedId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_remote_feed_id'],
      ),
      apiTimeout: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}api_timeout'],
      )!,
      apiMaxRetries: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}api_max_retries'],
      )!,
      pluginId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plugin_id'],
      ),
      pluginFeedKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plugin_feed_key'],
      ),
      pluginProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plugin_provider'],
      ),
    );
  }

  @override
  $FeedsTableTable createAlias(String alias) {
    return $FeedsTableTable(attachedDatabase, alias);
  }
}

class FeedsTableData extends DataClass implements Insertable<FeedsTableData> {
  /// 主键 ID
  final String id;

  /// 订阅源 URL
  final String url;

  /// 订阅源标题
  final String title;

  /// 订阅源描述
  final String? description;

  /// 订阅源图标 URL
  final String? iconUrl;

  /// 订阅源网站链接
  final String? link;

  /// 所属分类 ID
  final String? categoryId;

  /// 排序顺序
  final int sortOrder;

  /// 未读数量
  final int unreadCount;

  /// 最后更新时间
  final DateTime? lastUpdated;

  /// 最后获取时间
  final DateTime? lastFetched;

  /// 是否启用
  final bool isEnabled;

  /// 是否被屏蔽
  final bool isBlocked;

  /// 健康状态：0-正常, 1-警告, 2-失效
  final int healthStatus;

  /// 连续失败次数
  final int failureCount;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;

  /// 数据源类型：'rss'、'api' 或 'plugin'
  final String sourceType;

  /// API 基础 URL（仅 API 数据源）
  final String? apiBaseUrl;

  /// API 密钥（仅 API 数据源）
  final String? apiKey;

  /// API 自定义请求头（JSON 格式，仅 API 数据源）
  final String? apiHeaders;

  /// API 远程 Feed ID（仅 API 数据源）
  final String? apiRemoteFeedId;

  /// API 请求超时（秒，仅 API 数据源）
  final int apiTimeout;

  /// API 最大重试次数（仅 API 数据源）
  final int apiMaxRetries;

  /// 插件 ID（仅插件数据源）
  final String? pluginId;

  /// 插件内 Feed Key（仅插件数据源）
  final String? pluginFeedKey;

  /// 插件能力提供者 ID（仅插件数据源）
  final String? pluginProvider;
  const FeedsTableData({
    required this.id,
    required this.url,
    required this.title,
    this.description,
    this.iconUrl,
    this.link,
    this.categoryId,
    required this.sortOrder,
    required this.unreadCount,
    this.lastUpdated,
    this.lastFetched,
    required this.isEnabled,
    required this.isBlocked,
    required this.healthStatus,
    required this.failureCount,
    required this.createdAt,
    required this.updatedAt,
    required this.sourceType,
    this.apiBaseUrl,
    this.apiKey,
    this.apiHeaders,
    this.apiRemoteFeedId,
    required this.apiTimeout,
    required this.apiMaxRetries,
    this.pluginId,
    this.pluginFeedKey,
    this.pluginProvider,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['url'] = Variable<String>(url);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || iconUrl != null) {
      map['icon_url'] = Variable<String>(iconUrl);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['unread_count'] = Variable<int>(unreadCount);
    if (!nullToAbsent || lastUpdated != null) {
      map['last_updated'] = Variable<DateTime>(lastUpdated);
    }
    if (!nullToAbsent || lastFetched != null) {
      map['last_fetched'] = Variable<DateTime>(lastFetched);
    }
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['is_blocked'] = Variable<bool>(isBlocked);
    map['health_status'] = Variable<int>(healthStatus);
    map['failure_count'] = Variable<int>(failureCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || apiBaseUrl != null) {
      map['api_base_url'] = Variable<String>(apiBaseUrl);
    }
    if (!nullToAbsent || apiKey != null) {
      map['api_key'] = Variable<String>(apiKey);
    }
    if (!nullToAbsent || apiHeaders != null) {
      map['api_headers'] = Variable<String>(apiHeaders);
    }
    if (!nullToAbsent || apiRemoteFeedId != null) {
      map['api_remote_feed_id'] = Variable<String>(apiRemoteFeedId);
    }
    map['api_timeout'] = Variable<int>(apiTimeout);
    map['api_max_retries'] = Variable<int>(apiMaxRetries);
    if (!nullToAbsent || pluginId != null) {
      map['plugin_id'] = Variable<String>(pluginId);
    }
    if (!nullToAbsent || pluginFeedKey != null) {
      map['plugin_feed_key'] = Variable<String>(pluginFeedKey);
    }
    if (!nullToAbsent || pluginProvider != null) {
      map['plugin_provider'] = Variable<String>(pluginProvider);
    }
    return map;
  }

  FeedsTableCompanion toCompanion(bool nullToAbsent) {
    return FeedsTableCompanion(
      id: Value(id),
      url: Value(url),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      iconUrl: iconUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(iconUrl),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      sortOrder: Value(sortOrder),
      unreadCount: Value(unreadCount),
      lastUpdated: lastUpdated == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdated),
      lastFetched: lastFetched == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFetched),
      isEnabled: Value(isEnabled),
      isBlocked: Value(isBlocked),
      healthStatus: Value(healthStatus),
      failureCount: Value(failureCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sourceType: Value(sourceType),
      apiBaseUrl: apiBaseUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(apiBaseUrl),
      apiKey: apiKey == null && nullToAbsent
          ? const Value.absent()
          : Value(apiKey),
      apiHeaders: apiHeaders == null && nullToAbsent
          ? const Value.absent()
          : Value(apiHeaders),
      apiRemoteFeedId: apiRemoteFeedId == null && nullToAbsent
          ? const Value.absent()
          : Value(apiRemoteFeedId),
      apiTimeout: Value(apiTimeout),
      apiMaxRetries: Value(apiMaxRetries),
      pluginId: pluginId == null && nullToAbsent
          ? const Value.absent()
          : Value(pluginId),
      pluginFeedKey: pluginFeedKey == null && nullToAbsent
          ? const Value.absent()
          : Value(pluginFeedKey),
      pluginProvider: pluginProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(pluginProvider),
    );
  }

  factory FeedsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedsTableData(
      id: serializer.fromJson<String>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      iconUrl: serializer.fromJson<String?>(json['iconUrl']),
      link: serializer.fromJson<String?>(json['link']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      lastUpdated: serializer.fromJson<DateTime?>(json['lastUpdated']),
      lastFetched: serializer.fromJson<DateTime?>(json['lastFetched']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      isBlocked: serializer.fromJson<bool>(json['isBlocked']),
      healthStatus: serializer.fromJson<int>(json['healthStatus']),
      failureCount: serializer.fromJson<int>(json['failureCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      apiBaseUrl: serializer.fromJson<String?>(json['apiBaseUrl']),
      apiKey: serializer.fromJson<String?>(json['apiKey']),
      apiHeaders: serializer.fromJson<String?>(json['apiHeaders']),
      apiRemoteFeedId: serializer.fromJson<String?>(json['apiRemoteFeedId']),
      apiTimeout: serializer.fromJson<int>(json['apiTimeout']),
      apiMaxRetries: serializer.fromJson<int>(json['apiMaxRetries']),
      pluginId: serializer.fromJson<String?>(json['pluginId']),
      pluginFeedKey: serializer.fromJson<String?>(json['pluginFeedKey']),
      pluginProvider: serializer.fromJson<String?>(json['pluginProvider']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'url': serializer.toJson<String>(url),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'iconUrl': serializer.toJson<String?>(iconUrl),
      'link': serializer.toJson<String?>(link),
      'categoryId': serializer.toJson<String?>(categoryId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'lastUpdated': serializer.toJson<DateTime?>(lastUpdated),
      'lastFetched': serializer.toJson<DateTime?>(lastFetched),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'isBlocked': serializer.toJson<bool>(isBlocked),
      'healthStatus': serializer.toJson<int>(healthStatus),
      'failureCount': serializer.toJson<int>(failureCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sourceType': serializer.toJson<String>(sourceType),
      'apiBaseUrl': serializer.toJson<String?>(apiBaseUrl),
      'apiKey': serializer.toJson<String?>(apiKey),
      'apiHeaders': serializer.toJson<String?>(apiHeaders),
      'apiRemoteFeedId': serializer.toJson<String?>(apiRemoteFeedId),
      'apiTimeout': serializer.toJson<int>(apiTimeout),
      'apiMaxRetries': serializer.toJson<int>(apiMaxRetries),
      'pluginId': serializer.toJson<String?>(pluginId),
      'pluginFeedKey': serializer.toJson<String?>(pluginFeedKey),
      'pluginProvider': serializer.toJson<String?>(pluginProvider),
    };
  }

  FeedsTableData copyWith({
    String? id,
    String? url,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> iconUrl = const Value.absent(),
    Value<String?> link = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    int? sortOrder,
    int? unreadCount,
    Value<DateTime?> lastUpdated = const Value.absent(),
    Value<DateTime?> lastFetched = const Value.absent(),
    bool? isEnabled,
    bool? isBlocked,
    int? healthStatus,
    int? failureCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? sourceType,
    Value<String?> apiBaseUrl = const Value.absent(),
    Value<String?> apiKey = const Value.absent(),
    Value<String?> apiHeaders = const Value.absent(),
    Value<String?> apiRemoteFeedId = const Value.absent(),
    int? apiTimeout,
    int? apiMaxRetries,
    Value<String?> pluginId = const Value.absent(),
    Value<String?> pluginFeedKey = const Value.absent(),
    Value<String?> pluginProvider = const Value.absent(),
  }) => FeedsTableData(
    id: id ?? this.id,
    url: url ?? this.url,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    iconUrl: iconUrl.present ? iconUrl.value : this.iconUrl,
    link: link.present ? link.value : this.link,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    sortOrder: sortOrder ?? this.sortOrder,
    unreadCount: unreadCount ?? this.unreadCount,
    lastUpdated: lastUpdated.present ? lastUpdated.value : this.lastUpdated,
    lastFetched: lastFetched.present ? lastFetched.value : this.lastFetched,
    isEnabled: isEnabled ?? this.isEnabled,
    isBlocked: isBlocked ?? this.isBlocked,
    healthStatus: healthStatus ?? this.healthStatus,
    failureCount: failureCount ?? this.failureCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    sourceType: sourceType ?? this.sourceType,
    apiBaseUrl: apiBaseUrl.present ? apiBaseUrl.value : this.apiBaseUrl,
    apiKey: apiKey.present ? apiKey.value : this.apiKey,
    apiHeaders: apiHeaders.present ? apiHeaders.value : this.apiHeaders,
    apiRemoteFeedId: apiRemoteFeedId.present
        ? apiRemoteFeedId.value
        : this.apiRemoteFeedId,
    apiTimeout: apiTimeout ?? this.apiTimeout,
    apiMaxRetries: apiMaxRetries ?? this.apiMaxRetries,
    pluginId: pluginId.present ? pluginId.value : this.pluginId,
    pluginFeedKey: pluginFeedKey.present
        ? pluginFeedKey.value
        : this.pluginFeedKey,
    pluginProvider: pluginProvider.present
        ? pluginProvider.value
        : this.pluginProvider,
  );
  FeedsTableData copyWithCompanion(FeedsTableCompanion data) {
    return FeedsTableData(
      id: data.id.present ? data.id.value : this.id,
      url: data.url.present ? data.url.value : this.url,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      iconUrl: data.iconUrl.present ? data.iconUrl.value : this.iconUrl,
      link: data.link.present ? data.link.value : this.link,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
      lastFetched: data.lastFetched.present
          ? data.lastFetched.value
          : this.lastFetched,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      isBlocked: data.isBlocked.present ? data.isBlocked.value : this.isBlocked,
      healthStatus: data.healthStatus.present
          ? data.healthStatus.value
          : this.healthStatus,
      failureCount: data.failureCount.present
          ? data.failureCount.value
          : this.failureCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      apiBaseUrl: data.apiBaseUrl.present
          ? data.apiBaseUrl.value
          : this.apiBaseUrl,
      apiKey: data.apiKey.present ? data.apiKey.value : this.apiKey,
      apiHeaders: data.apiHeaders.present
          ? data.apiHeaders.value
          : this.apiHeaders,
      apiRemoteFeedId: data.apiRemoteFeedId.present
          ? data.apiRemoteFeedId.value
          : this.apiRemoteFeedId,
      apiTimeout: data.apiTimeout.present
          ? data.apiTimeout.value
          : this.apiTimeout,
      apiMaxRetries: data.apiMaxRetries.present
          ? data.apiMaxRetries.value
          : this.apiMaxRetries,
      pluginId: data.pluginId.present ? data.pluginId.value : this.pluginId,
      pluginFeedKey: data.pluginFeedKey.present
          ? data.pluginFeedKey.value
          : this.pluginFeedKey,
      pluginProvider: data.pluginProvider.present
          ? data.pluginProvider.value
          : this.pluginProvider,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedsTableData(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('link: $link, ')
          ..write('categoryId: $categoryId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('lastFetched: $lastFetched, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('isBlocked: $isBlocked, ')
          ..write('healthStatus: $healthStatus, ')
          ..write('failureCount: $failureCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sourceType: $sourceType, ')
          ..write('apiBaseUrl: $apiBaseUrl, ')
          ..write('apiKey: $apiKey, ')
          ..write('apiHeaders: $apiHeaders, ')
          ..write('apiRemoteFeedId: $apiRemoteFeedId, ')
          ..write('apiTimeout: $apiTimeout, ')
          ..write('apiMaxRetries: $apiMaxRetries, ')
          ..write('pluginId: $pluginId, ')
          ..write('pluginFeedKey: $pluginFeedKey, ')
          ..write('pluginProvider: $pluginProvider')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
    apiBaseUrl,
    apiKey,
    apiHeaders,
    apiRemoteFeedId,
    apiTimeout,
    apiMaxRetries,
    pluginId,
    pluginFeedKey,
    pluginProvider,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedsTableData &&
          other.id == this.id &&
          other.url == this.url &&
          other.title == this.title &&
          other.description == this.description &&
          other.iconUrl == this.iconUrl &&
          other.link == this.link &&
          other.categoryId == this.categoryId &&
          other.sortOrder == this.sortOrder &&
          other.unreadCount == this.unreadCount &&
          other.lastUpdated == this.lastUpdated &&
          other.lastFetched == this.lastFetched &&
          other.isEnabled == this.isEnabled &&
          other.isBlocked == this.isBlocked &&
          other.healthStatus == this.healthStatus &&
          other.failureCount == this.failureCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sourceType == this.sourceType &&
          other.apiBaseUrl == this.apiBaseUrl &&
          other.apiKey == this.apiKey &&
          other.apiHeaders == this.apiHeaders &&
          other.apiRemoteFeedId == this.apiRemoteFeedId &&
          other.apiTimeout == this.apiTimeout &&
          other.apiMaxRetries == this.apiMaxRetries &&
          other.pluginId == this.pluginId &&
          other.pluginFeedKey == this.pluginFeedKey &&
          other.pluginProvider == this.pluginProvider);
}

class FeedsTableCompanion extends UpdateCompanion<FeedsTableData> {
  final Value<String> id;
  final Value<String> url;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> iconUrl;
  final Value<String?> link;
  final Value<String?> categoryId;
  final Value<int> sortOrder;
  final Value<int> unreadCount;
  final Value<DateTime?> lastUpdated;
  final Value<DateTime?> lastFetched;
  final Value<bool> isEnabled;
  final Value<bool> isBlocked;
  final Value<int> healthStatus;
  final Value<int> failureCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> sourceType;
  final Value<String?> apiBaseUrl;
  final Value<String?> apiKey;
  final Value<String?> apiHeaders;
  final Value<String?> apiRemoteFeedId;
  final Value<int> apiTimeout;
  final Value<int> apiMaxRetries;
  final Value<String?> pluginId;
  final Value<String?> pluginFeedKey;
  final Value<String?> pluginProvider;
  final Value<int> rowid;
  const FeedsTableCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.link = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.lastFetched = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.isBlocked = const Value.absent(),
    this.healthStatus = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.apiBaseUrl = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.apiHeaders = const Value.absent(),
    this.apiRemoteFeedId = const Value.absent(),
    this.apiTimeout = const Value.absent(),
    this.apiMaxRetries = const Value.absent(),
    this.pluginId = const Value.absent(),
    this.pluginFeedKey = const Value.absent(),
    this.pluginProvider = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedsTableCompanion.insert({
    required String id,
    required String url,
    required String title,
    this.description = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.link = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.lastFetched = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.isBlocked = const Value.absent(),
    this.healthStatus = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.apiBaseUrl = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.apiHeaders = const Value.absent(),
    this.apiRemoteFeedId = const Value.absent(),
    this.apiTimeout = const Value.absent(),
    this.apiMaxRetries = const Value.absent(),
    this.pluginId = const Value.absent(),
    this.pluginFeedKey = const Value.absent(),
    this.pluginProvider = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       url = Value(url),
       title = Value(title);
  static Insertable<FeedsTableData> custom({
    Expression<String>? id,
    Expression<String>? url,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? iconUrl,
    Expression<String>? link,
    Expression<String>? categoryId,
    Expression<int>? sortOrder,
    Expression<int>? unreadCount,
    Expression<DateTime>? lastUpdated,
    Expression<DateTime>? lastFetched,
    Expression<bool>? isEnabled,
    Expression<bool>? isBlocked,
    Expression<int>? healthStatus,
    Expression<int>? failureCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? sourceType,
    Expression<String>? apiBaseUrl,
    Expression<String>? apiKey,
    Expression<String>? apiHeaders,
    Expression<String>? apiRemoteFeedId,
    Expression<int>? apiTimeout,
    Expression<int>? apiMaxRetries,
    Expression<String>? pluginId,
    Expression<String>? pluginFeedKey,
    Expression<String>? pluginProvider,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (iconUrl != null) 'icon_url': iconUrl,
      if (link != null) 'link': link,
      if (categoryId != null) 'category_id': categoryId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (lastFetched != null) 'last_fetched': lastFetched,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (isBlocked != null) 'is_blocked': isBlocked,
      if (healthStatus != null) 'health_status': healthStatus,
      if (failureCount != null) 'failure_count': failureCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sourceType != null) 'source_type': sourceType,
      if (apiBaseUrl != null) 'api_base_url': apiBaseUrl,
      if (apiKey != null) 'api_key': apiKey,
      if (apiHeaders != null) 'api_headers': apiHeaders,
      if (apiRemoteFeedId != null) 'api_remote_feed_id': apiRemoteFeedId,
      if (apiTimeout != null) 'api_timeout': apiTimeout,
      if (apiMaxRetries != null) 'api_max_retries': apiMaxRetries,
      if (pluginId != null) 'plugin_id': pluginId,
      if (pluginFeedKey != null) 'plugin_feed_key': pluginFeedKey,
      if (pluginProvider != null) 'plugin_provider': pluginProvider,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? url,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? iconUrl,
    Value<String?>? link,
    Value<String?>? categoryId,
    Value<int>? sortOrder,
    Value<int>? unreadCount,
    Value<DateTime?>? lastUpdated,
    Value<DateTime?>? lastFetched,
    Value<bool>? isEnabled,
    Value<bool>? isBlocked,
    Value<int>? healthStatus,
    Value<int>? failureCount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? sourceType,
    Value<String?>? apiBaseUrl,
    Value<String?>? apiKey,
    Value<String?>? apiHeaders,
    Value<String?>? apiRemoteFeedId,
    Value<int>? apiTimeout,
    Value<int>? apiMaxRetries,
    Value<String?>? pluginId,
    Value<String?>? pluginFeedKey,
    Value<String?>? pluginProvider,
    Value<int>? rowid,
  }) {
    return FeedsTableCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      link: link ?? this.link,
      categoryId: categoryId ?? this.categoryId,
      sortOrder: sortOrder ?? this.sortOrder,
      unreadCount: unreadCount ?? this.unreadCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lastFetched: lastFetched ?? this.lastFetched,
      isEnabled: isEnabled ?? this.isEnabled,
      isBlocked: isBlocked ?? this.isBlocked,
      healthStatus: healthStatus ?? this.healthStatus,
      failureCount: failureCount ?? this.failureCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sourceType: sourceType ?? this.sourceType,
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      apiKey: apiKey ?? this.apiKey,
      apiHeaders: apiHeaders ?? this.apiHeaders,
      apiRemoteFeedId: apiRemoteFeedId ?? this.apiRemoteFeedId,
      apiTimeout: apiTimeout ?? this.apiTimeout,
      apiMaxRetries: apiMaxRetries ?? this.apiMaxRetries,
      pluginId: pluginId ?? this.pluginId,
      pluginFeedKey: pluginFeedKey ?? this.pluginFeedKey,
      pluginProvider: pluginProvider ?? this.pluginProvider,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconUrl.present) {
      map['icon_url'] = Variable<String>(iconUrl.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (lastFetched.present) {
      map['last_fetched'] = Variable<DateTime>(lastFetched.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (isBlocked.present) {
      map['is_blocked'] = Variable<bool>(isBlocked.value);
    }
    if (healthStatus.present) {
      map['health_status'] = Variable<int>(healthStatus.value);
    }
    if (failureCount.present) {
      map['failure_count'] = Variable<int>(failureCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (apiBaseUrl.present) {
      map['api_base_url'] = Variable<String>(apiBaseUrl.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (apiHeaders.present) {
      map['api_headers'] = Variable<String>(apiHeaders.value);
    }
    if (apiRemoteFeedId.present) {
      map['api_remote_feed_id'] = Variable<String>(apiRemoteFeedId.value);
    }
    if (apiTimeout.present) {
      map['api_timeout'] = Variable<int>(apiTimeout.value);
    }
    if (apiMaxRetries.present) {
      map['api_max_retries'] = Variable<int>(apiMaxRetries.value);
    }
    if (pluginId.present) {
      map['plugin_id'] = Variable<String>(pluginId.value);
    }
    if (pluginFeedKey.present) {
      map['plugin_feed_key'] = Variable<String>(pluginFeedKey.value);
    }
    if (pluginProvider.present) {
      map['plugin_provider'] = Variable<String>(pluginProvider.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedsTableCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('link: $link, ')
          ..write('categoryId: $categoryId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('lastFetched: $lastFetched, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('isBlocked: $isBlocked, ')
          ..write('healthStatus: $healthStatus, ')
          ..write('failureCount: $failureCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sourceType: $sourceType, ')
          ..write('apiBaseUrl: $apiBaseUrl, ')
          ..write('apiKey: $apiKey, ')
          ..write('apiHeaders: $apiHeaders, ')
          ..write('apiRemoteFeedId: $apiRemoteFeedId, ')
          ..write('apiTimeout: $apiTimeout, ')
          ..write('apiMaxRetries: $apiMaxRetries, ')
          ..write('pluginId: $pluginId, ')
          ..write('pluginFeedKey: $pluginFeedKey, ')
          ..write('pluginProvider: $pluginProvider, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ArticlesTableTable extends ArticlesTable
    with TableInfo<$ArticlesTableTable, ArticlesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feedIdMeta = const VerificationMeta('feedId');
  @override
  late final GeneratedColumn<String> feedId = GeneratedColumn<String>(
    'feed_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isCachedMeta = const VerificationMeta(
    'isCached',
  );
  @override
  late final GeneratedColumn<bool> isCached = GeneratedColumn<bool>(
    'is_cached',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_cached" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isBlockedMeta = const VerificationMeta(
    'isBlocked',
  );
  @override
  late final GeneratedColumn<bool> isBlocked = GeneratedColumn<bool>(
    'is_blocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_blocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _readProgressMeta = const VerificationMeta(
    'readProgress',
  );
  @override
  late final GeneratedColumn<int> readProgress = GeneratedColumn<int>(
    'read_progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _favoriteFolderIdMeta = const VerificationMeta(
    'favoriteFolderId',
  );
  @override
  late final GeneratedColumn<String> favoriteFolderId = GeneratedColumn<String>(
    'favorite_folder_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    feedId,
    title,
    link,
    summary,
    content,
    author,
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArticlesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feed_id')) {
      context.handle(
        _feedIdMeta,
        feedId.isAcceptableOrUnknown(data['feed_id']!, _feedIdMeta),
      );
    } else if (isInserting) {
      context.missing(_feedIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('is_cached')) {
      context.handle(
        _isCachedMeta,
        isCached.isAcceptableOrUnknown(data['is_cached']!, _isCachedMeta),
      );
    }
    if (data.containsKey('is_blocked')) {
      context.handle(
        _isBlockedMeta,
        isBlocked.isAcceptableOrUnknown(data['is_blocked']!, _isBlockedMeta),
      );
    }
    if (data.containsKey('read_progress')) {
      context.handle(
        _readProgressMeta,
        readProgress.isAcceptableOrUnknown(
          data['read_progress']!,
          _readProgressMeta,
        ),
      );
    }
    if (data.containsKey('favorite_folder_id')) {
      context.handle(
        _favoriteFolderIdMeta,
        favoriteFolderId.isAcceptableOrUnknown(
          data['favorite_folder_id']!,
          _favoriteFolderIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArticlesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticlesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      feedId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feed_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      isCached: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_cached'],
      )!,
      isBlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_blocked'],
      )!,
      readProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}read_progress'],
      )!,
      favoriteFolderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}favorite_folder_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ArticlesTableTable createAlias(String alias) {
    return $ArticlesTableTable(attachedDatabase, alias);
  }
}

class ArticlesTableData extends DataClass
    implements Insertable<ArticlesTableData> {
  /// 主键 ID
  final String id;

  /// 所属订阅源 ID
  final String feedId;

  /// 文章标题
  final String title;

  /// 文章链接
  final String link;

  /// 文章摘要
  final String? summary;

  /// 文章内容（HTML）
  final String? content;

  /// 作者
  final String? author;

  /// 封面图 URL
  final String? imageUrl;

  /// 发布时间
  final DateTime? publishedAt;

  /// 是否已读
  final bool isRead;

  /// 是否已收藏
  final bool isFavorite;

  /// 是否已缓存
  final bool isCached;

  /// 是否被屏蔽
  final bool isBlocked;

  /// 阅读进度（0-100）
  final int readProgress;

  /// 收藏夹 ID
  final String? favoriteFolderId;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;
  const ArticlesTableData({
    required this.id,
    required this.feedId,
    required this.title,
    required this.link,
    this.summary,
    this.content,
    this.author,
    this.imageUrl,
    this.publishedAt,
    required this.isRead,
    required this.isFavorite,
    required this.isCached,
    required this.isBlocked,
    required this.readProgress,
    this.favoriteFolderId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feed_id'] = Variable<String>(feedId);
    map['title'] = Variable<String>(title);
    map['link'] = Variable<String>(link);
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    map['is_read'] = Variable<bool>(isRead);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_cached'] = Variable<bool>(isCached);
    map['is_blocked'] = Variable<bool>(isBlocked);
    map['read_progress'] = Variable<int>(readProgress);
    if (!nullToAbsent || favoriteFolderId != null) {
      map['favorite_folder_id'] = Variable<String>(favoriteFolderId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ArticlesTableCompanion toCompanion(bool nullToAbsent) {
    return ArticlesTableCompanion(
      id: Value(id),
      feedId: Value(feedId),
      title: Value(title),
      link: Value(link),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      isRead: Value(isRead),
      isFavorite: Value(isFavorite),
      isCached: Value(isCached),
      isBlocked: Value(isBlocked),
      readProgress: Value(readProgress),
      favoriteFolderId: favoriteFolderId == null && nullToAbsent
          ? const Value.absent()
          : Value(favoriteFolderId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ArticlesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticlesTableData(
      id: serializer.fromJson<String>(json['id']),
      feedId: serializer.fromJson<String>(json['feedId']),
      title: serializer.fromJson<String>(json['title']),
      link: serializer.fromJson<String>(json['link']),
      summary: serializer.fromJson<String?>(json['summary']),
      content: serializer.fromJson<String?>(json['content']),
      author: serializer.fromJson<String?>(json['author']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isCached: serializer.fromJson<bool>(json['isCached']),
      isBlocked: serializer.fromJson<bool>(json['isBlocked']),
      readProgress: serializer.fromJson<int>(json['readProgress']),
      favoriteFolderId: serializer.fromJson<String?>(json['favoriteFolderId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'feedId': serializer.toJson<String>(feedId),
      'title': serializer.toJson<String>(title),
      'link': serializer.toJson<String>(link),
      'summary': serializer.toJson<String?>(summary),
      'content': serializer.toJson<String?>(content),
      'author': serializer.toJson<String?>(author),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'isRead': serializer.toJson<bool>(isRead),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isCached': serializer.toJson<bool>(isCached),
      'isBlocked': serializer.toJson<bool>(isBlocked),
      'readProgress': serializer.toJson<int>(readProgress),
      'favoriteFolderId': serializer.toJson<String?>(favoriteFolderId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ArticlesTableData copyWith({
    String? id,
    String? feedId,
    String? title,
    String? link,
    Value<String?> summary = const Value.absent(),
    Value<String?> content = const Value.absent(),
    Value<String?> author = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<DateTime?> publishedAt = const Value.absent(),
    bool? isRead,
    bool? isFavorite,
    bool? isCached,
    bool? isBlocked,
    int? readProgress,
    Value<String?> favoriteFolderId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ArticlesTableData(
    id: id ?? this.id,
    feedId: feedId ?? this.feedId,
    title: title ?? this.title,
    link: link ?? this.link,
    summary: summary.present ? summary.value : this.summary,
    content: content.present ? content.value : this.content,
    author: author.present ? author.value : this.author,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    isRead: isRead ?? this.isRead,
    isFavorite: isFavorite ?? this.isFavorite,
    isCached: isCached ?? this.isCached,
    isBlocked: isBlocked ?? this.isBlocked,
    readProgress: readProgress ?? this.readProgress,
    favoriteFolderId: favoriteFolderId.present
        ? favoriteFolderId.value
        : this.favoriteFolderId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ArticlesTableData copyWithCompanion(ArticlesTableCompanion data) {
    return ArticlesTableData(
      id: data.id.present ? data.id.value : this.id,
      feedId: data.feedId.present ? data.feedId.value : this.feedId,
      title: data.title.present ? data.title.value : this.title,
      link: data.link.present ? data.link.value : this.link,
      summary: data.summary.present ? data.summary.value : this.summary,
      content: data.content.present ? data.content.value : this.content,
      author: data.author.present ? data.author.value : this.author,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      isCached: data.isCached.present ? data.isCached.value : this.isCached,
      isBlocked: data.isBlocked.present ? data.isBlocked.value : this.isBlocked,
      readProgress: data.readProgress.present
          ? data.readProgress.value
          : this.readProgress,
      favoriteFolderId: data.favoriteFolderId.present
          ? data.favoriteFolderId.value
          : this.favoriteFolderId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesTableData(')
          ..write('id: $id, ')
          ..write('feedId: $feedId, ')
          ..write('title: $title, ')
          ..write('link: $link, ')
          ..write('summary: $summary, ')
          ..write('content: $content, ')
          ..write('author: $author, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('isRead: $isRead, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isCached: $isCached, ')
          ..write('isBlocked: $isBlocked, ')
          ..write('readProgress: $readProgress, ')
          ..write('favoriteFolderId: $favoriteFolderId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    feedId,
    title,
    link,
    summary,
    content,
    author,
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticlesTableData &&
          other.id == this.id &&
          other.feedId == this.feedId &&
          other.title == this.title &&
          other.link == this.link &&
          other.summary == this.summary &&
          other.content == this.content &&
          other.author == this.author &&
          other.imageUrl == this.imageUrl &&
          other.publishedAt == this.publishedAt &&
          other.isRead == this.isRead &&
          other.isFavorite == this.isFavorite &&
          other.isCached == this.isCached &&
          other.isBlocked == this.isBlocked &&
          other.readProgress == this.readProgress &&
          other.favoriteFolderId == this.favoriteFolderId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ArticlesTableCompanion extends UpdateCompanion<ArticlesTableData> {
  final Value<String> id;
  final Value<String> feedId;
  final Value<String> title;
  final Value<String> link;
  final Value<String?> summary;
  final Value<String?> content;
  final Value<String?> author;
  final Value<String?> imageUrl;
  final Value<DateTime?> publishedAt;
  final Value<bool> isRead;
  final Value<bool> isFavorite;
  final Value<bool> isCached;
  final Value<bool> isBlocked;
  final Value<int> readProgress;
  final Value<String?> favoriteFolderId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ArticlesTableCompanion({
    this.id = const Value.absent(),
    this.feedId = const Value.absent(),
    this.title = const Value.absent(),
    this.link = const Value.absent(),
    this.summary = const Value.absent(),
    this.content = const Value.absent(),
    this.author = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isCached = const Value.absent(),
    this.isBlocked = const Value.absent(),
    this.readProgress = const Value.absent(),
    this.favoriteFolderId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArticlesTableCompanion.insert({
    required String id,
    required String feedId,
    required String title,
    required String link,
    this.summary = const Value.absent(),
    this.content = const Value.absent(),
    this.author = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isCached = const Value.absent(),
    this.isBlocked = const Value.absent(),
    this.readProgress = const Value.absent(),
    this.favoriteFolderId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       feedId = Value(feedId),
       title = Value(title),
       link = Value(link);
  static Insertable<ArticlesTableData> custom({
    Expression<String>? id,
    Expression<String>? feedId,
    Expression<String>? title,
    Expression<String>? link,
    Expression<String>? summary,
    Expression<String>? content,
    Expression<String>? author,
    Expression<String>? imageUrl,
    Expression<DateTime>? publishedAt,
    Expression<bool>? isRead,
    Expression<bool>? isFavorite,
    Expression<bool>? isCached,
    Expression<bool>? isBlocked,
    Expression<int>? readProgress,
    Expression<String>? favoriteFolderId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (feedId != null) 'feed_id': feedId,
      if (title != null) 'title': title,
      if (link != null) 'link': link,
      if (summary != null) 'summary': summary,
      if (content != null) 'content': content,
      if (author != null) 'author': author,
      if (imageUrl != null) 'image_url': imageUrl,
      if (publishedAt != null) 'published_at': publishedAt,
      if (isRead != null) 'is_read': isRead,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isCached != null) 'is_cached': isCached,
      if (isBlocked != null) 'is_blocked': isBlocked,
      if (readProgress != null) 'read_progress': readProgress,
      if (favoriteFolderId != null) 'favorite_folder_id': favoriteFolderId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArticlesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? feedId,
    Value<String>? title,
    Value<String>? link,
    Value<String?>? summary,
    Value<String?>? content,
    Value<String?>? author,
    Value<String?>? imageUrl,
    Value<DateTime?>? publishedAt,
    Value<bool>? isRead,
    Value<bool>? isFavorite,
    Value<bool>? isCached,
    Value<bool>? isBlocked,
    Value<int>? readProgress,
    Value<String?>? favoriteFolderId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ArticlesTableCompanion(
      id: id ?? this.id,
      feedId: feedId ?? this.feedId,
      title: title ?? this.title,
      link: link ?? this.link,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      isRead: isRead ?? this.isRead,
      isFavorite: isFavorite ?? this.isFavorite,
      isCached: isCached ?? this.isCached,
      isBlocked: isBlocked ?? this.isBlocked,
      readProgress: readProgress ?? this.readProgress,
      favoriteFolderId: favoriteFolderId ?? this.favoriteFolderId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (feedId.present) {
      map['feed_id'] = Variable<String>(feedId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isCached.present) {
      map['is_cached'] = Variable<bool>(isCached.value);
    }
    if (isBlocked.present) {
      map['is_blocked'] = Variable<bool>(isBlocked.value);
    }
    if (readProgress.present) {
      map['read_progress'] = Variable<int>(readProgress.value);
    }
    if (favoriteFolderId.present) {
      map['favorite_folder_id'] = Variable<String>(favoriteFolderId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesTableCompanion(')
          ..write('id: $id, ')
          ..write('feedId: $feedId, ')
          ..write('title: $title, ')
          ..write('link: $link, ')
          ..write('summary: $summary, ')
          ..write('content: $content, ')
          ..write('author: $author, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('isRead: $isRead, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isCached: $isCached, ')
          ..write('isBlocked: $isBlocked, ')
          ..write('readProgress: $readProgress, ')
          ..write('favoriteFolderId: $favoriteFolderId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isExpandedMeta = const VerificationMeta(
    'isExpanded',
  );
  @override
  late final GeneratedColumn<bool> isExpanded = GeneratedColumn<bool>(
    'is_expanded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_expanded" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    sortOrder,
    isExpanded,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_expanded')) {
      context.handle(
        _isExpandedMeta,
        isExpanded.isAcceptableOrUnknown(data['is_expanded']!, _isExpandedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isExpanded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_expanded'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoriesTableData extends DataClass
    implements Insertable<CategoriesTableData> {
  /// 主键 ID
  final String id;

  /// 分类名称
  final String name;

  /// 分类描述
  final String? description;

  /// 排序顺序
  final int sortOrder;

  /// 是否展开（UI状态）
  final bool isExpanded;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;
  const CategoriesTableData({
    required this.id,
    required this.name,
    this.description,
    required this.sortOrder,
    required this.isExpanded,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_expanded'] = Variable<bool>(isExpanded);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      sortOrder: Value(sortOrder),
      isExpanded: Value(isExpanded),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isExpanded: serializer.fromJson<bool>(json['isExpanded']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isExpanded': serializer.toJson<bool>(isExpanded),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoriesTableData copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    int? sortOrder,
    bool? isExpanded,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CategoriesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    sortOrder: sortOrder ?? this.sortOrder,
    isExpanded: isExpanded ?? this.isExpanded,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CategoriesTableData copyWithCompanion(CategoriesTableCompanion data) {
    return CategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isExpanded: data.isExpanded.present
          ? data.isExpanded.value
          : this.isExpanded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isExpanded: $isExpanded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    sortOrder,
    isExpanded,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.sortOrder == this.sortOrder &&
          other.isExpanded == this.isExpanded &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> sortOrder;
  final Value<bool> isExpanded;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isExpanded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isExpanded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<CategoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? sortOrder,
    Expression<bool>? isExpanded,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isExpanded != null) 'is_expanded': isExpanded,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<int>? sortOrder,
    Value<bool>? isExpanded,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      isExpanded: isExpanded ?? this.isExpanded,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isExpanded.present) {
      map['is_expanded'] = Variable<bool>(isExpanded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isExpanded: $isExpanded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoriteFoldersTableTable extends FavoriteFoldersTable
    with TableInfo<$FavoriteFoldersTableTable, FavoriteFoldersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteFoldersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, sortOrder, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_folders';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteFoldersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteFoldersTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteFoldersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoriteFoldersTableTable createAlias(String alias) {
    return $FavoriteFoldersTableTable(attachedDatabase, alias);
  }
}

class FavoriteFoldersTableData extends DataClass
    implements Insertable<FavoriteFoldersTableData> {
  /// 主键 ID
  final String id;

  /// 收藏夹名称
  final String name;

  /// 排序顺序
  final int sortOrder;

  /// 创建时间
  final DateTime createdAt;
  const FavoriteFoldersTableData({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoriteFoldersTableCompanion toCompanion(bool nullToAbsent) {
    return FavoriteFoldersTableCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteFoldersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteFoldersTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteFoldersTableData copyWith({
    String? id,
    String? name,
    int? sortOrder,
    DateTime? createdAt,
  }) => FavoriteFoldersTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  FavoriteFoldersTableData copyWithCompanion(
    FavoriteFoldersTableCompanion data,
  ) {
    return FavoriteFoldersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteFoldersTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteFoldersTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class FavoriteFoldersTableCompanion
    extends UpdateCompanion<FavoriteFoldersTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FavoriteFoldersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteFoldersTableCompanion.insert({
    required String id,
    required String name,
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<FavoriteFoldersTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteFoldersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return FavoriteFoldersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteFoldersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnnotationsTableTable extends AnnotationsTable
    with TableInfo<$AnnotationsTableTable, AnnotationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnnotationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<String> articleId = GeneratedColumn<String>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedTextMeta = const VerificationMeta(
    'selectedText',
  );
  @override
  late final GeneratedColumn<String> selectedText = GeneratedColumn<String>(
    'selected_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startOffsetMeta = const VerificationMeta(
    'startOffset',
  );
  @override
  late final GeneratedColumn<int> startOffset = GeneratedColumn<int>(
    'start_offset',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endOffsetMeta = const VerificationMeta(
    'endOffset',
  );
  @override
  late final GeneratedColumn<int> endOffset = GeneratedColumn<int>(
    'end_offset',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _highlightColorMeta = const VerificationMeta(
    'highlightColor',
  );
  @override
  late final GeneratedColumn<String> highlightColor = GeneratedColumn<String>(
    'highlight_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    articleId,
    content,
    selectedText,
    startOffset,
    endOffset,
    highlightColor,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'annotations';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnnotationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('selected_text')) {
      context.handle(
        _selectedTextMeta,
        selectedText.isAcceptableOrUnknown(
          data['selected_text']!,
          _selectedTextMeta,
        ),
      );
    }
    if (data.containsKey('start_offset')) {
      context.handle(
        _startOffsetMeta,
        startOffset.isAcceptableOrUnknown(
          data['start_offset']!,
          _startOffsetMeta,
        ),
      );
    }
    if (data.containsKey('end_offset')) {
      context.handle(
        _endOffsetMeta,
        endOffset.isAcceptableOrUnknown(data['end_offset']!, _endOffsetMeta),
      );
    }
    if (data.containsKey('highlight_color')) {
      context.handle(
        _highlightColorMeta,
        highlightColor.isAcceptableOrUnknown(
          data['highlight_color']!,
          _highlightColorMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnnotationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnnotationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}article_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      selectedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_text'],
      ),
      startOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_offset'],
      ),
      endOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_offset'],
      ),
      highlightColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}highlight_color'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AnnotationsTableTable createAlias(String alias) {
    return $AnnotationsTableTable(attachedDatabase, alias);
  }
}

class AnnotationsTableData extends DataClass
    implements Insertable<AnnotationsTableData> {
  /// 主键 ID
  final String id;

  /// 所属文章 ID
  final String articleId;

  /// 批注内容
  final String content;

  /// 选中的文本
  final String? selectedText;

  /// 选中文本的起始位置
  final int? startOffset;

  /// 选中文本的结束位置
  final int? endOffset;

  /// 高亮颜色
  final String? highlightColor;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;
  const AnnotationsTableData({
    required this.id,
    required this.articleId,
    required this.content,
    this.selectedText,
    this.startOffset,
    this.endOffset,
    this.highlightColor,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['article_id'] = Variable<String>(articleId);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || selectedText != null) {
      map['selected_text'] = Variable<String>(selectedText);
    }
    if (!nullToAbsent || startOffset != null) {
      map['start_offset'] = Variable<int>(startOffset);
    }
    if (!nullToAbsent || endOffset != null) {
      map['end_offset'] = Variable<int>(endOffset);
    }
    if (!nullToAbsent || highlightColor != null) {
      map['highlight_color'] = Variable<String>(highlightColor);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AnnotationsTableCompanion toCompanion(bool nullToAbsent) {
    return AnnotationsTableCompanion(
      id: Value(id),
      articleId: Value(articleId),
      content: Value(content),
      selectedText: selectedText == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedText),
      startOffset: startOffset == null && nullToAbsent
          ? const Value.absent()
          : Value(startOffset),
      endOffset: endOffset == null && nullToAbsent
          ? const Value.absent()
          : Value(endOffset),
      highlightColor: highlightColor == null && nullToAbsent
          ? const Value.absent()
          : Value(highlightColor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AnnotationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnnotationsTableData(
      id: serializer.fromJson<String>(json['id']),
      articleId: serializer.fromJson<String>(json['articleId']),
      content: serializer.fromJson<String>(json['content']),
      selectedText: serializer.fromJson<String?>(json['selectedText']),
      startOffset: serializer.fromJson<int?>(json['startOffset']),
      endOffset: serializer.fromJson<int?>(json['endOffset']),
      highlightColor: serializer.fromJson<String?>(json['highlightColor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'articleId': serializer.toJson<String>(articleId),
      'content': serializer.toJson<String>(content),
      'selectedText': serializer.toJson<String?>(selectedText),
      'startOffset': serializer.toJson<int?>(startOffset),
      'endOffset': serializer.toJson<int?>(endOffset),
      'highlightColor': serializer.toJson<String?>(highlightColor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AnnotationsTableData copyWith({
    String? id,
    String? articleId,
    String? content,
    Value<String?> selectedText = const Value.absent(),
    Value<int?> startOffset = const Value.absent(),
    Value<int?> endOffset = const Value.absent(),
    Value<String?> highlightColor = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AnnotationsTableData(
    id: id ?? this.id,
    articleId: articleId ?? this.articleId,
    content: content ?? this.content,
    selectedText: selectedText.present ? selectedText.value : this.selectedText,
    startOffset: startOffset.present ? startOffset.value : this.startOffset,
    endOffset: endOffset.present ? endOffset.value : this.endOffset,
    highlightColor: highlightColor.present
        ? highlightColor.value
        : this.highlightColor,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AnnotationsTableData copyWithCompanion(AnnotationsTableCompanion data) {
    return AnnotationsTableData(
      id: data.id.present ? data.id.value : this.id,
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      content: data.content.present ? data.content.value : this.content,
      selectedText: data.selectedText.present
          ? data.selectedText.value
          : this.selectedText,
      startOffset: data.startOffset.present
          ? data.startOffset.value
          : this.startOffset,
      endOffset: data.endOffset.present ? data.endOffset.value : this.endOffset,
      highlightColor: data.highlightColor.present
          ? data.highlightColor.value
          : this.highlightColor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnnotationsTableData(')
          ..write('id: $id, ')
          ..write('articleId: $articleId, ')
          ..write('content: $content, ')
          ..write('selectedText: $selectedText, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset, ')
          ..write('highlightColor: $highlightColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    articleId,
    content,
    selectedText,
    startOffset,
    endOffset,
    highlightColor,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnnotationsTableData &&
          other.id == this.id &&
          other.articleId == this.articleId &&
          other.content == this.content &&
          other.selectedText == this.selectedText &&
          other.startOffset == this.startOffset &&
          other.endOffset == this.endOffset &&
          other.highlightColor == this.highlightColor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AnnotationsTableCompanion extends UpdateCompanion<AnnotationsTableData> {
  final Value<String> id;
  final Value<String> articleId;
  final Value<String> content;
  final Value<String?> selectedText;
  final Value<int?> startOffset;
  final Value<int?> endOffset;
  final Value<String?> highlightColor;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AnnotationsTableCompanion({
    this.id = const Value.absent(),
    this.articleId = const Value.absent(),
    this.content = const Value.absent(),
    this.selectedText = const Value.absent(),
    this.startOffset = const Value.absent(),
    this.endOffset = const Value.absent(),
    this.highlightColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnnotationsTableCompanion.insert({
    required String id,
    required String articleId,
    required String content,
    this.selectedText = const Value.absent(),
    this.startOffset = const Value.absent(),
    this.endOffset = const Value.absent(),
    this.highlightColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       articleId = Value(articleId),
       content = Value(content);
  static Insertable<AnnotationsTableData> custom({
    Expression<String>? id,
    Expression<String>? articleId,
    Expression<String>? content,
    Expression<String>? selectedText,
    Expression<int>? startOffset,
    Expression<int>? endOffset,
    Expression<String>? highlightColor,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (articleId != null) 'article_id': articleId,
      if (content != null) 'content': content,
      if (selectedText != null) 'selected_text': selectedText,
      if (startOffset != null) 'start_offset': startOffset,
      if (endOffset != null) 'end_offset': endOffset,
      if (highlightColor != null) 'highlight_color': highlightColor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnnotationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? articleId,
    Value<String>? content,
    Value<String?>? selectedText,
    Value<int?>? startOffset,
    Value<int?>? endOffset,
    Value<String?>? highlightColor,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AnnotationsTableCompanion(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      content: content ?? this.content,
      selectedText: selectedText ?? this.selectedText,
      startOffset: startOffset ?? this.startOffset,
      endOffset: endOffset ?? this.endOffset,
      highlightColor: highlightColor ?? this.highlightColor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (articleId.present) {
      map['article_id'] = Variable<String>(articleId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (selectedText.present) {
      map['selected_text'] = Variable<String>(selectedText.value);
    }
    if (startOffset.present) {
      map['start_offset'] = Variable<int>(startOffset.value);
    }
    if (endOffset.present) {
      map['end_offset'] = Variable<int>(endOffset.value);
    }
    if (highlightColor.present) {
      map['highlight_color'] = Variable<String>(highlightColor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnnotationsTableCompanion(')
          ..write('id: $id, ')
          ..write('articleId: $articleId, ')
          ..write('content: $content, ')
          ..write('selectedText: $selectedText, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset, ')
          ..write('highlightColor: $highlightColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncLogsTableTable extends SyncLogsTable
    with TableInfo<$SyncLogsTableTable, SyncLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _syncTypeMeta = const VerificationMeta(
    'syncType',
  );
  @override
  late final GeneratedColumn<String> syncType = GeneratedColumn<String>(
    'sync_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemCountMeta = const VerificationMeta(
    'itemCount',
  );
  @override
  late final GeneratedColumn<int> itemCount = GeneratedColumn<int>(
    'item_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncType,
    status,
    message,
    itemCount,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_type')) {
      context.handle(
        _syncTypeMeta,
        syncType.isAcceptableOrUnknown(data['sync_type']!, _syncTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_syncTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    }
    if (data.containsKey('item_count')) {
      context.handle(
        _itemCountMeta,
        itemCount.isAcceptableOrUnknown(data['item_count']!, _itemCountMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      ),
      itemCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_count'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $SyncLogsTableTable createAlias(String alias) {
    return $SyncLogsTableTable(attachedDatabase, alias);
  }
}

class SyncLogsTableData extends DataClass
    implements Insertable<SyncLogsTableData> {
  /// 主键 ID
  final int id;

  /// 同步类型
  final String syncType;

  /// 同步状态：success, failed, partial
  final String status;

  /// 同步消息
  final String? message;

  /// 同步的项目数量
  final int itemCount;

  /// 同步时间
  final DateTime syncedAt;
  const SyncLogsTableData({
    required this.id,
    required this.syncType,
    required this.status,
    this.message,
    required this.itemCount,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_type'] = Variable<String>(syncType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    map['item_count'] = Variable<int>(itemCount);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  SyncLogsTableCompanion toCompanion(bool nullToAbsent) {
    return SyncLogsTableCompanion(
      id: Value(id),
      syncType: Value(syncType),
      status: Value(status),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      itemCount: Value(itemCount),
      syncedAt: Value(syncedAt),
    );
  }

  factory SyncLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLogsTableData(
      id: serializer.fromJson<int>(json['id']),
      syncType: serializer.fromJson<String>(json['syncType']),
      status: serializer.fromJson<String>(json['status']),
      message: serializer.fromJson<String?>(json['message']),
      itemCount: serializer.fromJson<int>(json['itemCount']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncType': serializer.toJson<String>(syncType),
      'status': serializer.toJson<String>(status),
      'message': serializer.toJson<String?>(message),
      'itemCount': serializer.toJson<int>(itemCount),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  SyncLogsTableData copyWith({
    int? id,
    String? syncType,
    String? status,
    Value<String?> message = const Value.absent(),
    int? itemCount,
    DateTime? syncedAt,
  }) => SyncLogsTableData(
    id: id ?? this.id,
    syncType: syncType ?? this.syncType,
    status: status ?? this.status,
    message: message.present ? message.value : this.message,
    itemCount: itemCount ?? this.itemCount,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  SyncLogsTableData copyWithCompanion(SyncLogsTableCompanion data) {
    return SyncLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      syncType: data.syncType.present ? data.syncType.value : this.syncType,
      status: data.status.present ? data.status.value : this.status,
      message: data.message.present ? data.message.value : this.message,
      itemCount: data.itemCount.present ? data.itemCount.value : this.itemCount,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogsTableData(')
          ..write('id: $id, ')
          ..write('syncType: $syncType, ')
          ..write('status: $status, ')
          ..write('message: $message, ')
          ..write('itemCount: $itemCount, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, syncType, status, message, itemCount, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLogsTableData &&
          other.id == this.id &&
          other.syncType == this.syncType &&
          other.status == this.status &&
          other.message == this.message &&
          other.itemCount == this.itemCount &&
          other.syncedAt == this.syncedAt);
}

class SyncLogsTableCompanion extends UpdateCompanion<SyncLogsTableData> {
  final Value<int> id;
  final Value<String> syncType;
  final Value<String> status;
  final Value<String?> message;
  final Value<int> itemCount;
  final Value<DateTime> syncedAt;
  const SyncLogsTableCompanion({
    this.id = const Value.absent(),
    this.syncType = const Value.absent(),
    this.status = const Value.absent(),
    this.message = const Value.absent(),
    this.itemCount = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  SyncLogsTableCompanion.insert({
    this.id = const Value.absent(),
    required String syncType,
    required String status,
    this.message = const Value.absent(),
    this.itemCount = const Value.absent(),
    this.syncedAt = const Value.absent(),
  }) : syncType = Value(syncType),
       status = Value(status);
  static Insertable<SyncLogsTableData> custom({
    Expression<int>? id,
    Expression<String>? syncType,
    Expression<String>? status,
    Expression<String>? message,
    Expression<int>? itemCount,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncType != null) 'sync_type': syncType,
      if (status != null) 'status': status,
      if (message != null) 'message': message,
      if (itemCount != null) 'item_count': itemCount,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  SyncLogsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? syncType,
    Value<String>? status,
    Value<String?>? message,
    Value<int>? itemCount,
    Value<DateTime>? syncedAt,
  }) {
    return SyncLogsTableCompanion(
      id: id ?? this.id,
      syncType: syncType ?? this.syncType,
      status: status ?? this.status,
      message: message ?? this.message,
      itemCount: itemCount ?? this.itemCount,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncType.present) {
      map['sync_type'] = Variable<String>(syncType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (itemCount.present) {
      map['item_count'] = Variable<int>(itemCount.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('syncType: $syncType, ')
          ..write('status: $status, ')
          ..write('message: $message, ')
          ..write('itemCount: $itemCount, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $EditedArticlesTableTable extends EditedArticlesTable
    with TableInfo<$EditedArticlesTableTable, EditedArticlesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EditedArticlesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<String> articleId = GeneratedColumn<String>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deltaJsonMeta = const VerificationMeta(
    'deltaJson',
  );
  @override
  late final GeneratedColumn<String> deltaJson = GeneratedColumn<String>(
    'delta_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _htmlContentMeta = const VerificationMeta(
    'htmlContent',
  );
  @override
  late final GeneratedColumn<String> htmlContent = GeneratedColumn<String>(
    'html_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _editedAtMeta = const VerificationMeta(
    'editedAt',
  );
  @override
  late final GeneratedColumn<DateTime> editedAt = GeneratedColumn<DateTime>(
    'edited_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    articleId,
    deltaJson,
    htmlContent,
    summary,
    editedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'edited_articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<EditedArticlesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('delta_json')) {
      context.handle(
        _deltaJsonMeta,
        deltaJson.isAcceptableOrUnknown(data['delta_json']!, _deltaJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_deltaJsonMeta);
    }
    if (data.containsKey('html_content')) {
      context.handle(
        _htmlContentMeta,
        htmlContent.isAcceptableOrUnknown(
          data['html_content']!,
          _htmlContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_htmlContentMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('edited_at')) {
      context.handle(
        _editedAtMeta,
        editedAt.isAcceptableOrUnknown(data['edited_at']!, _editedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {articleId};
  @override
  EditedArticlesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EditedArticlesTableData(
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}article_id'],
      )!,
      deltaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}delta_json'],
      )!,
      htmlContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}html_content'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      editedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}edited_at'],
      )!,
    );
  }

  @override
  $EditedArticlesTableTable createAlias(String alias) {
    return $EditedArticlesTableTable(attachedDatabase, alias);
  }
}

class EditedArticlesTableData extends DataClass
    implements Insertable<EditedArticlesTableData> {
  /// 文章 ID（主键，关联 articles 表）
  final String articleId;

  /// Quill Delta JSON 格式的编辑内容
  final String deltaJson;

  /// 转换后的 HTML 内容（用于显示）
  final String htmlContent;

  /// 从内容提取的摘要
  final String? summary;

  /// 编辑时间
  final DateTime editedAt;
  const EditedArticlesTableData({
    required this.articleId,
    required this.deltaJson,
    required this.htmlContent,
    this.summary,
    required this.editedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['article_id'] = Variable<String>(articleId);
    map['delta_json'] = Variable<String>(deltaJson);
    map['html_content'] = Variable<String>(htmlContent);
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    map['edited_at'] = Variable<DateTime>(editedAt);
    return map;
  }

  EditedArticlesTableCompanion toCompanion(bool nullToAbsent) {
    return EditedArticlesTableCompanion(
      articleId: Value(articleId),
      deltaJson: Value(deltaJson),
      htmlContent: Value(htmlContent),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      editedAt: Value(editedAt),
    );
  }

  factory EditedArticlesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EditedArticlesTableData(
      articleId: serializer.fromJson<String>(json['articleId']),
      deltaJson: serializer.fromJson<String>(json['deltaJson']),
      htmlContent: serializer.fromJson<String>(json['htmlContent']),
      summary: serializer.fromJson<String?>(json['summary']),
      editedAt: serializer.fromJson<DateTime>(json['editedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'articleId': serializer.toJson<String>(articleId),
      'deltaJson': serializer.toJson<String>(deltaJson),
      'htmlContent': serializer.toJson<String>(htmlContent),
      'summary': serializer.toJson<String?>(summary),
      'editedAt': serializer.toJson<DateTime>(editedAt),
    };
  }

  EditedArticlesTableData copyWith({
    String? articleId,
    String? deltaJson,
    String? htmlContent,
    Value<String?> summary = const Value.absent(),
    DateTime? editedAt,
  }) => EditedArticlesTableData(
    articleId: articleId ?? this.articleId,
    deltaJson: deltaJson ?? this.deltaJson,
    htmlContent: htmlContent ?? this.htmlContent,
    summary: summary.present ? summary.value : this.summary,
    editedAt: editedAt ?? this.editedAt,
  );
  EditedArticlesTableData copyWithCompanion(EditedArticlesTableCompanion data) {
    return EditedArticlesTableData(
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      deltaJson: data.deltaJson.present ? data.deltaJson.value : this.deltaJson,
      htmlContent: data.htmlContent.present
          ? data.htmlContent.value
          : this.htmlContent,
      summary: data.summary.present ? data.summary.value : this.summary,
      editedAt: data.editedAt.present ? data.editedAt.value : this.editedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EditedArticlesTableData(')
          ..write('articleId: $articleId, ')
          ..write('deltaJson: $deltaJson, ')
          ..write('htmlContent: $htmlContent, ')
          ..write('summary: $summary, ')
          ..write('editedAt: $editedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(articleId, deltaJson, htmlContent, summary, editedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EditedArticlesTableData &&
          other.articleId == this.articleId &&
          other.deltaJson == this.deltaJson &&
          other.htmlContent == this.htmlContent &&
          other.summary == this.summary &&
          other.editedAt == this.editedAt);
}

class EditedArticlesTableCompanion
    extends UpdateCompanion<EditedArticlesTableData> {
  final Value<String> articleId;
  final Value<String> deltaJson;
  final Value<String> htmlContent;
  final Value<String?> summary;
  final Value<DateTime> editedAt;
  final Value<int> rowid;
  const EditedArticlesTableCompanion({
    this.articleId = const Value.absent(),
    this.deltaJson = const Value.absent(),
    this.htmlContent = const Value.absent(),
    this.summary = const Value.absent(),
    this.editedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EditedArticlesTableCompanion.insert({
    required String articleId,
    required String deltaJson,
    required String htmlContent,
    this.summary = const Value.absent(),
    this.editedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : articleId = Value(articleId),
       deltaJson = Value(deltaJson),
       htmlContent = Value(htmlContent);
  static Insertable<EditedArticlesTableData> custom({
    Expression<String>? articleId,
    Expression<String>? deltaJson,
    Expression<String>? htmlContent,
    Expression<String>? summary,
    Expression<DateTime>? editedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (articleId != null) 'article_id': articleId,
      if (deltaJson != null) 'delta_json': deltaJson,
      if (htmlContent != null) 'html_content': htmlContent,
      if (summary != null) 'summary': summary,
      if (editedAt != null) 'edited_at': editedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EditedArticlesTableCompanion copyWith({
    Value<String>? articleId,
    Value<String>? deltaJson,
    Value<String>? htmlContent,
    Value<String?>? summary,
    Value<DateTime>? editedAt,
    Value<int>? rowid,
  }) {
    return EditedArticlesTableCompanion(
      articleId: articleId ?? this.articleId,
      deltaJson: deltaJson ?? this.deltaJson,
      htmlContent: htmlContent ?? this.htmlContent,
      summary: summary ?? this.summary,
      editedAt: editedAt ?? this.editedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (articleId.present) {
      map['article_id'] = Variable<String>(articleId.value);
    }
    if (deltaJson.present) {
      map['delta_json'] = Variable<String>(deltaJson.value);
    }
    if (htmlContent.present) {
      map['html_content'] = Variable<String>(htmlContent.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (editedAt.present) {
      map['edited_at'] = Variable<DateTime>(editedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EditedArticlesTableCompanion(')
          ..write('articleId: $articleId, ')
          ..write('deltaJson: $deltaJson, ')
          ..write('htmlContent: $htmlContent, ')
          ..write('summary: $summary, ')
          ..write('editedAt: $editedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FeedsTableTable feedsTable = $FeedsTableTable(this);
  late final $ArticlesTableTable articlesTable = $ArticlesTableTable(this);
  late final $CategoriesTableTable categoriesTable = $CategoriesTableTable(
    this,
  );
  late final $FavoriteFoldersTableTable favoriteFoldersTable =
      $FavoriteFoldersTableTable(this);
  late final $AnnotationsTableTable annotationsTable = $AnnotationsTableTable(
    this,
  );
  late final $SyncLogsTableTable syncLogsTable = $SyncLogsTableTable(this);
  late final $EditedArticlesTableTable editedArticlesTable =
      $EditedArticlesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    feedsTable,
    articlesTable,
    categoriesTable,
    favoriteFoldersTable,
    annotationsTable,
    syncLogsTable,
    editedArticlesTable,
  ];
}

typedef $$FeedsTableTableCreateCompanionBuilder =
    FeedsTableCompanion Function({
      required String id,
      required String url,
      required String title,
      Value<String?> description,
      Value<String?> iconUrl,
      Value<String?> link,
      Value<String?> categoryId,
      Value<int> sortOrder,
      Value<int> unreadCount,
      Value<DateTime?> lastUpdated,
      Value<DateTime?> lastFetched,
      Value<bool> isEnabled,
      Value<bool> isBlocked,
      Value<int> healthStatus,
      Value<int> failureCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> sourceType,
      Value<String?> apiBaseUrl,
      Value<String?> apiKey,
      Value<String?> apiHeaders,
      Value<String?> apiRemoteFeedId,
      Value<int> apiTimeout,
      Value<int> apiMaxRetries,
      Value<String?> pluginId,
      Value<String?> pluginFeedKey,
      Value<String?> pluginProvider,
      Value<int> rowid,
    });
typedef $$FeedsTableTableUpdateCompanionBuilder =
    FeedsTableCompanion Function({
      Value<String> id,
      Value<String> url,
      Value<String> title,
      Value<String?> description,
      Value<String?> iconUrl,
      Value<String?> link,
      Value<String?> categoryId,
      Value<int> sortOrder,
      Value<int> unreadCount,
      Value<DateTime?> lastUpdated,
      Value<DateTime?> lastFetched,
      Value<bool> isEnabled,
      Value<bool> isBlocked,
      Value<int> healthStatus,
      Value<int> failureCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> sourceType,
      Value<String?> apiBaseUrl,
      Value<String?> apiKey,
      Value<String?> apiHeaders,
      Value<String?> apiRemoteFeedId,
      Value<int> apiTimeout,
      Value<int> apiMaxRetries,
      Value<String?> pluginId,
      Value<String?> pluginFeedKey,
      Value<String?> pluginProvider,
      Value<int> rowid,
    });

class $$FeedsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FeedsTableTable> {
  $$FeedsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconUrl => $composableBuilder(
    column: $table.iconUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastFetched => $composableBuilder(
    column: $table.lastFetched,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBlocked => $composableBuilder(
    column: $table.isBlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get healthStatus => $composableBuilder(
    column: $table.healthStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiBaseUrl => $composableBuilder(
    column: $table.apiBaseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiHeaders => $composableBuilder(
    column: $table.apiHeaders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiRemoteFeedId => $composableBuilder(
    column: $table.apiRemoteFeedId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get apiTimeout => $composableBuilder(
    column: $table.apiTimeout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get apiMaxRetries => $composableBuilder(
    column: $table.apiMaxRetries,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pluginId => $composableBuilder(
    column: $table.pluginId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pluginFeedKey => $composableBuilder(
    column: $table.pluginFeedKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pluginProvider => $composableBuilder(
    column: $table.pluginProvider,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeedsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedsTableTable> {
  $$FeedsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconUrl => $composableBuilder(
    column: $table.iconUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastFetched => $composableBuilder(
    column: $table.lastFetched,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBlocked => $composableBuilder(
    column: $table.isBlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get healthStatus => $composableBuilder(
    column: $table.healthStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiBaseUrl => $composableBuilder(
    column: $table.apiBaseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiHeaders => $composableBuilder(
    column: $table.apiHeaders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiRemoteFeedId => $composableBuilder(
    column: $table.apiRemoteFeedId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get apiTimeout => $composableBuilder(
    column: $table.apiTimeout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get apiMaxRetries => $composableBuilder(
    column: $table.apiMaxRetries,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pluginId => $composableBuilder(
    column: $table.pluginId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pluginFeedKey => $composableBuilder(
    column: $table.pluginFeedKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pluginProvider => $composableBuilder(
    column: $table.pluginProvider,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeedsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedsTableTable> {
  $$FeedsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconUrl =>
      $composableBuilder(column: $table.iconUrl, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastFetched => $composableBuilder(
    column: $table.lastFetched,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isBlocked =>
      $composableBuilder(column: $table.isBlocked, builder: (column) => column);

  GeneratedColumn<int> get healthStatus => $composableBuilder(
    column: $table.healthStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get apiBaseUrl => $composableBuilder(
    column: $table.apiBaseUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get apiKey =>
      $composableBuilder(column: $table.apiKey, builder: (column) => column);

  GeneratedColumn<String> get apiHeaders => $composableBuilder(
    column: $table.apiHeaders,
    builder: (column) => column,
  );

  GeneratedColumn<String> get apiRemoteFeedId => $composableBuilder(
    column: $table.apiRemoteFeedId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get apiTimeout => $composableBuilder(
    column: $table.apiTimeout,
    builder: (column) => column,
  );

  GeneratedColumn<int> get apiMaxRetries => $composableBuilder(
    column: $table.apiMaxRetries,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pluginId =>
      $composableBuilder(column: $table.pluginId, builder: (column) => column);

  GeneratedColumn<String> get pluginFeedKey => $composableBuilder(
    column: $table.pluginFeedKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pluginProvider => $composableBuilder(
    column: $table.pluginProvider,
    builder: (column) => column,
  );
}

class $$FeedsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedsTableTable,
          FeedsTableData,
          $$FeedsTableTableFilterComposer,
          $$FeedsTableTableOrderingComposer,
          $$FeedsTableTableAnnotationComposer,
          $$FeedsTableTableCreateCompanionBuilder,
          $$FeedsTableTableUpdateCompanionBuilder,
          (
            FeedsTableData,
            BaseReferences<_$AppDatabase, $FeedsTableTable, FeedsTableData>,
          ),
          FeedsTableData,
          PrefetchHooks Function()
        > {
  $$FeedsTableTableTableManager(_$AppDatabase db, $FeedsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> iconUrl = const Value.absent(),
                Value<String?> link = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<DateTime?> lastUpdated = const Value.absent(),
                Value<DateTime?> lastFetched = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<bool> isBlocked = const Value.absent(),
                Value<int> healthStatus = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> apiBaseUrl = const Value.absent(),
                Value<String?> apiKey = const Value.absent(),
                Value<String?> apiHeaders = const Value.absent(),
                Value<String?> apiRemoteFeedId = const Value.absent(),
                Value<int> apiTimeout = const Value.absent(),
                Value<int> apiMaxRetries = const Value.absent(),
                Value<String?> pluginId = const Value.absent(),
                Value<String?> pluginFeedKey = const Value.absent(),
                Value<String?> pluginProvider = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedsTableCompanion(
                id: id,
                url: url,
                title: title,
                description: description,
                iconUrl: iconUrl,
                link: link,
                categoryId: categoryId,
                sortOrder: sortOrder,
                unreadCount: unreadCount,
                lastUpdated: lastUpdated,
                lastFetched: lastFetched,
                isEnabled: isEnabled,
                isBlocked: isBlocked,
                healthStatus: healthStatus,
                failureCount: failureCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                sourceType: sourceType,
                apiBaseUrl: apiBaseUrl,
                apiKey: apiKey,
                apiHeaders: apiHeaders,
                apiRemoteFeedId: apiRemoteFeedId,
                apiTimeout: apiTimeout,
                apiMaxRetries: apiMaxRetries,
                pluginId: pluginId,
                pluginFeedKey: pluginFeedKey,
                pluginProvider: pluginProvider,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String url,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> iconUrl = const Value.absent(),
                Value<String?> link = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<DateTime?> lastUpdated = const Value.absent(),
                Value<DateTime?> lastFetched = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<bool> isBlocked = const Value.absent(),
                Value<int> healthStatus = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> apiBaseUrl = const Value.absent(),
                Value<String?> apiKey = const Value.absent(),
                Value<String?> apiHeaders = const Value.absent(),
                Value<String?> apiRemoteFeedId = const Value.absent(),
                Value<int> apiTimeout = const Value.absent(),
                Value<int> apiMaxRetries = const Value.absent(),
                Value<String?> pluginId = const Value.absent(),
                Value<String?> pluginFeedKey = const Value.absent(),
                Value<String?> pluginProvider = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedsTableCompanion.insert(
                id: id,
                url: url,
                title: title,
                description: description,
                iconUrl: iconUrl,
                link: link,
                categoryId: categoryId,
                sortOrder: sortOrder,
                unreadCount: unreadCount,
                lastUpdated: lastUpdated,
                lastFetched: lastFetched,
                isEnabled: isEnabled,
                isBlocked: isBlocked,
                healthStatus: healthStatus,
                failureCount: failureCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                sourceType: sourceType,
                apiBaseUrl: apiBaseUrl,
                apiKey: apiKey,
                apiHeaders: apiHeaders,
                apiRemoteFeedId: apiRemoteFeedId,
                apiTimeout: apiTimeout,
                apiMaxRetries: apiMaxRetries,
                pluginId: pluginId,
                pluginFeedKey: pluginFeedKey,
                pluginProvider: pluginProvider,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeedsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedsTableTable,
      FeedsTableData,
      $$FeedsTableTableFilterComposer,
      $$FeedsTableTableOrderingComposer,
      $$FeedsTableTableAnnotationComposer,
      $$FeedsTableTableCreateCompanionBuilder,
      $$FeedsTableTableUpdateCompanionBuilder,
      (
        FeedsTableData,
        BaseReferences<_$AppDatabase, $FeedsTableTable, FeedsTableData>,
      ),
      FeedsTableData,
      PrefetchHooks Function()
    >;
typedef $$ArticlesTableTableCreateCompanionBuilder =
    ArticlesTableCompanion Function({
      required String id,
      required String feedId,
      required String title,
      required String link,
      Value<String?> summary,
      Value<String?> content,
      Value<String?> author,
      Value<String?> imageUrl,
      Value<DateTime?> publishedAt,
      Value<bool> isRead,
      Value<bool> isFavorite,
      Value<bool> isCached,
      Value<bool> isBlocked,
      Value<int> readProgress,
      Value<String?> favoriteFolderId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ArticlesTableTableUpdateCompanionBuilder =
    ArticlesTableCompanion Function({
      Value<String> id,
      Value<String> feedId,
      Value<String> title,
      Value<String> link,
      Value<String?> summary,
      Value<String?> content,
      Value<String?> author,
      Value<String?> imageUrl,
      Value<DateTime?> publishedAt,
      Value<bool> isRead,
      Value<bool> isFavorite,
      Value<bool> isCached,
      Value<bool> isBlocked,
      Value<int> readProgress,
      Value<String?> favoriteFolderId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ArticlesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ArticlesTableTable> {
  $$ArticlesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedId => $composableBuilder(
    column: $table.feedId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCached => $composableBuilder(
    column: $table.isCached,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBlocked => $composableBuilder(
    column: $table.isBlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get readProgress => $composableBuilder(
    column: $table.readProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get favoriteFolderId => $composableBuilder(
    column: $table.favoriteFolderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ArticlesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticlesTableTable> {
  $$ArticlesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedId => $composableBuilder(
    column: $table.feedId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCached => $composableBuilder(
    column: $table.isCached,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBlocked => $composableBuilder(
    column: $table.isBlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get readProgress => $composableBuilder(
    column: $table.readProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get favoriteFolderId => $composableBuilder(
    column: $table.favoriteFolderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArticlesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticlesTableTable> {
  $$ArticlesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get feedId =>
      $composableBuilder(column: $table.feedId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCached =>
      $composableBuilder(column: $table.isCached, builder: (column) => column);

  GeneratedColumn<bool> get isBlocked =>
      $composableBuilder(column: $table.isBlocked, builder: (column) => column);

  GeneratedColumn<int> get readProgress => $composableBuilder(
    column: $table.readProgress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get favoriteFolderId => $composableBuilder(
    column: $table.favoriteFolderId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ArticlesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArticlesTableTable,
          ArticlesTableData,
          $$ArticlesTableTableFilterComposer,
          $$ArticlesTableTableOrderingComposer,
          $$ArticlesTableTableAnnotationComposer,
          $$ArticlesTableTableCreateCompanionBuilder,
          $$ArticlesTableTableUpdateCompanionBuilder,
          (
            ArticlesTableData,
            BaseReferences<
              _$AppDatabase,
              $ArticlesTableTable,
              ArticlesTableData
            >,
          ),
          ArticlesTableData,
          PrefetchHooks Function()
        > {
  $$ArticlesTableTableTableManager(_$AppDatabase db, $ArticlesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticlesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArticlesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArticlesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> feedId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> link = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isCached = const Value.absent(),
                Value<bool> isBlocked = const Value.absent(),
                Value<int> readProgress = const Value.absent(),
                Value<String?> favoriteFolderId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArticlesTableCompanion(
                id: id,
                feedId: feedId,
                title: title,
                link: link,
                summary: summary,
                content: content,
                author: author,
                imageUrl: imageUrl,
                publishedAt: publishedAt,
                isRead: isRead,
                isFavorite: isFavorite,
                isCached: isCached,
                isBlocked: isBlocked,
                readProgress: readProgress,
                favoriteFolderId: favoriteFolderId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String feedId,
                required String title,
                required String link,
                Value<String?> summary = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isCached = const Value.absent(),
                Value<bool> isBlocked = const Value.absent(),
                Value<int> readProgress = const Value.absent(),
                Value<String?> favoriteFolderId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArticlesTableCompanion.insert(
                id: id,
                feedId: feedId,
                title: title,
                link: link,
                summary: summary,
                content: content,
                author: author,
                imageUrl: imageUrl,
                publishedAt: publishedAt,
                isRead: isRead,
                isFavorite: isFavorite,
                isCached: isCached,
                isBlocked: isBlocked,
                readProgress: readProgress,
                favoriteFolderId: favoriteFolderId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ArticlesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArticlesTableTable,
      ArticlesTableData,
      $$ArticlesTableTableFilterComposer,
      $$ArticlesTableTableOrderingComposer,
      $$ArticlesTableTableAnnotationComposer,
      $$ArticlesTableTableCreateCompanionBuilder,
      $$ArticlesTableTableUpdateCompanionBuilder,
      (
        ArticlesTableData,
        BaseReferences<_$AppDatabase, $ArticlesTableTable, ArticlesTableData>,
      ),
      ArticlesTableData,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableTableCreateCompanionBuilder =
    CategoriesTableCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      Value<int> sortOrder,
      Value<bool> isExpanded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$CategoriesTableTableUpdateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<int> sortOrder,
      Value<bool> isExpanded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isExpanded => $composableBuilder(
    column: $table.isExpanded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isExpanded => $composableBuilder(
    column: $table.isExpanded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isExpanded => $composableBuilder(
    column: $table.isExpanded,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoriesTableData,
          $$CategoriesTableTableFilterComposer,
          $$CategoriesTableTableOrderingComposer,
          $$CategoriesTableTableAnnotationComposer,
          $$CategoriesTableTableCreateCompanionBuilder,
          $$CategoriesTableTableUpdateCompanionBuilder,
          (
            CategoriesTableData,
            BaseReferences<
              _$AppDatabase,
              $CategoriesTableTable,
              CategoriesTableData
            >,
          ),
          CategoriesTableData,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableTableManager(
    _$AppDatabase db,
    $CategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isExpanded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion(
                id: id,
                name: name,
                description: description,
                sortOrder: sortOrder,
                isExpanded: isExpanded,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isExpanded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                sortOrder: sortOrder,
                isExpanded: isExpanded,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTableTable,
      CategoriesTableData,
      $$CategoriesTableTableFilterComposer,
      $$CategoriesTableTableOrderingComposer,
      $$CategoriesTableTableAnnotationComposer,
      $$CategoriesTableTableCreateCompanionBuilder,
      $$CategoriesTableTableUpdateCompanionBuilder,
      (
        CategoriesTableData,
        BaseReferences<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoriesTableData
        >,
      ),
      CategoriesTableData,
      PrefetchHooks Function()
    >;
typedef $$FavoriteFoldersTableTableCreateCompanionBuilder =
    FavoriteFoldersTableCompanion Function({
      required String id,
      required String name,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$FavoriteFoldersTableTableUpdateCompanionBuilder =
    FavoriteFoldersTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$FavoriteFoldersTableTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteFoldersTableTable> {
  $$FavoriteFoldersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteFoldersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteFoldersTableTable> {
  $$FavoriteFoldersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteFoldersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteFoldersTableTable> {
  $$FavoriteFoldersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FavoriteFoldersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteFoldersTableTable,
          FavoriteFoldersTableData,
          $$FavoriteFoldersTableTableFilterComposer,
          $$FavoriteFoldersTableTableOrderingComposer,
          $$FavoriteFoldersTableTableAnnotationComposer,
          $$FavoriteFoldersTableTableCreateCompanionBuilder,
          $$FavoriteFoldersTableTableUpdateCompanionBuilder,
          (
            FavoriteFoldersTableData,
            BaseReferences<
              _$AppDatabase,
              $FavoriteFoldersTableTable,
              FavoriteFoldersTableData
            >,
          ),
          FavoriteFoldersTableData,
          PrefetchHooks Function()
        > {
  $$FavoriteFoldersTableTableTableManager(
    _$AppDatabase db,
    $FavoriteFoldersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteFoldersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteFoldersTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FavoriteFoldersTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteFoldersTableCompanion(
                id: id,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteFoldersTableCompanion.insert(
                id: id,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteFoldersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteFoldersTableTable,
      FavoriteFoldersTableData,
      $$FavoriteFoldersTableTableFilterComposer,
      $$FavoriteFoldersTableTableOrderingComposer,
      $$FavoriteFoldersTableTableAnnotationComposer,
      $$FavoriteFoldersTableTableCreateCompanionBuilder,
      $$FavoriteFoldersTableTableUpdateCompanionBuilder,
      (
        FavoriteFoldersTableData,
        BaseReferences<
          _$AppDatabase,
          $FavoriteFoldersTableTable,
          FavoriteFoldersTableData
        >,
      ),
      FavoriteFoldersTableData,
      PrefetchHooks Function()
    >;
typedef $$AnnotationsTableTableCreateCompanionBuilder =
    AnnotationsTableCompanion Function({
      required String id,
      required String articleId,
      required String content,
      Value<String?> selectedText,
      Value<int?> startOffset,
      Value<int?> endOffset,
      Value<String?> highlightColor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AnnotationsTableTableUpdateCompanionBuilder =
    AnnotationsTableCompanion Function({
      Value<String> id,
      Value<String> articleId,
      Value<String> content,
      Value<String?> selectedText,
      Value<int?> startOffset,
      Value<int?> endOffset,
      Value<String?> highlightColor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AnnotationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AnnotationsTableTable> {
  $$AnnotationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get highlightColor => $composableBuilder(
    column: $table.highlightColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnnotationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AnnotationsTableTable> {
  $$AnnotationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get highlightColor => $composableBuilder(
    column: $table.highlightColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnnotationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnnotationsTableTable> {
  $$AnnotationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get articleId =>
      $composableBuilder(column: $table.articleId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endOffset =>
      $composableBuilder(column: $table.endOffset, builder: (column) => column);

  GeneratedColumn<String> get highlightColor => $composableBuilder(
    column: $table.highlightColor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AnnotationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnnotationsTableTable,
          AnnotationsTableData,
          $$AnnotationsTableTableFilterComposer,
          $$AnnotationsTableTableOrderingComposer,
          $$AnnotationsTableTableAnnotationComposer,
          $$AnnotationsTableTableCreateCompanionBuilder,
          $$AnnotationsTableTableUpdateCompanionBuilder,
          (
            AnnotationsTableData,
            BaseReferences<
              _$AppDatabase,
              $AnnotationsTableTable,
              AnnotationsTableData
            >,
          ),
          AnnotationsTableData,
          PrefetchHooks Function()
        > {
  $$AnnotationsTableTableTableManager(
    _$AppDatabase db,
    $AnnotationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnnotationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnnotationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnnotationsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> articleId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> selectedText = const Value.absent(),
                Value<int?> startOffset = const Value.absent(),
                Value<int?> endOffset = const Value.absent(),
                Value<String?> highlightColor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnnotationsTableCompanion(
                id: id,
                articleId: articleId,
                content: content,
                selectedText: selectedText,
                startOffset: startOffset,
                endOffset: endOffset,
                highlightColor: highlightColor,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String articleId,
                required String content,
                Value<String?> selectedText = const Value.absent(),
                Value<int?> startOffset = const Value.absent(),
                Value<int?> endOffset = const Value.absent(),
                Value<String?> highlightColor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnnotationsTableCompanion.insert(
                id: id,
                articleId: articleId,
                content: content,
                selectedText: selectedText,
                startOffset: startOffset,
                endOffset: endOffset,
                highlightColor: highlightColor,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnnotationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnnotationsTableTable,
      AnnotationsTableData,
      $$AnnotationsTableTableFilterComposer,
      $$AnnotationsTableTableOrderingComposer,
      $$AnnotationsTableTableAnnotationComposer,
      $$AnnotationsTableTableCreateCompanionBuilder,
      $$AnnotationsTableTableUpdateCompanionBuilder,
      (
        AnnotationsTableData,
        BaseReferences<
          _$AppDatabase,
          $AnnotationsTableTable,
          AnnotationsTableData
        >,
      ),
      AnnotationsTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncLogsTableTableCreateCompanionBuilder =
    SyncLogsTableCompanion Function({
      Value<int> id,
      required String syncType,
      required String status,
      Value<String?> message,
      Value<int> itemCount,
      Value<DateTime> syncedAt,
    });
typedef $$SyncLogsTableTableUpdateCompanionBuilder =
    SyncLogsTableCompanion Function({
      Value<int> id,
      Value<String> syncType,
      Value<String> status,
      Value<String?> message,
      Value<int> itemCount,
      Value<DateTime> syncedAt,
    });

class $$SyncLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncLogsTableTable> {
  $$SyncLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncType => $composableBuilder(
    column: $table.syncType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncLogsTableTable> {
  $$SyncLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncType => $composableBuilder(
    column: $table.syncType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncLogsTableTable> {
  $$SyncLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncType =>
      $composableBuilder(column: $table.syncType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<int> get itemCount =>
      $composableBuilder(column: $table.itemCount, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$SyncLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncLogsTableTable,
          SyncLogsTableData,
          $$SyncLogsTableTableFilterComposer,
          $$SyncLogsTableTableOrderingComposer,
          $$SyncLogsTableTableAnnotationComposer,
          $$SyncLogsTableTableCreateCompanionBuilder,
          $$SyncLogsTableTableUpdateCompanionBuilder,
          (
            SyncLogsTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncLogsTableTable,
              SyncLogsTableData
            >,
          ),
          SyncLogsTableData,
          PrefetchHooks Function()
        > {
  $$SyncLogsTableTableTableManager(_$AppDatabase db, $SyncLogsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> message = const Value.absent(),
                Value<int> itemCount = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => SyncLogsTableCompanion(
                id: id,
                syncType: syncType,
                status: status,
                message: message,
                itemCount: itemCount,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String syncType,
                required String status,
                Value<String?> message = const Value.absent(),
                Value<int> itemCount = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => SyncLogsTableCompanion.insert(
                id: id,
                syncType: syncType,
                status: status,
                message: message,
                itemCount: itemCount,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncLogsTableTable,
      SyncLogsTableData,
      $$SyncLogsTableTableFilterComposer,
      $$SyncLogsTableTableOrderingComposer,
      $$SyncLogsTableTableAnnotationComposer,
      $$SyncLogsTableTableCreateCompanionBuilder,
      $$SyncLogsTableTableUpdateCompanionBuilder,
      (
        SyncLogsTableData,
        BaseReferences<_$AppDatabase, $SyncLogsTableTable, SyncLogsTableData>,
      ),
      SyncLogsTableData,
      PrefetchHooks Function()
    >;
typedef $$EditedArticlesTableTableCreateCompanionBuilder =
    EditedArticlesTableCompanion Function({
      required String articleId,
      required String deltaJson,
      required String htmlContent,
      Value<String?> summary,
      Value<DateTime> editedAt,
      Value<int> rowid,
    });
typedef $$EditedArticlesTableTableUpdateCompanionBuilder =
    EditedArticlesTableCompanion Function({
      Value<String> articleId,
      Value<String> deltaJson,
      Value<String> htmlContent,
      Value<String?> summary,
      Value<DateTime> editedAt,
      Value<int> rowid,
    });

class $$EditedArticlesTableTableFilterComposer
    extends Composer<_$AppDatabase, $EditedArticlesTableTable> {
  $$EditedArticlesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deltaJson => $composableBuilder(
    column: $table.deltaJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get htmlContent => $composableBuilder(
    column: $table.htmlContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get editedAt => $composableBuilder(
    column: $table.editedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EditedArticlesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EditedArticlesTableTable> {
  $$EditedArticlesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deltaJson => $composableBuilder(
    column: $table.deltaJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get htmlContent => $composableBuilder(
    column: $table.htmlContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get editedAt => $composableBuilder(
    column: $table.editedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EditedArticlesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EditedArticlesTableTable> {
  $$EditedArticlesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get articleId =>
      $composableBuilder(column: $table.articleId, builder: (column) => column);

  GeneratedColumn<String> get deltaJson =>
      $composableBuilder(column: $table.deltaJson, builder: (column) => column);

  GeneratedColumn<String> get htmlContent => $composableBuilder(
    column: $table.htmlContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<DateTime> get editedAt =>
      $composableBuilder(column: $table.editedAt, builder: (column) => column);
}

class $$EditedArticlesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EditedArticlesTableTable,
          EditedArticlesTableData,
          $$EditedArticlesTableTableFilterComposer,
          $$EditedArticlesTableTableOrderingComposer,
          $$EditedArticlesTableTableAnnotationComposer,
          $$EditedArticlesTableTableCreateCompanionBuilder,
          $$EditedArticlesTableTableUpdateCompanionBuilder,
          (
            EditedArticlesTableData,
            BaseReferences<
              _$AppDatabase,
              $EditedArticlesTableTable,
              EditedArticlesTableData
            >,
          ),
          EditedArticlesTableData,
          PrefetchHooks Function()
        > {
  $$EditedArticlesTableTableTableManager(
    _$AppDatabase db,
    $EditedArticlesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EditedArticlesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EditedArticlesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EditedArticlesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> articleId = const Value.absent(),
                Value<String> deltaJson = const Value.absent(),
                Value<String> htmlContent = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<DateTime> editedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EditedArticlesTableCompanion(
                articleId: articleId,
                deltaJson: deltaJson,
                htmlContent: htmlContent,
                summary: summary,
                editedAt: editedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String articleId,
                required String deltaJson,
                required String htmlContent,
                Value<String?> summary = const Value.absent(),
                Value<DateTime> editedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EditedArticlesTableCompanion.insert(
                articleId: articleId,
                deltaJson: deltaJson,
                htmlContent: htmlContent,
                summary: summary,
                editedAt: editedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EditedArticlesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EditedArticlesTableTable,
      EditedArticlesTableData,
      $$EditedArticlesTableTableFilterComposer,
      $$EditedArticlesTableTableOrderingComposer,
      $$EditedArticlesTableTableAnnotationComposer,
      $$EditedArticlesTableTableCreateCompanionBuilder,
      $$EditedArticlesTableTableUpdateCompanionBuilder,
      (
        EditedArticlesTableData,
        BaseReferences<
          _$AppDatabase,
          $EditedArticlesTableTable,
          EditedArticlesTableData
        >,
      ),
      EditedArticlesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FeedsTableTableTableManager get feedsTable =>
      $$FeedsTableTableTableManager(_db, _db.feedsTable);
  $$ArticlesTableTableTableManager get articlesTable =>
      $$ArticlesTableTableTableManager(_db, _db.articlesTable);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$FavoriteFoldersTableTableTableManager get favoriteFoldersTable =>
      $$FavoriteFoldersTableTableTableManager(_db, _db.favoriteFoldersTable);
  $$AnnotationsTableTableTableManager get annotationsTable =>
      $$AnnotationsTableTableTableManager(_db, _db.annotationsTable);
  $$SyncLogsTableTableTableManager get syncLogsTable =>
      $$SyncLogsTableTableTableManager(_db, _db.syncLogsTable);
  $$EditedArticlesTableTableTableManager get editedArticlesTable =>
      $$EditedArticlesTableTableTableManager(_db, _db.editedArticlesTable);
}
