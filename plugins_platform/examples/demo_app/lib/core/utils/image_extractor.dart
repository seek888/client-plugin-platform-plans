/// 图片 URL 提取工具类
///
/// 从 RSS/Atom 内容中提取图片 URL
/// 支持从 media:content、enclosure、HTML 内容中提取
class ImageExtractor {
  /// 从 HTML 内容中提取第一个图片 URL
  ///
  /// [html] - HTML 内容字符串
  /// 返回第一个找到的图片 URL，如果没有找到则返回 null
  static String? extractFromHtml(String? html) {
    if (html == null || html.isEmpty) return null;

    // 匹配 img 标签的 src 属性
    final imgRegex = RegExp(
      r'''<img[^>]+src=["']([^"']+)["']''',
      caseSensitive: false,
    );
    final match = imgRegex.firstMatch(html);
    return match?.group(1);
  }

  /// 从 HTML 内容中提取所有图片 URL
  ///
  /// [html] - HTML 内容字符串
  /// 返回所有找到的图片 URL 列表
  static List<String> extractAllFromHtml(String? html) {
    if (html == null || html.isEmpty) return [];

    final imgRegex = RegExp(
      r'''<img[^>]+src=["']([^"']+)["']''',
      caseSensitive: false,
    );

    return imgRegex
        .allMatches(html)
        .map((match) => match.group(1))
        .whereType<String>()
        .toList();
  }

  /// 检查 URL 是否为图片
  ///
  /// [url] - URL 字符串
  /// 返回是否为图片 URL
  static bool isImageUrl(String url) {
    final lowerUrl = url.toLowerCase();
    return lowerUrl.endsWith('.jpg') ||
        lowerUrl.endsWith('.jpeg') ||
        lowerUrl.endsWith('.png') ||
        lowerUrl.endsWith('.gif') ||
        lowerUrl.endsWith('.webp') ||
        lowerUrl.endsWith('.svg') ||
        lowerUrl.endsWith('.bmp') ||
        lowerUrl.endsWith('.ico');
  }

  /// 检查 MIME 类型是否为图片
  ///
  /// [mimeType] - MIME 类型字符串
  /// 返回是否为图片 MIME 类型
  static bool isImageMimeType(String? mimeType) {
    if (mimeType == null) return false;
    return mimeType.toLowerCase().startsWith('image/');
  }

  /// 从 srcset 属性中提取最佳图片 URL
  ///
  /// [srcset] - srcset 属性值
  /// 返回最高分辨率的图片 URL
  static String? extractFromSrcset(String? srcset) {
    if (srcset == null || srcset.isEmpty) return null;

    // srcset 格式: "url1 1x, url2 2x" 或 "url1 100w, url2 200w"
    final entries = srcset.split(',').map((e) => e.trim()).toList();

    String? bestUrl;
    double bestValue = 0;

    for (final entry in entries) {
      final parts = entry
          .split(RegExp(r'\s+'))
          .where((p) => p.isNotEmpty)
          .toList();
      if (parts.isEmpty) continue;

      final url = parts[0];
      double value = 1;

      if (parts.length > 1) {
        final descriptor = parts[1].toLowerCase();
        if (descriptor.endsWith('x')) {
          value = double.tryParse(descriptor.replaceAll('x', '')) ?? 1;
        } else if (descriptor.endsWith('w')) {
          value = double.tryParse(descriptor.replaceAll('w', '')) ?? 1;
        }
      }

      if (value > bestValue) {
        bestValue = value;
        bestUrl = url;
      }
    }

    return bestUrl;
  }

  /// 从 Open Graph meta 标签中提取图片 URL
  ///
  /// [html] - HTML 内容字符串
  /// 返回 og:image 的值
  static String? extractOpenGraphImage(String? html) {
    if (html == null || html.isEmpty) return null;

    // 匹配 <meta property="og:image" content="...">
    final ogRegex = RegExp(
      r'''<meta[^>]+property=["']og:image["'][^>]+content=["']([^"']+)["']''',
      caseSensitive: false,
    );
    var match = ogRegex.firstMatch(html);
    if (match != null) return match.group(1);

    // 也尝试匹配 content 在 property 之前的情况
    final ogRegex2 = RegExp(
      r'''<meta[^>]+content=["']([^"']+)["'][^>]+property=["']og:image["']''',
      caseSensitive: false,
    );
    match = ogRegex2.firstMatch(html);
    return match?.group(1);
  }

  /// 从 Twitter Card meta 标签中提取图片 URL
  ///
  /// [html] - HTML 内容字符串
  /// 返回 twitter:image 的值
  static String? extractTwitterImage(String? html) {
    if (html == null || html.isEmpty) return null;

    // 匹配 <meta name="twitter:image" content="...">
    final twitterRegex = RegExp(
      r'''<meta[^>]+name=["']twitter:image["'][^>]+content=["']([^"']+)["']''',
      caseSensitive: false,
    );
    var match = twitterRegex.firstMatch(html);
    if (match != null) return match.group(1);

    // 也尝试匹配 content 在 name 之前的情况
    final twitterRegex2 = RegExp(
      r'''<meta[^>]+content=["']([^"']+)["'][^>]+name=["']twitter:image["']''',
      caseSensitive: false,
    );
    match = twitterRegex2.firstMatch(html);
    return match?.group(1);
  }

  /// 规范化图片 URL
  ///
  /// [url] - 图片 URL
  /// [baseUrl] - 基础 URL（用于处理相对路径）
  /// 返回规范化后的绝对 URL
  static String? normalizeUrl(String? url, {String? baseUrl}) {
    if (url == null || url.isEmpty) return null;

    // 已经是绝对 URL
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }

    // 协议相对 URL
    if (url.startsWith('//')) {
      return 'https:$url';
    }

    // 相对 URL，需要基础 URL
    if (baseUrl != null && baseUrl.isNotEmpty) {
      try {
        final base = Uri.parse(baseUrl);
        final resolved = base.resolve(url);
        return resolved.toString();
      } catch (_) {
        return null;
      }
    }

    return null;
  }
}
