import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';
import 'package:rss_reader/core/logging/logging.dart';
import 'package:rss_reader/features/sync/domain/entities/sync_entities.dart';
import 'package:rss_reader/features/sync/domain/services/sync_service.dart';
import 'package:rss_reader/features/sync/domain/services/sync_log_service.dart';
import 'package:rss_reader/features/sync/data/services/sync_error_handler.dart';

final _log = logger.tag(LogTags.sync);

/// 同步服务实现
///
/// 负责订阅源、阅读状态、收藏等数据的云端同步
class SyncServiceImpl implements SyncService {
  final SyncLogService _syncLogService;
  final SyncErrorHandler _errorHandler;

  final _statusController = StreamController<SyncStatus>.broadcast();
  SyncStatus _currentStatus = const SyncStatus(state: SyncState.idle);
  bool _isCancelled = false;

  SyncServiceImpl({required SyncLogService syncLogService})
      : _syncLogService = syncLogService,
        _errorHandler = SyncErrorHandler(syncLogService: syncLogService);

  @override
  Stream<SyncStatus> get syncStatusStream => _statusController.stream;

  @override
  SyncStatus get currentStatus => _currentStatus;

  void _updateStatus(SyncStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  @override
  Future<Either<Failure, SyncResult>> syncAll() async {
    if (_currentStatus.isSyncing) {
      _log.warning('同步已在进行中，跳过本次请求');
      return Left(Failure.sync(message: '同步正在进行中', syncType: 'all'));
    }

    _log.info('开始全量同步');
    final stopwatch = Stopwatch()..start();

    _isCancelled = false;
    final errors = <SyncError>[];
    var syncedFeedsCount = 0;
    var syncedArticlesCount = 0;
    var syncedFavoritesCount = 0;

    try {
      // 开始同步
      _updateStatus(
        SyncStatus(
          state: SyncState.syncing,
          progress: 0.0,
          message: '正在同步订阅源...',
          currentSyncType: SyncType.all,
        ),
      );

      // 同步订阅源
      if (!_isCancelled) {
        _log.debug('同步订阅源...');
        final feedsResult = await syncFeeds();
        feedsResult.fold((failure) async {
          final error = await _errorHandler.handleError(
            SyncType.feeds,
            failure,
          );
          errors.add(error);
        }, (count) => syncedFeedsCount = count);
      }

      _updateStatus(
        _currentStatus.copyWith(progress: 0.33, message: '正在同步阅读状态...'),
      );

      // 同步阅读状态
      if (!_isCancelled) {
        _log.debug('同步阅读状态...');
        final readStatusResult = await syncReadStatus();
        readStatusResult.fold((failure) async {
          final error = await _errorHandler.handleError(
            SyncType.readStatus,
            failure,
          );
          errors.add(error);
        }, (count) => syncedArticlesCount = count);
      }

      _updateStatus(
        _currentStatus.copyWith(progress: 0.66, message: '正在同步收藏...'),
      );

      // 同步收藏
      if (!_isCancelled) {
        _log.debug('同步收藏...');
        final favoritesResult = await syncFavorites();
        favoritesResult.fold((failure) async {
          final error = await _errorHandler.handleError(
            SyncType.favorites,
            failure,
          );
          errors.add(error);
        }, (count) => syncedFavoritesCount = count);
      }

      final syncedAt = DateTime.now();
      final success = errors.isEmpty;
      final totalSynced =
          syncedFeedsCount + syncedArticlesCount + syncedFavoritesCount;

      final result = SyncResult(
        success: success,
        syncedFeedsCount: syncedFeedsCount,
        syncedArticlesCount: syncedArticlesCount,
        syncedFavoritesCount: syncedFavoritesCount,
        failedCount: errors.length,
        errors: errors,
        syncedAt: syncedAt,
      );

      // 记录同步日志
      if (success) {
        await _errorHandler.logSuccess(
          SyncType.all,
          itemCount: totalSynced,
          message: '同步完成',
        );
        _log.info(
            '同步完成, 耗时: ${stopwatch.elapsedMilliseconds}ms, 同步项: $totalSynced');
      } else if (errors.length < 3) {
        await _errorHandler.logPartialSuccess(
          SyncType.all,
          itemCount: totalSynced,
          errors: errors,
        );
        _log.warning('同步部分完成, 错误数: ${errors.length}');
      } else {
        await _errorHandler.logFailure(
          SyncType.all,
          message: '同步失败: ${errors.map((e) => e.message).join(', ')}',
        );
        _log.error('同步失败, 错误数: ${errors.length}');
      }

      _updateStatus(
        SyncStatus(
          state: success ? SyncState.success : SyncState.partial,
          progress: 1.0,
          message: success ? '同步完成' : '同步部分完成',
          lastSyncTime: syncedAt,
        ),
      );

      return Right(result);
    } catch (e, stackTrace) {
      // 使用错误处理器处理异常
      final error = await _errorHandler.handleError(
        SyncType.all,
        e,
        stackTrace,
      );

      _log.error('同步异常', error: e, stackTrace: stackTrace);

      _updateStatus(
        SyncStatus(
          state: SyncState.failed,
          progress: 0.0,
          message: error.message,
        ),
      );

      return Left(Failure.sync(message: error.message, syncType: 'all'));
    }
  }

  @override
  Future<Either<Failure, int>> syncFeeds() async {
    try {
      // 模拟同步订阅源
      // 实际实现中，这里会与云端 API 交互
      await Future.delayed(const Duration(milliseconds: 100));

      // 记录成功日志
      await _errorHandler.logSuccess(
        SyncType.feeds,
        itemCount: 0,
        message: '订阅源同步完成',
      );

      return const Right(0);
    } catch (e, stackTrace) {
      final error = await _errorHandler.handleError(
        SyncType.feeds,
        e,
        stackTrace,
      );
      return Left(Failure.sync(message: error.message, syncType: 'feeds'));
    }
  }

  @override
  Future<Either<Failure, int>> syncReadStatus() async {
    try {
      // 模拟同步阅读状态
      await Future.delayed(const Duration(milliseconds: 100));

      await _errorHandler.logSuccess(
        SyncType.readStatus,
        itemCount: 0,
        message: '阅读状态同步完成',
      );

      return const Right(0);
    } catch (e, stackTrace) {
      final error = await _errorHandler.handleError(
        SyncType.readStatus,
        e,
        stackTrace,
      );
      return Left(Failure.sync(message: error.message, syncType: 'readStatus'));
    }
  }

  @override
  Future<Either<Failure, int>> syncFavorites() async {
    try {
      // 模拟同步收藏
      await Future.delayed(const Duration(milliseconds: 100));

      await _errorHandler.logSuccess(
        SyncType.favorites,
        itemCount: 0,
        message: '收藏同步完成',
      );

      return const Right(0);
    } catch (e, stackTrace) {
      final error = await _errorHandler.handleError(
        SyncType.favorites,
        e,
        stackTrace,
      );
      return Left(Failure.sync(message: error.message, syncType: 'favorites'));
    }
  }

  @override
  Future<Either<Failure, void>> resolveConflict(
    SyncConflict conflict, {
    required bool useLocal,
  }) async {
    try {
      // 实际实现中，这里会根据 useLocal 决定使用本地还是远程值
      // 并更新相应的数据
      return const Right(null);
    } catch (e) {
      return Left(
        Failure.sync(
          message: '解决冲突失败: ${e.toString()}',
          syncType: conflict.type.name,
        ),
      );
    }
  }

  @override
  Future<void> cancelSync() async {
    _log.info('取消同步');
    _isCancelled = true;
    _updateStatus(SyncStatus(state: SyncState.idle, message: '同步已取消'));
  }

  @override
  Future<DateTime?> getLastSyncTime() async {
    final result = await _syncLogService.getLastSyncLog();
    return result.fold((failure) => null, (log) => log?.syncedAt);
  }

  @override
  Future<bool> needsSync() async {
    final lastSyncTime = await getLastSyncTime();
    if (lastSyncTime == null) {
      return true;
    }

    // 如果上次同步超过 1 小时，则需要同步
    final hoursSinceLastSync = DateTime.now().difference(lastSyncTime).inHours;
    return hoursSinceLastSync >= 1;
  }

  /// 释放资源
  void dispose() {
    _statusController.close();
  }
}
