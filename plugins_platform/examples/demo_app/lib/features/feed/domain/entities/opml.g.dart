// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opml.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OPMLFeedImpl _$$OPMLFeedImplFromJson(Map<String, dynamic> json) =>
    _$OPMLFeedImpl(
      title: json['title'] as String,
      xmlUrl: json['xmlUrl'] as String,
      htmlUrl: json['htmlUrl'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$$OPMLFeedImplToJson(_$OPMLFeedImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'xmlUrl': instance.xmlUrl,
      'htmlUrl': instance.htmlUrl,
      'description': instance.description,
      'category': instance.category,
    };

_$OPMLDocumentImpl _$$OPMLDocumentImplFromJson(Map<String, dynamic> json) =>
    _$OPMLDocumentImpl(
      title: json['title'] as String? ?? 'RSS Reader Export',
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      feeds:
          (json['feeds'] as List<dynamic>?)
              ?.map((e) => OPMLFeed.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      categorizedFeeds:
          (json['categorizedFeeds'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>)
                  .map((e) => OPMLFeed.fromJson(e as Map<String, dynamic>))
                  .toList(),
            ),
          ) ??
          const {},
    );

Map<String, dynamic> _$$OPMLDocumentImplToJson(_$OPMLDocumentImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'feeds': instance.feeds,
      'categorizedFeeds': instance.categorizedFeeds,
    };
