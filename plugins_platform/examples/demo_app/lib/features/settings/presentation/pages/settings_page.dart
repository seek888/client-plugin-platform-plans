import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/core/desktop/system_tray_provider.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:rss_reader/features/settings/domain/entities/app_settings.dart';
import 'package:rss_reader/features/settings/presentation/providers/app_settings_provider.dart';
import 'package:rss_reader/features/settings/presentation/providers/tray_settings_provider.dart';

/// 设置页面
class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsNotifierProvider);
    final notifier = ref.read(appSettingsNotifierProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: ListView(
        children: [
          _SettingsSection(
            title: '外观',
            children: [
              _ThemeModeTile(
                currentMode: settings.themeMode,
                onChanged: notifier.setThemeMode,
              ),
              const Divider(height: 1),
              _FontSizeTile(
                currentSize: settings.fontSize,
                onChanged: notifier.setFontSize,
              ),
            ],
          ),
          _SettingsSection(
            title: '阅读',
            children: [
              SwitchListTile(
                title: const Text('无图模式'),
                subtitle: const Text('不加载图片，节省流量'),
                value: settings.noImageMode,
                onChanged: notifier.setNoImageMode,
                secondary: Icon(
                  settings.noImageMode
                      ? Icons.image_not_supported
                      : Icons.image,
                  color: theme.colorScheme.primary,
                ),
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('显示文章摘要'),
                subtitle: const Text('在文章列表中显示摘要预览'),
                value: settings.showArticleSummary,
                onChanged: notifier.setShowArticleSummary,
                secondary: Icon(
                  Icons.short_text,
                  color: theme.colorScheme.primary,
                ),
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('自动标记已读'),
                subtitle: const Text('滚动超过50%时自动标记为已读'),
                value: settings.autoMarkAsRead,
                onChanged: notifier.setAutoMarkAsRead,
                secondary: Icon(
                  Icons.done_all,
                  color: theme.colorScheme.primary,
                ),
              ),
              const Divider(height: 1),
              _LineHeightTile(
                currentHeight: settings.lineHeight,
                onChanged: notifier.setLineHeight,
              ),
            ],
          ),
          _SettingsSection(
            title: '刷新',
            children: [
              _RefreshFrequencyTile(
                currentFrequency: settings.refreshFrequency,
                onChanged: notifier.setRefreshFrequency,
              ),
            ],
          ),
          if (PlatformUtils.isMobile)
            _SettingsSection(
              title: '交互',
              children: [
                SwitchListTile(
                  title: const Text('滑动手势'),
                  subtitle: const Text('启用文章卡片滑动操作'),
                  value: settings.swipeGesturesEnabled,
                  onChanged: notifier.setSwipeGesturesEnabled,
                  secondary: Icon(
                    Icons.swipe,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          _SettingsSection(
            title: '通知',
            children: [
              SwitchListTile(
                title: const Text('新内容通知'),
                subtitle: const Text('有新文章时发送通知提醒'),
                value: settings.notificationsEnabled,
                onChanged: notifier.setNotificationsEnabled,
                secondary: Icon(
                  settings.notificationsEnabled
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          _SettingsSection(
            title: '扩展',
            children: [
              ListTile(
                leading: Icon(
                  Icons.extension_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('插件扩展'),
                subtitle: const Text('安装、激活和打开插件平台扩展'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/plugins'),
              ),
            ],
          ),
          // Windows 系统托盘设置
          if (Platform.isWindows) _TraySettingsSection(),
          _SettingsSection(
            title: '其他',
            children: [
              ListTile(
                leading: Icon(Icons.restore, color: theme.colorScheme.primary),
                title: const Text('恢复默认设置'),
                subtitle: const Text('将所有设置恢复为默认值'),
                onTap: () => _showResetConfirmDialog(context, notifier),
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('关于'),
                subtitle: const Text('版本信息和开源许可'),
                onTap: () => _showAboutDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showResetConfirmDialog(
    BuildContext context,
    AppSettingsNotifier notifier,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('恢复默认设置'),
        content: const Text('确定要将所有设置恢复为默认值吗？此操作无法撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              notifier.resetToDefaults();
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('已恢复默认设置')));
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'RSS Reader',
      applicationVersion: '1.0.0',
      applicationIcon: const FlutterLogo(size: 48),
      applicationLegalese: '© 2025 RSS Reader',
      children: [const SizedBox(height: 16), const Text('一款简洁高效的 RSS 阅读器')],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _ThemeModeTile extends StatelessWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onChanged;
  const _ThemeModeTile({required this.currentMode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(
        _getThemeIcon(currentMode),
        color: theme.colorScheme.primary,
      ),
      title: const Text('主题模式'),
      subtitle: Text(_getThemeLabel(currentMode)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showThemePicker(context),
    );
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }

  String _getThemeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return '跟随系统';
      case ThemeMode.light:
        return '浅色模式';
      case ThemeMode.dark:
        return '深色模式';
    }
  }

  void _showThemePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '选择主题模式',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            ...ThemeMode.values.map(
              (mode) => ListTile(
                leading: Icon(_getThemeIcon(mode)),
                title: Text(_getThemeLabel(mode)),
                trailing: currentMode == mode
                    ? Icon(
                        Icons.check,
                        color: Theme.of(ctx).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  onChanged(mode);
                  Navigator.pop(ctx);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _FontSizeTile extends StatelessWidget {
  final FontSizeOption currentSize;
  final ValueChanged<FontSizeOption> onChanged;
  const _FontSizeTile({required this.currentSize, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(Icons.text_fields, color: theme.colorScheme.primary),
      title: const Text('字体大小'),
      subtitle: Text(currentSize.label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showFontSizePicker(context),
    );
  }

  void _showFontSizePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '选择字体大小',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            ...FontSizeOption.values.map(
              (size) => ListTile(
                title: Text(size.label),
                subtitle: Text('缩放比例: ${(size.scale * 100).toInt()}%'),
                trailing: currentSize == size
                    ? Icon(
                        Icons.check,
                        color: Theme.of(ctx).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  onChanged(size);
                  Navigator.pop(ctx);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _RefreshFrequencyTile extends StatelessWidget {
  final RefreshFrequency currentFrequency;
  final ValueChanged<RefreshFrequency> onChanged;
  const _RefreshFrequencyTile({
    required this.currentFrequency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(Icons.refresh, color: theme.colorScheme.primary),
      title: const Text('自动刷新频率'),
      subtitle: Text(currentFrequency.label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showFrequencyPicker(context),
    );
  }

  void _showFrequencyPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.8,
        expand: false,
        builder: (_, scrollController) => SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '选择刷新频率',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: RefreshFrequency.values
                      .map(
                        (freq) => ListTile(
                          title: Text(freq.label),
                          subtitle: freq.isAutoRefresh
                              ? Text('每 ${freq.minutes} 分钟自动刷新')
                              : const Text('仅手动下拉刷新'),
                          trailing: currentFrequency == freq
                              ? Icon(
                                  Icons.check,
                                  color: Theme.of(ctx).colorScheme.primary,
                                )
                              : null,
                          onTap: () {
                            onChanged(freq);
                            Navigator.pop(ctx);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LineHeightTile extends StatelessWidget {
  final double currentHeight;
  final ValueChanged<double> onChanged;
  const _LineHeightTile({required this.currentHeight, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(
        Icons.format_line_spacing,
        color: theme.colorScheme.primary,
      ),
      title: const Text('行间距'),
      subtitle: Slider(
        value: currentHeight,
        min: 1.0,
        max: 2.0,
        divisions: 10,
        label: '${currentHeight.toStringAsFixed(1)}x',
        onChanged: onChanged,
      ),
      trailing: Text(
        '${currentHeight.toStringAsFixed(1)}x',
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}

/// Windows 系统托盘设置区域
/// Requirements: 6.1, 6.2, 6.3, 6.4
class _TraySettingsSection extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final traySettingsAsync = ref.watch(traySettingsNotifierProvider);
    final trayNotifier = ref.read(traySettingsNotifierProvider.notifier);
    final trayStateNotifier = ref.read(systemTrayNotifierProvider.notifier);
    final theme = Theme.of(context);

    return traySettingsAsync.when(
      data: (traySettings) => _SettingsSection(
        title: '系统托盘',
        children: [
          SwitchListTile(
            title: const Text('启动时最小化到托盘'),
            subtitle: const Text('应用启动时自动隐藏到系统托盘'),
            value: traySettings.startMinimized,
            onChanged: (value) {
              trayNotifier.setStartMinimized(value);
            },
            secondary: Icon(
              Icons.minimize,
              color: theme.colorScheme.primary,
            ),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('关闭时最小化到托盘'),
            subtitle: const Text('点击关闭按钮时隐藏到托盘而非退出'),
            value: traySettings.closeToTray,
            onChanged: (value) {
              trayNotifier.setCloseToTray(value);
              trayStateNotifier.updateSettings(
                traySettings.copyWith(closeToTray: value),
              );
            },
            secondary: Icon(
              Icons.close,
              color: theme.colorScheme.primary,
            ),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('显示桌面通知'),
            subtitle: const Text('在 Windows 通知中心显示新内容提醒'),
            value: traySettings.showNotifications,
            onChanged: (value) {
              trayNotifier.setShowNotifications(value);
            },
            secondary: Icon(
              traySettings.showNotifications
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      loading: () => const _SettingsSection(
        title: '系统托盘',
        children: [
          ListTile(
            title: Text('加载中...'),
            leading: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ],
      ),
      error: (error, stack) => _SettingsSection(
        title: '系统托盘',
        children: [
          ListTile(
            title: const Text('加载设置失败'),
            subtitle: Text(error.toString()),
            leading: Icon(Icons.error, color: theme.colorScheme.error),
          ),
        ],
      ),
    );
  }
}
