import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_entities.freezed.dart';
part 'sync_entities.g.dart';

/// 同步状态枚举
enum SyncState {
  /// 空闲
  idle,

  /// 同步中
  syncing,

  /// 成功
  success,

  /// 失败
  failed,

  /// 部分成功
  partial,
}

/// 同步类型枚举
enum SyncType {
  /// 全部同步
  all,

  /// 订阅源同步
  feeds,

  /// 阅读状态同步
  readStatus,

  /// 收藏同步
  favorites,
}

/// 同步状态
@freezed
class SyncStatus with _$SyncStatus {
  const SyncStatus._();

  const factory SyncStatus({
    required SyncState state,
    @Default(0.0) double progress,
    String? message,
    DateTime? lastSyncTime,
    SyncType? currentSyncType,
  }) = _SyncStatus;

  factory SyncStatus.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusFromJson(json);

  /// 是否正在同步
  bool get isSyncing => state == SyncState.syncing;

  /// 是否同步成功
  bool get isSuccess => state == SyncState.success;

  /// 是否同步失败
  bool get isFailed => state == SyncState.failed;
}

/// 同步结果
@freezed
class SyncResult with _$SyncResult {
  const SyncResult._();

  const factory SyncResult({
    required bool success,
    @Default(0) int syncedFeedsCount,
    @Default(0) int syncedArticlesCount,
    @Default(0) int syncedFavoritesCount,
    @Default(0) int failedCount,
    @Default([]) List<SyncError> errors,
    DateTime? syncedAt,
  }) = _SyncResult;

  factory SyncResult.fromJson(Map<String, dynamic> json) =>
      _$SyncResultFromJson(json);

  /// 是否有错误
  bool get hasErrors => errors.isNotEmpty;

  /// 是否部分成功
  bool get isPartialSuccess => success && hasErrors;
}

/// 同步错误
@freezed
class SyncError with _$SyncError {
  const factory SyncError({
    required SyncType type,
    required String message,
    String? itemId,
    DateTime? occurredAt,
  }) = _SyncError;

  factory SyncError.fromJson(Map<String, dynamic> json) =>
      _$SyncErrorFromJson(json);
}

/// 同步冲突
@freezed
class SyncConflict with _$SyncConflict {
  const factory SyncConflict({
    required String itemId,
    required SyncType type,
    required dynamic localValue,
    required dynamic remoteValue,
    required DateTime localUpdatedAt,
    required DateTime remoteUpdatedAt,
  }) = _SyncConflict;

  factory SyncConflict.fromJson(Map<String, dynamic> json) =>
      _$SyncConflictFromJson(json);
}

/// 同步日志条目
@freezed
class SyncLogEntry with _$SyncLogEntry {
  const factory SyncLogEntry({
    int? id,
    required SyncType syncType,
    required String status,
    String? message,
    @Default(0) int itemCount,
    required DateTime syncedAt,
  }) = _SyncLogEntry;

  factory SyncLogEntry.fromJson(Map<String, dynamic> json) =>
      _$SyncLogEntryFromJson(json);
}
