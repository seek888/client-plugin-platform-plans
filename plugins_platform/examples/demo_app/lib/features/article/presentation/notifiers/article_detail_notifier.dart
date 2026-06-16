import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/database/database_provider.dart';
import 'package:rss_reader/features/article/data/services/article_cache_service_impl.dart';
import 'package:rss_reader/features/article/data/services/article_fetcher_service_impl.dart';
import 'package:rss_reader/features/article/data/services/article_navigation_service_impl.dart';
import 'package:rss_reader/features/article/domain/repositories/article_repository.dart';
import 'package:rss_reader/features/article/domain/services/article_cache_service.dart';
import 'package:rss_reader/features/article/domain/services/article_fetcher_service.dart';
import 'package:rss_reader/features/article/domain/services/article_navigation_service.dart';
import 'package:rss_reader/features/article/presentation/notifiers/article_list_notifier.dart';
import 'package:rss_reader/features/article/presentation/providers/article_editor_provider.dart';
import 'package:rss_reader/features/article/presentation/side_effects/article_detail_side_effect.dart';
import 'package:rss_reader/features/article/presentation/states/article_detail_state.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/repositories/feed_repository.dart';
import 'package:rss_reader/features/feed/presentation/notifiers/feed_list_notifier.dart';

part 'article_detail_notifier.g.dart';

/// 文章缓存服务 Provider
@riverpod
ArticleCacheService articleCacheService(Ref ref) {
  final articleDao = ref.watch(articleDaoProvider);
  return ArticleCacheServiceImpl(articleDao: articleDao);
}

/// 文章导航服务 Provider
@riverpod
ArticleNavigationService articleNavigationService(Ref ref) {
  final articleDao = ref.watch(articleDaoProvider);
  return ArticleNavigationServiceImpl(articleDao: articleDao);
}

/// 文章内容抓取服务 Provider
@riverpod
ArticleFetcherService articleFetcherService(Ref ref) {
  return ArticleFetcherServiceImpl();
}

/// 文章详情 Notifier
/// 负责管理文章详情页的状态和业务逻辑
@riverpod
class ArticleDetailNotifier extends _$ArticleDetailNotifier {
  StreamController<ArticleDetailSideEffect>? _sideEffectController;
  bool _isDisposed = false;

  /// 获取文章仓库
  ArticleRepository get _articleRepository =>
      ref.read(articleRepositoryProvider);

  /// 获取缓存服务
  ArticleCacheService get _cacheService =>
      ref.read(articleCacheServiceProvider);

  /// 获取导航服务
  ArticleNavigationService get _navigationService =>
      ref.read(articleNavigationServiceProvider);

  /// 获取内容抓取服务
  ArticleFetcherService get _fetcherService =>
      ref.read(articleFetcherServiceProvider);

  /// 获取订阅源仓库
  FeedRepository get _feedRepository => ref.read(feedRepositoryProvider);

  /// 获取或创建副作用控制器
  StreamController<ArticleDetailSideEffect> get _controller {
    _sideEffectController ??=
        StreamController<ArticleDetailSideEffect>.broadcast();
    return _sideEffectController!;
  }

  /// 副作用流
  Stream<ArticleDetailSideEffect> get sideEffect => _controller.stream;

  /// 安全地添加副作用事件
  void _addSideEffect(ArticleDetailSideEffect effect) {
    if (!_isDisposed &&
        _sideEffectController != null &&
        !_sideEffectController!.isClosed) {
      _sideEffectController!.add(effect);
    }
  }

  @override
  ArticleDetailState build(String articleId) {
    _isDisposed = false;

    // 确保创建新的控制器
    _sideEffectController =
        StreamController<ArticleDetailSideEffect>.broadcast();

    // 清理资源
    ref.onDispose(() {
      _isDisposed = true;
      _sideEffectController?.close();
      _sideEffectController = null;
    });

    // 初始加载
    _loadArticleDetail(articleId);

    return const ArticleDetailState.initial();
  }

  /// 加载文章详情
  Future<void> _loadArticleDetail(String articleId) async {
    state = const ArticleDetailState.loading();

    final result = await _articleRepository.getArticleDetail(articleId);

    await result.fold(
      (failure) async {
        state = ArticleDetailState.error(message: failure.userMessage);
      },
      (article) async {
        // 获取订阅源信息
        Feed? feed;
        final feedResult = await _feedRepository.getFeedById(article.feedId);
        feedResult.fold((_) => feed = null, (f) => feed = f);

        // 获取文章位置信息
        final positionResult = await _navigationService.getArticlePosition(
          articleId,
          article.feedId,
        );

        // 检查是否有编辑版本
        var displayArticle = article;
        try {
          final editedArticleDao = ref.read(editedArticleDaoProvider);
          final editedContent = await editedArticleDao.getEditedContent(articleId);
          if (editedContent != null) {
            // 使用编辑后的内容
            displayArticle = article.copyWith(
              content: editedContent.htmlContent,
              summary: editedContent.summary,
            );
          }
        } catch (_) {
          // 忽略错误，使用原始内容
        }

        // 先显示已有内容
        state = ArticleDetailState.loaded(
          article: displayArticle,
          feed: feed,
          position: positionResult.fold((_) => null, (p) => p),
        );

        // 自动标记为已读
        if (!article.isRead) {
          await _articleRepository.markAsRead(articleId, true);
          // 更新本地状态
          state = state.maybeMap(
            loaded: (s) =>
                s.copyWith(article: s.article.copyWith(isRead: true)),
            orElse: () => state,
          );

          // 同步更新文章列表中的已读状态（跳过数据库操作，因为上面已经更新过了）
          ref
              .read(articleListNotifierProvider.notifier)
              .onMarkAsRead(articleId, skipDatabase: true);
        }

        // 检查是否需要抓取完整内容（仅当没有编辑版本时）
        if (displayArticle == article && _fetcherService.shouldFetchFullContent(
            article.content, article.summary)) {
          await _fetchFullContent(article);
        }
      },
    );
  }

