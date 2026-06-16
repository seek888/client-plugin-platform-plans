import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rss_reader/features/article/presentation/notifiers/article_detail_notifier.dart';
import 'package:rss_reader/features/article/presentation/providers/article_content_renderer_provider.dart';
import 'package:rss_reader/features/article/presentation/side_effects/article_detail_side_effect.dart';
import 'package:rss_reader/shared/providers/providers.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// 文章详情页（移动端全屏页面）
class ArticleDetailPage extends HookConsumerWidget {
  final String articleId;

  const ArticleDetailPage({super.key, required this.articleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(articleDetailNotifierProvider(articleId));
    final notifier = ref.read(
      articleDetailNotifierProvider(articleId).notifier,
    );
    final renderer = ref.watch(articleContentRendererProvider);
    final renderConfig = ref.watch(articleRenderConfigProvider);
    final scrollController = useScrollController();

    // 阅读进度
    final readProgress = useState(0.0);

    // 监听滚动更新进度
    useEffect(() {
      void onScroll() {
        if (scrollController.hasClients &&
            scrollController.position.maxScrollExtent > 0) {
          final progress = scrollController.offset /
              scrollController.position.maxScrollExtent;
          readProgress.value = progress.clamp(0.0, 1.0);

          // 更新阅读进度（每 10% 更新一次）
          final progressPercent = (progress * 100).round();
          if (progressPercent % 10 == 0) {
            notifier.onUpdateReadProgress(progressPercent);
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    // 处理副作用
    useEffect(() {
      final notifierInstance = ref.read(
        articleDetailNotifierProvider(articleId).notifier,
      );
      final subscription = notifierInstance.sideEffect.listen((sideEffect) {
        _handleSideEffect(context, ref, sideEffect, notifier);
      });
      return () => subscription.cancel();
    }, [articleId]);

    return Scaffold(
      body: state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (
          article,
          feed,
          position,
          isCaching,
          isFetchingContent,
          isTranslating,
          translatedContent,
          showTranslation,
          savedProgress,
          fontScale,
        ) {
          final content = showTranslation && translatedContent != null
              ? translatedContent
              : article.content ?? article.summary ?? '';

          final effectiveConfig = renderConfig.copyWith(
            fontSize: renderConfig.fontSize * fontScale,
            onLinkTap: (url) => notifier.onOpenExternalLink(url),
            onImageTap: (imageUrl) => notifier.onShowImageViewer(imageUrl),
          );

          return Stack(
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  // 顶部 AppBar
                  _buildAppBar(context, notifier, article, feed),
                  // 正在加载完整内容提示
                  if (isFetchingContent)
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.3),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '正在加载完整内容...',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  // 文章内容
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // 文章标题
                        SelectableText(
                          article.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                        ),
                        const SizedBox(height: 16),
                        // 元信息
                        _buildMetaInfo(context, article, feed, position),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 24),
                        // 文章内容
                        renderer.renderContent(content, effectiveConfig),
                        const SizedBox(height: 100), // 底部留白
                      ]),
                    ),
                  ),
                ],
              ),
              // 阅读进度条
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: LinearProgressIndicator(
                    value: readProgress.value,
                    backgroundColor: Colors.transparent,
                    minHeight: 2,
                  ),
                ),
              ),
            ],
          );
        },
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(message),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => notifier.onRefresh(),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
      // 底部导航栏
      bottomNavigationBar: state.maybeWhen(
        loaded: (article, feed, position, _, __, ___, ____, _____, ______,
                _______) =>
            _buildBottomBar(context, notifier, article, position),
        orElse: () => null,
      ),
    );
  }

  /// 构建顶部 AppBar
  Widget _buildAppBar(
    BuildContext context,
    ArticleDetailNotifier notifier,
    article,
    feed,
  ) {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: feed != null
          ? InkWell(
              onTap: () => notifier.onNavigateToFeed(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (feed.iconUrl != null && feed.iconUrl!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          feed.iconUrl!,
                          width: 24,
                          height: 24,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.rss_feed, size: 24),
                        ),
                      ),
                    ),
                  Flexible(
                    child: Text(feed.title, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            )
          : null,
      actions: [
        IconButton(
          icon: Icon(
            article.isFavorite ? Icons.star : Icons.star_outline,
            color: article.isFavorite
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
          tooltip: article.isFavorite ? '取消收藏' : '收藏',
          onPressed: () => notifier.onToggleFavorite(),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                context.push('/article/$articleId/edit');
                break;
              case 'cache':
                notifier.onCacheArticle();
                break;
              case 'translate':
                notifier.onTranslate();
                break;
              case 'share':
                notifier.onShareArticle();
                break;
              case 'open_browser':
                notifier.onOpenOriginalLink();
                break;
              case 'copy_link':
                notifier.onCopyLink();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined),
                  SizedBox(width: 12),
                  Text('编辑'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'cache',
              child: Row(
                children: [
                  Icon(
                    article.isCached
                        ? Icons.offline_pin
                        : Icons.download_for_offline_outlined,
                  ),
                  const SizedBox(width: 12),
                  Text(article.isCached ? '取消缓存' : '缓存'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'translate',
              child: Row(
                children: [
                  Icon(Icons.translate),
                  SizedBox(width: 12),
                  Text('翻译'),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share_outlined),
                  SizedBox(width: 12),
                  Text('分享'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'open_browser',
              child: Row(
                children: [
                  Icon(Icons.open_in_new),
                  SizedBox(width: 12),
                  Text('在浏览器中打开'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'copy_link',
              child: Row(
                children: [Icon(Icons.link), SizedBox(width: 12), Text('复制链接')],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 构建元信息
  Widget _buildMetaInfo(BuildContext context, article, feed, position) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final theme = Theme.of(context);

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // 作者
        if (article.author != null && article.author!.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person_outline,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                article.author!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        // 发布时间
        if (article.publishedAt != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                dateFormat.format(article.publishedAt!),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        // 文章位置
        if (position != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.article_outlined,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                '${position.currentIndex} / ${position.totalCount}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
      ],
    );
  }

  /// 构建底部导航栏
  Widget _buildBottomBar(
    BuildContext context,
    ArticleDetailNotifier notifier,
    article,
    position,
  ) {
    final hasPrevious = position?.hasPrevious ?? false;
    final hasNext = position?.hasNext ?? false;

    return SafeArea(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            // 上一篇
            Expanded(
              child: InkWell(
                onTap:
                    hasPrevious ? () => notifier.onNavigateToPrevious() : null,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: hasPrevious
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).disabledColor,
                      ),
                      Text(
                        '上一篇',
                        style: TextStyle(
                          color: hasPrevious
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 分隔线
            Container(
              width: 1,
              height: 24,
              color: Theme.of(context).dividerColor,
            ),
            // 下一篇
            Expanded(
              child: InkWell(
                onTap: hasNext ? () => notifier.onNavigateToNext() : null,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '下一篇',
                        style: TextStyle(
                          color: hasNext
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).disabledColor,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: hasNext
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).disabledColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 处理副作用
  void _handleSideEffect(
    BuildContext context,
    WidgetRef ref,
    ArticleDetailSideEffect sideEffect,
    ArticleDetailNotifier notifier,
  ) {
    sideEffect.when(
      showToast: (message, isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor:
                isError ? Theme.of(context).colorScheme.error : null,
          ),
        );
      },
      navigateToPrevious: (newArticleId) {
        // 更新全局选中状态并导航
        ref.read(selectedArticleIdProvider.notifier).state = newArticleId;
        context.go('/article/$newArticleId');
      },
      navigateToNext: (newArticleId) {
        // 更新全局选中状态并导航
        ref.read(selectedArticleIdProvider.notifier).state = newArticleId;
        context.go('/article/$newArticleId');
      },
      navigateToFeed: (feedId) {
        // 更新选中的订阅源并返回
        ref.read(selectedFeedIdProvider.notifier).state = feedId;
        context.go('/');
      },
      goBack: () {
        context.pop();
      },
      openExternalLink: (url) async {
        final uri = Uri.tryParse(url);
        if (uri != null && await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      showImageViewer: (imageUrl, allImages, initialIndex) {
        // 显示图片查看器
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => _ImageViewerPage(
              imageUrl: imageUrl,
              allImages: allImages,
              initialIndex: initialIndex,
            ),
          ),
        );
      },
      shareArticle: (title, link) async {
        await Share.share('$title\n$link');
      },
      copyLink: (link) async {
        await Clipboard.setData(ClipboardData(text: link));
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('链接已复制')));
        }
      },
      showConfirmDialog: (title, message, onConfirm, onCancel) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onCancel?.call();
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onConfirm();
                },
                child: const Text('确定'),
              ),
            ],
          ),
        );
      },
      showAnnotationMenu: (selectedText, startOffset, endOffset) {
        // 显示批注菜单
        showModalBottomSheet(
          context: context,
          builder: (sheetContext) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.note_add),
                  title: const Text('添加批注'),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    // TODO: 实现批注功能
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.translate),
                  title: const Text('翻译'),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    notifier.onWordTranslate(selectedText);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.copy),
                  title: const Text('复制'),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: selectedText));
                    if (sheetContext.mounted) {
                      Navigator.of(sheetContext).pop();
                      ScaffoldMessenger.of(
                        sheetContext,
                      ).showSnackBar(const SnackBar(content: Text('已复制')));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
      showWordTranslation: (originalText, translatedText) {
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(originalText),
            content: Text(translatedText),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('关闭'),
              ),
            ],
          ),
        );
      },
      scrollToPosition: (position) {
        // TODO: 实现滚动到指定位置
      },
    );
  }
}

/// 图片查看器页面（移动端全屏）
class _ImageViewerPage extends StatelessWidget {
  final String imageUrl;
  final List<String>? allImages;
  final int? initialIndex;

  const _ImageViewerPage({
    required this.imageUrl,
    this.allImages,
    this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  color: Colors.white,
                ),
              );
            },
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(Icons.broken_image, size: 64, color: Colors.white54),
            ),
          ),
        ),
      ),
    );
  }
}
