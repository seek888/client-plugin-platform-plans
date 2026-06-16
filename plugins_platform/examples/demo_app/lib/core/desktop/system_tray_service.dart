/// 系统托盘服务接口
///
/// 定义系统托盘功能的核心操作
/// Requirements: 1.1, 1.3, 3.1, 5.1, 5.2
abstract class SystemTrayService {
  /// 初始化系统托盘
  /// Requirements: 1.1
  Future<bool> initialize();

  /// 释放资源
  Future<void> dispose();

  /// 显示通知
  /// Requirements: 3.1, 3.2
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  });

  /// 显示批量新内容通知
  /// Requirements: 3.4
  Future<void> showBatchNotification({
    required int totalCount,
    required int feedCount,
  });

  /// 更新托盘图标提示文字
  /// Requirements: 5.2, 5.3, 5.4
  Future<void> updateTooltip(String tooltip);

  /// 设置未读数量徽章
  /// Requirements: 5.1
  Future<void> setUnreadBadge(int count);

  /// 显示主窗口
  /// Requirements: 1.3, 2.3
  Future<void> showMainWindow();

  /// 隐藏到托盘
  /// Requirements: 4.1
  Future<void> hideToTray();

  /// 检查是否已初始化
  bool get isInitialized;

  /// 设置同步回调
  set onSyncRequested(void Function()? callback);

  /// 设置设置页面回调
  set onSettingsRequested(void Function()? callback);

  /// 设置退出回调
  set onExitRequested(void Function()? callback);

  /// 设置通知点击回调
  set onNotificationClicked(void Function(String? payload)? callback);
}
