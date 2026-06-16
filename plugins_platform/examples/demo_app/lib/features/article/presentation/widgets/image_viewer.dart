import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 图片查看器
/// 支持缩放、滑动、多图切换
class ImageViewer extends HookWidget {
  /// 当前图片 URL
  final String imageUrl;

  /// 所有图片 URL 列表（用于多图切换）
  final List<String>? allImages;

  /// 初始索引
  final int initialIndex;

  /// 背景颜色
  final Color backgroundColor;

  /// 关闭回调
  final VoidCallback? onClose;

  const ImageViewer({
    super.key,
    required this.imageUrl,
    this.allImages,
    this.initialIndex = 0,
    this.backgroundColor = Colors.black,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final images = allImages ?? [imageUrl];
    final currentIndex = useState(initialIndex.clamp(0, images.length - 1));
    final pageController = usePageController(initialPage: currentIndex.value);
    final transformationController = useTransformationController();
    final isZoomed = useState(false);
    final screenSize = MediaQuery.of(context).size;

    // 监听缩放状态
    useEffect(() {
      void listener() {
        final scale = transformationController.value.getMaxScaleOnAxis();
        isZoomed.value = scale > 1.1;
      }

      transformationController.addListener(listener);
      return () => transformationController.removeListener(listener);
    }, [transformationController]);

    void resetZoom() {
      transformationController.value = Matrix4.identity();
    }

    void goToPrevious() {
      if (currentIndex.value > 0) {
        resetZoom();
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    void goToNext() {
      if (currentIndex.value < images.length - 1) {
        resetZoom();
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: RawKeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.escape) {
              onClose?.call();
              Navigator.of(context).pop();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              goToPrevious();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              goToNext();
            }
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 图片内容
            GestureDetector(
              onTap: () {
                // 单击关闭（仅在未缩放时）
                if (!isZoomed.value) {
                  onClose?.call();
                  Navigator.of(context).pop();
                }
              },
              onDoubleTap: () {
                if (isZoomed.value) {
                  resetZoom();
                } else {
                  transformationController.value = Matrix4.identity()
                    ..scale(2.0);
                }
              },
              child: images.length > 1
                  ? PageView.builder(
                      controller: pageController,
                      itemCount: images.length,
                      onPageChanged: (index) {
                        resetZoom();
                        currentIndex.value = index;
                      },
                      physics: isZoomed.value
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => _buildImageItem(
                        context,
                        images[index],
                        transformationController,
                        screenSize,
                      ),
                    )
                  : _buildImageItem(
                      context,
                      imageUrl,
                      transformationController,
                      screenSize,
                    ),
            ),
            // 顶部操作栏
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                        tooltip: '关闭',
                        onPressed: () {
                          onClose?.call();
                          Navigator.of(context).pop();
                        },
                      ),
                      const Spacer(),
                      if (images.length > 1)
                        Text(
                          '${currentIndex.value + 1} / ${images.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.zoom_in, color: Colors.white),
                        tooltip: '放大',
                        onPressed: () {
                          final currentScale = transformationController.value
                              .getMaxScaleOnAxis();
                          if (currentScale < 5.0) {
                            transformationController.value = Matrix4.identity()
                              ..scale(currentScale * 1.5);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.zoom_out, color: Colors.white),
                        tooltip: '缩小',
                        onPressed: () {
                          final currentScale = transformationController.value
                              .getMaxScaleOnAxis();
                          if (currentScale > 0.5) {
                            transformationController.value = Matrix4.identity()
                              ..scale(currentScale / 1.5);
                          }
                        },
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        color: Colors.grey[900],
                        onSelected: (value) async {
                          switch (value) {
                            case 'save':
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('保存功能开发中')),
                              );
                              break;
                            case 'copy':
                              await Clipboard.setData(
                                ClipboardData(text: images[currentIndex.value]),
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('图片链接已复制')),
                                );
                              }
                              break;
                            case 'reset':
                              resetZoom();
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'reset',
                            child: Row(
                              children: [
                                Icon(Icons.refresh, color: Colors.white),
                                SizedBox(width: 12),
                                Text('重置缩放',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'save',
                            child: Row(
                              children: [
                                Icon(Icons.save_alt, color: Colors.white),
                                SizedBox(width: 12),
                                Text('保存图片',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'copy',
                            child: Row(
                              children: [
                                Icon(Icons.link, color: Colors.white),
                                SizedBox(width: 12),
                                Text('复制链接',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 左右切换按钮（多图时显示）
            if (images.length > 1) ...[
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: currentIndex.value > 0
                            ? Colors.black54
                            : Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: currentIndex.value > 0
                            ? Colors.white
                            : Colors.white38,
                        size: 32,
                      ),
                    ),
                    onPressed: currentIndex.value > 0 ? goToPrevious : null,
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: currentIndex.value < images.length - 1
                            ? Colors.black54
                            : Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_right,
                        color: currentIndex.value < images.length - 1
                            ? Colors.white
                            : Colors.white38,
                        size: 32,
                      ),
                    ),
                    onPressed: currentIndex.value < images.length - 1
                        ? goToNext
                        : null,
                  ),
                ),
              ),
            ],
            // 底部指示器（多图时显示）
            if (images.length > 1)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == currentIndex.value
                                ? Colors.white
                                : Colors.white38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            // 底部提示
            Positioned(
              bottom: images.length > 1 ? 50 : 16,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '双击放大/还原 · 拖动平移',
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

  /// 构建单个图片项
  Widget _buildImageItem(
    BuildContext context,
    String url,
    TransformationController controller,
    Size screenSize,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: InteractiveViewer(
            transformationController: controller,
            minScale: 0.5,
            maxScale: 5.0,
            constrained: false,
            boundaryMargin: EdgeInsets.all(
              constraints.maxWidth > constraints.maxHeight
                  ? constraints.maxWidth
                  : constraints.maxHeight,
            ),
            onInteractionEnd: (details) {
              final scale = controller.value.getMaxScaleOnAxis();
              if (scale < 1.1 && scale > 0.9) {
                controller.value = Matrix4.identity();
              }
            },
            child: Center(
              child: Image.network(
                url,
                fit: BoxFit.contain,
                width: screenSize.width * 0.95,
                height: screenSize.height * 0.85,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: screenSize.width * 0.95,
                    height: screenSize.height * 0.85,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => const _ImageErrorPlaceholder(),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 图片加载失败占位符
class _ImageErrorPlaceholder extends StatelessWidget {
  const _ImageErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.broken_image_outlined,
          size: 64,
          color: Colors.white54,
        ),
        const SizedBox(height: 16),
        Text(
          '图片加载失败',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

/// 使用 TransformationController 的 Hook
TransformationController useTransformationController() {
  return use(const _TransformationControllerHook());
}

class _TransformationControllerHook extends Hook<TransformationController> {
  const _TransformationControllerHook();

  @override
  _TransformationControllerHookState createState() =>
      _TransformationControllerHookState();
}

class _TransformationControllerHookState
    extends HookState<TransformationController, _TransformationControllerHook> {
  late final TransformationController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = TransformationController();
  }

  @override
  TransformationController build(BuildContext context) => _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// 显示图片查看器
void showImageViewer(
  BuildContext context, {
  required String imageUrl,
  List<String>? allImages,
  int initialIndex = 0,
}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black87,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ImageViewer(
            imageUrl: imageUrl,
            allImages: allImages,
            initialIndex: initialIndex,
          ),
        );
      },
    ),
  );
}
