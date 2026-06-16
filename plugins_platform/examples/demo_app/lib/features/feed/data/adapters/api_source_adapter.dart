import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';
import 'package:rss_reader/features/feed/domain/services/data_source_adapter.dart';

final _log = logger.tag(LogTags.network);

/// API 数据源适配器
/// 通过 REST API 获取数据，实现 DataSourceAdapter 接口
class ApiSourceAdapter implements DataSourceAdapter {
  /// API 配置
  final ApiSourceConfig config;

  /// HTTP 客户端
  final http.Client _httpClient;

  /// 是否已释放
  bool _disposed = false;

  ApiSourceAdapter({
    required this.config,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  @override
  SourceType get sourceType => SourceType.api;

  @override
  Future<Either<Failure, ParsedFeed>> fetchFeedMetadata() async {
    _log.debug('获取 Feed 元数据: ${config.baseUrl}');

    final feedId = config.remoteFeedId ?? 'default';
    final result = await _request<Map<String, dynamic>>(
      'GET',
      '/feeds/$feedId',
    );

    return result.fold(
      (failure) => Left(failure),
      (data) {
        try {
          final feed = _parseFeedResponse(data);
          return Right(feed);
        } catch (e) {
          _log.error('解析 Feed 响应失败', error: e);
          return Left(Failure.parse(
            message: '解析 Feed 数据失败: ${e.toString()}',
            source: config.baseUrl,
          ));
        }
      },
    );
  }

  @override
  Future<Either<Failure, ArticleListResult>> fetchArticles({
    int page = 1,
    int pageSize = 20,
    DateTime? since,
  }) async {
    _log.debug('获取文章列表: page=$page, pageSize=$pageSize, since=$since');

    final feedId = config.remoteFeedId ?? 'default';
    final queryParams = <String, String>{
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };

    if (since != null) {
      queryParams['since'] = since.toUtc().toIso8601String();
    }

    final result = await _request<Map<String, dynamic>>(
      'GET',
      '/feeds/$feedId/articles',
      queryParams: queryParams,
    );

    return result.fold(
      (failure) => Left(failure),
      (data) {
        try {
          final articleListResult =
              _parseArticleListResponse(data, page, pageSize);
          return Right(articleListResult);
        } catch (e) {
          _log.error('解析文章列表响应失败', error: e);
          return Left(Failure.parse(
            message: '解析文章列表失败: ${e.toString()}',
            source: config.baseUrl,
          ));
        }
      },
    );
  }

  @override
  Future<Either<Failure, ParsedArticle>> fetchArticleDetail(
    String articleId,
  ) async {
    _log.debug('获取文章详情: $articleId');

    final result = await _request<Map<String, dynamic>>(
      'GET',
      '/articles/$articleId',
    );

    return result.fold(
      (failure) => Left(failure),
      (data) {
        try {
          final article = _parseArticleResponse(data);
          return Right(article);
        } catch (e) {
          _log.error('解析文章详情响应失败', error: e);
          return Left(Failure.parse(
            message: '解析文章详情失败: ${e.toString()}',
            source: config.baseUrl,
          ));
        }
      },
    );
  }

  @override
  Future<Either<Failure, bool>> validateConnection() async {
    _log.debug('验证 API 连接: ${config.baseUrl}');

    final result = await _request<Map<String, dynamic>>('GET', '/health');

    return result.fold(
      (failure) => Left(failure),
      (_) => const Right(true),
    );
  }

  @override
  void dispose() {
    if (!_disposed) {
      _httpClient.close();
      _disposed = true;
    }
  }

  // ========== 私有方法 ==========

  /// 发送 HTTP 请求（带重试）
  Future<Either<Failure, T>> _request<T>(
    String method,
    String path, {
    Map<String, String>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    if (_disposed) {
      return Left(Failure.unknown(message: '适配器已释放'));
    }

    final uri = Uri.parse('${config.baseUrl}$path').replace(
      queryParameters: queryParams?.isNotEmpty == true ? queryParams : null,
    );

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (config.apiKey != null && config.apiKey!.isNotEmpty)
        'Authorization': 'Bearer ${config.apiKey}',
      ...config.customHeaders,
    };

    for (var attempt = 0; attempt < config.maxRetries; attempt++) {
      try {
        _log.debug(
            '发送请求: $method $uri (尝试 ${attempt + 1}/${config.maxRetries})');

        http.Response response;
        switch (method.toUpperCase()) {
          case 'GET':
            response = await _httpClient
                .get(uri, headers: headers)
                .timeout(config.timeout);
            break;
          case 'POST':
            response = await _httpClient
                .post(uri,
                    headers: headers,
                    body: body != null ? jsonEncode(body) : null)
                .timeout(config.timeout);
            break;
          default:
            return Left(Failure.unknown(message: '不支持的 HTTP 方法: $method'));
        }

        _log.debug('收到响应: ${response.statusCode}');

        // 处理成功响应
        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (response.body.isEmpty) {
            return Right({} as T);
          }
          final decoded = jsonDecode(response.body);
          return Right(decoded as T);
        }

        // 处理认证错误（不重试）
        if (response.statusCode == 401) {
          _log.warning('认证失败: ${config.baseUrl}');
          return Left(Failure.authentication(
            message: '认证失败，请检查 API 密钥',
          ));
        }

        // 处理客户端错误（不重试）
        if (response.statusCode >= 400 && response.statusCode < 500) {
          final errorMessage = _extractErrorMessage(response);
          return Left(Failure.server(
            message: errorMessage,
            statusCode: response.statusCode,
            url: uri.toString(),
          ));
        }

        // 服务器错误，可以重试
        if (attempt < config.maxRetries - 1) {
          final delay = Duration(seconds: pow(2, attempt).toInt());
          _log.warning('服务器错误 ${response.statusCode}，${delay.inSeconds}秒后重试');
          await Future.delayed(delay);
          continue;
        }

        return Left(Failure.server(
          message: '服务器错误',
          statusCode: response.statusCode,
          url: uri.toString(),
        ));
      } catch (e) {
        _log.error('请求失败: $uri', error: e);

        // 最后一次尝试失败
        if (attempt >= config.maxRetries - 1) {
          return Left(Failure.network(
            message: '网络请求失败: ${e.toString()}',
            url: uri.toString(),
          ));
        }

        // 等待后重试
        final delay = Duration(seconds: pow(2, attempt).toInt());
        _log.warning('网络错误，${delay.inSeconds}秒后重试');
        await Future.delayed(delay);
      }
    }

    return Left(Failure.network(
      message: '请求失败，已达到最大重试次数',
      url: uri.toString(),
    ));
  }

  /// 从响应中提取错误信息
  String _extractErrorMessage(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map<String, dynamic>) {
        return body['message'] ?? body['error'] ?? '请求失败';
      }
    } catch (_) {}
    return '请求失败 (${response.statusCode})';
  }

  /// 解析 Feed 响应
  ParsedFeed _parseFeedResponse(Map<String, dynamic> data) {
    final articlesData = data['articles'] as List<dynamic>? ?? [];
    final articles = articlesData
        .map((a) => _parseArticleResponse(a as Map<String, dynamic>))
        .toList();

    return ParsedFeed(
      title: data['title'] as String? ?? 'Unknown',
      description: data['description'] as String?,
      link: data['link'] as String?,
      iconUrl: data['iconUrl'] as String?,
      articles: articles,
      feedType: FeedType.unknown,
      lastUpdated: data['lastUpdated'] != null
          ? DateTime.tryParse(data['lastUpdated'] as String)
          : null,
    );
  }

  /// 解析文章列表响应
  ArticleListResult _parseArticleListResponse(
    Map<String, dynamic> data,
    int page,
    int pageSize,
  ) {
    final articlesData = data['articles'] as List<dynamic>? ?? [];
    final articles = articlesData
        .map((a) => _parseArticleResponse(a as Map<String, dynamic>))
        .toList();

    return ArticleListResult(
      articles: articles,
      hasMore: data['hasMore'] as bool? ?? false,
      totalCount: data['totalCount'] as int?,
      nextCursor: data['nextCursor'] as String?,
      currentPage: page,
      pageSize: pageSize,
    );
  }

  /// 解析单篇文章响应
  ParsedArticle _parseArticleResponse(Map<String, dynamic> data) {
    List<String> categories = [];
    if (data['categories'] != null) {
      categories = (data['categories'] as List<dynamic>)
          .map((c) => c.toString())
          .toList();
    }

    return ParsedArticle(
      guid: data['guid'] as String? ?? data['id'] as String?,
      title: data['title'] as String? ?? 'Untitled',
      summary: data['summary'] as String?,
      content: data['content'] as String?,
      author: data['author'] as String?,
      link: data['link'] as String?,
      imageUrl: data['imageUrl'] as String?,
      publishedAt: data['publishedAt'] != null
          ? DateTime.tryParse(data['publishedAt'] as String)
          : null,
      categories: categories,
    );
  }
}
