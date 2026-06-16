import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_management_side_effect.freezed.dart';

/// 订阅源管理页副作用
/// 用于处理 UI 副作用，如显示 Toast、导航、对话框、文件选择等
@freezed
sealed class FeedManagementSideEffect with _$FeedManagementSideEffect {
  /// 显示 Toast 消息
  const factory FeedManagementSideEffect.showToast({
    required String message,
    @Default(false) bool isError,
  }) = FeedManagementSideEffectShowToast;

  /// 导航返回
  const factory FeedManagementSideEffect.navigateBack() =
      FeedManagementSideEffectNavigateBack;

  /// 显示确认对话框
  const factory FeedManagementSideEffect.showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) = FeedManagementSideEffectShowConfirmDialog;

  /// 显示添加订阅源对话框
  const factory FeedManagementSideEffect.showAddFeedDialog() =
      FeedManagementSideEffectShowAddFeedDialog;

  /// 显示分类选择对话框
  const factory FeedManagementSideEffect.showCategoryPicker({
    required List<String> feedIds,
  }) = FeedManagementSideEffectShowCategoryPicker;

  /// 显示创建分类对话框
  const factory FeedManagementSideEffect.showCreateCategoryDialog() =
      FeedManagementSideEffectShowCreateCategoryDialog;

  /// 打开文件选择器（导入 OPML）
  const factory FeedManagementSideEffect.openFilePicker() =
      FeedManagementSideEffectOpenFilePicker;

  /// 打开文件保存对话框（导出 OPML）
  const factory FeedManagementSideEffect.openFileSaver({
    required String suggestedFileName,
  }) = FeedManagementSideEffectOpenFileSaver;

  /// 导入完成
  const factory FeedManagementSideEffect.importCompleted({
    required int importedCount,
    required int failedCount,
  }) = FeedManagementSideEffectImportCompleted;

  /// 导出完成
  const factory FeedManagementSideEffect.exportCompleted({
    required String filePath,
  }) = FeedManagementSideEffectExportCompleted;

  /// 关闭添加订阅源对话框
  const factory FeedManagementSideEffect.closeAddFeedDialog() =
      FeedManagementSideEffectCloseAddFeedDialog;
}
