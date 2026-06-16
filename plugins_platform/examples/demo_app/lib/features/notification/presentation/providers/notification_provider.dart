import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/features/notification/data/services/notification_service_impl.dart';
import 'package:rss_reader/features/notification/data/services/new_content_notifier.dart';
import 'package:rss_reader/features/notification/domain/services/notification_service.dart';
import 'package:rss_reader/features/settings/presentation/providers/app_settings_provider.dart';

part 'notification_provider.g.dart';

/// 通知服务 Provider
///
/// 提供全局单例的通知服务实例
@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) {
  return NotificationServiceImpl();
}

/// 新内容通知器 Provider
///
/// 提供新内容通知功能，会检查用户设置中是否启用了通知
@riverpod
NewContentNotifier newContentNotifier(Ref ref) {
  final notificationService = ref.watch(notificationServiceProvider);
  final settings = ref.watch(appSettingsNotifierProvider);

  // 根据用户设置同步通知启用状态
  notificationService.setNotificationEnabled(settings.notificationsEnabled);

  return NewContentNotifier(notificationService: notificationService);
}

/// 通知权限状态 Provider
///
/// 检查当前是否有通知权限
@riverpod
Future<bool> notificationPermission(Ref ref) async {
  final service = ref.watch(notificationServiceProvider);
  return service.hasPermission();
}

/// 通知启用状态 Provider
///
/// 检查用户是否启用了通知
@riverpod
Future<bool> notificationEnabled(Ref ref) async {
  final service = ref.watch(notificationServiceProvider);
  return service.isNotificationEnabled();
}

/// 通知初始化状态 Notifier
///
/// 管理通知服务的初始化状态
@riverpod
class NotificationInitializer extends _$NotificationInitializer {
  @override
  Future<bool> build() async {
    final service = ref.watch(notificationServiceProvider);
    final result = await service.initialize();
    return result.fold((failure) => false, (success) => success);
  }

  /// 请求通知权限
  Future<bool> requestPermission() async {
    final service = ref.read(notificationServiceProvider);
    final result = await service.requestPermission();
    return result.fold((failure) => false, (granted) => granted);
  }
}
