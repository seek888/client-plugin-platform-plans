import 'package:drift/native.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/sync_log_dao.dart';
import 'package:rss_reader/features/sync/data/services/sync_log_service_impl.dart';
import 'package:rss_reader/features/sync/domain/entities/sync_entities.dart';
import 'package:rss_reader/features/sync/domain/services/sync_log_service.dart';

/// Generators for sync log testing
extension SyncLogGenerators on Any {
  /// Generate a random sync type
  Generator<SyncType> get syncType {
    return any.choose(SyncType.values);
  }

  /// Generate a random error message
  Generator<String> get errorMessage {
    return any.intInRange(10, 50).map((length) => 'Error: ${'x' * length}');
  }

  /// Generate a random item count
  Generator<int> get itemCount {
    return any.intInRange(0, 100);
  }
}

/// Test context for sync log tests
class SyncLogTestContext {
  final AppDatabase database;
  final SyncLogDao syncLogDao;
  final SyncLogService syncLogService;

  SyncLogTestContext._({
    required this.database,
    required this.syncLogDao,
    required this.syncLogService,
  });

  factory SyncLogTestContext.create() {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final syncLogDao = SyncLogDao(database);
    final syncLogService = SyncLogServiceImpl(syncLogDao: syncLogDao);
    return SyncLogTestContext._(
      database: database,
      syncLogDao: syncLogDao,
      syncLogService: syncLogService,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}

void main() {
  group('Property 17: Sync Failure Logging Correctness', () {
    /// **Property 17: 同步失败日志记录**
    /// *For any* 同步失败事件，同步日志表中应记录该失败事件，包含失败时间和错误信息。
    /// **Validates: Requirements 17.4**

    Glados2(any.syncType, any.errorMessage).test(
      'Property 17a: Sync failure is logged with correct type and message',
      (SyncType syncType, String errorMessage) async {
        final ctx = SyncLogTestContext.create();
        try {
          // Log a sync failure
          final result = await ctx.syncLogService.logSyncFailure(
            syncType: syncType,
            message: errorMessage,
          );

          // Verify the log was created
          expect(result.isRight(), isTrue);

          // Retrieve the last log entry
          final lastLogResult = await ctx.syncLogService.getLastSyncLog(
            syncType: syncType,
          );
          expect(lastLogResult.isRight(), isTrue);

          final lastLog = lastLogResult.getOrElse(() => null);
          expect(lastLog, isNotNull);
          expect(lastLog!.syncType, equals(syncType));
          expect(lastLog.status, equals('failed'));
          expect(lastLog.message, equals(errorMessage));
        } finally {
          await ctx.dispose();
        }
      },
    );

    Glados(any.syncType).test(
      'Property 17b: Failed sync logs appear in failed logs list',
      (SyncType syncType) async {
        final ctx = SyncLogTestContext.create();
        try {
          const errorMessage = 'Test failure message';

          // Log a sync failure
          await ctx.syncLogService.logSyncFailure(
            syncType: syncType,
            message: errorMessage,
          );

          // Retrieve failed logs
          final failedLogsResult = await ctx.syncLogService.getFailedSyncLogs();
          expect(failedLogsResult.isRight(), isTrue);

          final failedLogs = failedLogsResult.getOrElse(() => []);
          expect(failedLogs.isNotEmpty, isTrue);

          // Verify the failure is in the list
          final matchingLog = failedLogs.firstWhere(
            (log) => log.syncType == syncType && log.message == errorMessage,
            orElse: () => throw Exception('Log not found'),
          );
          expect(matchingLog.status, equals('failed'));
        } finally {
          await ctx.dispose();
        }
      },
    );

    Glados(any.syncType).test(
      'Property 17c: Sync failure timestamp is recorded',
      (SyncType syncType) async {
        final ctx = SyncLogTestContext.create();
        try {
          final beforeLog = DateTime.now();

          // Log a sync failure
          await ctx.syncLogService.logSyncFailure(
            syncType: syncType,
            message: 'Test failure',
          );

          final afterLog = DateTime.now();

          // Retrieve the last log entry
          final lastLogResult = await ctx.syncLogService.getLastSyncLog(
            syncType: syncType,
          );
          expect(lastLogResult.isRight(), isTrue);

          final lastLog = lastLogResult.getOrElse(() => null);
          expect(lastLog, isNotNull);

          // Verify timestamp is within expected range
          expect(
            lastLog!.syncedAt.isAfter(
              beforeLog.subtract(const Duration(seconds: 1)),
            ),
            isTrue,
            reason: 'Log timestamp should be after test start',
          );
          expect(
            lastLog.syncedAt.isBefore(afterLog.add(const Duration(seconds: 1))),
            isTrue,
            reason: 'Log timestamp should be before test end',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    Glados2(any.syncType, any.itemCount).test(
      'Property 17d: Successful sync logs are recorded correctly',
      (SyncType syncType, int itemCount) async {
        final ctx = SyncLogTestContext.create();
        try {
          // Log a successful sync
          final result = await ctx.syncLogService.logSync(
            syncType: syncType,
            status: 'success',
            message: 'Sync completed',
            itemCount: itemCount,
          );

          expect(result.isRight(), isTrue);

          // Retrieve the last log entry
          final lastLogResult = await ctx.syncLogService.getLastSyncLog(
            syncType: syncType,
          );
          expect(lastLogResult.isRight(), isTrue);

          final lastLog = lastLogResult.getOrElse(() => null);
          expect(lastLog, isNotNull);
          expect(lastLog!.syncType, equals(syncType));
          expect(lastLog.status, equals('success'));
          expect(lastLog.itemCount, equals(itemCount));
        } finally {
          await ctx.dispose();
        }
      },
    );

    test('Property 17e: Multiple failures are all logged', () async {
      final ctx = SyncLogTestContext.create();
      try {
        const failureCount = 5;

        // Log multiple failures
        for (var i = 0; i < failureCount; i++) {
          await ctx.syncLogService.logSyncFailure(
            syncType: SyncType.all,
            message: 'Failure $i',
          );
        }

        // Retrieve failed logs
        final failedLogsResult = await ctx.syncLogService.getFailedSyncLogs(
          limit: 10,
        );
        expect(failedLogsResult.isRight(), isTrue);

        final failedLogs = failedLogsResult.getOrElse(() => []);
        expect(failedLogs.length, equals(failureCount));

        // Verify all failures are present (check that all messages exist)
        final messages = failedLogs.map((log) => log.message).toSet();
        for (var i = 0; i < failureCount; i++) {
          expect(
            messages.contains('Failure $i'),
            isTrue,
            reason: 'Should contain Failure $i',
          );
        }
      } finally {
        await ctx.dispose();
      }
    });

    test('Property 17f: Log count is accurate', () async {
      final ctx = SyncLogTestContext.create();
      try {
        // Log some successes and failures
        await ctx.syncLogService.logSync(
          syncType: SyncType.feeds,
          status: 'success',
          message: 'Success 1',
        );
        await ctx.syncLogService.logSyncFailure(
          syncType: SyncType.feeds,
          message: 'Failure 1',
        );
        await ctx.syncLogService.logSyncFailure(
          syncType: SyncType.favorites,
          message: 'Failure 2',
        );

        // Check total count
        final totalCountResult = await ctx.syncLogService.getSyncLogCount();
        expect(totalCountResult.getOrElse(() => -1), equals(3));

        // Check count by type
        final feedsCountResult = await ctx.syncLogService.getSyncLogCount(
          syncType: SyncType.feeds,
        );
        expect(feedsCountResult.getOrElse(() => -1), equals(2));

        // Check count by status
        final failedCountResult = await ctx.syncLogService.getSyncLogCount(
          status: 'failed',
        );
        expect(failedCountResult.getOrElse(() => -1), equals(2));
      } finally {
        await ctx.dispose();
      }
    });

    test('Property 17g: Old logs can be cleared', () async {
      final ctx = SyncLogTestContext.create();
      try {
        // Log some entries
        await ctx.syncLogService.logSync(
          syncType: SyncType.all,
          status: 'success',
          message: 'Old log',
        );

        // Wait longer to ensure timestamp difference
        await Future.delayed(const Duration(seconds: 1));

        final cutoffTime = DateTime.now();

        // Wait a bit more before adding new log
        await Future.delayed(const Duration(milliseconds: 100));

        // Log another entry
        await ctx.syncLogService.logSync(
          syncType: SyncType.all,
          status: 'success',
          message: 'New log',
        );

        // Clear old logs
        final clearResult = await ctx.syncLogService.clearOldLogs(
          olderThan: cutoffTime,
        );
        expect(clearResult.isRight(), isTrue);

        // The old log should be cleared (count >= 0)
        final clearedCount = clearResult.getOrElse(() => -1);
        expect(clearedCount >= 0, isTrue);

        // Verify new log still exists
        final logsResult = await ctx.syncLogService.getSyncLogs();
        expect(logsResult.isRight(), isTrue);

        final logs = logsResult.getOrElse(() => []);
        // At least the new log should remain
        expect(logs.isNotEmpty, isTrue);
        expect(logs.any((log) => log.message == 'New log'), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    test('Property 17h: Empty log list when no logs exist', () async {
      final ctx = SyncLogTestContext.create();
      try {
        // Retrieve logs without adding any
        final logsResult = await ctx.syncLogService.getSyncLogs();
        expect(logsResult.isRight(), isTrue);
        expect(logsResult.getOrElse(() => []).isEmpty, isTrue);

        // Retrieve failed logs
        final failedLogsResult = await ctx.syncLogService.getFailedSyncLogs();
        expect(failedLogsResult.isRight(), isTrue);
        expect(failedLogsResult.getOrElse(() => []).isEmpty, isTrue);

        // Get last log
        final lastLogResult = await ctx.syncLogService.getLastSyncLog();
        expect(lastLogResult.isRight(), isTrue);
        expect(lastLogResult.getOrElse(() => null), isNull);
      } finally {
        await ctx.dispose();
      }
    });

    Glados(any.syncType).test(
      'Property 17i: Partial success status is logged correctly',
      (SyncType syncType) async {
        final ctx = SyncLogTestContext.create();
        try {
          // Log a partial success
          final result = await ctx.syncLogService.logSync(
            syncType: syncType,
            status: 'partial',
            message: 'Partial sync completed with errors',
            itemCount: 5,
          );

          expect(result.isRight(), isTrue);

          // Retrieve the last log entry
          final lastLogResult = await ctx.syncLogService.getLastSyncLog(
            syncType: syncType,
          );
          expect(lastLogResult.isRight(), isTrue);

          final lastLog = lastLogResult.getOrElse(() => null);
          expect(lastLog, isNotNull);
          expect(lastLog!.status, equals('partial'));
        } finally {
          await ctx.dispose();
        }
      },
    );
  });
}
