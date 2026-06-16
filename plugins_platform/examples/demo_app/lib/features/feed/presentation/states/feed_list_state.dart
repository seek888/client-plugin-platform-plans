import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

part 'feed_list_state.freezed.dart';

/// 订阅源列表状态
/// 使用 freezed 生成不可变状态类
@freezed
class FeedListState with _$FeedListState {
  /// 初始状态
  const factory FeedListState.initial() = FeedListStateInitial;

  /// 加载中状态
  const factory FeedListState.loading() = FeedListStateLoading;

  /// 加载成功状态
  const factory FeedListState.loaded({
    /// 订阅源列表
    required List<Feed> feeds,

    /// 分类列表
    required List<FeedCategory> categories,

    /// 当前选中的订阅源 ID
    String? selectedFeedId,

    /// 是否正在刷新
    @Default(false) bool isRefreshing,

    /// 总未读数
    @Default(0) int totalUnreadCount,
  }) = FeedListStateLoaded;

  /// 错误状态
  const factory FeedListState.error({required String message}) =
      FeedListStateError;
}
