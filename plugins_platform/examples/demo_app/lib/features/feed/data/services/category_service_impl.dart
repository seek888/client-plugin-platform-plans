import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/category_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/services/category_service.dart';
import 'package:uuid/uuid.dart';

/// 分类服务实现
class CategoryServiceImpl implements CategoryService {
  final CategoryDao _categoryDao;
  final FeedDao _feedDao;
  final Uuid _uuid;

  CategoryServiceImpl({
    required CategoryDao categoryDao,
    required FeedDao feedDao,
    Uuid? uuid,
  }) : _categoryDao = categoryDao,
       _feedDao = feedDao,
       _uuid = uuid ?? const Uuid();

  @override
  Future<Either<Failure, List<FeedCategory>>> getAllCategories() async {
    try {
      final categoriesData = await _categoryDao.getAllCategories();
      final categories = categoriesData
          .map(_mapCategoriesTableDataToCategory)
          .toList();
      return Right(categories);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取分类列表失败',
          table: 'categories',
          operation: 'getAllCategories',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FeedCategory>> getCategoryById(
    String categoryId,
  ) async {
    try {
      final categoryData = await _categoryDao.getCategoryById(categoryId);
      if (categoryData == null) {
        return Left(
          Failure.database(
            message: '分类不存在',
            table: 'categories',
            operation: 'getCategoryById',
          ),
        );
      }
      return Right(_mapCategoriesTableDataToCategory(categoryData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取分类失败',
          table: 'categories',
          operation: 'getCategoryById',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FeedCategory>> createCategory(String name) async {
    try {
      // 验证名称
      if (name.trim().isEmpty) {
        return Left(
          Failure.validation(message: '分类名称不能为空', field: 'name', value: name),
        );
      }

      // 检查是否已存在同名分类
      final existingCategories = await _categoryDao.getAllCategories();
      final exists = existingCategories.any(
        (c) => c.name.toLowerCase() == name.trim().toLowerCase(),
      );
      if (exists) {
        return Left(
          Failure.validation(message: '该分类名称已存在', field: 'name', value: name),
        );
      }

      final categoryId = _uuid.v4();
      final now = DateTime.now();

      // 获取当前最大排序值
      final maxSortOrder = existingCategories.isEmpty
          ? 0
          : existingCategories
                .map((c) => c.sortOrder)
                .reduce((a, b) => a > b ? a : b);

      final companion = CategoriesTableCompanion(
        id: Value(categoryId),
        name: Value(name.trim()),
        sortOrder: Value(maxSortOrder + 1),
        createdAt: Value(now),
        updatedAt: Value(now),
      );

      await _categoryDao.insertCategory(companion);

      final categoryData = await _categoryDao.getCategoryById(categoryId);
      if (categoryData == null) {
        return Left(
          Failure.database(
            message: '创建分类失败',
            table: 'categories',
            operation: 'createCategory',
          ),
        );
      }
      return Right(_mapCategoriesTableDataToCategory(categoryData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '创建分类失败',
          table: 'categories',
          operation: 'createCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FeedCategory>> renameCategory(
    String categoryId,
    String newName,
  ) async {
    try {
      // 验证名称
      if (newName.trim().isEmpty) {
        return Left(
          Failure.validation(
            message: '分类名称不能为空',
            field: 'name',
            value: newName,
          ),
        );
      }

      // 检查分类是否存在
      final categoryData = await _categoryDao.getCategoryById(categoryId);
      if (categoryData == null) {
        return Left(
          Failure.database(
            message: '分类不存在',
            table: 'categories',
            operation: 'renameCategory',
          ),
        );
      }

      // 检查是否已存在同名分类（排除自己）
      final existingCategories = await _categoryDao.getAllCategories();
      final exists = existingCategories.any(
        (c) =>
            c.id != categoryId &&
            c.name.toLowerCase() == newName.trim().toLowerCase(),
      );
      if (exists) {
        return Left(
          Failure.validation(
            message: '该分类名称已存在',
            field: 'name',
            value: newName,
          ),
        );
      }

      final companion = CategoriesTableCompanion(
        id: Value(categoryId),
        name: Value(newName.trim()),
        description: Value(categoryData.description),
        sortOrder: Value(categoryData.sortOrder),
        isExpanded: Value(categoryData.isExpanded),
        updatedAt: Value(DateTime.now()),
      );

      await _categoryDao.updateCategory(companion);

      final updatedData = await _categoryDao.getCategoryById(categoryId);
      if (updatedData == null) {
        return Left(
          Failure.database(
            message: '重命名分类失败',
            table: 'categories',
            operation: 'renameCategory',
          ),
        );
      }
      return Right(_mapCategoriesTableDataToCategory(updatedData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '重命名分类失败',
          table: 'categories',
          operation: 'renameCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String categoryId) async {
    try {
      // 将该分类下的订阅源移到未分类
      final feeds = await _feedDao.getFeedsByCategory(categoryId);
      for (final feed in feeds) {
        await _feedDao.updateFeed(
          FeedsTableCompanion(
            id: Value(feed.id),
            url: Value(feed.url),
            title: Value(feed.title),
            categoryId: const Value(null),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      // 删除分类
      await _categoryDao.deleteCategory(categoryId);

      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '删除分类失败',
          table: 'categories',
          operation: 'deleteCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Feed>>> getFeedsByCategory(
    String? categoryId,
  ) async {
    try {
      final feedsData = await _feedDao.getFeedsByCategory(categoryId);
      final feeds = feedsData.map(_mapFeedsTableDataToFeed).toList();
      return Right(feeds);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取分类下的订阅源失败',
          table: 'feeds',
          operation: 'getFeedsByCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> moveFeedToCategory(
    String feedId,
    String? categoryId,
  ) async {
    try {
      final feedData = await _feedDao.getFeedById(feedId);
      if (feedData == null) {
        return Left(
          Failure.database(
            message: '订阅源不存在',
            table: 'feeds',
            operation: 'moveFeedToCategory',
          ),
        );
      }

      // 如果指定了分类，检查分类是否存在
      if (categoryId != null) {
        final categoryData = await _categoryDao.getCategoryById(categoryId);
        if (categoryData == null) {
          return Left(
            Failure.database(
              message: '分类不存在',
              table: 'categories',
              operation: 'moveFeedToCategory',
            ),
          );
        }
      }

      await _feedDao.updateFeed(
        FeedsTableCompanion(
          id: Value(feedId),
          url: Value(feedData.url),
          title: Value(feedData.title),
          categoryId: Value(categoryId),
          updatedAt: Value(DateTime.now()),
        ),
      );

      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '移动订阅源失败',
          table: 'feeds',
          operation: 'moveFeedToCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> moveFeedsToCategory(
    List<String> feedIds,
    String? categoryId,
  ) async {
    try {
      // 如果指定了分类，检查分类是否存在
      if (categoryId != null) {
        final categoryData = await _categoryDao.getCategoryById(categoryId);
        if (categoryData == null) {
          return Left(
            Failure.database(
              message: '分类不存在',
              table: 'categories',
              operation: 'moveFeedsToCategory',
            ),
          );
        }
      }

      for (final feedId in feedIds) {
        final feedData = await _feedDao.getFeedById(feedId);
        if (feedData != null) {
          await _feedDao.updateFeed(
            FeedsTableCompanion(
              id: Value(feedId),
              url: Value(feedData.url),
              title: Value(feedData.title),
              categoryId: Value(categoryId),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '批量移动订阅源失败',
          table: 'feeds',
          operation: 'moveFeedsToCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> reorderCategories(
    List<String> categoryIds,
  ) async {
    try {
      await _categoryDao.updateSortOrders(categoryIds);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '重排序分类失败',
          table: 'categories',
          operation: 'reorderCategories',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FeedCategory>> toggleCategoryExpanded(
    String categoryId,
  ) async {
    try {
      final categoryData = await _categoryDao.getCategoryById(categoryId);
      if (categoryData == null) {
        return Left(
          Failure.database(
            message: '分类不存在',
            table: 'categories',
            operation: 'toggleCategoryExpanded',
          ),
        );
      }

      final companion = CategoriesTableCompanion(
        id: Value(categoryId),
        name: Value(categoryData.name),
        description: Value(categoryData.description),
        sortOrder: Value(categoryData.sortOrder),
        isExpanded: Value(!categoryData.isExpanded),
        updatedAt: Value(DateTime.now()),
      );

      await _categoryDao.updateCategory(companion);

      final updatedData = await _categoryDao.getCategoryById(categoryId);
      if (updatedData == null) {
        return Left(
          Failure.database(
            message: '切换分类展开状态失败',
            table: 'categories',
            operation: 'toggleCategoryExpanded',
          ),
        );
      }
      return Right(_mapCategoriesTableDataToCategory(updatedData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '切换分类展开状态失败',
          table: 'categories',
          operation: 'toggleCategoryExpanded',
        ),
      );
    }
  }

  @override
  Stream<List<FeedCategory>> watchAllCategories() {
    return _categoryDao.watchAllCategories().map(
      (categoriesData) =>
          categoriesData.map(_mapCategoriesTableDataToCategory).toList(),
    );
  }

  // ========== 私有方法 ==========

  /// 将数据库数据映射为 FeedCategory 实体
  FeedCategory _mapCategoriesTableDataToCategory(CategoriesTableData data) {
    return FeedCategory(
      id: data.id,
      name: data.name,
      description: data.description,
      sortOrder: data.sortOrder,
      isExpanded: data.isExpanded,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  /// 将数据库数据映射为 Feed 实体
  Feed _mapFeedsTableDataToFeed(FeedsTableData data) {
    return Feed(
      id: data.id,
      url: data.url,
      title: data.title,
      description: data.description,
      iconUrl: data.iconUrl,
      link: data.link,
      categoryId: data.categoryId,
      sortOrder: data.sortOrder,
      unreadCount: data.unreadCount,
      lastUpdated: data.lastUpdated,
      lastFetched: data.lastFetched,
      isEnabled: data.isEnabled,
      isBlocked: data.isBlocked,
      healthStatus: data.healthStatus,
      failureCount: data.failureCount,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
