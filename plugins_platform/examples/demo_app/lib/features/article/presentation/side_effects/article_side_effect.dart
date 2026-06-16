import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_side_effect.freezed.dart';

/// 文章列表副作用
/// 用于处理 UI 副作用，如显示 Toast、导航、对话框等
@freezed
sealed class ArticleSideEffect with _$ArticleSideEffect {
  /// 显示 Toast 消息
  const factory ArticleSideEffect.showToast({
    required String message,
    @Default(false) bool isError,
  }) = ArticleSideEffectShowToast;

  /// 导航到文章详情页
  const factory ArticleSideEffect.navigateToArticle({
    required String articleId,
  }) = ArticleSideEffectNavigateToArticle;

  /// 导航到指定路由
  const factory ArticleSideEffect.navigate({
    required String route,
    Map<String, String>? params,
  }) = ArticleSideEffectNavigate;

  /// 显示确认对话框
  const factory ArticleSideEffect.showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) = ArticleSideEffectShowConfirmDialog;

  /// 显示屏蔽选项对话框
  const factory ArticleSideEffect.showBlockOptions({
    required String articleId,
    required String feedId,
  }) = ArticleSideEffectShowBlockOptions;

  /// 滚动到顶部
  const factory ArticleSideEffect.scrollToTop() = ArticleSideEffectScrollToTop;

  /// 在新窗口打开文章（桌面端）
  const factory ArticleSideEffect.openInNewWindow({required String articleId}) =
      ArticleSideEffectOpenInNewWindow;

  /// 分享文章
  const factory ArticleSideEffect.shareArticle({
    required String articleId,
    required String title,
    required String link,
  }) = ArticleSideEffectShareArticle;
}
