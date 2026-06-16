import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';

/// 通知服务接口
///
/// 负责应用内通知的初始化、权限请求和发送
/// Requirements: 16.1
abstract class NotificationService {
  /// 初始化通知服务
  ///
  /// 配置通知渠道和基本设置
  /// 返回初始化是否成功
  Future<Either<Failure, bool>> initialize();

  /// 请求通知权限
  ///
  /// 在 iOS 和 Android 13+ 上需要请求权限
  /// 返回权限是否被授予
  Future<Either<Failure, bool>> requestPermission();

  /// 检查通知权限状态
  ///
  /// 返回当前是否有通知权限
  Future<bool> hasPermission();

  /// 显示新内容通知
  ///
  /// [feedTitle] 订阅源标题
  /// [articleCount] 新文章数量
  /// [feedId] 订阅源 ID，用于点击通知后跳转
  Future<Either<Failure, void>> showNewContentNotification({
    required String feedTitle,
    required int articleCount,
    String? feedId,
  });

  /// 显示批量新内容通知
  ///
  /// [totalCount] 总新文章数量
  /// [feedCount] 有更新的订阅源数量
  Future<Either<Failure, void>> showBatchNewContentNotification({
    required int totalCount,
    required int feedCount,
  });

  /// 显示同步完成通知
  ///
  /// [message] 同步结果消息
  Future<Either<Failure, void>> showSyncCompleteNotification({
    required String message,
  });

  /// 显示错误通知
  ///
  /// [title] 错误标题
  /// [message] 错误详情
  Future<Either<Failure, void>> showErrorNotification({
    required String title,
    required String message,
  });

  /// 取消所有通知
  Future<void> cancelAllNotifications();

  /// 取消指定通知
  ///
  /// [notificationId] 通知 ID
  Future<void> cancelNotification(int notificationId);

  /// 获取通知是否已启用
  ///
  /// 检查用户是否在应用设置中启用了通知
  Future<bool> isNotificationEnabled();

  /// 设置通知启用状态
  ///
  /// [enabled] 是否启用通知
  Future<void> setNotificationEnabled(bool enabled);
}
