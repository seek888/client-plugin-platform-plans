import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_side_effect.freezed.dart';

/// 搜索页副作用
/// 用于处理 UI 副作用，如显示 Toast、导航、对话框等
/// Requirements: 8.1, 8.3, 8.4
@freezed
sealed class SearchSideEffect with _$SearchSideEffect {
  /// 显示 Toast 消息
  const factory SearchSideEffect.showToast({
    required String message,
    @Default(false) bool isError,
  }) = SearchSideEffectShowToast;

  /// 导航到文章详情页
  const factory SearchSideEffect.navigateToArticle({
    required String articleId,
  }) = SearchSideEffectNavigateToArticle;

  /// 导航到订阅源详情页
  const factory SearchSideEffect.navigateToFeed({required String feedId}) =
      SearchSideEffectNavigateToFeed;

  /// 关闭搜索页
  const factory SearchSideEffect.closeSearch() = SearchSideEffectCloseSearch;

  /// 清除搜索框焦点
  const factory SearchSideEffect.clearFocus() = SearchSideEffectClearFocus;

  /// 显示确认对话框（用于清除历史记录）
  const factory SearchSideEffect.showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) = SearchSideEffectShowConfirmDialog;
}
