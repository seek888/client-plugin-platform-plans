import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/article_dao.dart';
import 'package:rss_reader/core/database/daos/category_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/core/services/rss_parser_service.dart';
import 'package:rss_reader/features/feed/data/services/data_source_manager.dart';
import 'package:rss_reader/features/feed/data/services/plugin_feed_discovery_service.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';
import 'package:rss_reader/features/feed/domain/repositories/feed_repository.dart';
import 'package:uuid/uuid.dart';

final _log = logger.tag(LogTags.feed);

/// 订阅源仓库实现
class FeedRepositoryImpl implements FeedRepository {
  final FeedDao _feedDao;
  final CategoryDao _categoryDao;
  final ArticleDao _articleDao;
  final RssParserService _rssParserService;
  final DataSourceManager? _dataSourceManager;
  final PluginFeedDiscoveryService? _pluginFeedDiscoveryService;
  final Uuid _uuid;

  FeedRepositoryImpl({
    required FeedDao feedDao,
    required CategoryDao categoryDao,
    required ArticleDao articleDao,
    required RssParserService rssParserService,
    DataSourceManager? dataSourceManager,
    PluginFeedDiscoveryService? pluginFeedDiscoveryService,
    Uuid? uuid,
  })  : _feedDao = feedDao,
        _categoryDao = categoryDao,
        _articleDao = articleDao,
        _rssParserService = rssParserService,
        _dataSourceManager = dataSourceManager,
        _pluginFeedDiscoveryService = pluginFeedDiscoveryService,
        _uuid = uuid ?? const Uuid();

