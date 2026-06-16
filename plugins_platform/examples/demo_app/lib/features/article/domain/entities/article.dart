import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

/// 文章排序类型
enum ArticleSortType {
  /// 时间倒序（最新优先）
  timeDesc,

  /// 时间正序（最早优先）
  timeAsc,

  /// 未读优先
  unreadFirst,
}

/// 文章筛选类型
enum ArticleFilterType {
  /// 全部
  all,

  /// 仅未读
  unread,

  /// 仅已读
  read,

  /// 仅收藏
  favorite,
}

/// 文章实体
@freezed
class Article with _$Article {
  const Article._();

  const factory Article({
    required String id,
    required String feedId,
    required String title,
    String? summary,
    String? content,
    String? author,
    required String link,
    String? imageUrl,
    DateTime? publishedAt,
    @Default(false) bool isRead,
    @Default(false) bool isFavorite,
    @Default(false) bool isCached,
    @Default(false) bool isBlocked,
    @Default(0) int readProgress,
    String? favoriteFolderId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  /// 是否有封面图
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  /// 是否有内容
  bool get hasContent => content != null && content!.isNotEmpty;

  /// 获取显示内容（优先内容，其次摘要）
  String? get displayContent => content ?? summary;
}
