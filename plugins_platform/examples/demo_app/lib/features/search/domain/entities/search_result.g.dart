// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      articles: (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
      feeds: (json['feeds'] as List<dynamic>)
          .map((e) => Feed.fromJson(e as Map<String, dynamic>))
          .toList(),
      query: json['query'] as String,
      scope: $enumDecode(_$SearchScopeEnumMap, json['scope']),
      totalCount: (json['totalCount'] as num).toInt(),
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'feeds': instance.feeds,
      'query': instance.query,
      'scope': _$SearchScopeEnumMap[instance.scope]!,
      'totalCount': instance.totalCount,
    };

const _$SearchScopeEnumMap = {
  SearchScope.all: 'all',
  SearchScope.title: 'title',
  SearchScope.content: 'content',
  SearchScope.feed: 'feed',
};
