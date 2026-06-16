import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rss_reader/features/article/domain/entities/article.dart';
import 'package:rss_reader/features/article/domain/services/article_navigation_service.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

part 'article_detail_state.freezed.dart';

/// 文章详情状态
/// 使用 freezed 生成不可变状态类
@freezed
class ArticleDetailState with _$ArticleDetailState {
  /// 初始状态
  const factory ArticleDetailState.initial() = ArticleDetailStateInitial;

  /// 加载中状态
  const factory ArticleDetailState.loading() = ArticleDetailStateLoading;

  /// 加载成功状态
  const factory ArticleDetailState.loaded({
    /// 文章详情
    required Article article,

    /// 所属订阅源
    Feed? feed,

    /// 文章位置信息
    ArticlePosition? position,

    /// 是否正在缓存
    @Default(false) bool isCaching,

    /// 是否正在抓取完整内容
    @Default(false) bool isFetchingContent,

    /// 是否正在翻译
    @Default(false) bool isTranslating,

    /// 翻译后的内容（null 表示显示原文）
    String? translatedContent,

    /// 是否显示翻译内容
    @Default(false) bool showTranslation,

    /// 当前阅读进度（0-100）
    @Default(0) int readProgress,

    /// 字体大小缩放比例
    @Default(1.0) double fontScale,
  }) = ArticleDetailStateLoaded;

  /// 错误状态
  const factory ArticleDetailState.error({required String message}) =
      ArticleDetailStateError;
}