  /// 抓取文章完整内容
  Future<void> _fetchFullContent(article) async {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    // 显示正在加载完整内容的状态
    state = currentState.copyWith(isFetchingContent: true);

    final result = await _fetcherService.fetchArticleContent(
      currentState.article.link,
    );

    result.fold(
      (failure) {
        // 抓取失败，保持原有内容，只更新加载状态
        state = currentState.copyWith(isFetchingContent: false);
        // 不显示错误提示，因为原有摘要内容仍可阅读
      },
      (fullContent) async {
        // 更新文章内容
        final updatedArticle = currentState.article.copyWith(
          content: fullContent,
        );

        state = currentState.copyWith(
          article: updatedArticle,
          isFetchingContent: false,
        );

        // 将完整内容保存到数据库
        await _saveFullContent(currentState.article.id, fullContent);
      },
    );
  }

  /// 保存完整内容到数据库
  Future<void> _saveFullContent(String articleId, String content) async {
    try {
      final articleDao = ref.read(articleDaoProvider);
      await articleDao.updateArticleContent(articleId, content);
    } catch (_) {
      // 保存失败不影响显示
    }
  }

  /// Intent: 刷新文章详情
  Future<void> onRefresh() async {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    await _loadArticleDetail(currentState.article.id);
  }

  /// Intent: 切换收藏状态
  Future<void> onToggleFavorite() async {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    final result = await _articleRepository.toggleFavorite(
      currentState.article.id,
    );

    result.fold(
      (failure) {
        _addSideEffect(
          ArticleDetailSideEffect.showToast(message: '操作失败', isError: true),
        );
      },
      (_) {
        final newFavoriteStatus = !currentState.article.isFavorite;
        state = currentState.copyWith(
          article: currentState.article.copyWith(isFavorite: newFavoriteStatus),
        );

        _addSideEffect(
          ArticleDetailSideEffect.showToast(
            message: newFavoriteStatus ? '已收藏' : '已取消收藏',
          ),
        );
      },
    );
  }

  /// Intent: 缓存文章
  Future<void> onCacheArticle() async {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    if (currentState.article.isCached) {
      // 已缓存，取消缓存
      state = currentState.copyWith(isCaching: true);

      final result = await _cacheService.uncacheArticle(
        currentState.article.id,
      );

      result.fold(
        (failure) {
          state = currentState.copyWith(isCaching: false);
          _addSideEffect(
            ArticleDetailSideEffect.showToast(message: '取消缓存失败', isError: true),
          );
        },
        (_) {
          state = currentState.copyWith(
            isCaching: false,
            article: currentState.article.copyWith(isCached: false),
          );
          _addSideEffect(
            const ArticleDetailSideEffect.showToast(message: '已取消缓存'),
          );
        },
      );
    } else {
      // 未缓存，进行缓存
      state = currentState.copyWith(isCaching: true);

      final result = await _cacheService.cacheArticle(currentState.article.id);

      result.fold(
        (failure) {
          state = currentState.copyWith(isCaching: false);
          _addSideEffect(
            ArticleDetailSideEffect.showToast(message: '缓存失败', isError: true),
          );
        },
        (_) {
          state = currentState.copyWith(
            isCaching: false,
            article: currentState.article.copyWith(isCached: true),
          );
          _addSideEffect(
            const ArticleDetailSideEffect.showToast(message: '已缓存'),
          );
        },
      );
    }
  }

  /// Intent: 翻译文章（模拟）
  Future<void> onTranslate() async {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    if (currentState.showTranslation) {
      // 切换回原文
      state = currentState.copyWith(showTranslation: false);
      _addSideEffect(
        const ArticleDetailSideEffect.showToast(message: '已切换为原文'),
      );
    } else if (currentState.translatedContent != null) {
      // 已有翻译，切换显示
      state = currentState.copyWith(showTranslation: true);
      _addSideEffect(
        const ArticleDetailSideEffect.showToast(message: '已切换为译文'),
      );
    } else {
      // 需要翻译
      state = currentState.copyWith(isTranslating: true);

      // 模拟翻译延迟（实际应调用翻译服务）
      await Future.delayed(const Duration(seconds: 1));

      // 模拟翻译结果（实际应返回真实翻译）
      final translatedContent =
          '[翻译内容] ${currentState.article.content ?? currentState.article.summary ?? ''}';

      state = currentState.copyWith(
        isTranslating: false,
        translatedContent: translatedContent,
        showTranslation: true,
      );

      _addSideEffect(const ArticleDetailSideEffect.showToast(message: '翻译完成'));
    }
  }

