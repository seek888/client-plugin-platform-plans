import 'dart:io';

import 'package:rss_reader/core/desktop/tray_integration_service.dart';
import 'package:rss_reader/features/notification/domain/services/notification_service.dart';

/// 新内容通知器
///
/// 负责在后台刷新时发送新内容通知
/// Requirements: 16.1
class NewContentNotifier {
  final NotificationService _notificationService;

  NewContentNotifier({required NotificationService notificationService})
      : _notificationService = notificationService;

  /// 通知单个订阅源有新内容
  ///
  /// [feedTitle] 订阅源标题
  /// [articleCount] 新文章数量
  /// [feedId] 订阅源 ID
  Future<void> notifyNewContent({
    required String feedTitle,
    required int articleCount,
    String? feedId,
  }) async {
    if (articleCount <= 0) return;

    // Windows 平台使用托盘通知
    if (Platform.isWindows) {
      await TrayIntegrationService.instance.showNewContentNotification(
        feedTitle: feedTitle,
        articleCount: articleCount,
      );
    } else {
      // 移动端使用本地通知
      await _notificationService.showNewContentNotification(
        feedTitle: feedTitle,
        articleCount: articleCount,
        feedId: feedId,
      );
    }
  }

  /// 通知批量新内容
  ///
  /// [refreshResults] 刷新结果列表，包含每个订阅源的新文章数
  Future<void> notifyBatchNewContent({
    required Map<String, int> refreshResults,
  }) async {
    // 过滤出有新内容的订阅源
    final feedsWithNewContent =
        refreshResults.entries.where((entry) => entry.value > 0).toList();

    if (feedsWithNewContent.isEmpty) return;

    final totalCount = feedsWithNewContent.fold<int>(
      0,
      (sum, entry) => sum + entry.value,
    );
    final feedCount = feedsWithNewContent.length;

    // Windows 平台使用托盘通知
    if (Platform.isWindows) {
      await TrayIntegrationService.instance.showBatchNotification(
        totalCount: totalCount,
        feedCount: feedCount,
      );
    } else {
      // 移动端使用本地通知
      await _notificationService.showBatchNewContentNotification(
        totalCount: totalCount,
        feedCount: feedCount,
      );
    }
  }

  /// 通知刷新结果
  ///
  /// [newArticleCount] 新文章总数
  /// [failedCount] 失败的订阅源数量
  Future<void> notifyRefreshResult({
    required int newArticleCount,
    required int failedCount,
  }) async {
    if (newArticleCount > 0) {
      // Windows 平台使用托盘通知
      if (Platform.isWindows) {
        await TrayIntegrationService.instance.showBatchNotification(
          totalCount: newArticleCount,
          feedCount: 1,
        );
      } else {
        await _notificationService.showBatchNewContentNotification(
          totalCount: newArticleCount,
          feedCount: 1,
        );
      }
    }

    if (failedCount > 0) {
      await _notificationService.showErrorNotification(
        title: '刷新部分失败',
        message: '$failedCount 个订阅源刷新失败',
      );
    }
  }
}
