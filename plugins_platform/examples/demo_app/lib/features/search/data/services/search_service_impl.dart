import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/search/domain/entities/search_result.dart';
import 'package:rss_reader/features/search/domain/services/search_service.dart';

/// 搜索服务实现类
///
/// 提供文章和订阅源的全文搜索功能
/// Requirements: 8.1, 8.2, 8.3, 8.4, 8.5
class SearchServiceImpl implements SearchService {
  /// 文章数据源（用于搜索文章）
  final List<Article> Function() _getArticles;

  /// 订阅源数据源（用于搜索订阅源）
  final List<Feed> Function() _getFeeds;

  /// 搜索历史存储
  final List<String> _searchHistory = [];

  /// 最大搜索历史数量
  static const int _maxHistoryCount = 20;

  SearchServiceImpl({
    required List<Article> Function() getArticles,
    required List<Feed> Function() getFeeds,
  }) : _getArticles = getArticles,
       _getFeeds = getFeeds;

  @override
  Future<Either<Failure, SearchResult>> search(
    String query, {
    SearchScope scope = SearchScope.all,
    int limit = 50,
  }) async {
    try {
      // 空查询返回空结果
      final trimmedQuery = query.trim();
      if (trimmedQuery.isEmpty) {
        return Right(SearchResult.empty(query, scope));
      }

      // 转换为小写进行不区分大小写的搜索
      final lowerQuery = trimmedQuery.toLowerCase();

      List<Article> matchedArticles = [];
      List<Feed> matchedFeeds = [];

      // 根据搜索范围执行搜索
      switch (scope) {
        case SearchScope.all:
          matchedArticles = _searchArticles(
            lowerQuery,
            searchTitle: true,
            searchContent: true,
          );
          matchedFeeds = _searchFeeds(lowerQuery);
          break;
        case SearchScope.title:
          matchedArticles = _searchArticles(
            lowerQuery,
            searchTitle: true,
            searchContent: false,
          );
          break;
        case SearchScope.content:
          matchedArticles = _searchArticles(
            lowerQuery,
            searchTitle: false,
            searchContent: true,
          );
          break;
        case SearchScope.feed:
          matchedFeeds = _searchFeeds(lowerQuery);
          break;
      }

      // 应用限制
      if (matchedArticles.length > limit) {
        matchedArticles = matchedArticles.sublist(0, limit);
      }
      if (matchedFeeds.length > limit) {
        matchedFeeds = matchedFeeds.sublist(0, limit);
      }

      final totalCount = matchedArticles.length + matchedFeeds.length;

      return Right(
        SearchResult(
          articles: matchedArticles,
          feeds: matchedFeeds,
          query: trimmedQuery,
          scope: scope,
          totalCount: totalCount,
        ),
      );
    } catch (e) {
      return Left(Failure.cache(message: '搜索失败: ${e.toString()}'));
    }
  }

  /// 搜索文章
  ///
  /// [query] 小写的搜索关键词
  /// [searchTitle] 是否搜索标题
  /// [searchContent] 是否搜索内容
  List<Article> _searchArticles(
    String query, {
    required bool searchTitle,
    required bool searchContent,
  }) {
    final articles = _getArticles();
    return articles.where((article) {
      // 跳过被屏蔽的文章
      if (article.isBlocked) return false;

      bool matches = false;

      // 搜索标题
      if (searchTitle) {
        final title = article.title.toLowerCase();
        if (title.contains(query)) {
          matches = true;
        }
      }

      // 搜索内容（包括摘要和正文）
      if (searchContent && !matches) {
        final summary = article.summary?.toLowerCase() ?? '';
        final content = article.content?.toLowerCase() ?? '';
        if (summary.contains(query) || content.contains(query)) {
          matches = true;
        }
      }

      return matches;
    }).toList();
  }

  /// 搜索订阅源
  ///
  /// [query] 小写的搜索关键词
  List<Feed> _searchFeeds(String query) {
    final feeds = _getFeeds();
    return feeds.where((feed) {
      // 跳过被屏蔽的订阅源
      if (feed.isBlocked) return false;

      // 搜索订阅源名称
      final title = feed.title.toLowerCase();
      if (title.contains(query)) {
        return true;
      }

      // 搜索订阅源描述
      final description = feed.description?.toLowerCase() ?? '';
      if (description.contains(query)) {
        return true;
      }

      return false;
    }).toList();
  }

  @override
  Future<List<String>> getSuggestions(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    final lowerQuery = query.toLowerCase();
    final suggestions = <String>{};

    // 从文章标题中获取建议
    final articles = _getArticles();
    for (final article in articles) {
      if (article.title.toLowerCase().contains(lowerQuery)) {
        suggestions.add(article.title);
        if (suggestions.length >= 10) break;
      }
    }

    // 从订阅源名称中获取建议
    if (suggestions.length < 10) {
      final feeds = _getFeeds();
      for (final feed in feeds) {
        if (feed.title.toLowerCase().contains(lowerQuery)) {
          suggestions.add(feed.title);
          if (suggestions.length >= 10) break;
        }
      }
    }

    return suggestions.toList();
  }

  @override
  Future<List<String>> getSearchHistory() async {
    return List.unmodifiable(_searchHistory);
  }

  @override
  Future<void> addSearchHistory(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return;

    // 移除已存在的相同记录（避免重复）
    _searchHistory.remove(trimmedQuery);

    // 添加到列表开头
    _searchHistory.insert(0, trimmedQuery);

    // 限制历史记录数量
    if (_searchHistory.length > _maxHistoryCount) {
      _searchHistory.removeRange(_maxHistoryCount, _searchHistory.length);
    }
  }

  @override
  Future<void> clearSearchHistory() async {
    _searchHistory.clear();
  }

  @override
  Future<void> removeSearchHistory(String query) async {
    _searchHistory.remove(query);
  }
}
