// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edited_article_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditedArticleContentImpl _$$EditedArticleContentImplFromJson(
  Map<String, dynamic> json,
) => _$EditedArticleContentImpl(
  articleId: json['articleId'] as String,
  deltaJson: json['deltaJson'] as String,
  htmlContent: json['htmlContent'] as String,
  editedAt: DateTime.parse(json['editedAt'] as String),
  summary: json['summary'] as String?,
);

Map<String, dynamic> _$$EditedArticleContentImplToJson(
  _$EditedArticleContentImpl instance,
) => <String, dynamic>{
  'articleId': instance.articleId,
  'deltaJson': instance.deltaJson,
  'htmlContent': instance.htmlContent,
  'editedAt': instance.editedAt.toIso8601String(),
  'summary': instance.summary,
};
