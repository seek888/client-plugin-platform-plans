// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiSourceConfigImpl _$$ApiSourceConfigImplFromJson(
  Map<String, dynamic> json,
) => _$ApiSourceConfigImpl(
  baseUrl: json['baseUrl'] as String,
  apiKey: json['apiKey'] as String?,
  customHeaders:
      (json['customHeaders'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  timeout: json['timeout'] == null
      ? const Duration(seconds: 30)
      : Duration(microseconds: (json['timeout'] as num).toInt()),
  maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
  remoteFeedId: json['remoteFeedId'] as String?,
);

Map<String, dynamic> _$$ApiSourceConfigImplToJson(
  _$ApiSourceConfigImpl instance,
) => <String, dynamic>{
  'baseUrl': instance.baseUrl,
  'apiKey': instance.apiKey,
  'customHeaders': instance.customHeaders,
  'timeout': instance.timeout.inMicroseconds,
  'maxRetries': instance.maxRetries,
  'remoteFeedId': instance.remoteFeedId,
};

_$ArticleListResultImpl _$$ArticleListResultImplFromJson(
  Map<String, dynamic> json,
) => _$ArticleListResultImpl(
  articles: (json['articles'] as List<dynamic>)
      .map((e) => ParsedArticle.fromJson(e as Map<String, dynamic>))
      .toList(),
  hasMore: json['hasMore'] as bool,
  totalCount: (json['totalCount'] as num?)?.toInt(),
  nextCursor: json['nextCursor'] as String?,
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
);

Map<String, dynamic> _$$ArticleListResultImplToJson(
  _$ArticleListResultImpl instance,
) => <String, dynamic>{
  'articles': instance.articles,
  'hasMore': instance.hasMore,
  'totalCount': instance.totalCount,
  'nextCursor': instance.nextCursor,
  'currentPage': instance.currentPage,
  'pageSize': instance.pageSize,
};

_$PluginSourceConfigImpl _$$PluginSourceConfigImplFromJson(
  Map<String, dynamic> json,
) => _$PluginSourceConfigImpl(
  pluginId: json['pluginId'] as String,
  feedKey: json['feedKey'] as String,
  provider: json['provider'] as String? ?? 'rss.feed.provider',
);

Map<String, dynamic> _$$PluginSourceConfigImplToJson(
  _$PluginSourceConfigImpl instance,
) => <String, dynamic>{
  'pluginId': instance.pluginId,
  'feedKey': instance.feedKey,
  'provider': instance.provider,
};

_$RssSourceConfigImpl _$$RssSourceConfigImplFromJson(
  Map<String, dynamic> json,
) => _$RssSourceConfigImpl(
  feedUrl: json['feedUrl'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$RssSourceConfigImplToJson(
  _$RssSourceConfigImpl instance,
) => <String, dynamic>{
  'feedUrl': instance.feedUrl,
  'runtimeType': instance.$type,
};

_$ApiDataSourceConfigImpl _$$ApiDataSourceConfigImplFromJson(
  Map<String, dynamic> json,
) => _$ApiDataSourceConfigImpl(
  config: ApiSourceConfig.fromJson(json['config'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$ApiDataSourceConfigImplToJson(
  _$ApiDataSourceConfigImpl instance,
) => <String, dynamic>{
  'config': instance.config,
  'runtimeType': instance.$type,
};

_$PluginDataSourceConfigImpl _$$PluginDataSourceConfigImplFromJson(
  Map<String, dynamic> json,
) => _$PluginDataSourceConfigImpl(
  config: PluginSourceConfig.fromJson(json['config'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$PluginDataSourceConfigImplToJson(
  _$PluginDataSourceConfigImpl instance,
) => <String, dynamic>{
  'config': instance.config,
  'runtimeType': instance.$type,
};
