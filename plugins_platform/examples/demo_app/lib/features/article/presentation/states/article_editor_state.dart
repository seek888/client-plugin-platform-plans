import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_editor_state.freezed.dart';

/// 文章编辑器状态
@freezed
class ArticleEditorState with _$ArticleEditorState {
  /// 初始状态
  const factory ArticleEditorState.initial() = ArticleEditorInitial;

  /// 加载中
  const factory ArticleEditorState.loading() = ArticleEditorLoading;

  /// 已加载
  const factory ArticleEditorState.loaded({
    required String articleId,
    required List<Map<String, dynamic>> content,
    required bool hasEditedVersion,
    @Default(false) bool isDirty,
    @Default(false) bool isSaving,
    @Default(false) bool isNewNote,
  }) = ArticleEditorLoaded;

  /// 错误状态
  const factory ArticleEditorState.error({
    required String message,
    String? articleId,
  }) = ArticleEditorError;
}
