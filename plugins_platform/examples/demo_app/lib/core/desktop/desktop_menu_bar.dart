import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/app/theme/app_theme.dart';
import 'package:rss_reader/core/router/routes.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';

/// 桌面端菜单栏
///
/// 提供文件、编辑、视图菜单，支持：
/// - 文件菜单：导入/导出 OPML
/// - 编辑菜单：复制/粘贴
/// - 视图菜单：主题切换
class DesktopMenuBar extends ConsumerWidget {
  final Widget child;

  const DesktopMenuBar({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 非桌面端直接返回 child
    if (!PlatformUtils.isDesktop) {
      return child;
    }

    return PlatformMenuBar(
      menus: [
        // 文件菜单
        PlatformMenu(
          label: '文件',
          menus: [
            PlatformMenuItem(
              label: '导入 OPML...',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyO,
                control: true,
              ),
              onSelected: () => _handleImportOPML(context),
            ),
            PlatformMenuItem(
              label: '导出 OPML...',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyE,
                control: true,
                shift: true,
              ),
              onSelected: () => _handleExportOPML(context),
            ),
            PlatformMenuItem(
              label: '订阅源管理',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.comma,
                control: true,
              ),
              onSelected: () => _handleFeedManagement(context),
            ),
            PlatformMenuItem(
              label: '设置',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.comma,
                control: true,
                shift: true,
              ),
              onSelected: () => _handleSettings(context),
            ),
            if (!PlatformUtils.isMacOS)
              PlatformMenuItem(
                label: '退出',
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyQ,
                  control: true,
                ),
                onSelected: () => _handleExit(),
              ),
          ],
        ),
        // 编辑菜单
        PlatformMenu(
          label: '编辑',
          menus: [
            PlatformMenuItem(
              label: '撤销',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyZ,
                control: true,
              ),
              onSelected: null, // 由系统处理
            ),
            PlatformMenuItem(
              label: '重做',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyZ,
                control: true,
                shift: true,
              ),
              onSelected: null, // 由系统处理
            ),
            PlatformMenuItem(
              label: '剪切',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyX,
                control: true,
              ),
              onSelected: null, // 由系统处理
            ),
            PlatformMenuItem(
              label: '复制',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyC,
                control: true,
              ),
              onSelected: null, // 由系统处理
            ),
            PlatformMenuItem(
              label: '粘贴',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyV,
                control: true,
              ),
              onSelected: null, // 由系统处理
            ),
            PlatformMenuItem(
              label: '全选',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyA,
                control: true,
              ),
              onSelected: null, // 由系统处理
            ),
            PlatformMenuItem(
              label: '搜索',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyF,
                control: true,
              ),
              onSelected: () => _handleSearch(context),
            ),
          ],
        ),
        // 视图菜单
        PlatformMenu(
          label: '视图',
          menus: [
            PlatformMenu(
              label: '主题',
              menus: [
                PlatformMenuItem(
                  label: '跟随系统',
                  onSelected: () => _handleThemeChange(ref, ThemeMode.system),
                ),
                PlatformMenuItem(
                  label: '浅色模式',
                  onSelected: () => _handleThemeChange(ref, ThemeMode.light),
                ),
                PlatformMenuItem(
                  label: '深色模式',
                  onSelected: () => _handleThemeChange(ref, ThemeMode.dark),
                ),
              ],
            ),
            PlatformMenuItem(
              label: '刷新',
              shortcut: const SingleActivator(LogicalKeyboardKey.f5),
              onSelected: () => _handleRefresh(context),
            ),
            PlatformMenuItem(
              label: '首页',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyH,
                control: true,
              ),
              onSelected: () => _handleGoHome(context),
            ),
            PlatformMenuItem(
              label: '收藏',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyB,
                control: true,
              ),
              onSelected: () => _handleFavorites(context),
            ),
          ],
        ),
        // 帮助菜单
        PlatformMenu(
          label: '帮助',
          menus: [
            PlatformMenuItem(
              label: '关于 RSS Reader',
              onSelected: () => _handleAbout(context),
            ),
            PlatformMenuItem(
              label: '键盘快捷键',
              shortcut: const SingleActivator(
                LogicalKeyboardKey.slash,
                control: true,
              ),
              onSelected: () => _handleKeyboardShortcuts(context),
            ),
          ],
        ),
      ],
      child: child,
    );
  }

  /// 处理导入 OPML
  void _handleImportOPML(BuildContext context) {
    // 导航到订阅源管理页，触发导入
    context.push(AppRoutes.feedManagement);
    // 实际导入逻辑在 FeedManagementPage 中处理
  }

  /// 处理导出 OPML
  void _handleExportOPML(BuildContext context) {
    // 导航到订阅源管理页，触发导出
    context.push(AppRoutes.feedManagement);
    // 实际导出逻辑在 FeedManagementPage 中处理
  }

  /// 处理订阅源管理
  void _handleFeedManagement(BuildContext context) {
    context.push(AppRoutes.feedManagement);
  }

  /// 处理设置
  void _handleSettings(BuildContext context) {
    context.push(AppRoutes.settings);
  }

  /// 处理退出
  void _handleExit() {
    SystemNavigator.pop();
  }

  /// 处理搜索
  void _handleSearch(BuildContext context) {
    context.push(AppRoutes.search);
  }

  /// 处理主题切换
  void _handleThemeChange(WidgetRef ref, ThemeMode mode) {
    ref.read(themeModeProvider.notifier).state = mode;
  }

  /// 处理刷新
  void _handleRefresh(BuildContext context) {
    // 发送刷新事件，由 HomePage 处理
    // 这里可以使用 Riverpod 或其他状态管理方式触发刷新
  }

  /// 处理返回首页
  void _handleGoHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  /// 处理收藏
  void _handleFavorites(BuildContext context) {
    context.push(AppRoutes.favorites);
  }

  /// 处理关于
  void _handleAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'RSS Reader',
      applicationVersion: '1.0.0',
      applicationIcon: const FlutterLogo(size: 64),
      applicationLegalese: '© 2025 RSS Reader',
      children: [
        const SizedBox(height: 16),
        const Text('一款跨平台的 RSS 阅读器应用'),
        const SizedBox(height: 8),
        const Text('支持 iOS、Android、Windows、macOS、Linux'),
      ],
    );
  }

  /// 处理键盘快捷键帮助
  void _handleKeyboardShortcuts(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const KeyboardShortcutsDialog(),
    );
  }
}

