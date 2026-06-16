import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/entities/opml.dart';

/// OPML 服务接口
/// 负责 OPML 文件的导入导出功能
abstract class OPMLService {
  /// 解析 OPML 内容字符串
  ///
  /// [content] OPML XML 格式的字符串内容
  /// 返回解析后的 [OPMLFeed] 列表，或解析失败时返回 [Failure]
  Either<Failure, List<OPMLFeed>> parseOPML(String content);

  /// 将订阅源列表导出为 OPML 格式字符串
  ///
  /// [feeds] 要导出的订阅源列表
  /// [categories] 可选的分类列表，用于组织订阅源
  /// 返回 OPML XML 格式的字符串，或导出失败时返回 [Failure]
  Either<Failure, String> exportToOPML(
    List<Feed> feeds, {
    List<FeedCategory>? categories,
  });

  /// 从文件导入 OPML
  ///
  /// [file] OPML 文件
  /// 返回解析后的 [OPMLFeed] 列表，或导入失败时返回 [Failure]
  Future<Either<Failure, List<OPMLFeed>>> importFromFile(File file);

  /// 导出订阅源到文件
  ///
  /// [feeds] 要导出的订阅源列表
  /// [path] 导出文件路径
  /// [categories] 可选的分类列表
  /// 返回导出的文件，或导出失败时返回 [Failure]
  Future<Either<Failure, File>> exportToFile(
    List<Feed> feeds,
    String path, {
    List<FeedCategory>? categories,
  });

  /// 将 OPMLFeed 列表转换为 Feed 列表
  ///
  /// [opmlFeeds] OPML 订阅源列表
  /// 返回转换后的 [Feed] 列表
  List<Feed> convertToFeeds(List<OPMLFeed> opmlFeeds);

  /// 验证 OPML 内容是否有效
  ///
  /// [content] OPML XML 格式的字符串内容
  /// 返回是否有效
  bool isValidOPML(String content);
}
