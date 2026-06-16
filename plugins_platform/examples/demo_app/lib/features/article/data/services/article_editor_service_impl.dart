import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/edited_article_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/features/article/domain/services/article_editor_service.dart';
import 'package:rss_reader/features/article/domain/services/content_converter.dart';

final _log = logger.tag('ArticleEditorServiceImpl');

/// ArticleEditorService 接口实现
class ArticleEditorServiceImpl implements ArticleEditorService {
  final EditedArticleDao _editedArticleDao;
  final ArticleDao _articleDao;
  final ContentConverter _contentConverter;

  ArticleEditorServiceImpl({
    required EditedArticleDao editedArticleDao,
    required ArticleDao articleDao,
    required ContentConverter contentConverter,
  })  : _editedArticleDao = editedArticleDao,
        _articleDao = articleDao,
        _contentConverter = contentConverter;

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> loadContent(
      String articleId) async {
    try {
      // 如果是新建笔记（空 articleId），返回空文档
      if (articleId.isEmpty) {
        _log.debug('新建笔记，返回空文档');
        return Right([
          {'insert': '\n'}
        ]);
      }

      // 首先检查是否有已编辑版本
      final editedContent =
          await _editedArticleDao.getEditedContent(articleId);

      if (editedContent != null) {
        // 返回已编辑的 Delta 内容
        _log.debug('加载已编辑内容: $articleId');
        final deltaJson =
            List<Map<String, dynamic>>.from(jsonDecode(editedContent.deltaJson));
        return Right(deltaJson);
      }

      // 没有编辑版本，加载原始内容并转换
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(Failure.editorLoad(
          message: '文章不存在',
          articleId: articleId,
        ));
      }

      final htmlContent = article.content ?? article.summary ?? '';
      _log.debug('加载原始内容并转换: $articleId');

      return _contentConverter.htmlToDelta(htmlContent);
    } catch (e, stackTrace) {
      _log.error('加载内容失败', error: e, stackTrace: stackTrace);
      return Left(Failure.editorLoad(
        message: '加载内容失败: ${e.toString()}',
        articleId: articleId,
      ));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveContent(
      String articleId, List<Map<String, dynamic>> delta) async {
    try {
      // 将 Delta 转换为 HTML
      final htmlResult = _contentConverter.deltaToHtml(delta);

      return htmlResult.fold(
        (failure) => Left(failure),
        (htmlContent) async {
          // 提取摘要
          final summary = _contentConverter.extractSummary(delta);

          // 序列化 Delta 为 JSON 字符串
          final deltaJson = jsonEncode(delta);

          // 保存到数据库
          await _editedArticleDao.saveEditedContent(
            EditedArticlesTableCompanion(
              articleId: Value(articleId),
              deltaJson: Value(deltaJson),
              htmlContent: Value(htmlContent),
              summary: Value(summary),
              editedAt: Value(DateTime.now()),
            ),
          );

          _log.info('保存编辑内容成功: $articleId');
          return const Right(unit);
        },
      );
    } catch (e, stackTrace) {
      _log.error('保存内容失败', error: e, stackTrace: stackTrace);
      return Left(Failure.editorSave(
        message: '保存失败: ${e.toString()}',
        articleId: articleId,
      ));
    }
  }

  @override
  Future<Either<Failure, Unit>> discardChanges(String articleId) async {
    try {
      await _editedArticleDao.deleteEditedContent(articleId);
      _log.info('丢弃编辑内容: $articleId');
      return const Right(unit);
    } catch (e, stackTrace) {
      _log.error('丢弃内容失败', error: e, stackTrace: stackTrace);
      return Left(Failure.editorSave(
        message: '丢弃失败: ${e.toString()}',
        articleId: articleId,
      ));
    }
  }

  @override
  Future<bool> hasEditedVersion(String articleId) async {
    return _editedArticleDao.hasEditedVersion(articleId);
  }

  @override
  Future<Either<Failure, String>> getOriginalContent(String articleId) async {
    try {
      final article = await _articleDao.getArticleById(articleId);
      if (article == null) {
        return Left(Failure.editorLoad(
          message: '文章不存在',
          articleId: articleId,
        ));
      }

      return Right(article.content ?? article.summary ?? '');
    } catch (e, stackTrace) {
      _log.error('获取原始内容失败', error: e, stackTrace: stackTrace);
      return Left(Failure.editorLoad(
        message: '获取原始内容失败: ${e.toString()}',
        articleId: articleId,
      ));
    }
  }
}
