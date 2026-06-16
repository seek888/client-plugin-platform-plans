import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';

/// HTML 与 Quill Delta 格式转换服务接口
abstract class ContentConverter {
  /// 将 HTML 转换为 Quill Delta
  ///
  /// [html] - 输入的 HTML 字符串
  /// 返回 Quill Delta JSON 列表，失败时返回 Failure
  Either<Failure, List<Map<String, dynamic>>> htmlToDelta(String html);

  /// 将 Quill Delta 转换为 HTML
  ///
  /// [delta] - Quill Delta JSON 列表
  /// 返回 HTML 字符串，失败时返回 Failure
  Either<Failure, String> deltaToHtml(List<Map<String, dynamic>> delta);

  /// 从 Delta 提取纯文本
  ///
  /// [delta] - Quill Delta JSON 列表
  /// 返回纯文本字符串
  String deltaToPlainText(List<Map<String, dynamic>> delta);

  /// 从 Delta 提取摘要（前 N 个字符）
  ///
  /// [delta] - Quill Delta JSON 列表
  /// [maxLength] - 最大长度，默认 200
  /// 返回摘要字符串
  String extractSummary(List<Map<String, dynamic>> delta, {int maxLength = 200});
}
