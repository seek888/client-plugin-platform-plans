import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';

part 'article_list_state.freezed.dart';

/// 文章列表状态
/// 使用 freezed 生成不可变状态类
@freezed
class ArticleListState with _$ArticleListState {
  /// 初始状态
  const factory ArticleListState.initial() = ArticleListStateInitial;

  /// 加载中状态
  const factory ArticleListState.loading() = ArticleListStateLoading;

  /// 加载成功状态
  const factory ArticleListState.loaded({
    /// 文章列表
    required List<Article> articles,

    /// 当前订阅源 ID（null 表示全部）
    String? feedId,

    /// 当前排序类型
    @Default(ArticleSortType.timeDesc) ArticleSortType sortType,

    /// 当前筛选类型
    @Default(ArticleFilterType.all) ArticleFilterType filterType,

    /// 当前页码
    @Default(1) int currentPage,

    /// 是否还有更多数据
    @Default(true) bool hasMore,

    /// 是否正在加载更多
    @Default(false) bool isLoadingMore,

    /// 是否正在刷新
    @Default(false) bool isRefreshing,

    /// 当前选中的文章 ID
    String? selectedArticleId,
  }) = ArticleListStateLoaded;

  /// 错误状态
  const factory ArticleListState.error({required String message}) =
      ArticleListStateError;
}
