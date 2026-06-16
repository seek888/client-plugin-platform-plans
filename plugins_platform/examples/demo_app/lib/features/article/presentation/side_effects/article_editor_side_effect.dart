import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_editor_side_effect.freezed.dart';

/// 文章编辑器副作用
@freezed
class ArticleEditorSideEffect with _$ArticleEditorSideEffect {
  /// 显示保存成功提示
  const factory ArticleEditorSideEffect.showSaveSuccess() =
      ArticleEditorShowSaveSuccess;

  /// 显示保存失败提示
  const factory ArticleEditorSideEffect.showSaveError(String message) =
      ArticleEditorShowSaveError;

  /// 显示丢弃确认对话框
  const factory ArticleEditorSideEffect.showDiscardConfirmation() =
      ArticleEditorShowDiscardConfirmation;

  /// 导航返回
  const factory ArticleEditorSideEffect.navigateBack() =
      ArticleEditorNavigateBack;

  /// 显示加载失败提示
  const factory ArticleEditorSideEffect.showLoadError(String message) =
      ArticleEditorShowLoadError;
}
