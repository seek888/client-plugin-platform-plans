import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/tables/categories_table.dart';

part 'category_dao.g.dart';

/// 分类数据访问对象
@DriftAccessor(tables: [CategoriesTable, FavoriteFoldersTable])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  /// 获取所有分类
  Future<List<CategoriesTableData>> getAllCategories() {
    return (select(
      categoriesTable,
    )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get();
  }

  /// 根据 ID 获取分类
  Future<CategoriesTableData?> getCategoryById(String id) {
    return (select(
      categoriesTable,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// 插入分类
  Future<int> insertCategory(CategoriesTableCompanion category) {
    return into(categoriesTable).insert(category);
  }

  /// 更新分类
  Future<bool> updateCategory(CategoriesTableCompanion category) {
    return update(categoriesTable).replace(category);
  }

  /// 删除分类
  Future<int> deleteCategory(String id) {
    return (delete(categoriesTable)..where((t) => t.id.equals(id))).go();
  }

  /// 更新排序顺序
  Future<void> updateSortOrders(List<String> categoryIds) async {
    await transaction(() async {
      for (var i = 0; i < categoryIds.length; i++) {
        await (update(categoriesTable)
              ..where((t) => t.id.equals(categoryIds[i])))
            .write(CategoriesTableCompanion(sortOrder: Value(i)));
      }
    });
  }

  /// 监听所有分类变化
  Stream<List<CategoriesTableData>> watchAllCategories() {
    return (select(
      categoriesTable,
    )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).watch();
  }

  // ========== 收藏夹相关 ==========

  /// 获取所有收藏夹
  Future<List<FavoriteFoldersTableData>> getAllFavoriteFolders() {
    return (select(
      favoriteFoldersTable,
    )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get();
  }

  /// 插入收藏夹
  Future<int> insertFavoriteFolder(FavoriteFoldersTableCompanion folder) {
    return into(favoriteFoldersTable).insert(folder);
  }

  /// 删除收藏夹
  Future<int> deleteFavoriteFolder(String id) {
    return (delete(favoriteFoldersTable)..where((t) => t.id.equals(id))).go();
  }
}
