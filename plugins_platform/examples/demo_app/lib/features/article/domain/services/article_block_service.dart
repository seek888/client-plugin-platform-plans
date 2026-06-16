import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';

/// 文章屏蔽服务接口
abstract class ArticleBlockService {
  /// 屏蔽文章
  Future<Either<Failure, void>> blockArticle(String articleId);

  /// 检查文章是否被屏蔽
  Future<Either<Failure, bool>> isBlocked(String articleId);

  /// 获取未屏蔽的文章列表
  Future<Either<Failure, List<Article>>> getUnblockedArticles({
    String? feedId,
    int page = 1,
    int pageSize = 20,
  });

  /// 获取未屏蔽的文章数量
  Future<Either<Failure, int>> getUnblockedCount({String? feedId});
}