/// 键盘快捷键帮助对话框
class KeyboardShortcutsDialog extends StatelessWidget {
  const KeyboardShortcutsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('键盘快捷键'),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSection('导航', [
                _buildShortcut('J', '下一篇文章'),
                _buildShortcut('K', '上一篇文章'),
                _buildShortcut('Ctrl+H', '返回首页'),
                _buildShortcut('Escape', '返回'),
              ]),
              const SizedBox(height: 16),
              _buildSection('操作', [
                _buildShortcut('R', '刷新'),
                _buildShortcut('S', '收藏/取消收藏'),
                _buildShortcut('M', '标记已读/未读'),
                _buildShortcut('Ctrl+F', '搜索'),
              ]),
              const SizedBox(height: 16),
              _buildSection('文件', [
                _buildShortcut('Ctrl+O', '导入 OPML'),
                _buildShortcut('Ctrl+Shift+E', '导出 OPML'),
                _buildShortcut('Ctrl+,', '订阅源管理'),
                _buildShortcut('Ctrl+Shift+,', '设置'),
              ]),
              const SizedBox(height: 16),
              _buildSection('编辑', [
                _buildShortcut('Ctrl+C', '复制'),
                _buildShortcut('Ctrl+V', '粘贴'),
                _buildShortcut('Ctrl+A', '全选'),
              ]),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('关闭'),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> shortcuts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...shortcuts,
      ],
    );
  }

  Widget _buildShortcut(String key, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Text(
              key,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(description),
        ],
      ),
    );
  }
}
