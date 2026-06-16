import 'package:flutter/material.dart';

/// 文章卡片骨架屏组件
class ArticleSkeleton extends StatelessWidget {
  /// 是否显示封面图骨架
  final bool showImage;

  const ArticleSkeleton({super.key, this.showImage = true});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 订阅源图标骨架
          _SkeletonBox(width: 36, height: 36, borderRadius: 8),
          const SizedBox(width: 12),
          // 文章信息骨架
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 订阅源名称和时间骨架
                Row(
                  children: [
                    _SkeletonBox(width: 60, height: 12, borderRadius: 4),
                    const SizedBox(width: 8),
                    _SkeletonBox(width: 40, height: 12, borderRadius: 4),
                  ],
                ),
                const SizedBox(height: 8),
                // 标题骨架
                _SkeletonBox(
                  width: double.infinity,
                  height: 16,
                  borderRadius: 4,
                ),
                const SizedBox(height: 4),
                _SkeletonBox(width: 200, height: 16, borderRadius: 4),
                const SizedBox(height: 8),
                // 摘要骨架
                _SkeletonBox(
                  width: double.infinity,
                  height: 12,
                  borderRadius: 4,
                ),
                const SizedBox(height: 4),
                _SkeletonBox(width: 150, height: 12, borderRadius: 4),
              ],
            ),
          ),
          // 封面图骨架
          if (showImage) ...[
            const SizedBox(width: 12),
            _SkeletonBox(width: 80, height: 80, borderRadius: 8),
          ],
        ],
      ),
    );
  }
}

/// 骨架屏基础组件
class _SkeletonBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _SkeletonBox({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(
      begin: 0.3,
      end: 0.6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(
              alpha: _animation.value,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        );
      },
    );
  }
}

/// 文章列表骨架屏
class ArticleListSkeleton extends StatelessWidget {
  /// 骨架屏数量
  final int count;

  /// 是否显示封面图骨架
  final bool showImage;

  const ArticleListSkeleton({super.key, this.count = 5, this.showImage = true});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) => ArticleSkeleton(showImage: showImage),
    );
  }
}

/// 加载更多指示器
class LoadMoreIndicator extends StatelessWidget {
  /// 是否正在加载
  final bool isLoading;

  /// 是否还有更多数据
  final bool hasMore;

  /// 没有更多数据时的提示文字
  final String noMoreText;

  const LoadMoreIndicator({
    super.key,
    required this.isLoading,
    required this.hasMore,
    this.noMoreText = '没有更多了',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (isLoading) {
      return Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '加载中...',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    if (!hasMore) {
      return Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Text(
          noMoreText,
          style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
