import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/category_dao.dart';
import 'package:rss_reader/core/database/daos/annotation_dao.dart';

/// 数据库实例 Provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});

/// Feed DAO Provider
final feedDaoProvider = Provider<FeedDao>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return FeedDao(database);
});

/// Article DAO Provider
final articleDaoProvider = Provider<ArticleDao>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return ArticleDao(database);
});

/// Category DAO Provider
final categoryDaoProvider = Provider<CategoryDao>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return CategoryDao(database);
});

/// Annotation DAO Provider
final annotationDaoProvider = Provider<AnnotationDao>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return AnnotationDao(database);
});
