import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/features/article/domain/services/article_fetcher_service.dart';

final _log = logger.tag(LogTags.network);

/// 文章内容抓取服务实现
class ArticleFetcherServiceImpl implements ArticleFetcherService {
  final http.Client _httpClient;

  /// 内容长度阈值，低于此值认为是摘要需要抓取完整内容
  static const int _contentThreshold = 500;

  ArticleFetcherServiceImpl({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  bool shouldFetchFullContent(String? content, String? summary) {
    // 如果没有内容，需要抓取
    if (content == null || content.isEmpty) {
      return true;
    }

    // 去除 HTML 标签后计算纯文本长度
    final plainText = _stripHtmlTags(content);

    // 如果内容太短（可能只是摘要），需要抓取
    if (plainText.length < _contentThreshold) {
      return true;
    }

    // 如果内容和摘要相同，说明没有完整内容
    if (summary != null && content.trim() == summary.trim()) {
      return true;
    }

    return false;
  }

  @override
  Future<Either<Failure, String>> fetchArticleContent(String url) async {
    _log.debug('开始抓取文章内容: $url');
    final stopwatch = Stopwatch()..start();

    try {
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
        },
      ).timeout(const Duration(seconds: 15));

      _log.debug(
          '收到响应: ${response.statusCode}, 耗时: ${stopwatch.elapsedMilliseconds}ms');

      if (response.statusCode == 200) {
        final content = _decodeResponse(response);
        final extractedContent = _extractMainContent(content);

        if (extractedContent.isNotEmpty) {
          _log.info('文章抓取成功: $url, 内容长度: ${extractedContent.length}');
          return Right(extractedContent);
        }

        _log.warning('无法提取文章内容: $url');
        return Left(Failure.parse(
          message: '无法提取文章内容',
          source: url,
        ));
      }

      _log.warning('获取文章失败: $url, 状态码: ${response.statusCode}');
      return Left(Failure.network(
        message: '获取文章失败',
        statusCode: response.statusCode,
        url: url,
      ));
    } catch (e, stackTrace) {
      _log.error('网络错误: $url', error: e, stackTrace: stackTrace);
      return Left(Failure.network(
        message: '网络错误: ${e.toString()}',
        url: url,
      ));
    }
  }

  /// 解码响应内容
  String _decodeResponse(http.Response response) {
    // 尝试从 Content-Type 获取编码
    final contentType = response.headers['content-type'] ?? '';
    final charsetMatch = RegExp(r'charset=([^\s;]+)').firstMatch(contentType);
    final charset = charsetMatch?.group(1)?.toLowerCase();

    try {
      if (charset == 'gbk' || charset == 'gb2312' || charset == 'gb18030') {
        // 对于中文编码，尝试使用 latin1 解码后转换
        // 注意：这是简化处理，实际可能需要更复杂的编码转换
        return utf8.decode(response.bodyBytes, allowMalformed: true);
      }
      return utf8.decode(response.bodyBytes);
    } catch (_) {
      return utf8.decode(response.bodyBytes, allowMalformed: true);
    }
  }

  /// 提取页面主要内容
  String _extractMainContent(String html) {
    // 移除 script 和 style 标签
    var content = html
        .replaceAll(
            RegExp(r'<script[^>]*>[\s\S]*?</script>', caseSensitive: false), '')
        .replaceAll(
            RegExp(r'<style[^>]*>[\s\S]*?</style>', caseSensitive: false), '')
        .replaceAll(RegExp(r'<!--[\s\S]*?-->'), '');

    // 尝试提取 article 标签内容
    final articleMatch = RegExp(
      r'<article[^>]*>([\s\S]*?)</article>',
      caseSensitive: false,
    ).firstMatch(content);
    if (articleMatch != null) {
      return _cleanContent(articleMatch.group(1) ?? '');
    }

    // 尝试提取常见的内容容器
    final contentSelectors = [
      r'<div[^>]*class="[^"]*(?:article|content|post|entry|main)[^"]*"[^>]*>([\s\S]*?)</div>',
      r'<main[^>]*>([\s\S]*?)</main>',
      r'<div[^>]*id="[^"]*(?:article|content|post|entry|main)[^"]*"[^>]*>([\s\S]*?)</div>',
    ];

    for (final selector in contentSelectors) {
      final match = RegExp(selector, caseSensitive: false).firstMatch(content);
      if (match != null) {
        final extracted = match.group(1) ?? '';
        if (_stripHtmlTags(extracted).length > _contentThreshold) {
          return _cleanContent(extracted);
        }
      }
    }

    // 如果都没找到，尝试提取 body 内容
    final bodyMatch = RegExp(
      r'<body[^>]*>([\s\S]*?)</body>',
      caseSensitive: false,
    ).firstMatch(content);
    if (bodyMatch != null) {
      return _cleanContent(bodyMatch.group(1) ?? '');
    }

    return _cleanContent(content);
  }

  /// 清理内容
  String _cleanContent(String content) {
    // 移除导航、页脚、侧边栏等
    var cleaned = content
        .replaceAll(
            RegExp(r'<nav[^>]*>[\s\S]*?</nav>', caseSensitive: false), '')
        .replaceAll(
            RegExp(r'<footer[^>]*>[\s\S]*?</footer>', caseSensitive: false), '')
        .replaceAll(
            RegExp(r'<aside[^>]*>[\s\S]*?</aside>', caseSensitive: false), '')
        .replaceAll(
            RegExp(r'<header[^>]*>[\s\S]*?</header>', caseSensitive: false),
            '');

    // 移除广告相关的 div
    cleaned = cleaned.replaceAll(
      RegExp(
          r'<div[^>]*class="[^"]*(?:ad|ads|advertisement|banner|sidebar)[^"]*"[^>]*>[\s\S]*?</div>',
          caseSensitive: false),
      '',
    );

    // 保留有意义的 HTML 标签
    return cleaned.trim();
  }

  /// 去除 HTML 标签
  String _stripHtmlTags(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