  /// Intent: 导航到上一篇文章
  Future<void> onNavigateToPrevious() async {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    final result = await _navigationService.getPreviousArticle(
      currentState.article.id,
      currentState.article.feedId,
    );

    result.fold(
      (failure) {
        _addSideEffect(
          ArticleDetailSideEffect.showToast(message: '获取上一篇失败', isError: true),
        );
      },
      (article) {
        if (article != null) {
          _addSideEffect(
            ArticleDetailSideEffect.navigateToPrevious(articleId: article.id),
          );
        } else {
          _addSideEffect(
            const ArticleDetailSideEffect.showToast(message: '已经是第一篇了'),
          );
        }
      },
    );
  }

  /// Intent: 导航到下一篇文章
  Future<void> onNavigateToNext() async {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    final result = await _navigationService.getNextArticle(
      currentState.article.id,
      currentState.article.feedId,
    );

    result.fold(
      (failure) {
        _addSideEffect(
          ArticleDetailSideEffect.showToast(message: '获取下一篇失败', isError: true),
        );
      },
      (article) {
        if (article != null) {
          _addSideEffect(
            ArticleDetailSideEffect.navigateToNext(articleId: article.id),
          );
        } else {
          _addSideEffect(
            const ArticleDetailSideEffect.showToast(message: '已经是最后一篇了'),
          );
        }
      },
    );
  }

  /// Intent: 导航到订阅源列表
  void onNavigateToFeed() {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    _addSideEffect(
      ArticleDetailSideEffect.navigateToFeed(
        feedId: currentState.article.feedId,
      ),
    );
  }

  /// Intent: 返回上一页
  void onGoBack() {
    _addSideEffect(const ArticleDetailSideEffect.goBack());
  }

  /// Intent: 打开外部链接
  void onOpenExternalLink(String url) {
    _addSideEffect(ArticleDetailSideEffect.openExternalLink(url: url));
  }

  /// Intent: 打开原文链接
  void onOpenOriginalLink() {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    _addSideEffect(
      ArticleDetailSideEffect.openExternalLink(url: currentState.article.link),
    );
  }

  /// Intent: 显示图片查看器
  void onShowImageViewer(
    String imageUrl, {
    List<String>? allImages,
    int? initialIndex,
  }) {
    _addSideEffect(
      ArticleDetailSideEffect.showImageViewer(
        imageUrl: imageUrl,
        allImages: allImages,
        initialIndex: initialIndex,
      ),
    );
  }

  /// Intent: 分享文章
  void onShareArticle() {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    _addSideEffect(
      ArticleDetailSideEffect.shareArticle(
        title: currentState.article.title,
        link: currentState.article.link,
      ),
    );
  }

  /// Intent: 复制链接
  void onCopyLink() {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    _addSideEffect(
      ArticleDetailSideEffect.copyLink(link: currentState.article.link),
    );
  }

  /// Intent: 更新阅读进度
  Future<void> onUpdateReadProgress(int progress) async {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    // 更新本地状态
    state = currentState.copyWith(readProgress: progress);

    // 保存到数据库
    await _articleRepository.updateReadProgress(
      currentState.article.id,
      progress,
    );
  }

  /// Intent: 调整字体大小
  void onFontScaleChanged(double scale) {
    final currentState = state;
    if (currentState is! ArticleDetailStateLoaded) return;

    state = currentState.copyWith(fontScale: scale.clamp(0.8, 1.5));
  }

  /// Intent: 显示批注菜单
  void onShowAnnotationMenu(
    String selectedText,
    int startOffset,
    int endOffset,
  ) {
    _addSideEffect(
      ArticleDetailSideEffect.showAnnotationMenu(
        selectedText: selectedText,
        startOffset: startOffset,
        endOffset: endOffset,
      ),
    );
  }

  /// Intent: 划词翻译
  Future<void> onWordTranslate(String text) async {
    // 模拟翻译（实际应调用翻译服务）
    await Future.delayed(const Duration(milliseconds: 500));

    _addSideEffect(
      ArticleDetailSideEffect.showWordTranslation(
        originalText: text,
        translatedText: '[翻译] $text',
      ),
    );
  }
}

/// 副作用 Provider
@riverpod
Stream<ArticleDetailSideEffect> articleDetailSideEffect(
  Ref ref,
  String articleId,
) {
  return ref
      .watch(articleDetailNotifierProvider(articleId).notifier)
      .sideEffect;
}
