import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/features/article/data/services/delta_to_html_converter.dart';
import 'package:rss_reader/features/article/data/services/html_to_delta_converter.dart';
import 'package:rss_reader/features/article/domain/services/content_converter.dart';

final _log = logger.tag('ContentConverterImpl');

/// ContentConverter 接口实现
class ContentConverterImpl implements ContentConverter {
  final HtmlToDeltaConverter _htmlToDeltaConverter;
  final DeltaToHtmlConverter _deltaToHtmlConverter;

  ContentConverterImpl({
    HtmlToDeltaConverter? htmlToDeltaConverter,
    DeltaToHtmlConverter? deltaToHtmlConverter,
  })  : _htmlToDeltaConverter = htmlToDeltaConverter ?? HtmlToDeltaConverter(),
        _deltaToHtmlConverter = deltaToHtmlConverter ?? DeltaToHtmlConverter();

  @override
  Either<Failure, List<Map<String, dynamic>>> htmlToDelta(String html) {
    try {
      final delta = _htmlToDeltaConverter.convert(html);
      return Right(delta);
    } catch (e, stackTrace) {
      _log.error('HTML 转 Delta 失败', error: e, stackTrace: stackTrace);
      return Left(Failure.htmlParse(
        message: 'HTML 解析失败: ${e.toString()}',
        htmlSnippet: html.length > 100 ? '${html.substring(0, 100)}...' : html,
      ));
    }
  }

  @override
  Either<Failure, String> deltaToHtml(List<Map<String, dynamic>> delta) {
    try {
      final html = _deltaToHtmlConverter.convert(delta);
      return Right(html);
    } catch (e, stackTrace) {
      _log.error('Delta 转 HTML 失败', error: e, stackTrace: stackTrace);
      return Left(Failure.deltaConversion(
        message: 'Delta 转换失败: ${e.toString()}',
        details: 'Delta 操作数: ${delta.length}',
      ));
    }
  }

  @override
  String deltaToPlainText(List<Map<String, dynamic>> delta) {
    return _deltaToHtmlConverter.extractPlainText(delta);
  }

  @override
  String extractSummary(List<Map<String, dynamic>> delta, {int maxLength = 200}) {
    final plainText = deltaToPlainText(delta).trim();
    if (plainText.length <= maxLength) {
      return plainText;
    }
    // 尝试在单词边界截断
    final truncated = plainText.substring(0, maxLength);
    final lastSpace = truncated.lastIndexOf(' ');
    if (lastSpace > maxLength * 0.8) {
      return '${truncated.substring(0, lastSpace)}...';
    }
    return '$truncated...';
  }
}
