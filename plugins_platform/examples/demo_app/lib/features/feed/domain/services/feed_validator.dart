import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';

/// 订阅源健康状态
class FeedHealthStatus {
  final String feedId;
  final int status; // 0: 正常, 1: 警告, 2: 失效
  final String? errorMessage;
  final DateTime checkedAt;

  const FeedHealthStatus({
    required this.feedId,
    required this.status,
    this.errorMessage,
    required this.checkedAt,
  });

  bool get isHealthy => status == 0;
  bool get hasWarning => status == 1;
  bool get isInvalid => status == 2;
}

/// URL 验证结果
class UrlValidationResult {
  final bool isValid;
  final String? errorMessage;
  final UrlValidationErrorType? errorType;

  const UrlValidationResult({
    required this.isValid,
    this.errorMessage,
    this.errorType,
  });

  factory UrlValidationResult.valid() {
    return const UrlValidationResult(isValid: true);
  }

  factory UrlValidationResult.invalid(
    String message,
    UrlValidationErrorType type,
  ) {
    return UrlValidationResult(
      isValid: false,
      errorMessage: message,
      errorType: type,
    );
  }
}

/// URL 验证错误类型
enum UrlValidationErrorType {
  emptyUrl,
  invalidFormat,
  unsupportedScheme,
  invalidHost,
}

/// Feed 内容验证结果
class FeedContentValidationResult {
  final bool isValid;
  final String? feedTitle;
  final String? feedDescription;
  final String? iconUrl;
  final String? errorMessage;
  final FeedType feedType;
  final int articleCount;

  const FeedContentValidationResult({
    required this.isValid,
    this.feedTitle,
    this.feedDescription,
    this.iconUrl,
    this.errorMessage,
    this.feedType = FeedType.unknown,
    this.articleCount = 0,
  });

  factory FeedContentValidationResult.success({
    required String feedTitle,
    String? feedDescription,
    String? iconUrl,
    required FeedType feedType,
    required int articleCount,
  }) {
    return FeedContentValidationResult(
      isValid: true,
      feedTitle: feedTitle,
      feedDescription: feedDescription,
      iconUrl: iconUrl,
      feedType: feedType,
      articleCount: articleCount,
    );
  }

  factory FeedContentValidationResult.failure(String errorMessage) {
    return FeedContentValidationResult(
      isValid: false,
      errorMessage: errorMessage,
    );
  }
}

/// 订阅源验证器接口
abstract class FeedValidator {
  /// 验证 URL 格式
  UrlValidationResult validateUrlFormat(String url);

  /// 验证 RSS/Atom URL 有效性（包括获取和解析）
  Future<Either<Failure, FeedContentValidationResult>> validateFeedUrl(
    String url,
  );

  /// 检测订阅源健康状态
  Future<FeedHealthStatus> checkHealth(Feed feed);

  /// 批量健康检测
  Future<List<FeedHealthStatus>> checkAllFeedsHealth(List<Feed> feeds);
}
