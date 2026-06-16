import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/notification/domain/services/notification_service.dart';

/// 通知服务实现
///
/// 使用 flutter_local_notifications 实现本地通知功能
/// Requirements: 16.1
class NotificationServiceImpl implements NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  bool _isInitialized = false;
  bool _notificationEnabled = true;

  /// 通知渠道 ID
  static const String _channelId = 'rss_reader_channel';

  /// 通知渠道名称
  static const String _channelName = 'RSS Reader 通知';

  /// 通知渠道描述
  static const String _channelDescription = '新内容更新和同步状态通知';

  /// 通知 ID 常量
  static const int _newContentNotificationId = 1;
  static const int _batchContentNotificationId = 2;
  static const int _syncNotificationId = 3;
  static const int _errorNotificationId = 4;

  NotificationServiceImpl({
    FlutterLocalNotificationsPlugin? notificationsPlugin,
  }) : _notificationsPlugin =
           notificationsPlugin ?? FlutterLocalNotificationsPlugin();

  @override
  Future<Either<Failure, bool>> initialize() async {
    try {
      // 桌面平台不支持本地通知，直接返回成功
      if (_isDesktopPlatform) {
        _isInitialized = true;
        return const Right(true);
      }

      // Android 初始化设置
      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      // iOS 初始化设置
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      final result = await _notificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      _isInitialized = result ?? false;
      return Right(_isInitialized);
    } catch (e) {
      return Left(Failure.unknown(message: '初始化通知服务失败: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> requestPermission() async {
    try {
      // 桌面平台不需要请求权限
      if (_isDesktopPlatform) {
        return const Right(true);
      }

      if (!_isInitialized) {
        final initResult = await initialize();
        if (initResult.isLeft()) {
          return initResult;
        }
      }

      bool granted = false;

      if (Platform.isAndroid) {
        // Android 13+ 需要请求通知权限
        final androidPlugin = _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

        if (androidPlugin != null) {
          granted =
              await androidPlugin.requestNotificationsPermission() ?? false;
        } else {
          // Android 12 及以下版本默认有权限
          granted = true;
        }
      } else if (Platform.isIOS) {
        // iOS 请求权限
        final iosPlugin = _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();

        if (iosPlugin != null) {
          granted =
              await iosPlugin.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              ) ??
              false;
        }
      }

      return Right(granted);
    } catch (e) {
      return Left(Failure.unknown(message: '请求通知权限失败: ${e.toString()}'));
    }
  }

  @override
  Future<bool> hasPermission() async {
    try {
      // 桌面平台默认有权限
      if (_isDesktopPlatform) {
        return true;
      }

      if (Platform.isAndroid) {
        final androidPlugin = _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

        if (androidPlugin != null) {
          return await androidPlugin.areNotificationsEnabled() ?? false;
        }
        return true;
      } else if (Platform.isIOS) {
        // iOS 没有直接检查权限的方法，假设已授权
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, void>> showNewContentNotification({
    required String feedTitle,
    required int articleCount,
    String? feedId,
  }) async {
    try {
      if (!_notificationEnabled || !_isInitialized) {
        return const Right(null);
      }

      // 桌面平台不显示通知
      if (_isDesktopPlatform) {
        return const Right(null);
      }

      final title = '新内容更新';
      final body = '$feedTitle 有 $articleCount 篇新文章';

      await _showNotification(
        id: _newContentNotificationId,
        title: title,
        body: body,
        payload: feedId,
      );

      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: '显示通知失败: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> showBatchNewContentNotification({
    required int totalCount,
    required int feedCount,
  }) async {
    try {
      if (!_notificationEnabled || !_isInitialized) {
        return const Right(null);
      }

      // 桌面平台不显示通知
      if (_isDesktopPlatform) {
        return const Right(null);
      }

      final title = '新内容更新';
      final body = '$feedCount 个订阅源共有 $totalCount 篇新文章';

      await _showNotification(
        id: _batchContentNotificationId,
        title: title,
        body: body,
      );

      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: '显示通知失败: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> showSyncCompleteNotification({
    required String message,
  }) async {
    try {
      if (!_notificationEnabled || !_isInitialized) {
        return const Right(null);
      }

      // 桌面平台不显示通知
      if (_isDesktopPlatform) {
        return const Right(null);
      }

      await _showNotification(
        id: _syncNotificationId,
        title: '同步完成',
        body: message,
      );

      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: '显示通知失败: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> showErrorNotification({
    required String title,
    required String message,
  }) async {
    try {
      if (!_notificationEnabled || !_isInitialized) {
        return const Right(null);
      }

      // 桌面平台不显示通知
      if (_isDesktopPlatform) {
        return const Right(null);
      }

      await _showNotification(
        id: _errorNotificationId,
        title: title,
        body: message,
      );

      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: '显示通知失败: ${e.toString()}'));
    }
  }

  @override
  Future<void> cancelAllNotifications() async {
    if (_isDesktopPlatform) return;

    try {
      await _notificationsPlugin.cancelAll();
    } catch (e) {
      // 忽略取消通知时的错误
      debugPrint('取消所有通知失败: $e');
    }
  }

  @override
  Future<void> cancelNotification(int notificationId) async {
    if (_isDesktopPlatform) return;

    try {
      await _notificationsPlugin.cancel(notificationId);
    } catch (e) {
      // 忽略取消通知时的错误
      debugPrint('取消通知失败: $e');
    }
  }

  @override
  Future<bool> isNotificationEnabled() async {
    return _notificationEnabled;
  }

  @override
  Future<void> setNotificationEnabled(bool enabled) async {
    _notificationEnabled = enabled;
  }

  /// 显示通知的内部方法
  Future<void> _showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// 通知点击回调
  void _onNotificationTapped(NotificationResponse response) {
    // 处理通知点击事件
    // 可以通过 payload 获取额外信息并进行导航
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      // 这里可以触发导航到特定订阅源
      debugPrint('通知被点击，payload: $payload');
    }
  }

  /// 检查是否为桌面平台
  bool get _isDesktopPlatform {
    if (kIsWeb) return false;
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }
}
