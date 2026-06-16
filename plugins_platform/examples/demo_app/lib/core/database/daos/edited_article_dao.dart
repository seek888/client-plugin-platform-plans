import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/tables/edited_articles_table.dart';

part 'edited_article_dao.g.dart';

/// 已编辑文章数据访问对象
@DriftAccessor(tables: [EditedArticlesTable])
class EditedArticleDao extends DatabaseAccessor<AppDatabase>
    with _$EditedArticleDaoMixin {
  EditedArticleDao(super.db);

  /// 根据文章 ID 获取已编辑内容
  Future<EditedArticlesTableData?> getEditedContent(String articleId) {
    return (select(editedArticlesTable)
          ..where((t) => t.articleId.equals(articleId)))
        .getSingleOrNull();
  }

  /// 保存或更新已编辑内容
  Future<int> saveEditedContent(EditedArticlesTableCompanion content) {
    return into(editedArticlesTable).insert(
      content,
      mode: InsertMode.insertOrReplace,
    );
  }

  /// 删除已编辑内容（恢复原始内容）
  Future<int> deleteEditedContent(String articleId) {
    return (delete(editedArticlesTable)
          ..where((t) => t.articleId.equals(articleId)))
        .go();
  }

  /// 检查文章是否有已编辑版本
  Future<bool> hasEditedVersion(String articleId) async {
    final result = await (select(editedArticlesTable)
          ..where((t) => t.articleId.equals(articleId)))
        .getSingleOrNull();
    return result != null;
  }

  /// 获取所有已编辑文章的 ID 列表
  Future<List<String>> getAllEditedArticleIds() async {
    final results = await select(editedArticlesTable).get();
    return results.map((e) => e.articleId).toList();
  }

  /// 监听已编辑内容变化
  Stream<EditedArticlesTableData?> watchEditedContent(String articleId) {
    return (select(editedArticlesTable)
          ..where((t) => t.articleId.equals(articleId)))
        .watchSingleOrNull();
  }

  /// 批量删除已编辑内容
  Future<int> deleteEditedContentByIds(List<String> articleIds) {
    return (delete(editedArticlesTable)
          ..where((t) => t.articleId.isIn(articleIds)))
        .go();
  }

  /// 获取已编辑文章数量
  Future<int> getEditedCount() async {
    final count = editedArticlesTable.articleId.count();
    final query = selectOnly(editedArticlesTable)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }
}
