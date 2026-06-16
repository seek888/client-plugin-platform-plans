import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsed_feed.freezed.dart';
part 'parsed_feed.g.dart';

/// Feed 类型枚举
enum FeedType { rss1, rss2, atom, unknown }

/// 解析后的统一 Feed 模型
@freezed
class ParsedFeed with _$ParsedFeed {
  const ParsedFeed._();

  const factory ParsedFeed({
    required String title,
    String? description,
    String? link,
    String? iconUrl,
    required List<ParsedArticle> articles,
    required FeedType feedType,
    DateTime? lastUpdated,
  }) = _ParsedFeed;

  factory ParsedFeed.fromJson(Map<String, dynamic> json) =>
      _$ParsedFeedFromJson(json);

  /// 是否为空 Feed
  bool get isEmpty => articles.isEmpty;

  /// 文章数量
  int get articleCount => articles.length;
}

/// 解析后的统一文章模型
@freezed
class ParsedArticle with _$ParsedArticle {
  const ParsedArticle._();

  const factory ParsedArticle({
    String? guid,
    required String title,
    String? summary,
    String? content,
    String? author,
    String? link,
    String? imageUrl,
    DateTime? publishedAt,
    @Default([]) List<String> categories,
  }) = _ParsedArticle;

  factory ParsedArticle.fromJson(Map<String, dynamic> json) =>
      _$ParsedArticleFromJson(json);

  /// 获取唯一标识符（优先使用 guid，否则使用 link）
  String get uniqueId => guid ?? link ?? title;

  /// 获取显示内容（优先使用 content，否则使用 summary）
  String? get displayContent => content ?? summary;

  /// 是否有图片
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;
}
