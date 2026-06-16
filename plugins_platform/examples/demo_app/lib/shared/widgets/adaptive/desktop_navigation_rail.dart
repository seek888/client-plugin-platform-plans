import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/shared/widgets/common/offline_aware_button.dart';

/// 导航目的地数据模型
class NavigationDestinationData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String? badge;

  const NavigationDestinationData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.badge,
  });
}

/// 桌面端左侧导航栏组件
/// 包含主要导航图标、分类快捷入口、设置入口
class DesktopNavigationRail extends HookConsumerWidget {
  /// 当前选中的导航索引
  final int selectedIndex;

  /// 导航选择回调
  final ValueChanged<int> onDestinationSelected;

  /// 导航目的地列表
  final List<NavigationDestinationData>? destinations;

  /// 收藏按钮点击回调
  final VoidCallback? onFavoritesPressed;

  /// 设置按钮点击回调
  final VoidCallback? onSettingsPressed;

  /// 插件扩展按钮点击回调
  final VoidCallback? onPluginsPressed;

  /// 添加订阅源按钮点击回调
  final VoidCallback? onAddFeedPressed;

  /// 新建笔记按钮点击回调
  final VoidCallback? onNewNotePressed;

  /// 是否显示标签
  final bool showLabels;

  /// 顶部 Logo Widget
  final Widget? leading;

  const DesktopNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.destinations,
    this.onFavoritesPressed,
    this.onSettingsPressed,
    this.onPluginsPressed,
    this.onAddFeedPressed,
    this.onNewNotePressed,
    this.showLabels = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 默认导航目的地
    final defaultDestinations = [
      const NavigationDestinationData(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: '首页',
      ),
      const NavigationDestinationData(
        icon: Icons.folder_outlined,
        selectedIcon: Icons.folder,
        label: '分类',
      ),
    ];

    final navDestinations = destinations ?? defaultDestinations;

    return Container(
      width: 72,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          right: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
      ),
      child: Column(
        children: [
          // 顶部 Logo 区域
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child:
                leading ??
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.rss_feed,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
          ),

          // 添加订阅源按钮 - 离线时禁用
          if (onAddFeedPressed != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: OfflineAwareIconButton(
                onPressed: onAddFeedPressed,
                icon: const Icon(Icons.add),
                tooltip: '添加订阅源',
                offlineTooltip: '离线模式下无法添加订阅源',
              ),
            ),

          // 新建笔记按钮
          if (onNewNotePressed != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: IconButton(
                onPressed: onNewNotePressed,
                icon: const Icon(Icons.edit_note),
                tooltip: '新建笔记',
              ),
            ),

          const Divider(indent: 16, endIndent: 16),

          // 主导航区域
          Expanded(
            child: NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              labelType: showLabels
                  ? NavigationRailLabelType.all
                  : NavigationRailLabelType.selected,
              backgroundColor: Colors.transparent,
              indicatorColor: colorScheme.secondaryContainer,
              destinations: navDestinations.map((dest) {
                return NavigationRailDestination(
                  icon: _buildIconWithBadge(dest.icon, dest.badge, colorScheme),
                  selectedIcon: _buildIconWithBadge(
                    dest.selectedIcon,
                    dest.badge,
                    colorScheme,
                  ),
                  label: Text(dest.label),
                );
              }).toList(),
            ),
          ),

          // 底部操作区域
          const Divider(indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 收藏按钮
                IconButton(
                  icon: const Icon(Icons.bookmark_outline),
                  onPressed: onFavoritesPressed,
                  tooltip: '收藏',
                ),
                const SizedBox(height: 8),
                IconButton(
                  icon: const Icon(Icons.extension_outlined),
                  onPressed: onPluginsPressed,
                  tooltip: '插件扩展',
                ),
                const SizedBox(height: 8),
                // 设置按钮
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: onSettingsPressed,
                  tooltip: '设置',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建带角标的图标
  Widget _buildIconWithBadge(
    IconData icon,
    String? badge,
    ColorScheme colorScheme,
  ) {
    if (badge == null || badge.isEmpty) {
      return Icon(icon);
    }

    return Badge(
      label: Text(badge, style: const TextStyle(fontSize: 10)),
      child: Icon(icon),
    );
  }
}
