import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';

/// 数据源适配器接口
/// 定义统一的数据获取方法，不同数据源实现各自的适配器
abstract class DataSourceAdapter {
  /// 获取数据源类型
  SourceType get sourceType;

  /// 获取 Feed 元数据
  ///
  /// 返回解析后的 Feed 信息（标题、描述、图标等）
  Future<Either<Failure, ParsedFeed>> fetchFeedMetadata();

  /// 获取文章列表（支持分页）
  ///
  /// [page] 页码（从 1 开始）
  /// [pageSize] 每页数量
  /// [since] 只获取此时间之后的文章（用于增量刷新）
  Future<Either<Failure, ArticleListResult>> fetchArticles({
    int page = 1,
    int pageSize = 20,
    DateTime? since,
  });

  /// 获取文章详情
  ///
  /// [articleId] 文章唯一标识符
  Future<Either<Failure, ParsedArticle>> fetchArticleDetail(String articleId);

  /// 验证数据源连接
  ///
  /// 返回 true 表示连接有效，false 表示连接无效
  Future<Either<Failure, bool>> validateConnection();

  /// 释放资源
  ///
  /// 在适配器不再使用时调用，用于清理 HTTP 客户端等资源
  void dispose();
}

/// 数据源适配器工厂
/// 根据数据源配置创建对应的适配器实例
abstract class DataSourceAdapterFactory {
  /// 创建数据源适配器
  ///
  /// [config] 数据源配置
  DataSourceAdapter createAdapter(DataSourceConfig config);
}
