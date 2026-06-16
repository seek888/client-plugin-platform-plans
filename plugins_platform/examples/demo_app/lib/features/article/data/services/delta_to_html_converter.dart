import 'package:rss_reader/core/logging/logging.dart';

final _log = logger.tag('DeltaToHtmlConverter');

/// Quill Delta 到 HTML 转换器
class DeltaToHtmlConverter {
  /// 将 Quill Delta JSON 列表转换为 HTML
  ///
  /// [deltaJson] - Delta 操作列表
  /// 返回 HTML 字符串
  String convert(List<Map<String, dynamic>> deltaJson) {
    if (deltaJson.isEmpty) {
      return '';
    }

    try {
      final buffer = StringBuffer();
      var currentBlockType = '';
      var listItems = <String>[];

      for (var i = 0; i < deltaJson.length; i++) {
        final op = deltaJson[i];
        final insert = op['insert'];
        final attributes = op['attributes'] as Map<String, dynamic>?;

        if (insert is String) {
          final lines = insert.split('\n');

          for (var j = 0; j < lines.length; j++) {
            final line = lines[j];
            final isLastSegment = j == lines.length - 1 && !insert.endsWith('\n');

            if (line.isNotEmpty) {
              final formattedText = _applyInlineFormatting(line, attributes);

              // 检查是否是列表项
              if (attributes != null && attributes.containsKey('list')) {
                listItems.add(formattedText);
              } else {
                // 先关闭之前的列表
                if (listItems.isNotEmpty) {
                  buffer.write(_closeList(currentBlockType, listItems));
                  listItems = [];
                  currentBlockType = '';
                }

                // 处理块级格式
                if (attributes != null) {
                  if (attributes.containsKey('header')) {
                    final level = attributes['header'] as int;
                    buffer.write('<h$level>$formattedText</h$level>');
                  } else if (attributes.containsKey('blockquote')) {
                    buffer.write('<blockquote>$formattedText</blockquote>');
                  } else if (attributes.containsKey('code-block')) {
                    buffer.write('<pre><code>$formattedText</code></pre>');
                  } else {
                    buffer.write('<p>$formattedText</p>');
                  }
                } else if (!isLastSegment || line.isNotEmpty) {
                  buffer.write('<p>$formattedText</p>');
                }
              }
            } else if (!isLastSegment) {
              // 空行
              if (listItems.isNotEmpty) {
                // 检查下一个操作是否还是列表
                final nextOp = i + 1 < deltaJson.length ? deltaJson[i + 1] : null;
                final nextAttrs = nextOp?['attributes'] as Map<String, dynamic>?;
                if (nextAttrs == null || !nextAttrs.containsKey('list')) {
                  buffer.write(_closeList(currentBlockType, listItems));
                  listItems = [];
                  currentBlockType = '';
                }
              } else {
                buffer.write('<p><br/></p>');
              }
            }

            // 更新当前块类型
            if (attributes != null && attributes.containsKey('list')) {
              currentBlockType = attributes['list'] as String;
            }
          }
        } else if (insert is Map) {
          // 处理嵌入内容（图片等）
          if (insert.containsKey('image')) {
            final imageUrl = insert['image'] as String;
            final alt = attributes?['alt'] as String? ?? '';
            buffer.write('<img src="$imageUrl" alt="$alt"/>');
          } else if (insert.containsKey('video')) {
            final videoUrl = insert['video'] as String;
            buffer.write('<video src="$videoUrl" controls></video>');
          }
        }
      }

      // 关闭剩余的列表
      if (listItems.isNotEmpty) {
        buffer.write(_closeList(currentBlockType, listItems));
      }

      final html = buffer.toString();
      _log.debug('Delta 转换为 HTML 成功，长度: ${html.length}');
      return html;
    } catch (e, stackTrace) {
      _log.error('Delta 转换失败', error: e, stackTrace: stackTrace);
      // 降级处理：提取纯文本
      return _fallbackToPlainText(deltaJson);
    }
  }

  /// 应用内联格式
  String _applyInlineFormatting(String text, Map<String, dynamic>? attributes) {
    if (attributes == null || text.isEmpty) {
      return _escapeHtml(text);
    }

    var result = _escapeHtml(text);

    // 链接
    if (attributes.containsKey('link')) {
      final href = attributes['link'] as String;
      result = '<a href="$href">$result</a>';
    }

    // 粗体
    if (attributes['bold'] == true) {
      result = '<strong>$result</strong>';
    }

    // 斜体
    if (attributes['italic'] == true) {
      result = '<em>$result</em>';
    }

    // 下划线
    if (attributes['underline'] == true) {
      result = '<u>$result</u>';
    }

    // 删除线
    if (attributes['strike'] == true) {
      result = '<s>$result</s>';
    }

    // 行内代码
    if (attributes['code'] == true) {
      result = '<code>$result</code>';
    }

    return result;
  }

  /// 关闭列表
  String _closeList(String listType, List<String> items) {
    if (items.isEmpty) return '';

    final tag = listType == 'ordered' ? 'ol' : 'ul';
    final buffer = StringBuffer();
    buffer.write('<$tag>');
    for (final item in items) {
      buffer.write('<li>$item</li>');
    }
    buffer.write('</$tag>');
    return buffer.toString();
  }

  /// HTML 转义
  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  /// 降级处理：提取纯文本
  String _fallbackToPlainText(List<Map<String, dynamic>> deltaJson) {
    final buffer = StringBuffer();
    for (final op in deltaJson) {
      final insert = op['insert'];
      if (insert is String) {
        buffer.write(insert);
      }
    }
    final text = buffer.toString().trim();
    return text.isEmpty ? '' : '<p>${_escapeHtml(text)}</p>';
  }

  /// 从 Delta 提取纯文本
  String extractPlainText(List<Map<String, dynamic>> deltaJson) {
    final buffer = StringBuffer();
    for (final op in deltaJson) {
      final insert = op['insert'];
      if (insert is String) {
        buffer.write(insert);
      }
    }
    return buffer.toString();
  }
}
