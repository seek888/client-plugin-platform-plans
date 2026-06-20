import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/core/network/network_info_provider.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:rss_reader/shared/widgets/adaptive/responsive_layout.dart';
import 'package:rss_reader/shared/widgets/common/offline_banner.dart';
import 'package:rss_reader/shared/widgets/desktop/window_controls.dart';
import 'package:window_manager/window_manager.dart';

/// 自适应脚手架组件
/// 移动端：单栏布局 + 底部导航
/// 桌面端：左中右三栏布局
class AdaptiveScaffold extends HookConsumerWidget {
  /// 左侧导航栏（PC端显示）
  final Widget? navigationRail;

  /// 中间面板（订阅源列表/文章列表）
  final Widget middlePanel;

  /// 右侧内容区（文章详情）
  final Widget? detailPanel;

  /// 移动端底部导航栏
  final Widget? bottomNavigationBar;

  /// 移动端 AppBar
  final PreferredSizeWidget? appBar;

  /// 中间面板宽度（PC端）
  final double middlePanelWidth;

  /// 左侧导航栏宽度（PC端）
  final double navigationRailWidth;

  /// 空详情占位组件
  final Widget? emptyDetailPlaceholder;

  /// 是否显示离线提示条
  final bool showOfflineBanner;

  /// 全屏覆盖层（覆盖除导航栏外的所有区域）
  final Widget? fullScreenOverlay;

  const AdaptiveScaffold({
    super.key,
    this.navigationRail,
    required this.middlePanel,
    this.detailPanel,
    this.bottomNavigationBar,
    this.appBar,
    this.middlePanelWidth = 320,
    this.navigationRailWidth = 72,
    this.emptyDetailPlaceholder,
    this.showOfflineBanner = true,
    this.fullScreenOverlay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineProvider);
    final showBanner = showOfflineBanner && isOffline;

    return ResponsiveLayout(
      // 移动端：单栏布局
      compactLayout: Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            if (showBanner) const OfflineBanner(),
            Expanded(child: middlePanel),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
      // 桌面端：三栏布局
      expandedLayout: Scaffold(
        body: Column(
          children: [
            // 桌面端顶部标题栏（包含窗口控制按钮）
            if (PlatformUtils.isDesktop) const _DesktopTitleBar(),
            if (showBanner) const OfflineBanner(),
            Expanded(
              child: Row(
                children: [
                  // 左侧导航栏
                  if (navigationRail != null)
                    SizedBox(width: navigationRailWidth, child: navigationRail),
                  // 全屏覆盖层或正常布局
                  Expanded(
                    child:
                        fullScreenOverlay ??
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final adaptiveMiddleWidth = constraints.maxWidth
                                .clamp(296.0, 380.0)
                                .toDouble();
                            final panelWidth = middlePanelWidth
                                .clamp(280.0, adaptiveMiddleWidth)
                                .toDouble();

                            return Row(
                              children: [
                                // 中间面板
                                SizedBox(width: panelWidth, child: middlePanel),
                                // 分隔线
                                const VerticalDivider(width: 1),
                                // 右侧内容区
                                Expanded(
                                  child:
                                      detailPanel ??
                                      emptyDetailPlaceholder ??
                                      const Center(child: Text('选择一篇文章开始阅读')),
                                ),
                              ],
                            );
                          },
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 桌面端标题栏
class _DesktopTitleBar extends StatelessWidget {
  const _DesktopTitleBar();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (_) => windowManager.startDragging(),
      onDoubleTap: () async {
        if (await windowManager.isMaximized()) {
          await windowManager.unmaximize();
        } else {
          await windowManager.maximize();
        }
      },
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            // 应用标题
            Text(
              'RSS Reader',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            // 窗口控制按钮
            const WindowControls(buttonSize: 32, iconSize: 14),
          ],
        ),
      ),
    );
  }
}
