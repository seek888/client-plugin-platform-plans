import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

/// 分类服务接口
abstract class CategoryService {
  /// 获取所有分类
  Future<Either<Failure, List<FeedCategory>>> getAllCategories();

  /// 根据 ID 获取分类
  Future<Either<Failure, FeedCategory>> getCategoryById(String categoryId);

  /// 创建分类
  Future<Either<Failure, FeedCategory>> createCategory(String name);

  /// 重命名分类
  Future<Either<Failure, FeedCategory>> renameCategory(
    String categoryId,
    String newName,
  );

  /// 删除分类
  Future<Either<Failure, void>> deleteCategory(String categoryId);

  /// 获取分类下的订阅源
  Future<Either<Failure, List<Feed>>> getFeedsByCategory(String? categoryId);

  /// 移动订阅源到分类
  Future<Either<Failure, void>> moveFeedToCategory(
    String feedId,
    String? categoryId,
  );

  /// 批量移动订阅源到分类
  Future<Either<Failure, void>> moveFeedsToCategory(
    List<String> feedIds,
    String? categoryId,
  );

  /// 重排序分类
  Future<Either<Failure, void>> reorderCategories(List<String> categoryIds);

  /// 切换分类展开/折叠状态
  Future<Either<Failure, FeedCategory>> toggleCategoryExpanded(
    String categoryId,
  );

  /// 监听所有分类变化
  Stream<List<FeedCategory>> watchAllCategories();
}
