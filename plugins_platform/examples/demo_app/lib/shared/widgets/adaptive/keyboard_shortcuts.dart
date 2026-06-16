import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';

// ============================================================================
// Intent 定义 - 用户意图
// ============================================================================

/// 下一篇文章意图
class NextArticleIntent extends Intent {
  const NextArticleIntent();
}

/// 上一篇文章意图
class PreviousArticleIntent extends Intent {
  const PreviousArticleIntent();
}

/// 刷新意图
class RefreshIntent extends Intent {
  const RefreshIntent();
}

/// 切换收藏意图
class ToggleFavoriteIntent extends Intent {
  const ToggleFavoriteIntent();
}

/// 标记已读意图
class MarkAsReadIntent extends Intent {
  const MarkAsReadIntent();
}

/// 搜索意图
class SearchIntent extends Intent {
  const SearchIntent();
}

/// 返回意图
class GoBackIntent extends Intent {
  const GoBackIntent();
}

/// 打开设置意图
class OpenSettingsIntent extends Intent {
  const OpenSettingsIntent();
}

/// 添加订阅源意图
class AddFeedIntent extends Intent {
  const AddFeedIntent();
}

// ============================================================================
// 快捷键回调类型定义
// ============================================================================

/// 键盘快捷键回调集合
class KeyboardShortcutCallbacks {
  /// 下一篇文章
  final VoidCallback? onNextArticle;

  /// 上一篇文章
  final VoidCallback? onPreviousArticle;

  /// 刷新
  final VoidCallback? onRefresh;

  /// 切换收藏
  final VoidCallback? onToggleFavorite;

  /// 标记已读
  final VoidCallback? onMarkAsRead;

  /// 搜索
  final VoidCallback? onSearch;

  /// 返回
  final VoidCallback? onGoBack;

  /// 打开设置
  final VoidCallback? onOpenSettings;

  /// 添加订阅源
  final VoidCallback? onAddFeed;

  const KeyboardShortcutCallbacks({
    this.onNextArticle,
    this.onPreviousArticle,
    this.onRefresh,
    this.onToggleFavorite,
    this.onMarkAsRead,
    this.onSearch,
    this.onGoBack,
    this.onOpenSettings,
    this.onAddFeed,
  });
}

// ============================================================================
// 键盘快捷键包装组件
// ============================================================================

/// 键盘快捷键包装组件
/// 仅在桌面端和 Web 平台启用键盘快捷键
class KeyboardShortcutsWrapper extends HookConsumerWidget {
  /// 子组件
  final Widget child;

  /// 快捷键回调
  final KeyboardShortcutCallbacks callbacks;

  /// 是否启用快捷键（可用于临时禁用，如输入框聚焦时）
  final bool enabled;

