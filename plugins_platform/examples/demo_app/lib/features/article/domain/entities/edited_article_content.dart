import 'package:freezed_annotation/freezed_annotation.dart';

part 'edited_article_content.freezed.dart';
part 'edited_article_content.g.dart';

/// 已编辑的文章内容实体
@freezed
class EditedArticleContent with _$EditedArticleContent {
  const EditedArticleContent._();

  const factory EditedArticleContent({
    /// 文章 ID（关联原始文章）
    required String articleId,

    /// Quill Delta JSON 格式的编辑内容
    required String deltaJson,

    /// 转换后的 HTML 内容（用于显示）
    required String htmlContent,

    /// 编辑时间
    required DateTime editedAt,

    /// 从内容提取的摘要
    String? summary,
  }) = _EditedArticleContent;

  factory EditedArticleContent.fromJson(Map<String, dynamic> json) =>
      _$EditedArticleContentFromJson(json);
}
