import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';

/// 文章收藏服务接口
abstract class ArticleFavoriteService {
  /// 收藏文章
  Future<Either<Failure, void>> addToFavorites(String articleId);

  /// 取消收藏
  Future<Either<Failure, void>> removeFromFavorites(String articleId);

  /// 切换收藏状态
  /// 返回新的收藏状态（true = 已收藏，false = 未收藏）
  Future<Either<Failure, bool>> toggleFavorite(String articleId);

  /// 检查文章是否已收藏
  Future<Either<Failure, bool>> isFavorite(String articleId);

  /// 获取收藏文章列表
  Future<Either<Failure, List<Article>>> getFavoriteArticles({
    int page = 1,
    int pageSize = 20,
  });

  /// 获取收藏文章数量
  Future<Either<Failure, int>> getFavoriteCount();

  /// 移动文章到收藏夹
  Future<Either<Failure, void>> moveToFolder(
    String articleId,
    String? folderId,
  );
}
