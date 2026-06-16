import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/feed/data/services/feed_sorting_service_impl.dart';
import 'package:rss_reader/features/feed/domain/services/feed_sorting_service.dart';

/// **Property 5: 订阅源重排序正确性**
/// **Validates: Requirements 3.1**
///
/// WHEN 用户拖拽订阅源 THEN THE Feed_Manager SHALL 调整订阅源在列表中的排序位置

// Custom generators for sorting testing
extension SortingGenerators on Any {
  /// Generator for feed count (2-10 feeds)
  Generator<int> get feedCount {
    return any.intInRange(2, 10);
  }

  /// Generator for valid index within a list
  Generator<int> validIndexFor(int listLength) {
    return any.intInRange(0, listLength - 1);
  }
}

/// Helper to create fresh database and service for each test
class SortingTestContext {
  final AppDatabase database;
  final FeedDao feedDao;
  final FeedSortingService sortingService;

  SortingTestContext._({
    required this.database,
    required this.feedDao,
    required this.sortingService,
  });

  factory SortingTestContext.create() {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final feedDao = FeedDao(database);
    final sortingService = FeedSortingServiceImpl(feedDao: feedDao);
    return SortingTestContext._(
      database: database,
      feedDao: feedDao,
      sortingService: sortingService,
    );
  }

