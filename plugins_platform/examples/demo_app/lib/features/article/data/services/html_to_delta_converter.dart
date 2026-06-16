import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:rss_reader/core/logging/logging.dart';

final _log = logger.tag('HtmlToDeltaConverter');

/// HTML 到 Quill Delta 转换器
class HtmlToDeltaConverter {
  /// 将 HTML 转换为 Quill Delta JSON 列表
  ///
  /// [html] - 输入的 HTML 字符串
  /// 返回 Delta 操作列表
  List<Map<String, dynamic>> convert(String html) {
    if (html.isEmpty) {
      // 返回空文档的 Delta
      return [
        {'insert': '\n'}
      ];
    }

    try {
      // 预处理 HTML
      final processedHtml = _preprocessHtml(html);

      // 使用 flutter_quill_delta_from_html 进行转换
      final converter = HtmlToDelta();
      final delta = converter.convert(processedHtml);

      // 转换为 JSON 格式
      final deltaJson = delta.toJson();

      _log.debug('HTML 转换为 Delta 成功，操作数: ${deltaJson.length}');
      return List<Map<String, dynamic>>.from(deltaJson);
    } catch (e, stackTrace) {
      _log.error('HTML 转换失败', error: e, stackTrace: stackTrace);
      // 降级处理：提取纯文本
      return _fallbackToPlainText(html);
    }
  }

  /// 预处理 HTML，处理一些常见问题
  String _preprocessHtml(String html) {
    var processed = html;

    // 移除可能导致问题的标签
    processed = processed.replaceAll(RegExp(r'<script[^>]*>.*?</script>', dotAll: true), '');
    processed = processed.replaceAll(RegExp(r'<style[^>]*>.*?</style>', dotAll: true), '');
    processed = processed.replaceAll(RegExp(r'<noscript[^>]*>.*?</noscript>', dotAll: true), '');

    // 处理自闭合标签
    processed = processed.replaceAll(RegExp(r'<br\s*/?>'), '<br/>');
    processed = processed.replaceAll(RegExp(r'<hr\s*/?>'), '<hr/>');

    // 处理空段落
    processed = processed.replaceAll(RegExp(r'<p>\s*</p>'), '<p><br/></p>');

    return processed;
  }

  /// 降级处理：将 HTML 转换为纯文本 Delta
  List<Map<String, dynamic>> _fallbackToPlainText(String html) {
    // 移除所有 HTML 标签
    final plainText = html
        .replaceAll(RegExp(r'<br\s*/?>'), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'&nbsp;'), ' ')
        .replaceAll(RegExp(r'&lt;'), '<')
        .replaceAll(RegExp(r'&gt;'), '>')
        .replaceAll(RegExp(r'&amp;'), '&')
        .replaceAll(RegExp(r'&quot;'), '"')
        .trim();

    if (plainText.isEmpty) {
      return [
        {'insert': '\n'}
      ];
    }

    return [
      {'insert': '$plainText\n'}
    ];
  }
}
