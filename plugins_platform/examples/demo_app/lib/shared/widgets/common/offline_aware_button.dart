import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/core/network/network_info_provider.dart';

/// 离线感知按钮
/// 当设备离线时自动禁用按钮
class OfflineAwareButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool disableWhenOffline;
  final String? offlineTooltip;

  const OfflineAwareButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.disableWhenOffline = true,
    this.offlineTooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineProvider);
    final shouldDisable = disableWhenOffline && isOffline;

    final button = ElevatedButton(
      onPressed: shouldDisable ? null : onPressed,
      style: style,
      child: child,
    );

    if (shouldDisable && offlineTooltip != null) {
      return Tooltip(message: offlineTooltip!, child: button);
    }

    return button;
  }
}

/// 离线感知图标按钮
/// 当设备离线时自动禁用按钮
class OfflineAwareIconButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final String? tooltip;
  final bool disableWhenOffline;
  final String? offlineTooltip;
  final Color? color;
  final double? iconSize;

  const OfflineAwareIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.disableWhenOffline = true,
    this.offlineTooltip,
    this.color,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineProvider);
    final shouldDisable = disableWhenOffline && isOffline;

    return IconButton(
      onPressed: shouldDisable ? null : onPressed,
      icon: icon,
      tooltip: shouldDisable ? (offlineTooltip ?? '离线模式下不可用') : tooltip,
      color: shouldDisable ? Theme.of(context).disabledColor : color,
      iconSize: iconSize,
    );
  }
}

/// 离线感知文本按钮
/// 当设备离线时自动禁用按钮
class OfflineAwareTextButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool disableWhenOffline;
  final String? offlineTooltip;

  const OfflineAwareTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.disableWhenOffline = true,
    this.offlineTooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineProvider);
    final shouldDisable = disableWhenOffline && isOffline;

    final button = TextButton(
      onPressed: shouldDisable ? null : onPressed,
      style: style,
      child: child,
    );

    if (shouldDisable && offlineTooltip != null) {
      return Tooltip(message: offlineTooltip!, child: button);
    }

    return button;
  }
}

/// 离线感知浮动操作按钮
/// 当设备离线时自动禁用按钮
class OfflineAwareFloatingActionButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final String? tooltip;
  final bool disableWhenOffline;
  final String? offlineTooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const OfflineAwareFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.tooltip,
    this.disableWhenOffline = true,
    this.offlineTooltip,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineProvider);
    final shouldDisable = disableWhenOffline && isOffline;

    return FloatingActionButton(
      onPressed: shouldDisable ? null : onPressed,
      tooltip: shouldDisable ? (offlineTooltip ?? '离线模式下不可用') : tooltip,
      backgroundColor: shouldDisable
          ? Theme.of(context).disabledColor
          : backgroundColor,
      foregroundColor: foregroundColor,
      child: child,
    );
  }
}
