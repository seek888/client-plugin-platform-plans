import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';

/// 文章导航服务接口
abstract class ArticleNavigationService {
  /// 获取上一篇文章（同订阅源，发布时间更晚的）
  Future<Either<Failure, Article?>> getPreviousArticle(
    String currentArticleId,
    String feedId,
  );

  /// 获取下一篇文章（同订阅源，发布时间更早的）
  Future<Either<Failure, Article?>> getNextArticle(
    String currentArticleId,
    String feedId,
  );

  /// 检查是否有上一篇文章
  Future<Either<Failure, bool>> hasPreviousArticle(
    String currentArticleId,
    String feedId,
  );

  /// 检查是否有下一篇文章
  Future<Either<Failure, bool>> hasNextArticle(
    String currentArticleId,
    String feedId,
  );

  /// 获取当前文章在订阅源中的位置信息
  Future<Either<Failure, ArticlePosition>> getArticlePosition(
    String currentArticleId,
    String feedId,
  );
}

/// 文章位置信息
class ArticlePosition {
  /// 当前位置（从 1 开始）
  final int currentIndex;

  /// 总文章数
  final int totalCount;

  /// 是否有上一篇
  final bool hasPrevious;

  /// 是否有下一篇
  final bool hasNext;

  const ArticlePosition({
    required this.currentIndex,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
  });

  /// 是否是第一篇
  bool get isFirst => currentIndex == 1;

  /// 是否是最后一篇
  bool get isLast => currentIndex == totalCount;
}
