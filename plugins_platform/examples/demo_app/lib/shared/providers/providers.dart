import 'package:flutter_riverpod/flutter_riverpod.dart';

// Re-export network providers for convenience
export 'package:rss_reader/core/network/network_info_provider.dart';

/// 当前选中的订阅源 ID
final selectedFeedIdProvider = StateProvider<String?>((ref) => null);

/// 当前选中的文章 ID
final selectedArticleIdProvider = StateProvider<String?>((ref) => null);

/// 当前选中的分类 ID
final selectedCategoryIdProvider = StateProvider<String?>((ref) => null);

/// 是否处于离线模式（手动设置，用于用户主动切换离线模式）
/// 注意：网络状态检测使用 isOfflineProvider（来自 network_info_provider.dart）
final isOfflineModeProvider = StateProvider<bool>((ref) => false);

/// 是否正在同步
final isSyncingProvider = StateProvider<bool>((ref) => false);

/// 是否显示编辑器面板（桌面端）
final showEditorPanelProvider = StateProvider<bool>((ref) => false);

/// 当前编辑的文章 ID（空字符串表示新建笔记）
final editingArticleIdProvider = StateProvider<String?>((ref) => null);