  const KeyboardShortcutsWrapper({
    super.key,
    required this.child,
    required this.callbacks,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 非桌面平台或禁用时直接返回子组件
    if (!PlatformUtils.supportsKeyboardShortcuts || !enabled) {
      return child;
    }

    return Shortcuts(
      shortcuts: _buildShortcuts(),
      child: Actions(
        actions: _buildActions(),
        child: Focus(autofocus: true, child: child),
      ),
    );
  }

  /// 构建快捷键映射
  Map<ShortcutActivator, Intent> _buildShortcuts() {
    return {
      // J: 下一篇文章
      const SingleActivator(LogicalKeyboardKey.keyJ): const NextArticleIntent(),

      // K: 上一篇文章
      const SingleActivator(LogicalKeyboardKey.keyK):
          const PreviousArticleIntent(),

      // R: 刷新
      const SingleActivator(LogicalKeyboardKey.keyR): const RefreshIntent(),

      // S: 收藏
      const SingleActivator(LogicalKeyboardKey.keyS):
          const ToggleFavoriteIntent(),

      // M: 标记已读
      const SingleActivator(LogicalKeyboardKey.keyM): const MarkAsReadIntent(),

      // Ctrl+F / Cmd+F: 搜索
      const SingleActivator(LogicalKeyboardKey.keyF, control: true):
          const SearchIntent(),
      const SingleActivator(LogicalKeyboardKey.keyF, meta: true):
          const SearchIntent(),

      // Escape: 返回
      const SingleActivator(LogicalKeyboardKey.escape): const GoBackIntent(),

      // Ctrl+, / Cmd+,: 打开设置
      const SingleActivator(LogicalKeyboardKey.comma, control: true):
          const OpenSettingsIntent(),
      const SingleActivator(LogicalKeyboardKey.comma, meta: true):
          const OpenSettingsIntent(),

      // Ctrl+N / Cmd+N: 添加订阅源
      const SingleActivator(LogicalKeyboardKey.keyN, control: true):
          const AddFeedIntent(),
      const SingleActivator(LogicalKeyboardKey.keyN, meta: true):
          const AddFeedIntent(),

      // 方向键导航
      const SingleActivator(LogicalKeyboardKey.arrowDown):
          const NextArticleIntent(),
      const SingleActivator(LogicalKeyboardKey.arrowUp):
          const PreviousArticleIntent(),
    };
  }

  /// 构建 Action 映射
  Map<Type, Action<Intent>> _buildActions() {
    return {
      NextArticleIntent: CallbackAction<NextArticleIntent>(
        onInvoke: (_) {
          callbacks.onNextArticle?.call();
          return null;
        },
      ),
      PreviousArticleIntent: CallbackAction<PreviousArticleIntent>(
        onInvoke: (_) {
          callbacks.onPreviousArticle?.call();
          return null;
        },
      ),
      RefreshIntent: CallbackAction<RefreshIntent>(
        onInvoke: (_) {
          callbacks.onRefresh?.call();
          return null;
        },
      ),
      ToggleFavoriteIntent: CallbackAction<ToggleFavoriteIntent>(
        onInvoke: (_) {
          callbacks.onToggleFavorite?.call();
          return null;
        },
      ),
      MarkAsReadIntent: CallbackAction<MarkAsReadIntent>(
        onInvoke: (_) {
          callbacks.onMarkAsRead?.call();
          return null;
        },
      ),
      SearchIntent: CallbackAction<SearchIntent>(
        onInvoke: (_) {
          callbacks.onSearch?.call();
          return null;
        },
      ),
      GoBackIntent: CallbackAction<GoBackIntent>(
        onInvoke: (_) {
          callbacks.onGoBack?.call();
          return null;
        },
      ),
      OpenSettingsIntent: CallbackAction<OpenSettingsIntent>(
        onInvoke: (_) {
          callbacks.onOpenSettings?.call();
          return null;
        },
      ),
      AddFeedIntent: CallbackAction<AddFeedIntent>(
        onInvoke: (_) {
          callbacks.onAddFeed?.call();
          return null;
        },
      ),
    };
  }
}

// ============================================================================
// 快捷键帮助对话框
// ============================================================================

/// 显示快捷键帮助对话框
void showKeyboardShortcutsHelp(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const KeyboardShortcutsHelpDialog(),
  );
}

/// 快捷键帮助对话框
class KeyboardShortcutsHelpDialog extends StatelessWidget {
  const KeyboardShortcutsHelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isMac = PlatformUtils.isMacOS;
    final modKey = isMac ? '⌘' : 'Ctrl';

    return AlertDialog(
      title: const Text('键盘快捷键'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildShortcutSection('导航', [
              _ShortcutItem('J / ↓', '下一篇文章'),
              _ShortcutItem('K / ↑', '上一篇文章'),
              _ShortcutItem('Escape', '返回'),
            ]),
            const SizedBox(height: 16),
            _buildShortcutSection('操作', [
              _ShortcutItem('R', '刷新'),
              _ShortcutItem('S', '收藏/取消收藏'),
              _ShortcutItem('M', '标记已读'),
              _ShortcutItem('$modKey + F', '搜索'),
              _ShortcutItem('$modKey + N', '添加订阅源'),
              _ShortcutItem('$modKey + ,', '打开设置'),
            ]),
          ],
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

  Widget _buildShortcutSection(String title, List<_ShortcutItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.shortcut,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(item.description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ShortcutItem {
  final String shortcut;
  final String description;

  _ShortcutItem(this.shortcut, this.description);
}
