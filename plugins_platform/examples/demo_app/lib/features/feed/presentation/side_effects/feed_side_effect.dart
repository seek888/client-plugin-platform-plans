import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_side_effect.freezed.dart';

/// 订阅源列表副作用
/// 用于处理 UI 副作用，如显示 Toast、导航、对话框等
@freezed
sealed class FeedSideEffect with _$FeedSideEffect {
  /// 显示 Toast 消息
  const factory FeedSideEffect.showToast({
    required String message,
    @Default(false) bool isError,
  }) = FeedSideEffectShowToast;

  /// 导航到指定路由
  const factory FeedSideEffect.navigate({
    required String route,
    Map<String, String>? params,
  }) = FeedSideEffectNavigate;

  /// 显示普通对话框
  const factory FeedSideEffect.showDialog({
    required String title,
    required String message,
  }) = FeedSideEffectShowDialog;

  /// 显示确认对话框
  const factory FeedSideEffect.showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) = FeedSideEffectShowConfirmDialog;

  /// 显示添加订阅源对话框
  const factory FeedSideEffect.showAddFeedDialog() =
      FeedSideEffectShowAddFeedDialog;

  /// 显示编辑订阅源对话框
  const factory FeedSideEffect.showEditFeedDialog({required String feedId}) =
      FeedSideEffectShowEditFeedDialog;

  /// 显示分类选择对话框
  const factory FeedSideEffect.showCategoryPicker({required String feedId}) =
      FeedSideEffectShowCategoryPicker;

  /// 滚动到指定位置
  const factory FeedSideEffect.scrollToTop() = FeedSideEffectScrollToTop;
}
