import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rss_reader/features/search/domain/entities/search_result.dart';

part 'search_state.freezed.dart';

/// 搜索页状态
/// 使用 freezed 生成不可变状态类
/// Requirements: 8.1, 8.2, 8.3, 8.4, 8.5
@freezed
class SearchState with _$SearchState {
  /// 初始状态 - 显示搜索历史
  const factory SearchState.initial({
    /// 搜索历史
    @Default([]) List<String> searchHistory,
  }) = SearchStateInitial;

  /// 搜索中状态
  const factory SearchState.searching({
    /// 当前搜索关键词
    required String query,

    /// 当前搜索范围
    required SearchScope scope,
  }) = SearchStateSearching;

  /// 搜索完成状态
  const factory SearchState.loaded({
    /// 搜索结果
    required SearchResult result,

    /// 搜索历史
    @Default([]) List<String> searchHistory,

    /// 搜索建议
    @Default([]) List<String> suggestions,
  }) = SearchStateLoaded;

  /// 空结果状态
  const factory SearchState.empty({
    /// 搜索关键词
    required String query,

    /// 搜索范围
    required SearchScope scope,

    /// 搜索历史
    @Default([]) List<String> searchHistory,
  }) = SearchStateEmpty;

  /// 错误状态
  const factory SearchState.error({
    required String message,

    /// 搜索关键词
    String? query,

    /// 搜索历史
    @Default([]) List<String> searchHistory,
  }) = SearchStateError;
}
