import 'package:rss_reader/features/article/domain/entities/article.dart';

/// 文章排序服务接口
abstract class ArticleSortingService {
  /// 按时间倒序排序（最新优先）
  List<Article> sortByTimeDesc(List<Article> articles);

  /// 按时间正序排序（最早优先）
  List<Article> sortByTimeAsc(List<Article> articles);

  /// 未读优先排序（未读在前，然后按时间倒序）
  List<Article> sortByUnreadFirst(List<Article> articles);

  /// 根据排序类型排序
  List<Article> sortArticles(List<Article> articles, ArticleSortType sortType);
}
