import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/features/sync/domain/entities/sync_entities.dart';
import 'package:rss_reader/features/sync/domain/services/sync_log_service.dart';

/// 同步错误处理器
///
/// 负责处理同步过程中的错误，并记录日志
class SyncErrorHandler {
  final SyncLogService _syncLogService;

  SyncErrorHandler({required SyncLogService syncLogService})
    : _syncLogService = syncLogService;

  /// 处理同步错误
  ///
  /// [syncType] 同步类型
  /// [error] 错误对象
  /// [stackTrace] 堆栈跟踪
  /// 返回格式化的 SyncError
  Future<SyncError> handleError(
    SyncType syncType,
    Object error, [
    StackTrace? stackTrace,
  ]) async {
    final message = _formatErrorMessage(syncType, error);

    // 记录失败日志
    await _syncLogService.logSyncFailure(syncType: syncType, message: message);

    return SyncError(
      type: syncType,
      message: message,
      occurredAt: DateTime.now(),
    );
  }

  /// 格式化错误消息
  String _formatErrorMessage(SyncType syncType, Object error) {
    final typeName = _syncTypeDisplayName(syncType);

    if (error is Failure) {
      return '$typeName同步失败: ${error.userMessage}';
    }

    if (error is Exception) {
      return '$typeName同步失败: ${error.toString().replaceFirst('Exception: ', '')}';
    }

    return '$typeName同步失败: ${error.toString()}';
  }

  /// 记录同步成功
  ///
  /// [syncType] 同步类型
  /// [itemCount] 同步的项目数量
  /// [message] 可选的自定义消息
  Future<void> logSuccess(
    SyncType syncType, {
    required int itemCount,
    String? message,
  }) async {
    await _syncLogService.logSync(
      syncType: syncType,
      status: 'success',
      message: message ?? '${_syncTypeDisplayName(syncType)}同步完成',
      itemCount: itemCount,
    );
  }

  /// 记录部分成功
  ///
  /// [syncType] 同步类型
  /// [itemCount] 成功同步的项目数量
  /// [errors] 发生的错误列表
  Future<void> logPartialSuccess(
    SyncType syncType, {
    required int itemCount,
    required List<SyncError> errors,
  }) async {
    final errorMessages = errors.map((e) => e.message).join('; ');
    await _syncLogService.logSync(
      syncType: syncType,
      status: 'partial',
      message: '${_syncTypeDisplayName(syncType)}部分成功，错误: $errorMessages',
      itemCount: itemCount,
    );
  }

  /// 记录同步失败
  ///
  /// [syncType] 同步类型
  /// [message] 失败消息
  Future<void> logFailure(SyncType syncType, {required String message}) async {
    await _syncLogService.logSyncFailure(syncType: syncType, message: message);
  }

  /// 获取同步类型显示名称
  String _syncTypeDisplayName(SyncType type) {
    switch (type) {
      case SyncType.all:
        return '全部';
      case SyncType.feeds:
        return '订阅源';
      case SyncType.readStatus:
        return '阅读状态';
      case SyncType.favorites:
        return '收藏';
    }
  }

  /// 判断错误是否可重试
  bool isRetryableError(Object error) {
    if (error is Failure) {
      return error.isRetryable;
    }

    // 网络相关错误通常可重试
    final errorString = error.toString().toLowerCase();
    return errorString.contains('timeout') ||
        errorString.contains('connection') ||
        errorString.contains('network') ||
        errorString.contains('socket');
  }

  /// 获取重试延迟时间（指数退避）
  Duration getRetryDelay(int attemptNumber) {
    // 指数退避：1s, 2s, 4s, 8s, 最大 30s
    final seconds = (1 << attemptNumber).clamp(1, 30);
    return Duration(seconds: seconds);
  }
}
