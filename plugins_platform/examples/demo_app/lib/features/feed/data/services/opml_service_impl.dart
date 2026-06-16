import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/entities/opml.dart';
import 'package:rss_reader/features/feed/domain/services/opml_service.dart';
import 'package:uuid/uuid.dart';

/// OPML 服务实现类
class OPMLServiceImpl implements OPMLService {
  final Uuid _uuid;

  OPMLServiceImpl({Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  @override
  Either<Failure, List<OPMLFeed>> parseOPML(String content) {
    try {
      if (content.trim().isEmpty) {
        return const Left(Failure.parse(message: 'OPML 内容为空', source: 'OPML'));
      }

      if (!isValidOPML(content)) {
        return const Left(
          Failure.parse(message: '无效的 OPML 格式', source: 'OPML'),
        );
      }

      final document = OPMLDocument.fromXmlString(content);
      return Right(document.feeds);
    } on FormatException catch (e) {
      return Left(
        Failure.parse(
          message: '解析 OPML 失败: ${e.message}',
          source: 'OPML',
          details: e.toString(),
        ),
      );
    } catch (e) {
      return Left(
        Failure.parse(
          message: '解析 OPML 时发生错误',
          source: 'OPML',
          details: e.toString(),
        ),
      );
    }
  }

  @override
  Either<Failure, String> exportToOPML(
    List<Feed> feeds, {
    List<FeedCategory>? categories,
  }) {
    try {
      // 将 Feed 转换为 OPMLFeed
      final opmlFeeds = feeds.map((feed) {
        String? categoryName;
        if (feed.categoryId != null && categories != null) {
          final category = categories
              .where((c) => c.id == feed.categoryId)
              .firstOrNull;
          categoryName = category?.name;
        }

        return OPMLFeed(
          title: feed.title,
          xmlUrl: feed.url,
          htmlUrl: feed.link,
          description: feed.description,
          category: categoryName,
        );
      }).toList();

      final document = OPMLDocument(
        title: 'RSS Reader Export',
        dateCreated: DateTime.now(),
        feeds: opmlFeeds,
      );

      return Right(document.toXmlString());
    } catch (e) {
      return Left(
        Failure.parse(
          message: '导出 OPML 失败',
          source: 'OPML',
          details: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<OPMLFeed>>> importFromFile(File file) async {
    try {
      if (!await file.exists()) {
        return Left(
          Failure.file(message: '文件不存在', path: file.path, operation: 'read'),
        );
      }

      final content = await file.readAsString();
      return parseOPML(content);
    } on FileSystemException catch (e) {
      return Left(
        Failure.file(
          message: '读取文件失败: ${e.message}',
          path: file.path,
          operation: 'read',
        ),
      );
    } catch (e) {
      return Left(
        Failure.file(message: '导入文件时发生错误', path: file.path, operation: 'read'),
      );
    }
  }

  @override
  Future<Either<Failure, File>> exportToFile(
    List<Feed> feeds,
    String path, {
    List<FeedCategory>? categories,
  }) async {
    try {
      final exportResult = exportToOPML(feeds, categories: categories);

      return exportResult.fold((failure) => Left(failure), (opmlContent) async {
        final file = File(path);

        // 确保父目录存在
        final parentDir = file.parent;
        if (!await parentDir.exists()) {
          await parentDir.create(recursive: true);
        }

        await file.writeAsString(opmlContent);
        return Right(file);
      });
    } on FileSystemException catch (e) {
      return Left(
        Failure.file(
          message: '写入文件失败: ${e.message}',
          path: path,
          operation: 'write',
        ),
      );
    } catch (e) {
      return Left(
        Failure.file(message: '导出文件时发生错误', path: path, operation: 'write'),
      );
    }
  }

  @override
  List<Feed> convertToFeeds(List<OPMLFeed> opmlFeeds) {
    final now = DateTime.now();

    return opmlFeeds.where((f) => f.isValid).map((opmlFeed) {
      return Feed(
        id: _uuid.v4(),
        url: opmlFeed.xmlUrl,
        title: opmlFeed.title,
        description: opmlFeed.description,
        link: opmlFeed.htmlUrl,
        createdAt: now,
        updatedAt: now,
      );
    }).toList();
  }

  @override
  bool isValidOPML(String content) {
    if (content.trim().isEmpty) {
      return false;
    }

    final trimmed = content.trim().toLowerCase();

    // 检查是否包含 OPML 基本结构
    return trimmed.contains('<opml') &&
        trimmed.contains('</opml>') &&
        trimmed.contains('<body') &&
        trimmed.contains('</body>');
  }
}
