// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      id: json['id'] as String,
      feedId: json['feedId'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String?,
      content: json['content'] as String?,
      author: json['author'] as String?,
      link: json['link'] as String,
      imageUrl: json['imageUrl'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isCached: json['isCached'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
      readProgress: (json['readProgress'] as num?)?.toInt() ?? 0,
      favoriteFolderId: json['favoriteFolderId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'feedId': instance.feedId,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'author': instance.author,
      'link': instance.link,
      'imageUrl': instance.imageUrl,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'isRead': instance.isRead,
      'isFavorite': instance.isFavorite,
      'isCached': instance.isCached,
      'isBlocked': instance.isBlocked,
      'readProgress': instance.readProgress,
      'favoriteFolderId': instance.favoriteFolderId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
