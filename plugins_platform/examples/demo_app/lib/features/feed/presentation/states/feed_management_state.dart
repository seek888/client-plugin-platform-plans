import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

part 'feed_management_state.freezed.dart';

/// 订阅源管理页状态
/// 使用 freezed 生成不可变状态类
@freezed
class FeedManagementState with _$FeedManagementState {
  /// 初始状态
  const factory FeedManagementState.initial() = FeedManagementStateInitial;

  /// 加载中状态
  const factory FeedManagementState.loading() = FeedManagementStateLoading;

  /// 加载成功状态
  const factory FeedManagementState.loaded({
    /// 订阅源列表
    required List<Feed> feeds,

    /// 分类列表
    required List<FeedCategory> categories,

    /// 是否处于批量选择模式
    @Default(false) bool isSelectionMode,

    /// 已选中的订阅源 ID 列表
    @Default([]) List<String> selectedFeedIds,

    /// 是否正在导入 OPML
    @Default(false) bool isImporting,

    /// 是否正在导出 OPML
    @Default(false) bool isExporting,

    /// 是否正在验证 URL
    @Default(false) bool isValidating,

    /// URL 验证结果
    FeedValidationState? validationState,

    /// 是否正在拖拽排序
    @Default(false) bool isDragging,

    /// 当前选择的数据源类型（添加对话框用）
    @Default(SourceType.rss) SourceType selectedSourceType,
  }) = FeedManagementStateLoaded;

  /// 错误状态
  const factory FeedManagementState.error({required String message}) =
      FeedManagementStateError;
}

/// URL 验证状态
@freezed
class FeedValidationState with _$FeedValidationState {
  /// 验证中
  const factory FeedValidationState.validating() =
      FeedValidationStateValidating;

  /// 验证成功
  const factory FeedValidationState.success({
    required String feedTitle,
    String? feedDescription,
    String? iconUrl,
    required int articleCount,
    @Default(SourceType.rss) SourceType sourceType,
  }) = FeedValidationStateSuccess;

  /// 验证失败
  const factory FeedValidationState.failure({required String errorMessage}) =
      FeedValidationStateFailure;
}
