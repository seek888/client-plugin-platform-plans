import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_detail_side_effect.freezed.dart';

/// 文章详情副作用
/// 用于处理 UI 副作用，如显示 Toast、导航、对话框等
@freezed
sealed class ArticleDetailSideEffect with _$ArticleDetailSideEffect {
  /// 显示 Toast 消息
  const factory ArticleDetailSideEffect.showToast({
    required String message,
    @Default(false) bool isError,
  }) = ArticleDetailSideEffectShowToast;

  /// 导航到上一篇文章
  const factory ArticleDetailSideEffect.navigateToPrevious({
    required String articleId,
  }) = ArticleDetailSideEffectNavigateToPrevious;

  /// 导航到下一篇文章
  const factory ArticleDetailSideEffect.navigateToNext({
    required String articleId,
  }) = ArticleDetailSideEffectNavigateToNext;

  /// 导航到订阅源列表
  const factory ArticleDetailSideEffect.navigateToFeed({
    required String feedId,
  }) = ArticleDetailSideEffectNavigateToFeed;

  /// 返回上一页
  const factory ArticleDetailSideEffect.goBack() =
      ArticleDetailSideEffectGoBack;

  /// 打开外部链接
  const factory ArticleDetailSideEffect.openExternalLink({
    required String url,
  }) = ArticleDetailSideEffectOpenExternalLink;

  /// 显示图片查看器
  const factory ArticleDetailSideEffect.showImageViewer({
    required String imageUrl,
    List<String>? allImages,
    int? initialIndex,
  }) = ArticleDetailSideEffectShowImageViewer;

  /// 分享文章
  const factory ArticleDetailSideEffect.shareArticle({
    required String title,
    required String link,
  }) = ArticleDetailSideEffectShareArticle;

  /// 复制链接到剪贴板
  const factory ArticleDetailSideEffect.copyLink({required String link}) =
      ArticleDetailSideEffectCopyLink;

  /// 显示确认对话框
  const factory ArticleDetailSideEffect.showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) = ArticleDetailSideEffectShowConfirmDialog;

  /// 显示批注菜单（移动端长按）
  const factory ArticleDetailSideEffect.showAnnotationMenu({
    required String selectedText,
    required int startOffset,
    required int endOffset,
  }) = ArticleDetailSideEffectShowAnnotationMenu;

  /// 显示划词翻译结果
  const factory ArticleDetailSideEffect.showWordTranslation({
    required String originalText,
    required String translatedText,
  }) = ArticleDetailSideEffectShowWordTranslation;

  /// 滚动到指定位置
  const factory ArticleDetailSideEffect.scrollToPosition({
    required double position,
  }) = ArticleDetailSideEffectScrollToPosition;
}
