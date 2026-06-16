import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:window_manager/window_manager.dart';

/// 桌面端窗口控制按钮组件
/// 包含最小化、最大化/还原、关闭按钮
class WindowControls extends HookWidget {
  /// 按钮大小
  final double buttonSize;

  /// 图标大小
  final double iconSize;

  /// 是否显示关闭按钮
  final bool showCloseButton;

  const WindowControls({
    super.key,
    this.buttonSize = 46,
    this.iconSize = 16,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    // 非桌面端不显示
    if (!PlatformUtils.isDesktop) {
      return const SizedBox.shrink();
    }

    final isMaximized = useState(false);
    final isFullScreen = useState(false);

    // 监听窗口状态变化
    useEffect(() {
      Future<void> updateState() async {
        isMaximized.value = await windowManager.isMaximized();
        isFullScreen.value = await windowManager.isFullScreen();
      }

      updateState();

      // 创建监听器
      final listener = _WindowStateListener(
        onMaximize: () => isMaximized.value = true,
        onUnmaximize: () => isMaximized.value = false,
        onEnterFullScreen: () => isFullScreen.value = true,
        onLeaveFullScreen: () => isFullScreen.value = false,
      );

      windowManager.addListener(listener);
      return () => windowManager.removeListener(listener);
    }, []);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 最小化按钮
        _WindowButton(
          icon: Icons.remove,
          tooltip: '最小化',
          size: buttonSize,
          iconSize: iconSize,
          onPressed: () => windowManager.minimize(),
          hoverColor: isDark
              ? Colors.white10
              : Colors.black.withValues(alpha: 0.05),
        ),
        // 最大化/还原按钮
        _WindowButton(
          icon: isMaximized.value || isFullScreen.value
              ? Icons.filter_none
              : Icons.crop_square,
          tooltip: isMaximized.value || isFullScreen.value ? '还原' : '最大化',
          size: buttonSize,
          iconSize: iconSize,
          onPressed: () async {
            if (isFullScreen.value) {
              await windowManager.setFullScreen(false);
            } else if (isMaximized.value) {
              await windowManager.unmaximize();
            } else {
              await windowManager.maximize();
            }
          },
          hoverColor: isDark
              ? Colors.white10
              : Colors.black.withValues(alpha: 0.05),
        ),
        // 全屏按钮
        _WindowButton(
          icon: isFullScreen.value ? Icons.fullscreen_exit : Icons.fullscreen,
          tooltip: isFullScreen.value ? '退出全屏' : '全屏',
          size: buttonSize,
          iconSize: iconSize,
          onPressed: () async {
            await windowManager.setFullScreen(!isFullScreen.value);
          },
          hoverColor: isDark
              ? Colors.white10
              : Colors.black.withValues(alpha: 0.05),
        ),
        // 关闭按钮
        if (showCloseButton)
          _WindowButton(
            icon: Icons.close,
            tooltip: '关闭',
            size: buttonSize,
            iconSize: iconSize,
            onPressed: () => windowManager.close(),
            hoverColor: Colors.red,
            hoverIconColor: Colors.white,
          ),
      ],
    );
  }
}

/// 窗口控制按钮
class _WindowButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final double size;
  final double iconSize;
  final VoidCallback onPressed;
  final Color hoverColor;
  final Color? hoverIconColor;

  const _WindowButton({
    required this.icon,
    required this.tooltip,
    required this.size,
    required this.iconSize,
    required this.onPressed,
    required this.hoverColor,
    this.hoverIconColor,
  });

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultIconColor = theme.colorScheme.onSurface;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: widget.size,
            height: widget.size,
            color: _isHovered ? widget.hoverColor : Colors.transparent,
            child: Center(
              child: Icon(
                widget.icon,
                size: widget.iconSize,
                color: _isHovered && widget.hoverIconColor != null
                    ? widget.hoverIconColor
                    : defaultIconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 窗口状态监听器
class _WindowStateListener with WindowListener {
  final VoidCallback? onMaximize;
  final VoidCallback? onUnmaximize;
  final VoidCallback? onEnterFullScreen;
  final VoidCallback? onLeaveFullScreen;

  _WindowStateListener({
    this.onMaximize,
    this.onUnmaximize,
    this.onEnterFullScreen,
    this.onLeaveFullScreen,
  });

  @override
  void onWindowMaximize() => onMaximize?.call();

  @override
  void onWindowUnmaximize() => onUnmaximize?.call();

  @override
  void onWindowEnterFullScreen() => onEnterFullScreen?.call();

  @override
  void onWindowLeaveFullScreen() => onLeaveFullScreen?.call();
}
