import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/services/rss_parser_service.dart';
import 'package:rss_reader/features/feed/data/services/data_source_manager.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/services/feed_validator.dart';

/// 订阅源验证器实现
class FeedValidatorImpl implements FeedValidator {
  final RssParserService _rssParserService;
  final DataSourceManager? _dataSourceManager;

  FeedValidatorImpl({
    required RssParserService rssParserService,
    DataSourceManager? dataSourceManager,
  })  : _rssParserService = rssParserService,
        _dataSourceManager = dataSourceManager;

  @override
  UrlValidationResult validateUrlFormat(String url) {
    // 1. 检查空 URL
    if (url.isEmpty) {
      return UrlValidationResult.invalid(
        'URL 不能为空',
        UrlValidationErrorType.emptyUrl,
      );
    }

    final trimmedUrl = url.trim();

    // 2. 检查 URL 格式
    Uri uri;
    try {
      uri = Uri.parse(trimmedUrl);
    } catch (_) {
      return UrlValidationResult.invalid(
        '无效的 URL 格式',
        UrlValidationErrorType.invalidFormat,
      );
    }

    // 3. 检查是否有 scheme
    if (!uri.hasScheme) {
      return UrlValidationResult.invalid(
        'URL 必须包含协议（http 或 https）',
        UrlValidationErrorType.invalidFormat,
      );
    }

    // 4. 检查 scheme 是否为 http 或 https
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      return UrlValidationResult.invalid(
        '仅支持 http 和 https 协议',
        UrlValidationErrorType.unsupportedScheme,
      );
    }

    // 5. 检查是否有 host
    if (!uri.hasAuthority || uri.host.isEmpty) {
      return UrlValidationResult.invalid(
        'URL 必须包含有效的域名',
        UrlValidationErrorType.invalidHost,
      );
    }

    // 6. 检查 host 格式（基本验证）
    if (!_isValidHost(uri.host)) {
      return UrlValidationResult.invalid(
        '无效的域名格式',
        UrlValidationErrorType.invalidHost,
      );
    }

    return UrlValidationResult.valid();
  }

  @override
  Future<Either<Failure, FeedContentValidationResult>> validateFeedUrl(
    String url,
  ) async {
    // 1. 先验证 URL 格式
    final urlValidation = validateUrlFormat(url);
    if (!urlValidation.isValid) {
      return Right(
        FeedContentValidationResult.failure(
          urlValidation.errorMessage ?? '无效的 URL',
        ),
      );
    }

    // 2. 尝试获取并解析 Feed
    final parseResult = await _rssParserService.fetchAndParseFeed(url.trim());

    return parseResult.fold(
      (failure) =>
          Right(FeedContentValidationResult.failure(failure.userMessage)),
      (parsedFeed) {
        // 3. 验证解析结果
        if (parsedFeed.title.isEmpty || parsedFeed.title == 'Unknown') {
          return Right(FeedContentValidationResult.failure('无法获取订阅源标题'));
        }

        return Right(
          FeedContentValidationResult.success(
            feedTitle: parsedFeed.title,
            feedDescription: parsedFeed.description,
            iconUrl: parsedFeed.iconUrl,
            feedType: parsedFeed.feedType,
            articleCount: parsedFeed.articleCount,
          ),
        );
      },
    );
  }

  @override
  Future<FeedHealthStatus> checkHealth(Feed feed) async {
    final now = DateTime.now();

    // 1. 检查是否被禁用或屏蔽
    if (!feed.isEnabled || feed.isBlocked) {
      return FeedHealthStatus(
        feedId: feed.id,
        status: 2,
        errorMessage: '订阅源已禁用或屏蔽',
        checkedAt: now,
      );
    }

    // 2. 根据数据源类型选择检测方式
    if (feed.sourceType == SourceType.api) {
      return _checkApiSourceHealth(feed, now);
    } else {
      return _checkRssSourceHealth(feed, now);
    }
  }

  /// 检测 RSS 数据源健康状态
  Future<FeedHealthStatus> _checkRssSourceHealth(
      Feed feed, DateTime now) async {
    final parseResult = await _rssParserService.fetchAndParseFeed(feed.url);

    return parseResult.fold(
      (failure) {
        final newFailureCount = feed.failureCount + 1;
        final status = newFailureCount >= 3 ? 2 : 1;

        return FeedHealthStatus(
          feedId: feed.id,
          status: status,
          errorMessage: failure.userMessage,
          checkedAt: now,
        );
      },
      (parsedFeed) {
        // 检查是否长期未更新（超过30天）
        if (feed.lastUpdated != null) {
          final daysSinceUpdate = now.difference(feed.lastUpdated!).inDays;
          if (daysSinceUpdate > 30) {
            return FeedHealthStatus(
              feedId: feed.id,
              status: 1,
              errorMessage: '订阅源已超过30天未更新',
              checkedAt: now,
            );
          }
        }

        return FeedHealthStatus(feedId: feed.id, status: 0, checkedAt: now);
      },
    );
  }

  /// 检测 API 数据源健康状态
  Future<FeedHealthStatus> _checkApiSourceHealth(
      Feed feed, DateTime now) async {
    // 如果没有 DataSourceManager，无法检测 API 源
    if (_dataSourceManager == null) {
      return FeedHealthStatus(
        feedId: feed.id,
        status: 1,
        errorMessage: '无法检测 API 数据源健康状态',
        checkedAt: now,
      );
    }

    try {
      final adapter = _dataSourceManager.getAdapter(feed);
      final connectionResult = await adapter.validateConnection();

      return connectionResult.fold(
        (failure) {
          final newFailureCount = feed.failureCount + 1;
          final status = newFailureCount >= 3 ? 2 : 1;

          return FeedHealthStatus(
            feedId: feed.id,
            status: status,
            errorMessage: failure.userMessage,
            checkedAt: now,
          );
        },
        (isConnected) {
          if (!isConnected) {
            return FeedHealthStatus(
              feedId: feed.id,
              status: 1,
              errorMessage: '无法连接到 API 服务器',
              checkedAt: now,
            );
          }

          // 检查是否长期未更新（超过30天）
          if (feed.lastUpdated != null) {
            final daysSinceUpdate = now.difference(feed.lastUpdated!).inDays;
            if (daysSinceUpdate > 30) {
              return FeedHealthStatus(
                feedId: feed.id,
                status: 1,
                errorMessage: '数据源已超过30天未更新',
                checkedAt: now,
              );
            }
          }

          return FeedHealthStatus(feedId: feed.id, status: 0, checkedAt: now);
        },
      );
    } catch (e) {
      return FeedHealthStatus(
        feedId: feed.id,
        status: 1,
        errorMessage: '检测失败: ${e.toString()}',
        checkedAt: now,
      );
    }
  }

  @override
  Future<List<FeedHealthStatus>> checkAllFeedsHealth(List<Feed> feeds) async {
    final results = <FeedHealthStatus>[];

    for (final feed in feeds) {
      final status = await checkHealth(feed);
      results.add(status);
    }

    return results;
  }

  /// 验证 host 格式
  bool _isValidHost(String host) {
    // 基本的域名格式验证
    // 允许 IP 地址和域名

    // IP 地址格式
    final ipRegex = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');
    if (ipRegex.hasMatch(host)) {
      // 验证每个数字是否在 0-255 范围内
      final parts = host.split('.');
      for (final part in parts) {
        final num = int.tryParse(part);
        if (num == null || num < 0 || num > 255) {
          return false;
        }
      }
      return true;
    }

    // 域名格式
    final domainRegex = RegExp(
      r'^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)*$',
    );
    return domainRegex.hasMatch(host);
  }
}
