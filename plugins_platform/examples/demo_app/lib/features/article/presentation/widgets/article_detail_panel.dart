import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rss_reader/features/article/presentation/notifiers/article_detail_notifier.dart';
import 'package:rss_reader/features/article/presentation/providers/article_content_renderer_provider.dart';
import 'package:rss_reader/features/article/presentation/side_effects/article_detail_side_effect.dart';
import 'package:url_launcher/url_launcher.dart';

/// 文章详情面板（桌面端右侧面板）
class ArticleDetailPanel extends HookConsumerWidget {
  final String articleId;

  const ArticleDetailPanel({super.key, required this.articleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(articleDetailNotifierProvider(articleId));
    final notifier = ref.read(
      articleDetailNotifierProvider(articleId).notifier,
    );
    final renderer = ref.watch(articleContentRendererProvider);
    final renderConfig = ref.watch(articleRenderConfigProvider);
    final scrollController = useScrollController();

    // 处理副作用
    useEffect(() {
      final notifierInstance = ref.read(
        articleDetailNotifierProvider(articleId).notifier,
      );
      final subscription = notifierInstance.sideEffect.listen((sideEffect) {
        _handleSideEffect(context, sideEffect, notifier);
      });
      return () => subscription.cancel();
    }, [articleId]);

    return state.when(
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
        readProgress,
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

        return Column(
          children: [
            // 顶部操作栏
            _buildToolbar(
              context,
              notifier,
              article,
              feed,
              isCaching,
              isTranslating,
              showTranslation,
            ),
            const Divider(height: 1),
            // 正在加载完整内容提示
            if (isFetchingContent)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            // 文章内容
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 文章标题
                    SelectableText(
                      article.title,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                  ],
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
    );
  }

  /// 构建顶部操作栏
  Widget _buildToolbar(
    BuildContext context,
    ArticleDetailNotifier notifier,
    article,
    feed,
    bool isCaching,
    bool isTranslating,
    bool showTranslation,
  ) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 订阅源名称（可点击跳转）
          if (feed != null)
            InkWell(
              onTap: () => notifier.onNavigateToFeed(),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                            width: 20,
                            height: 20,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.rss_feed, size: 20),
                          ),
                        ),
                      ),
                    Text(
                      feed.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          const Spacer(),
          // 操作按钮
          _buildActionButton(
            context,
            icon: article.isFavorite ? Icons.star : Icons.star_outline,
            tooltip: article.isFavorite ? '取消收藏' : '收藏',
            isActive: article.isFavorite,
            onPressed: () => notifier.onToggleFavorite(),
          ),
          _buildActionButton(
            context,
            icon: article.isCached
                ? Icons.offline_pin
                : Icons.download_for_offline_outlined,
            tooltip: article.isCached ? '取消缓存' : '缓存',
            isActive: article.isCached,
            isLoading: isCaching,
            onPressed: () => notifier.onCacheArticle(),
          ),
          _buildActionButton(
            context,
            icon: Icons.translate,
            tooltip: showTranslation ? '显示原文' : '翻译',
            isActive: showTranslation,
            isLoading: isTranslating,
            onPressed: () => notifier.onTranslate(),
          ),
          _buildActionButton(
            context,
            icon: Icons.share_outlined,
            tooltip: '分享',
            onPressed: () => notifier.onShareArticle(),
          ),
          _buildActionButton(
            context,
            icon: Icons.open_in_new,
            tooltip: '在浏览器中打开',
            onPressed: () => notifier.onOpenOriginalLink(),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: '更多',
            onSelected: (value) {
              switch (value) {
                case 'copy_link':
                  notifier.onCopyLink();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'copy_link',
                child: Row(
                  children: [
                    Icon(Icons.link),
                    SizedBox(width: 12),
                    Text('复制链接'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建操作按钮
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    bool isActive = false,
    bool isLoading = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                icon,
                color: isActive ? Theme.of(context).colorScheme.primary : null,
              ),
        tooltip: tooltip,
        onPressed: isLoading ? null : onPressed,
      ),
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

  /// 处理副作用
  void _handleSideEffect(
    BuildContext context,
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
      navigateToPrevious: (articleId) {
        // 桌面端：更新选中的文章 ID
        // 实际导航由父组件处理
      },
      navigateToNext: (articleId) {
        // 桌面端：更新选中的文章 ID
        // 实际导航由父组件处理
      },
      navigateToFeed: (feedId) {
        // 桌面端：更新选中的订阅源
        // 实际导航由父组件处理
      },
      goBack: () {
        // 桌面端：清除选中的文章
        // 实际导航由父组件处理
      },
      openExternalLink: (url) async {
        final uri = Uri.tryParse(url);
        if (uri != null && await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      showImageViewer: (imageUrl, allImages, initialIndex) {
        // 显示图片查看器对话框
        showDialog(
          context: context,
          builder: (context) => _ImageViewerDialog(
            imageUrl: imageUrl,
            allImages: allImages,
            initialIndex: initialIndex,
          ),
        );
      },
      shareArticle: (title, link) async {
        // 桌面端：复制到剪贴板
        await Clipboard.setData(ClipboardData(text: '$title\n$link'));
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('已复制到剪贴板')));
        }
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
        // TODO: 实现批注菜单
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

/// 图片查看器对话框（桌面端全屏）
class _ImageViewerDialog extends StatefulWidget {
  final String imageUrl;
  final List<String>? allImages;
  final int? initialIndex;

  const _ImageViewerDialog({
    required this.imageUrl,
    this.allImages,
    this.initialIndex,
  });

  @override
  State<_ImageViewerDialog> createState() => _ImageViewerDialogState();
}

class _ImageViewerDialogState extends State<_ImageViewerDialog> {
  late final TransformationController _transformationController;
  late int _currentIndex;
  late List<String> _images;
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _images = widget.allImages ?? [widget.imageUrl];
    _currentIndex = (widget.initialIndex ?? 0).clamp(0, _images.length - 1);

    _transformationController.addListener(_onTransformChanged);
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onTransformChanged);
    _transformationController.dispose();
    super.dispose();
  }

  void _onTransformChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    final zoomed = scale > 1.1;
    if (zoomed != _isZoomed) {
      setState(() => _isZoomed = zoomed);
    }
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _resetZoom();
      setState(() => _currentIndex--);
    }
  }

  void _goToNext() {
    if (_currentIndex < _images.length - 1) {
      _resetZoom();
      setState(() => _currentIndex++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: RawKeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.escape) {
              Navigator.pop(context);
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              _goToPrevious();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              _goToNext();
            }
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 图片内容 - 使用 LayoutBuilder 获取可用空间
            GestureDetector(
              onDoubleTap: () {
                if (_isZoomed) {
                  _resetZoom();
                } else {
                  // 双击放大到 2 倍
                  _transformationController.value = Matrix4.identity()
                    ..scale(2.0);
                }
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: InteractiveViewer(
                      transformationController: _transformationController,
                      minScale: 0.5,
                      maxScale: 5.0,
                      constrained: false,
                      boundaryMargin: EdgeInsets.all(
                        constraints.maxWidth > constraints.maxHeight
                            ? constraints.maxWidth
                            : constraints.maxHeight,
                      ),
                      child: Center(
                        child: Image.network(
                          _images[_currentIndex],
                          fit: BoxFit.contain,
                          width: screenSize.width * 0.9,
                          height: screenSize.height * 0.9,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: screenSize.width * 0.9,
                              height: screenSize.height * 0.9,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) => SizedBox(
                            width: screenSize.width * 0.9,
                            height: screenSize.height * 0.9,
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.broken_image,
                                    size: 64,
                                    color: Colors.white54,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    '图片加载失败',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // 顶部操作栏
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black54,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      tooltip: '关闭 (Esc)',
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    if (_images.length > 1)
                      Text(
                        '${_currentIndex + 1} / ${_images.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.zoom_in, color: Colors.white),
                      tooltip: '放大',
                      onPressed: () {
                        final currentScale =
                            _transformationController.value.getMaxScaleOnAxis();
                        if (currentScale < 5.0) {
                          _transformationController.value = Matrix4.identity()
                            ..scale(currentScale * 1.5);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_out, color: Colors.white),
                      tooltip: '缩小',
                      onPressed: () {
                        final currentScale =
                            _transformationController.value.getMaxScaleOnAxis();
                        if (currentScale > 0.5) {
                          _transformationController.value = Matrix4.identity()
                            ..scale(currentScale / 1.5);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      tooltip: '重置',
                      onPressed: _resetZoom,
                    ),
                  ],
                ),
              ),
            ),
            // 左右切换按钮（多图时显示）
            if (_images.length > 1) ...[
              // 上一张
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            _currentIndex > 0 ? Colors.black54 : Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color:
                            _currentIndex > 0 ? Colors.white : Colors.white38,
                        size: 32,
                      ),
                    ),
                    tooltip: '上一张 (←)',
                    onPressed: _currentIndex > 0 ? _goToPrevious : null,
                  ),
                ),
              ),
              // 下一张
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _currentIndex < _images.length - 1
                            ? Colors.black54
                            : Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_right,
                        color: _currentIndex < _images.length - 1
                            ? Colors.white
                            : Colors.white38,
                        size: 32,
                      ),
                    ),
                    tooltip: '下一张 (→)',
                    onPressed:
                        _currentIndex < _images.length - 1 ? _goToNext : null,
                  ),
                ),
              ),
            ],
            // 底部提示
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '双击放大/还原 · 滚轮缩放 · 拖动平移',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
