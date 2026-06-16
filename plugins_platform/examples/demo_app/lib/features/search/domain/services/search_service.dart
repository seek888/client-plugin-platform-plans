import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/search/domain/entities/search_result.dart';

/// 搜索服务接口
///
/// 提供文章和订阅源的全文搜索功能
/// Requirements: 8.1, 8.2, 8.3, 8.4, 8.5
abstract class SearchService {
  /// 搜索文章和订阅源
  ///
  /// [query] 搜索关键词
  /// [scope] 搜索范围（全部/标题/内容/订阅源）
  /// [limit] 返回结果数量限制
  ///
  /// Requirements:
  /// - 8.2: WHEN 用户输入搜索关键词 THEN THE Search_Engine SHALL 在标题、内容、订阅源名称中搜索匹配项
  /// - 8.5: WHEN 用户选择筛选标签 THEN THE Search_Engine SHALL 仅在对应范围内搜索
  Future<Either<Failure, SearchResult>> search(
    String query, {
    SearchScope scope = SearchScope.all,
    int limit = 50,
  });

  /// 获取搜索建议
  ///
  /// [query] 输入的部分关键词
  /// 返回匹配的搜索建议列表
  Future<List<String>> getSuggestions(String query);

  /// 获取搜索历史
  ///
  /// 返回最近的搜索记录
  Future<List<String>> getSearchHistory();

  /// 添加搜索历史
  ///
  /// [query] 要添加的搜索关键词
  Future<void> addSearchHistory(String query);

  /// 清除搜索历史
  Future<void> clearSearchHistory();

  /// 删除单条搜索历史
  ///
  /// [query] 要删除的搜索关键词
  Future<void> removeSearchHistory(String query);
}