  /// Create test feeds
  Future<List<String>> createTestFeeds(int count) async {
    final feedIds = <String>[];
    for (var i = 0; i < count; i++) {
      final feedId = 'feed-$i';
      await feedDao.insertFeed(
        FeedsTableCompanion(
          id: Value(feedId),
          url: Value('https://example$i.com/feed.xml'),
          title: Value('Feed $i'),
          sortOrder: Value(i),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
      feedIds.add(feedId);
    }
    return feedIds;
  }

  Future<void> dispose() async {
    await database.close();
  }
}

void main() {
  group('Property 5: Feed Reordering Correctness', () {
    // Property 5a: Reordering preserves all feeds
    Glados(any.feedCount).test('Property 5a: Reordering preserves all feeds', (
      int count,
    ) async {
      final ctx = SortingTestContext.create();

      try {
        // Create test feeds
        final originalFeedIds = await ctx.createTestFeeds(count);

        // Reverse the order
        final reversedFeedIds = originalFeedIds.reversed.toList();

        // Reorder
        final reorderResult = await ctx.sortingService.reorderFeeds(
          reversedFeedIds,
        );
        expect(reorderResult.isRight(), isTrue);

        // Get sorted feeds
        final sortedResult = await ctx.sortingService.getSortedFeeds();
        expect(sortedResult.isRight(), isTrue);

        final sortedFeeds = sortedResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        // Verify all feeds are preserved
        expect(
          sortedFeeds.length,
          equals(count),
          reason: 'All feeds should be preserved after reordering',
        );

        // Verify the order matches the reversed order
        for (var i = 0; i < count; i++) {
          expect(
            sortedFeeds[i].id,
            equals(reversedFeedIds[i]),
            reason: 'Feed at index $i should match the reordered list',
          );
        }
      } finally {
        await ctx.dispose();
      }
    });

    // Property 5b: Reordering is idempotent
    Glados(any.feedCount).test(
      'Property 5b: Reordering with same order is idempotent',
      (int count) async {
        final ctx = SortingTestContext.create();

        try {
          // Create test feeds
          final feedIds = await ctx.createTestFeeds(count);

          // Reorder with the same order
          final reorderResult1 = await ctx.sortingService.reorderFeeds(feedIds);
          expect(reorderResult1.isRight(), isTrue);

          // Get sorted feeds after first reorder
          final sortedResult1 = await ctx.sortingService.getSortedFeeds();
          final sortedFeeds1 = sortedResult1.getOrElse(
            () => throw StateError('Expected Right'),
          );

          // Reorder again with the same order
          final reorderResult2 = await ctx.sortingService.reorderFeeds(feedIds);
          expect(reorderResult2.isRight(), isTrue);

          // Get sorted feeds after second reorder
          final sortedResult2 = await ctx.sortingService.getSortedFeeds();
          final sortedFeeds2 = sortedResult2.getOrElse(
            () => throw StateError('Expected Right'),
          );

          // Verify the order is the same
          for (var i = 0; i < count; i++) {
            expect(
              sortedFeeds2[i].id,
              equals(sortedFeeds1[i].id),
              reason: 'Order should be the same after idempotent reordering',
            );
          }
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 5c: Moving feed to index updates sortOrder correctly
    test(
      'Property 5c: Moving feed to index updates sortOrder correctly',
      () async {
        final ctx = SortingTestContext.create();

        try {
          // Create 5 test feeds
          final feedIds = await ctx.createTestFeeds(5);

          // Move first feed to last position
          final moveResult = await ctx.sortingService.moveFeedToIndex(
            feedIds[0],
            4,
          );
          expect(moveResult.isRight(), isTrue);

          // Get sorted feeds
          final sortedResult = await ctx.sortingService.getSortedFeeds();
          final sortedFeeds = sortedResult.getOrElse(
            () => throw StateError('Expected Right'),
          );

          // Verify the first feed is now at the last position
          expect(sortedFeeds.last.id, equals(feedIds[0]));

          // Verify other feeds shifted correctly
          expect(sortedFeeds[0].id, equals(feedIds[1]));
          expect(sortedFeeds[1].id, equals(feedIds[2]));
          expect(sortedFeeds[2].id, equals(feedIds[3]));
          expect(sortedFeeds[3].id, equals(feedIds[4]));
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 5d: Swapping feeds exchanges their positions
    test('Property 5d: Swapping feeds exchanges their positions', () async {
      final ctx = SortingTestContext.create();

      try {
        // Create 5 test feeds
        final feedIds = await ctx.createTestFeeds(5);

        // Swap first and last feeds
        final swapResult = await ctx.sortingService.swapFeeds(
          feedIds[0],
          feedIds[4],
        );
        expect(swapResult.isRight(), isTrue);

        // Get sorted feeds
        final sortedResult = await ctx.sortingService.getSortedFeeds();
        final sortedFeeds = sortedResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        // Verify the swap
        expect(sortedFeeds[0].id, equals(feedIds[4]));
        expect(sortedFeeds[4].id, equals(feedIds[0]));

        // Verify middle feeds are unchanged
        expect(sortedFeeds[1].id, equals(feedIds[1]));
        expect(sortedFeeds[2].id, equals(feedIds[2]));
        expect(sortedFeeds[3].id, equals(feedIds[3]));
      } finally {
        await ctx.dispose();
      }
    });

    // Property 5e: Swapping same feed is a no-op
    test('Property 5e: Swapping same feed is a no-op', () async {
      final ctx = SortingTestContext.create();

      try {
        // Create 3 test feeds
        final feedIds = await ctx.createTestFeeds(3);

        // Get initial order
        final initialResult = await ctx.sortingService.getSortedFeeds();
        final initialFeeds = initialResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        // Swap feed with itself
        final swapResult = await ctx.sortingService.swapFeeds(
          feedIds[1],
          feedIds[1],
        );
        expect(swapResult.isRight(), isTrue);

        // Get sorted feeds after swap
        final sortedResult = await ctx.sortingService.getSortedFeeds();
        final sortedFeeds = sortedResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        // Verify order is unchanged
        for (var i = 0; i < 3; i++) {
          expect(sortedFeeds[i].id, equals(initialFeeds[i].id));
        }
      } finally {
        await ctx.dispose();
      }
    });

    // Property 5f: Moving feed to same position is a no-op
    test('Property 5f: Moving feed to same position is a no-op', () async {
      final ctx = SortingTestContext.create();

      try {
        // Create 3 test feeds
        final feedIds = await ctx.createTestFeeds(3);

        // Get initial order
        final initialResult = await ctx.sortingService.getSortedFeeds();
        final initialFeeds = initialResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        // Move feed to its current position
        final moveResult = await ctx.sortingService.moveFeedToIndex(
          feedIds[1],
          1,
        );
        expect(moveResult.isRight(), isTrue);

        // Get sorted feeds after move
        final sortedResult = await ctx.sortingService.getSortedFeeds();
        final sortedFeeds = sortedResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        // Verify order is unchanged
        for (var i = 0; i < 3; i++) {
          expect(sortedFeeds[i].id, equals(initialFeeds[i].id));
        }
      } finally {
        await ctx.dispose();
      }
    });
  });

  group('Feed Sorting Edge Cases', () {
    test('Moving feed to invalid index fails', () async {
      final ctx = SortingTestContext.create();

      try {
        // Create 3 test feeds
        final feedIds = await ctx.createTestFeeds(3);

        // Try to move to invalid index
        final moveResult = await ctx.sortingService.moveFeedToIndex(
          feedIds[0],
          10, // Invalid index
        );

        expect(moveResult.isLeft(), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    test('Moving non-existent feed fails', () async {
      final ctx = SortingTestContext.create();

      try {
        // Create 3 test feeds
        await ctx.createTestFeeds(3);

        // Try to move non-existent feed
        final moveResult = await ctx.sortingService.moveFeedToIndex(
          'non-existent-feed',
          0,
        );

        expect(moveResult.isLeft(), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    test('Swapping with non-existent feed fails', () async {
      final ctx = SortingTestContext.create();

      try {
        // Create 3 test feeds
        final feedIds = await ctx.createTestFeeds(3);

        // Try to swap with non-existent feed
        final swapResult = await ctx.sortingService.swapFeeds(
          feedIds[0],
          'non-existent-feed',
        );

        expect(swapResult.isLeft(), isTrue);
      } finally {
        await ctx.dispose();
      }
    });

    test('Empty reorder list succeeds', () async {
      final ctx = SortingTestContext.create();

      try {
        // Reorder with empty list
        final reorderResult = await ctx.sortingService.reorderFeeds([]);

        expect(reorderResult.isRight(), isTrue);
      } finally {
        await ctx.dispose();
      }
    });
  });
}
