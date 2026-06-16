import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/database/daos/edited_article_dao.dart';
import 'package:rss_reader/core/database/database_provider.dart';
import 'package:rss_reader/features/article/data/services/article_editor_service_impl.dart';
import 'package:rss_reader/features/article/data/services/content_converter_impl.dart';
import 'package:rss_reader/features/article/domain/services/article_editor_service.dart';
import 'package:rss_reader/features/article/domain/services/content_converter.dart';

part 'article_editor_provider.g.dart';

/// EditedArticle DAO Provider
@riverpod
EditedArticleDao editedArticleDao(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return EditedArticleDao(database);
}

/// ContentConverter Provider
@riverpod
ContentConverter contentConverter(Ref ref) {
  return ContentConverterImpl();
}

/// ArticleEditorService Provider
@riverpod
ArticleEditorService articleEditorService(Ref ref) {
  final editedArticleDao = ref.watch(editedArticleDaoProvider);
  final articleDao = ref.watch(articleDaoProvider);
  final contentConverter = ref.watch(contentConverterProvider);

  return ArticleEditorServiceImpl(
    editedArticleDao: editedArticleDao,
    articleDao: articleDao,
    contentConverter: contentConverter,
  );
}
