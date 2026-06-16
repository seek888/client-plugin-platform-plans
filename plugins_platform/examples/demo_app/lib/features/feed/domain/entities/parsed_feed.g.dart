// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedFeedImpl _$$ParsedFeedImplFromJson(Map<String, dynamic> json) =>
    _$ParsedFeedImpl(
      title: json['title'] as String,
      description: json['description'] as String?,
      link: json['link'] as String?,
      iconUrl: json['iconUrl'] as String?,
      articles: (json['articles'] as List<dynamic>)
          .map((e) => ParsedArticle.fromJson(e as Map<String, dynamic>))
          .toList(),
      feedType: $enumDecode(_$FeedTypeEnumMap, json['feedType']),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$ParsedFeedImplToJson(_$ParsedFeedImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'link': instance.link,
      'iconUrl': instance.iconUrl,
      'articles': instance.articles,
      'feedType': _$FeedTypeEnumMap[instance.feedType]!,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };

const _$FeedTypeEnumMap = {
  FeedType.rss1: 'rss1',
  FeedType.rss2: 'rss2',
  FeedType.atom: 'atom',
  FeedType.unknown: 'unknown',
};

_$ParsedArticleImpl _$$ParsedArticleImplFromJson(Map<String, dynamic> json) =>
    _$ParsedArticleImpl(
      guid: json['guid'] as String?,
      title: json['title'] as String,
      summary: json['summary'] as String?,
      content: json['content'] as String?,
      author: json['author'] as String?,
      link: json['link'] as String?,
      imageUrl: json['imageUrl'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ParsedArticleImplToJson(_$ParsedArticleImpl instance) =>
    <String, dynamic>{
      'guid': instance.guid,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'author': instance.author,
      'link': instance.link,
      'imageUrl': instance.imageUrl,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'categories': instance.categories,
    };
