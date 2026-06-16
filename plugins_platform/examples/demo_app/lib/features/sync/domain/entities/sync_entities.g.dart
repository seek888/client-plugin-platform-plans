// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncStatusImpl _$$SyncStatusImplFromJson(Map<String, dynamic> json) =>
    _$SyncStatusImpl(
      state: $enumDecode(_$SyncStateEnumMap, json['state']),
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      message: json['message'] as String?,
      lastSyncTime: json['lastSyncTime'] == null
          ? null
          : DateTime.parse(json['lastSyncTime'] as String),
      currentSyncType: $enumDecodeNullable(
        _$SyncTypeEnumMap,
        json['currentSyncType'],
      ),
    );

Map<String, dynamic> _$$SyncStatusImplToJson(_$SyncStatusImpl instance) =>
    <String, dynamic>{
      'state': _$SyncStateEnumMap[instance.state]!,
      'progress': instance.progress,
      'message': instance.message,
      'lastSyncTime': instance.lastSyncTime?.toIso8601String(),
      'currentSyncType': _$SyncTypeEnumMap[instance.currentSyncType],
    };

const _$SyncStateEnumMap = {
  SyncState.idle: 'idle',
  SyncState.syncing: 'syncing',
  SyncState.success: 'success',
  SyncState.failed: 'failed',
  SyncState.partial: 'partial',
};

const _$SyncTypeEnumMap = {
  SyncType.all: 'all',
  SyncType.feeds: 'feeds',
  SyncType.readStatus: 'readStatus',
  SyncType.favorites: 'favorites',
};

_$SyncResultImpl _$$SyncResultImplFromJson(Map<String, dynamic> json) =>
    _$SyncResultImpl(
      success: json['success'] as bool,
      syncedFeedsCount: (json['syncedFeedsCount'] as num?)?.toInt() ?? 0,
      syncedArticlesCount: (json['syncedArticlesCount'] as num?)?.toInt() ?? 0,
      syncedFavoritesCount:
          (json['syncedFavoritesCount'] as num?)?.toInt() ?? 0,
      failedCount: (json['failedCount'] as num?)?.toInt() ?? 0,
      errors:
          (json['errors'] as List<dynamic>?)
              ?.map((e) => SyncError.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
    );

Map<String, dynamic> _$$SyncResultImplToJson(_$SyncResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'syncedFeedsCount': instance.syncedFeedsCount,
      'syncedArticlesCount': instance.syncedArticlesCount,
      'syncedFavoritesCount': instance.syncedFavoritesCount,
      'failedCount': instance.failedCount,
      'errors': instance.errors,
      'syncedAt': instance.syncedAt?.toIso8601String(),
    };

_$SyncErrorImpl _$$SyncErrorImplFromJson(Map<String, dynamic> json) =>
    _$SyncErrorImpl(
      type: $enumDecode(_$SyncTypeEnumMap, json['type']),
      message: json['message'] as String,
      itemId: json['itemId'] as String?,
      occurredAt: json['occurredAt'] == null
          ? null
          : DateTime.parse(json['occurredAt'] as String),
    );

Map<String, dynamic> _$$SyncErrorImplToJson(_$SyncErrorImpl instance) =>
    <String, dynamic>{
      'type': _$SyncTypeEnumMap[instance.type]!,
      'message': instance.message,
      'itemId': instance.itemId,
      'occurredAt': instance.occurredAt?.toIso8601String(),
    };

_$SyncConflictImpl _$$SyncConflictImplFromJson(Map<String, dynamic> json) =>
    _$SyncConflictImpl(
      itemId: json['itemId'] as String,
      type: $enumDecode(_$SyncTypeEnumMap, json['type']),
      localValue: json['localValue'],
      remoteValue: json['remoteValue'],
      localUpdatedAt: DateTime.parse(json['localUpdatedAt'] as String),
      remoteUpdatedAt: DateTime.parse(json['remoteUpdatedAt'] as String),
    );

Map<String, dynamic> _$$SyncConflictImplToJson(_$SyncConflictImpl instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'type': _$SyncTypeEnumMap[instance.type]!,
      'localValue': instance.localValue,
      'remoteValue': instance.remoteValue,
      'localUpdatedAt': instance.localUpdatedAt.toIso8601String(),
      'remoteUpdatedAt': instance.remoteUpdatedAt.toIso8601String(),
    };

_$SyncLogEntryImpl _$$SyncLogEntryImplFromJson(Map<String, dynamic> json) =>
    _$SyncLogEntryImpl(
      id: (json['id'] as num?)?.toInt(),
      syncType: $enumDecode(_$SyncTypeEnumMap, json['syncType']),
      status: json['status'] as String,
      message: json['message'] as String?,
      itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
      syncedAt: DateTime.parse(json['syncedAt'] as String),
    );

Map<String, dynamic> _$$SyncLogEntryImplToJson(_$SyncLogEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'syncType': _$SyncTypeEnumMap[instance.syncType]!,
      'status': instance.status,
      'message': instance.message,
      'itemCount': instance.itemCount,
      'syncedAt': instance.syncedAt.toIso8601String(),
    };
