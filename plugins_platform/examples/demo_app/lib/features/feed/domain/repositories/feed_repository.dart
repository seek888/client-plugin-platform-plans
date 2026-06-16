import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';

/// 订阅源验证结果
class FeedValidationResult {
  final bool isValid;
  final String? feedTitle;
  final String? feedDescription;
  final String? iconUrl;
  final String? errorMessage;
  final FeedType feedType;
  final SourceType sourceType;

  const FeedValidationResult({
    required this.isValid,
    this.feedTitle,
    this.feedDescription,
    this.iconUrl,
    this.errorMessage,
    this.feedType = FeedType.unknown,
    this.sourceType = SourceType.rss,
  });

  factory FeedValidationResult.success({
    required String feedTitle,
    String? feedDescription,
    String? iconUrl,
    required FeedType feedType,
    SourceType sourceType = SourceType.rss,
  }) {
    return FeedValidationResult(
      isValid: true,
      feedTitle: feedTitle,
      feedDescription: feedDescription,
      iconUrl: iconUrl,
      feedType: feedType,
      sourceType: sourceType,
    );
  }

  factory FeedValidationResult.failure(String errorMessage) {
    return FeedValidationResult(isValid: false, errorMessage: errorMessage);
  }
}

/// 刷新结果
class RefreshResult {
  final int totalFeeds;
  final int successCount;
  final int failedCount;
  final int newArticleCount;
  final List<FeedRefreshError> errors;

  const RefreshResult({
    required this.totalFeeds,
    required this.successCount,
    required this.failedCount,
    required this.newArticleCount,
    this.errors = const [],
  });
}

/// 订阅源刷新错误
class FeedRefreshError {
  final String feedId;
  final String feedTitle;
  final String errorMessage;

  const FeedRefreshError({
    required this.feedId,
    required this.feedTitle,
    required this.errorMessage,
  });
}

/// 订阅源仓库接口
abstract class FeedRepository {
  /// 获取所有订阅源
  Future<Either<Failure, List<Feed>>> getAllFeeds();

  /// 根据 ID 获取订阅源
  Future<Either<Failure, Feed>> getFeedById(String feedId);

  /// 添加 RSS 订阅源
  Future<Either<Failure, Feed>> addFeed(String url);

  /// 添加 API 数据源
  ///
  /// [title] 数据源标题
  /// [apiConfig] API 配置
  Future<Either<Failure, Feed>> addApiFeed({
    required String title,
    required ApiSourceConfig apiConfig,
    String? description,
    String? iconUrl,
    String? categoryId,
  });

  /// 删除订阅源
  Future<Either<Failure, void>> deleteFeed(String feedId);

  /// 更新订阅源
  Future<Either<Failure, Feed>> updateFeed(Feed feed);

  /// 验证订阅源 URL（RSS）
  Future<Either<Failure, FeedValidationResult>> validateFeedUrl(String url);

  /// 验证 API 数据源配置
  Future<Either<Failure, FeedValidationResult>> validateApiSource(
    ApiSourceConfig config,
  );

  /// 刷新单个订阅源内容
  Future<Either<Failure, int>> refreshFeed(String feedId);

  /// 批量刷新所有订阅源
  Future<Either<Failure, RefreshResult>> refreshAllFeeds();

  /// 获取订阅源分类
  Future<Either<Failure, List<FeedCategory>>> getCategories();

  /// 创建分类
  Future<Either<Failure, FeedCategory>> createCategory(String name);

  /// 更新分类
  Future<Either<Failure, FeedCategory>> updateCategory(FeedCategory category);

  /// 删除分类
  Future<Either<Failure, void>> deleteCategory(String categoryId);

  /// 移动订阅源到分类
  Future<Either<Failure, void>> moveFeedToCategory(
    String feedId,
    String? categoryId,
  );

  /// 重排序订阅源
  Future<Either<Failure, void>> reorderFeeds(List<String> feedIds);

  /// 重排序分类
  Future<Either<Failure, void>> reorderCategories(List<String> categoryIds);

  /// 监听所有订阅源变化
  Stream<List<Feed>> watchAllFeeds();

  /// 监听所有分类变化
  Stream<List<FeedCategory>> watchAllCategories();
}