  @override
  Future<Either<Failure, List<Feed>>> getAllFeeds() async {
    try {
      await _pluginFeedDiscoveryService?.syncDiscoveredFeeds();
      final feedsData = await _feedDao.getAllFeeds();
      final feeds = feedsData.map(_mapFeedsTableDataToFeed).toList();
      return Right(feeds);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取订阅源列表失败',
          table: 'feeds',
          operation: 'getAllFeeds',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Feed>> getFeedById(String feedId) async {
    try {
      final feedData = await _feedDao.getFeedById(feedId);
      if (feedData == null) {
        return Left(
          Failure.database(
            message: '订阅源不存在',
            table: 'feeds',
            operation: 'getFeedById',
          ),
        );
      }
      return Right(_mapFeedsTableDataToFeed(feedData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取订阅源失败',
          table: 'feeds',
          operation: 'getFeedById',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Feed>> addFeed(String url) async {
    _log.info('添加订阅源: $url');
    try {
      // 1. 验证 URL
      final validationResult = await validateFeedUrl(url);
      return validationResult.fold((failure) => Left(failure), (result) async {
        if (!result.isValid) {
          _log.warning('订阅源验证失败: $url, ${result.errorMessage}');
          return Left(
            Failure.validation(
              message: result.errorMessage ?? '无效的订阅源',
              field: 'url',
              value: url,
            ),
          );
        }

        // 2. 检查是否已存在
        final existingFeeds = await _feedDao.getAllFeeds();
        final exists = existingFeeds.any((f) => f.url == url);
        if (exists) {
          _log.warning('订阅源已存在: $url');
          return Left(
            Failure.validation(message: '该订阅源已存在', field: 'url', value: url),
          );
        }

        // 3. 创建新订阅源
        final feedId = _uuid.v4();
        final now = DateTime.now();
        final companion = FeedsTableCompanion(
          id: Value(feedId),
          url: Value(url),
          title: Value(result.feedTitle ?? 'Unknown'),
          description: Value(result.feedDescription),
          iconUrl: Value(result.iconUrl),
          createdAt: Value(now),
          updatedAt: Value(now),
        );

        await _feedDao.insertFeed(companion);
        _log.debug('订阅源已保存到数据库: $feedId');

        // 4. 获取并保存文章
        await _fetchAndSaveArticles(feedId, url);

        // 5. 返回新创建的订阅源
        final feedData = await _feedDao.getFeedById(feedId);
        if (feedData == null) {
          return Left(
            Failure.database(
              message: '创建订阅源失败',
              table: 'feeds',
              operation: 'addFeed',
            ),
          );
        }
        _log.info('订阅源添加成功: ${result.feedTitle}');
        return Right(_mapFeedsTableDataToFeed(feedData));
      });
    } catch (e, stackTrace) {
      _log.error('添加订阅源失败: $url', error: e, stackTrace: stackTrace);
      return Left(
        Failure.database(
          message: '添加订阅源失败: ${e.toString()}',
          table: 'feeds',
          operation: 'addFeed',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Feed>> addApiFeed({
    required String title,
    required ApiSourceConfig apiConfig,
    String? description,
    String? iconUrl,
    String? categoryId,
  }) async {
    _log.info('添加 API 数据源: $title');
    try {
      // 1. 验证 API 配置
      final validationResult = await validateApiSource(apiConfig);
      return validationResult.fold((failure) => Left(failure), (result) async {
        if (!result.isValid) {
          _log.warning('API 数据源验证失败: $title, ${result.errorMessage}');
          return Left(
            Failure.validation(
              message: result.errorMessage ?? '无效的 API 配置',
              field: 'apiConfig',
            ),
          );
        }

        // 2. 检查是否已存在（通过 baseUrl 判断）
        final existingFeeds = await _feedDao.getAllFeeds();
        final exists = existingFeeds.any(
          (f) => f.sourceType == 'api' && f.apiBaseUrl == apiConfig.baseUrl,
        );
        if (exists) {
          _log.warning('API 数据源已存在: ${apiConfig.baseUrl}');
          return Left(
            Failure.validation(
              message: '该 API 数据源已存在',
              field: 'apiConfig',
            ),
          );
        }

        // 3. 序列化 customHeaders
        String? apiHeadersJson;
        if (apiConfig.customHeaders.isNotEmpty) {
          apiHeadersJson = jsonEncode(apiConfig.customHeaders);
        }

        // 4. 创建新数据源
        final feedId = _uuid.v4();
        final now = DateTime.now();
        final companion = FeedsTableCompanion(
          id: Value(feedId),
          url: Value(apiConfig.baseUrl),
          title: Value(result.feedTitle ?? title),
          description: Value(result.feedDescription ?? description),
          iconUrl: Value(result.iconUrl ?? iconUrl),
          categoryId: Value(categoryId),
          sourceType: const Value('api'),
          apiBaseUrl: Value(apiConfig.baseUrl),
          apiKey: Value(apiConfig.apiKey),
          apiHeaders: Value(apiHeadersJson),
          apiRemoteFeedId: Value(apiConfig.remoteFeedId),
          apiTimeout: Value(apiConfig.timeout.inSeconds),
          apiMaxRetries: Value(apiConfig.maxRetries),
          createdAt: Value(now),
          updatedAt: Value(now),
        );

        await _feedDao.insertFeed(companion);
        _log.debug('API 数据源已保存到数据库: $feedId');

        // 5. 获取并保存文章
        final feedData = await _feedDao.getFeedById(feedId);
        if (feedData == null) {
          return Left(
            Failure.database(
              message: '创建 API 数据源失败',
              table: 'feeds',
              operation: 'addApiFeed',
            ),
          );
        }

        final feed = _mapFeedsTableDataToFeed(feedData);
        await _fetchAndSaveArticlesForFeed(feed);

        // 6. 重新获取更新后的数据
        final updatedFeedData = await _feedDao.getFeedById(feedId);
        _log.info('API 数据源添加成功: $title');
        return Right(_mapFeedsTableDataToFeed(updatedFeedData!));
      });
    } catch (e, stackTrace) {
      _log.error('添加 API 数据源失败: $title', error: e, stackTrace: stackTrace);
      return Left(
        Failure.database(
          message: '添加 API 数据源失败: ${e.toString()}',
          table: 'feeds',
          operation: 'addApiFeed',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FeedValidationResult>> validateApiSource(
    ApiSourceConfig config,
  ) async {
    _log.debug('验证 API 数据源: ${config.baseUrl}');

    // 1. 验证配置格式
    if (!config.isValid) {
      return Right(FeedValidationResult.failure('无效的 API 配置'));
    }

    // 2. 如果有 DataSourceManager，使用适配器验证
    if (_dataSourceManager != null) {
      final adapter = _dataSourceManager.createAdapterFromConfig(
        DataSourceConfig.api(config: config),
      );

      try {
        // 验证连接
        final connectionResult = await adapter.validateConnection();
        final isConnected = connectionResult.fold(
          (failure) => false,
          (success) => success,
        );

        if (!isConnected) {
          adapter.dispose();
          return Right(FeedValidationResult.failure('无法连接到 API 服务器'));
        }

        // 获取 Feed 元数据
        final metadataResult = await adapter.fetchFeedMetadata();
        adapter.dispose();

        return metadataResult.fold(
          (failure) => Right(FeedValidationResult.failure(failure.userMessage)),
          (parsedFeed) => Right(
            FeedValidationResult.success(
              feedTitle: parsedFeed.title,
              feedDescription: parsedFeed.description,
              iconUrl: parsedFeed.iconUrl,
              feedType: parsedFeed.feedType,
              sourceType: SourceType.api,
            ),
          ),
        );
      } catch (e) {
        adapter.dispose();
        return Right(FeedValidationResult.failure('验证失败: ${e.toString()}'));
      }
    }

    // 3. 没有 DataSourceManager，只做基本验证
    return Right(
      FeedValidationResult.success(
        feedTitle: 'API Feed',
        feedType: FeedType.unknown,
        sourceType: SourceType.api,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> deleteFeed(String feedId) async {
    _log.info('删除订阅源: $feedId');
    try {
      // 1. 删除该订阅源的所有文章
      await _articleDao.deleteArticlesByFeed(feedId);

      // 2. 删除订阅源
      await _feedDao.deleteFeed(feedId);

      _log.info('订阅源删除成功: $feedId');
      return const Right(null);
    } catch (e, stackTrace) {
      _log.error('删除订阅源失败: $feedId', error: e, stackTrace: stackTrace);
      return Left(
        Failure.database(
          message: '删除订阅源失败',
          table: 'feeds',
          operation: 'deleteFeed',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Feed>> updateFeed(Feed feed) async {
    try {
      // 序列化 API 配置的 customHeaders
      String? apiHeadersJson;
      if (feed.apiConfig != null && feed.apiConfig!.customHeaders.isNotEmpty) {
        apiHeadersJson = jsonEncode(feed.apiConfig!.customHeaders);
      }

      final companion = FeedsTableCompanion(
        id: Value(feed.id),
        url: Value(feed.url),
        title: Value(feed.title),
        description: Value(feed.description),
        iconUrl: Value(feed.iconUrl),
        link: Value(feed.link),
        categoryId: Value(feed.categoryId),
        sortOrder: Value(feed.sortOrder),
        unreadCount: Value(feed.unreadCount),
        lastUpdated: Value(feed.lastUpdated),
        lastFetched: Value(feed.lastFetched),
        isEnabled: Value(feed.isEnabled),
        isBlocked: Value(feed.isBlocked),
        healthStatus: Value(feed.healthStatus),
        failureCount: Value(feed.failureCount),
        updatedAt: Value(DateTime.now()),
        // 数据源相关字段
        sourceType: Value(_sourceTypeToString(feed.sourceType)),
        apiBaseUrl: Value(feed.apiConfig?.baseUrl),
        apiKey: Value(feed.apiConfig?.apiKey),
        apiHeaders: Value(apiHeadersJson),
        apiRemoteFeedId: Value(feed.apiConfig?.remoteFeedId),
        apiTimeout: Value(feed.apiConfig?.timeout.inSeconds ?? 30),
        apiMaxRetries: Value(feed.apiConfig?.maxRetries ?? 3),
        pluginId: Value(feed.pluginConfig?.pluginId),
        pluginFeedKey: Value(feed.pluginConfig?.feedKey),
        pluginProvider: Value(feed.pluginConfig?.provider),
      );

      await _feedDao.updateFeed(companion);

      final updatedData = await _feedDao.getFeedById(feed.id);
      if (updatedData == null) {
        return Left(
          Failure.database(
            message: '更新订阅源失败',
            table: 'feeds',
            operation: 'updateFeed',
          ),
        );
      }
      return Right(_mapFeedsTableDataToFeed(updatedData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '更新订阅源失败',
          table: 'feeds',
          operation: 'updateFeed',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FeedValidationResult>> validateFeedUrl(
    String url,
  ) async {
    // 1. 验证 URL 格式
    if (!_isValidUrl(url)) {
      return Right(FeedValidationResult.failure('无效的 URL 格式'));
    }

    // 2. 尝试获取并解析 Feed
    final parseResult = await _rssParserService.fetchAndParseFeed(url);
    return parseResult.fold(
      (failure) => Right(FeedValidationResult.failure(failure.userMessage)),
      (parsedFeed) => Right(
        FeedValidationResult.success(
          feedTitle: parsedFeed.title,
          feedDescription: parsedFeed.description,
          iconUrl: parsedFeed.iconUrl,
          feedType: parsedFeed.feedType,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, int>> refreshFeed(String feedId) async {
    _log.debug('刷新订阅源: $feedId');
    try {
      final feedData = await _feedDao.getFeedById(feedId);
      if (feedData == null) {
        return Left(
          Failure.database(
            message: '订阅源不存在',
            table: 'feeds',
            operation: 'refreshFeed',
          ),
        );
      }

      final feed = _mapFeedsTableDataToFeed(feedData);
      final newArticleCount = await _fetchAndSaveArticlesForFeed(feed);

      // 更新最后获取时间和健康状态
      await _feedDao.updateHealthStatus(feedId, 0, 0);

      _log.info('订阅源刷新成功: ${feedData.title}, 新文章: $newArticleCount');
      return Right(newArticleCount);
    } catch (e, stackTrace) {
      _log.error('刷新订阅源失败: $feedId', error: e, stackTrace: stackTrace);
      // 更新失败计数
      final feedData = await _feedDao.getFeedById(feedId);
      if (feedData != null) {
        final newFailureCount = feedData.failureCount + 1;
        final newHealthStatus = newFailureCount >= 3 ? 2 : 1;
        await _feedDao.updateHealthStatus(
          feedId,
          newHealthStatus,
          newFailureCount,
        );
      }

      return Left(Failure.network(message: '刷新订阅源失败', url: feedData?.url));
    }
  }

  @override
  Future<Either<Failure, RefreshResult>> refreshAllFeeds() async {
    _log.info('开始刷新所有订阅源');
    final stopwatch = Stopwatch()..start();

    try {
      final feedsData = await _feedDao.getAllFeeds();
      int successCount = 0;
      int failedCount = 0;
      int totalNewArticles = 0;
      final errors = <FeedRefreshError>[];

      for (final feedData in feedsData) {
        if (!feedData.isEnabled || feedData.isBlocked) continue;

        final result = await refreshFeed(feedData.id);
        result.fold(
          (failure) {
            failedCount++;
            errors.add(
              FeedRefreshError(
                feedId: feedData.id,
                feedTitle: feedData.title,
                errorMessage: failure.userMessage,
              ),
            );
          },
          (newCount) {
            successCount++;
            totalNewArticles += newCount;
          },
        );
      }

      _log.info(
          '刷新完成, 耗时: ${stopwatch.elapsedMilliseconds}ms, 成功: $successCount, 失败: $failedCount, 新文章: $totalNewArticles');

      return Right(
        RefreshResult(
          totalFeeds: feedsData.length,
          successCount: successCount,
          failedCount: failedCount,
          newArticleCount: totalNewArticles,
          errors: errors,
        ),
      );
    } catch (e, stackTrace) {
      _log.error('刷新所有订阅源失败', error: e, stackTrace: stackTrace);
      return Left(
        Failure.database(
          message: '刷新所有订阅源失败',
          table: 'feeds',
          operation: 'refreshAllFeeds',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<FeedCategory>>> getCategories() async {
    try {
      final categoriesData = await _categoryDao.getAllCategories();
      final categories =
          categoriesData.map(_mapCategoriesTableDataToCategory).toList();
      return Right(categories);
    } catch (e) {
      return Left(
        Failure.database(
          message: '获取分类列表失败',
          table: 'categories',
          operation: 'getCategories',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FeedCategory>> createCategory(String name) async {
    try {
      final categoryId = _uuid.v4();
      final now = DateTime.now();

      // 获取当前最大排序值
      final categories = await _categoryDao.getAllCategories();
      final maxSortOrder = categories.isEmpty
          ? 0
          : categories.map((c) => c.sortOrder).reduce((a, b) => a > b ? a : b);

      final companion = CategoriesTableCompanion(
        id: Value(categoryId),
        name: Value(name),
        sortOrder: Value(maxSortOrder + 1),
        createdAt: Value(now),
        updatedAt: Value(now),
      );

      await _categoryDao.insertCategory(companion);

      final categoryData = await _categoryDao.getCategoryById(categoryId);
      if (categoryData == null) {
        return Left(
          Failure.database(
            message: '创建分类失败',
            table: 'categories',
            operation: 'createCategory',
          ),
        );
      }
      return Right(_mapCategoriesTableDataToCategory(categoryData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '创建分类失败',
          table: 'categories',
          operation: 'createCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FeedCategory>> updateCategory(
    FeedCategory category,
  ) async {
    try {
      final companion = CategoriesTableCompanion(
        id: Value(category.id),
        name: Value(category.name),
        description: Value(category.description),
        sortOrder: Value(category.sortOrder),
        isExpanded: Value(category.isExpanded),
        updatedAt: Value(DateTime.now()),
      );

      await _categoryDao.updateCategory(companion);

      final updatedData = await _categoryDao.getCategoryById(category.id);
      if (updatedData == null) {
        return Left(
          Failure.database(
            message: '更新分类失败',
            table: 'categories',
            operation: 'updateCategory',
          ),
        );
      }
      return Right(_mapCategoriesTableDataToCategory(updatedData));
    } catch (e) {
      return Left(
        Failure.database(
          message: '更新分类失败',
          table: 'categories',
          operation: 'updateCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String categoryId) async {
    try {
      // 将该分类下的订阅源移到未分类
      final feeds = await _feedDao.getFeedsByCategory(categoryId);
      for (final feed in feeds) {
        await _feedDao.updateFeed(
          FeedsTableCompanion(
            id: Value(feed.id),
            url: Value(feed.url),
            title: Value(feed.title),
            categoryId: const Value(null),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      // 删除分类
      await _categoryDao.deleteCategory(categoryId);

      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '删除分类失败',
          table: 'categories',
          operation: 'deleteCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> moveFeedToCategory(
    String feedId,
    String? categoryId,
  ) async {
    try {
      final feedData = await _feedDao.getFeedById(feedId);
      if (feedData == null) {
        return Left(
          Failure.database(
            message: '订阅源不存在',
            table: 'feeds',
            operation: 'moveFeedToCategory',
          ),
        );
      }

      await _feedDao.updateFeed(
        FeedsTableCompanion(
          id: Value(feedId),
          url: Value(feedData.url),
          title: Value(feedData.title),
          categoryId: Value(categoryId),
          updatedAt: Value(DateTime.now()),
        ),
      );

      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '移动订阅源失败',
          table: 'feeds',
          operation: 'moveFeedToCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> reorderFeeds(List<String> feedIds) async {
    try {
      await _feedDao.updateSortOrders(feedIds);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '重排序订阅源失败',
          table: 'feeds',
          operation: 'reorderFeeds',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> reorderCategories(
    List<String> categoryIds,
  ) async {
    try {
      await _categoryDao.updateSortOrders(categoryIds);
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.database(
          message: '重排序分类失败',
          table: 'categories',
          operation: 'reorderCategories',
        ),
      );
    }
  }

  @override
  Stream<List<Feed>> watchAllFeeds() {
    _pluginFeedDiscoveryService?.syncDiscoveredFeeds();
    return _feedDao.watchAllFeeds().map(
          (feedsData) => feedsData.map(_mapFeedsTableDataToFeed).toList(),
        );
  }

  @override
  Stream<List<FeedCategory>> watchAllCategories() {
    return _categoryDao.watchAllCategories().map(
          (categoriesData) =>
              categoriesData.map(_mapCategoriesTableDataToCategory).toList(),
        );
  }

  // ========== 私有方法 ==========

  /// 验证 URL 格式
  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (_) {
      return false;
    }
  }

  /// 获取并保存文章（使用 DataSourceManager）
  Future<int> _fetchAndSaveArticlesForFeed(Feed feed) async {
    // 如果有 DataSourceManager，使用适配器获取数据
    if (_dataSourceManager != null) {
      final adapter = _dataSourceManager.getAdapter(feed);
      final result = await adapter.fetchArticles();

      return result.fold(
        (failure) {
          _log.error(
            '订阅源适配器获取失败: ${feed.title}, message=${failureMessage(failure)}, userMessage=${failure.userMessage}',
          );
          throw Exception(failureMessage(failure));
        },
        (articleListResult) {
          _log.info(
            '订阅源适配器获取成功: ${feed.title}, articles=${articleListResult.articles.length}, totalCount=${articleListResult.totalCount}, hasMore=${articleListResult.hasMore}',
          );
          return _saveArticles(
            feed.id,
            articleListResult.articles,
            feed.lastFetched,
          );
        },
      );
    }

    // 回退到原有的 RSS 解析方式
    return _fetchAndSaveArticles(feed.id, feed.url);
  }

  String failureMessage(Failure failure) {
    return failure.when(
      network: (message, statusCode, url) => message,
      parse: (message, source, details) => message,
      cache: (message, key) => message,
      database: (message, table, operation) => message,
      validation: (message, field, value) => message,
      sync: (message, syncType, lastSyncTime) => message,
      file: (message, path, operation) => message,
      permission: (message, permissionType) => message,
      authentication: (message, feedId) => message,
      server: (message, statusCode, url) => message,
      notFound: (message, resourceType, resourceId) => message,
      unknown: (message, error, stackTrace) => message,
      htmlParse: (message, htmlSnippet) => message,
      deltaConversion: (message, details) => message,
      editorSave: (message, articleId) => message,
      editorLoad: (message, articleId) => message,
    );
  }

  /// 保存文章列表
  Future<int> _saveArticles(
    String feedId,
    List<ParsedArticle> articles,
    DateTime? lastFetched,
  ) async {
    int newCount = 0;

    for (final article in articles) {
      final articleId = _uuid.v4();
      final articleLink = article.link ?? article.uniqueId;
      final existingArticle = await _articleDao.getArticleByLink(
        articleLink,
      );

      if (existingArticle == null) {
        final now = DateTime.now();
          final companion = ArticlesTableCompanion(
          id: Value(articleId),
          feedId: Value(feedId),
          title: Value(article.title),
          link: Value(articleLink),
          summary: Value(article.summary),
          content: Value(article.content),
          author: Value(article.author),
          imageUrl: Value(article.imageUrl),
          publishedAt: Value(article.publishedAt),
          createdAt: Value(now),
          updatedAt: Value(now),
        );
        await _articleDao.insertArticle(companion);
        newCount++;
      }
    }

    // 更新未读数
    final unreadCount = await _articleDao.getUnreadCountByFeed(feedId);
    await _feedDao.updateUnreadCount(feedId, unreadCount);

    // 更新最后获取时间
    final feedData = await _feedDao.getFeedById(feedId);
    if (feedData != null) {
      await _feedDao.updateFeed(
        FeedsTableCompanion(
          id: Value(feedId),
          url: Value(feedData.url),
          title: Value(feedData.title),
          lastFetched: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }

    return newCount;
  }

  /// 获取并保存文章（原有方式，用于 RSS 数据源）
  Future<int> _fetchAndSaveArticles(String feedId, String url) async {
    final parseResult = await _rssParserService.fetchAndParseFeed(url);
    return parseResult.fold((failure) => throw Exception(failure.userMessage), (
      parsedFeed,
    ) async {
      int newCount = 0;
      for (final article in parsedFeed.articles) {
        final articleId = _uuid.v4();
        final existingArticle = await _articleDao.getArticleByLink(
          article.link ?? article.uniqueId,
        );

        if (existingArticle == null) {
          final now = DateTime.now();
          final companion = ArticlesTableCompanion(
            id: Value(articleId),
            feedId: Value(feedId),
            title: Value(article.title),
            link: Value(article.link ?? ''),
            summary: Value(article.summary),
            content: Value(article.content),
            author: Value(article.author),
            imageUrl: Value(article.imageUrl),
            publishedAt: Value(article.publishedAt),
            createdAt: Value(now),
            updatedAt: Value(now),
          );
          await _articleDao.insertArticle(companion);
          newCount++;
        }
      }

      // 更新未读数
      final unreadCount = await _articleDao.getUnreadCountByFeed(feedId);
      await _feedDao.updateUnreadCount(feedId, unreadCount);

      // 更新最后获取时间
      final feedData = await _feedDao.getFeedById(feedId);
      if (feedData != null) {
        await _feedDao.updateFeed(
          FeedsTableCompanion(
            id: Value(feedId),
            url: Value(feedData.url),
            title: Value(feedData.title),
            lastFetched: Value(DateTime.now()),
            lastUpdated: Value(parsedFeed.lastUpdated),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      return newCount;
    });
  }

  /// 将数据库数据映射为 Feed 实体
  Feed _mapFeedsTableDataToFeed(FeedsTableData data) {
    // 解析数据源类型
    final sourceType = _sourceTypeFromString(data.sourceType);

    // 解析 API 配置（如果是 API 数据源）
    ApiSourceConfig? apiConfig;
    if (sourceType == SourceType.api && data.apiBaseUrl != null) {
      Map<String, String> customHeaders = {};
      if (data.apiHeaders != null && data.apiHeaders!.isNotEmpty) {
        try {
          final decoded = jsonDecode(data.apiHeaders!) as Map<String, dynamic>;
          customHeaders = decoded.map((k, v) => MapEntry(k, v.toString()));
        } catch (_) {
          // 忽略解析错误
        }
      }

      apiConfig = ApiSourceConfig(
        baseUrl: data.apiBaseUrl!,
        apiKey: data.apiKey,
        customHeaders: customHeaders,
        timeout: Duration(seconds: data.apiTimeout),
        maxRetries: data.apiMaxRetries,
        remoteFeedId: data.apiRemoteFeedId,
      );
    }

    PluginSourceConfig? pluginConfig;
    if (sourceType == SourceType.plugin &&
        data.pluginId != null &&
        data.pluginFeedKey != null) {
      pluginConfig = PluginSourceConfig(
        pluginId: data.pluginId!,
        feedKey: data.pluginFeedKey!,
        provider: data.pluginProvider ?? PluginFeedDiscoveryService.providerCapability,
      );
    }

    return Feed(
      id: data.id,
      url: data.url,
      title: data.title,
      description: data.description,
      iconUrl: data.iconUrl,
      link: data.link,
      categoryId: data.categoryId,
      sortOrder: data.sortOrder,
      unreadCount: data.unreadCount,
      lastUpdated: data.lastUpdated,
      lastFetched: data.lastFetched,
      isEnabled: data.isEnabled,
      isBlocked: data.isBlocked,
      healthStatus: data.healthStatus,
      failureCount: data.failureCount,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      sourceType: sourceType,
      apiConfig: apiConfig,
      pluginConfig: pluginConfig,
    );
  }

  SourceType _sourceTypeFromString(String value) {
    return switch (value) {
      'api' => SourceType.api,
      'plugin' => SourceType.plugin,
      _ => SourceType.rss,
    };
  }

  String _sourceTypeToString(SourceType value) {
    return switch (value) {
      SourceType.rss => 'rss',
      SourceType.api => 'api',
      SourceType.plugin => 'plugin',
    };
  }

  /// 将数据库数据映射为 FeedCategory 实体
  FeedCategory _mapCategoriesTableDataToCategory(CategoriesTableData data) {
    return FeedCategory(
      id: data.id,
      name: data.name,
      description: data.description,
      sortOrder: data.sortOrder,
      isExpanded: data.isExpanded,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
