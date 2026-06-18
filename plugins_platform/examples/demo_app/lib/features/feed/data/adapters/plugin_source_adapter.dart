import 'package:dartz/dartz.dart';
import 'package:plugins_platform/plugins_platform.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/parsed_feed.dart';
import 'package:rss_reader/features/feed/domain/services/data_source_adapter.dart';

final _log = logger.tag(LogTags.feed);

/// 插件数据源适配器
class PluginSourceAdapter implements DataSourceAdapter {
  final PluginSourceConfig config;
  final PluginManager _pluginManager;

  bool _disposed = false;

  PluginSourceAdapter({
    required this.config,
    required PluginManager pluginManager,
  }) : _pluginManager = pluginManager;

  @override
  SourceType get sourceType => SourceType.plugin;

  @override
  Future<Either<Failure, ParsedFeed>> fetchFeedMetadata() async {
    return _call(() async {
      final data = await _invokeData('getFeedInfo', {
        'feedKey': config.feedKey,
        'provider': config.provider,
      });
      return ParsedFeed(
        title: data['title']?.toString() ?? 'Plugin Feed',
        description: data['description']?.toString(),
        link: data['link']?.toString(),
        iconUrl: data['iconUrl']?.toString(),
        articles: const [],
        feedType: FeedType.unknown,
        lastUpdated: _parseDate(data['lastUpdated']),
      );
    }, operation: '获取插件 Feed 元数据失败');
  }

  @override
  Future<Either<Failure, ArticleListResult>> fetchArticles({
    int page = 1,
    int pageSize = 20,
    DateTime? since,
  }) async {
    return _call(() async {
      final functionName = page <= 1 ? 'refresh' : 'loadMore';
      final request = {
        'feedKey': config.feedKey,
        'provider': config.provider,
        'page': page,
        'pageSize': pageSize,
        if (since != null) 'since': since.toUtc().toIso8601String(),
        if (since != null) 'date': _formatDate(since.toUtc()),
      };
      _log.info(
        '插件订阅源请求: plugin=${config.pluginId}, feed=${config.feedKey}, function=$functionName, params=$request',
      );

      final data = await _invokeData(functionName, request);
      final articles = _parseArticles(data['articles']);
      _log.info(
        '插件订阅源返回: plugin=${config.pluginId}, feed=${config.feedKey}, function=$functionName, articles=${articles.length}, totalCount=${data['totalCount']}, hasMore=${data['hasMore']}, nextCursor=${data['nextCursor']}',
      );

      return ArticleListResult(
        articles: articles,
        hasMore: data['hasMore'] == true,
        totalCount: articles.length,
        nextCursor: data['nextCursor']?.toString(),
        currentPage: page,
        pageSize: pageSize,
      );
    }, operation: '获取插件文章列表失败');
  }

  @override
  Future<Either<Failure, ParsedArticle>> fetchArticleDetail(
    String articleId,
  ) async {
    return _call(() async {
      final data = await _invokeData('getArticleDetail', {
        'feedKey': config.feedKey,
        'articleId': articleId,
      });
      return _parseArticle(data);
    }, operation: '获取插件文章详情失败');
  }

  @override
  Future<Either<Failure, bool>> validateConnection() async {
    return _call(() async {
      final data = await _invokeData(
        'getFeedInfo',
        {'feedKey': config.feedKey},
      );
      return data.isNotEmpty;
    }, operation: '验证插件数据源失败');
  }

  @override
  void dispose() {
    _disposed = true;
  }

  Future<Either<Failure, T>> _call<T>(
    Future<T> Function() task, {
    required String operation,
  }) async {
    if (_disposed) {
      return Left(Failure.unknown(message: '适配器已释放'));
    }
    try {
      await _ensureActivated();
      return Right(await task());
    } catch (e, stackTrace) {
      _log.error(operation, error: e, stackTrace: stackTrace);
      return Left(Failure.unknown(message: '$operation: ${e.toString()}'));
    }
  }

  Future<void> _ensureActivated() async {
    if (!_pluginManager.isActivated(config.pluginId)) {
      await _pluginManager.activate(config.pluginId);
    }
  }

  Future<Map<String, dynamic>> _invokeData(
    String functionName,
    Map<String, dynamic> params,
  ) async {
    _log.debug(
      '调用插件函数: plugin=${config.pluginId}, function=$functionName',
    );
    final result = await _pluginManager.callPluginFunction(
      config.pluginId,
      functionName,
      [params],
    );
    final payload = _unwrapInvokeResult(result);
    if (payload is Map<String, dynamic>) return payload;
    if (payload is Map) {
      return payload.map((key, value) => MapEntry(key.toString(), value));
    }
    return <String, dynamic>{};
  }

  dynamic _unwrapInvokeResult(dynamic result) {
    if (result is Map) {
      final map = result.map((key, value) => MapEntry(key.toString(), value));
      if (map['success'] == true && map.containsKey('data')) {
        return map['data'];
      }
      return map;
    }
    return result;
  }

  List<ParsedArticle> _parseArticles(dynamic value) {
    if (value is! List) return const [];
    return value
        .whereType<Map>()
        .map(
          (item) => item.map((key, value) => MapEntry(key.toString(), value)),
        )
        .map(_parseArticle)
        .toList(growable: false);
  }

  ParsedArticle _parseArticle(Map<String, dynamic> data) {
    final title = data['title']?.toString() ?? 'Untitled';
    final link = data['link']?.toString();
    return ParsedArticle(
      guid: data['guid']?.toString() ?? link ?? title,
      title: title,
      summary: data['summary']?.toString(),
      content: data['content']?.toString(),
      author: data['author']?.toString(),
      link: link,
      imageUrl: data['imageUrl']?.toString(),
      publishedAt: _parseDate(data['publishedAt']),
      categories: (data['categories'] as List?)
              ?.map((item) => item.toString())
              .toList(growable: false) ??
          const [],
    );
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value == null) return null;
    return int.tryParse(value.toString());
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
