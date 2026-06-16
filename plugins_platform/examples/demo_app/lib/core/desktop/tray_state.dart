import 'package:freezed_annotation/freezed_annotation.dart';

part 'tray_state.freezed.dart';

/// 托盘状态
///
/// 管理系统托盘的运行时状态
/// Requirements: 5.1, 5.2, 5.3, 5.4
@freezed
class TrayState with _$TrayState {
  const TrayState._();

  const factory TrayState({
    /// 是否已初始化
    @Default(false) bool isInitialized,

    /// 当前未读数量
    /// Requirements: 5.1
    @Default(0) int unreadCount,

    /// 是否正在同步
    /// Requirements: 5.2
    @Default(false) bool isSyncing,

    /// 最后同步时间
    /// Requirements: 5.3
    DateTime? lastSyncTime,

    /// 错误信息
    /// Requirements: 5.4
    String? errorMessage,
  }) = _TrayState;

  /// 生成 tooltip 文字
  /// Requirements: 5.2, 5.3, 5.4
  String get tooltipText {
    if (isSyncing) {
      return 'RSS Reader - 正在同步...';
    }

    if (errorMessage != null && errorMessage!.isNotEmpty) {
      return 'RSS Reader - 同步错误: $errorMessage';
    }

    final parts = <String>['RSS Reader'];

    if (unreadCount > 0) {
      parts.add('$unreadCount 篇未读');
    }

    if (lastSyncTime != null) {
      final timeStr = _formatLastSyncTime(lastSyncTime!);
      parts.add('上次同步: $timeStr');
    }

    return parts.join(' - ');
  }

  String _formatLastSyncTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) {
      return '刚刚';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} 分钟前';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} 小时前';
    } else {
      return '${diff.inDays} 天前';
    }
  }
}
