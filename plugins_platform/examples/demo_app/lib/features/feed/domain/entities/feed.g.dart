// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedImpl _$$FeedImplFromJson(Map<String, dynamic> json) => _$FeedImpl(
  id: json['id'] as String,
  url: json['url'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  iconUrl: json['iconUrl'] as String?,
  link: json['link'] as String?,
  categoryId: json['categoryId'] as String?,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
  lastFetched: json['lastFetched'] == null
      ? null
      : DateTime.parse(json['lastFetched'] as String),
  isEnabled: json['isEnabled'] as bool? ?? true,
  isBlocked: json['isBlocked'] as bool? ?? false,
  healthStatus: (json['healthStatus'] as num?)?.toInt() ?? 0,
  failureCount: (json['failureCount'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  sourceType:
      $enumDecodeNullable(_$SourceTypeEnumMap, json['sourceType']) ??
      SourceType.rss,
  apiConfig: json['apiConfig'] == null
      ? null
      : ApiSourceConfig.fromJson(json['apiConfig'] as Map<String, dynamic>),
  pluginConfig: json['pluginConfig'] == null
      ? null
      : PluginSourceConfig.fromJson(
          json['pluginConfig'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$FeedImplToJson(_$FeedImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'link': instance.link,
      'categoryId': instance.categoryId,
      'sortOrder': instance.sortOrder,
      'unreadCount': instance.unreadCount,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'lastFetched': instance.lastFetched?.toIso8601String(),
      'isEnabled': instance.isEnabled,
      'isBlocked': instance.isBlocked,
      'healthStatus': instance.healthStatus,
      'failureCount': instance.failureCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'sourceType': _$SourceTypeEnumMap[instance.sourceType]!,
      'apiConfig': instance.apiConfig,
      'pluginConfig': instance.pluginConfig,
    };

const _$SourceTypeEnumMap = {
  SourceType.rss: 'rss',
  SourceType.api: 'api',
  SourceType.plugin: 'plugin',
};

_$FeedCategoryImpl _$$FeedCategoryImplFromJson(Map<String, dynamic> json) =>
    _$FeedCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isExpanded: json['isExpanded'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$FeedCategoryImplToJson(_$FeedCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'sortOrder': instance.sortOrder,
      'isExpanded': instance.isExpanded,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
