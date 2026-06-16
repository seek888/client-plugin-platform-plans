import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/shared/widgets/adaptive/breakpoints.dart';

/// 响应式布局组件
/// 根据屏幕宽度自动切换不同的布局
class ResponsiveLayout extends HookConsumerWidget {
  /// 移动端布局（紧凑型）
  final Widget compactLayout;

  /// 平板布局（中等型，可选）
  final Widget? mediumLayout;

  /// 桌面布局（扩展型）
  final Widget expandedLayout;

  const ResponsiveLayout({
    super.key,
    required this.compactLayout,
    this.mediumLayout,
    required this.expandedLayout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final layoutType = getLayoutType(width);

        switch (layoutType) {
          case LayoutType.compact:
            return compactLayout;
          case LayoutType.medium:
            return mediumLayout ?? compactLayout;
          case LayoutType.expanded:
            return expandedLayout;
        }
      },
    );
  }
}
