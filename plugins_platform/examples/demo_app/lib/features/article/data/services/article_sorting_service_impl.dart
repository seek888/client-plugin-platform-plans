import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/domain/services/article_sorting_service.dart';

/// 文章排序服务实现
class ArticleSortingServiceImpl implements ArticleSortingService {
  @override
  List<Article> sortByTimeDesc(List<Article> articles) {
    final sorted = List<Article>.from(articles);
    sorted.sort((a, b) {
      final aTime = a.publishedAt ?? DateTime(1970);
      final bTime = b.publishedAt ?? DateTime(1970);
      return bTime.compareTo(aTime); // 降序：最新在前
    });
    return sorted;
  }

  @override
  List<Article> sortByTimeAsc(List<Article> articles) {
    final sorted = List<Article>.from(articles);
    sorted.sort((a, b) {
      final aTime = a.publishedAt ?? DateTime(1970);
      final bTime = b.publishedAt ?? DateTime(1970);
      return aTime.compareTo(bTime); // 升序：最早在前
    });
    return sorted;
  }

  @override
  List<Article> sortByUnreadFirst(List<Article> articles) {
    final sorted = List<Article>.from(articles);
    sorted.sort((a, b) {
      // 首先按已读状态排序（未读在前）
      if (a.isRead != b.isRead) {
        return a.isRead ? 1 : -1;
      }
      // 然后按时间倒序
      final aTime = a.publishedAt ?? DateTime(1970);
      final bTime = b.publishedAt ?? DateTime(1970);
      return bTime.compareTo(aTime);
    });
    return sorted;
  }

  @override
  List<Article> sortArticles(List<Article> articles, ArticleSortType sortType) {
    switch (sortType) {
      case ArticleSortType.timeDesc:
        return sortByTimeDesc(articles);
      case ArticleSortType.timeAsc:
        return sortByTimeAsc(articles);
      case ArticleSortType.unreadFirst:
        return sortByUnreadFirst(articles);
    }
  }
}
