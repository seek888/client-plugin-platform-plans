import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

part 'search_result.freezed.dart';
part 'search_result.g.dart';

/// 搜索范围
enum SearchScope {
  /// 全部（标题、内容、订阅源）
  all,

  /// 仅标题
  title,

  /// 仅内容
  content,

  /// 仅订阅源
  feed,
}

/// 搜索结果实体
@freezed
class SearchResult with _$SearchResult {
  const SearchResult._();

  const factory SearchResult({
    /// 匹配的文章列表
    required List<Article> articles,

    /// 匹配的订阅源列表
    required List<Feed> feeds,

    /// 搜索关键词
    required String query,

    /// 搜索范围
    required SearchScope scope,

    /// 总匹配数
    required int totalCount,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  /// 是否有结果
  bool get hasResults => totalCount > 0;

  /// 是否有文章结果
  bool get hasArticles => articles.isNotEmpty;

  /// 是否有订阅源结果
  bool get hasFeeds => feeds.isNotEmpty;

  /// 创建空结果
  static SearchResult empty(String query, SearchScope scope) => SearchResult(
    articles: const [],
    feeds: const [],
    query: query,
    scope: scope,
    totalCount: 0,
  );
}
