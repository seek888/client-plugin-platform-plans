import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';

/// 文章编辑服务接口
abstract class ArticleEditorService {
  /// 加载文章内容到编辑器
  ///
  /// [articleId] - 文章 ID
  /// 返回 Delta 格式的内容，优先返回已编辑版本
  Future<Either<Failure, List<Map<String, dynamic>>>> loadContent(
      String articleId);

  /// 保存编辑后的内容
  ///
  /// [articleId] - 文章 ID
  /// [delta] - 编辑后的 Delta 内容
  Future<Either<Failure, Unit>> saveContent(
      String articleId, List<Map<String, dynamic>> delta);

  /// 丢弃编辑，恢复原始内容
  ///
  /// [articleId] - 文章 ID
  Future<Either<Failure, Unit>> discardChanges(String articleId);

  /// 检查文章是否有已编辑版本
  ///
  /// [articleId] - 文章 ID
  Future<bool> hasEditedVersion(String articleId);

  /// 获取原始 RSS 内容
  ///
  /// [articleId] - 文章 ID
  /// 返回原始 HTML 内容
  Future<Either<Failure, String>> getOriginalContent(String articleId);
}
