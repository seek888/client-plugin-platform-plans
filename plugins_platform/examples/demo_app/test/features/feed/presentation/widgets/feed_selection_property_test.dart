import 'package:glados/glados.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';

/// **Property 20: 选中订阅源内容流刷新**
/// **Validates: Requirements 22.4**
///
/// *For any* 订阅源列表和选中操作，当用户点击订阅源时：
/// 1. 选中状态应正确更新为被点击的订阅源
/// 2. 选中 null 表示选择"全部"
/// 3. 选中状态变化应触发内容流刷新（通过回调验证）

/// 模拟选中状态管理器，用于测试选中逻辑
class FeedSelectionManager {
  String? _selectedFeedId;
  int _selectionChangeCount = 0;
  final List<String?> _selectionHistory = [];

  String? get selectedFeedId => _selectedFeedId;
  int get selectionChangeCount => _selectionChangeCount;
  List<String?> get selectionHistory => List.unmodifiable(_selectionHistory);

  /// 选择订阅源
  /// 返回 true 如果选中状态发生变化
  bool selectFeed(String? feedId) {
    final changed = _selectedFeedId != feedId;
    if (changed) {
      _selectedFeedId = feedId;
      _selectionChangeCount++;
      _selectionHistory.add(feedId);
    }
    return changed;
  }

  /// 检查订阅源是否被选中
  bool isSelected(String? feedId) {
    return _selectedFeedId == feedId;
  }

  /// 重置状态
  void reset() {
    _selectedFeedId = null;
    _selectionChangeCount = 0;
    _selectionHistory.clear();
  }
}

/// 内容流刷新追踪器
class ContentRefreshTracker {
  final List<String?> _refreshedForFeedIds = [];

  List<String?> get refreshedForFeedIds =>
      List.unmodifiable(_refreshedForFeedIds);

  void onFeedSelected(String? feedId) {
    _refreshedForFeedIds.add(feedId);
  }

  void reset() {
    _refreshedForFeedIds.clear();
  }
}

// Custom generators for feed selection testing
extension FeedSelectionGenerators on Any {
  /// Generator for valid Feed
  Generator<Feed> get validFeed {
    return any.combine5(
      any.lowercaseLetters,
      any.lowercaseLetters,
      any.lowercaseLetters,
      any.positiveIntOrZero,
      any.bool,
      (String id, String title, String url, int unread, bool enabled) {
        final safeId = id.isEmpty ? 'feed' : id;
        final safeTitle = title.isEmpty ? 'Feed Title' : title;
        final safeUrl = url.isEmpty ? 'example' : url;
        return Feed(
          id: safeId,
          url: 'https://example.com/$safeUrl.xml',
          title: safeTitle,
          unreadCount: unread % 100, // Cap at 100
          isEnabled: enabled,
        );
      },
    );
  }

  /// Generator for list of feeds with unique IDs
  Generator<List<Feed>> get feedList {
    return any.combine2(any.intInRange(1, 10), any.lowercaseLetters, (
      int count,
      String prefix,
    ) {
      final safePrefix = prefix.isEmpty ? 'feed' : prefix;
      return List.generate(
        count,
        (i) => Feed(
          id: '${safePrefix}_$i',
          url: 'https://example.com/${safePrefix}_$i.xml',
          title: 'Feed $i',
          unreadCount: i * 5,
          isEnabled: true,
        ),
      );
    });
  }

  /// Generator for feed ID
  Generator<String> get feedId {
    return any.combine2(any.lowercaseLetters, any.positiveIntOrZero, (
      String prefix,
      int index,
    ) {
      final safePrefix = prefix.isEmpty ? 'feed' : prefix;
      return '${safePrefix}_$index';
    });
  }
}

void main() {
  group('Property 20: Feed Selection Content Refresh', () {
    // Property 20a: Selecting a feed should update the selected state
    Glados(any.feedList).test(
      'Property 20a: Selecting a feed updates selected state correctly',
      (List<Feed> feeds) {
        final selectionManager = FeedSelectionManager();
        if (feeds.isEmpty) return;

        for (final feed in feeds) {
          selectionManager.selectFeed(feed.id);

          expect(
            selectionManager.selectedFeedId,
            equals(feed.id),
            reason: 'Selected feed ID should be ${feed.id}',
          );
          expect(
            selectionManager.isSelected(feed.id),
            isTrue,
            reason: 'Feed ${feed.id} should be marked as selected',
          );

          // Other feeds should not be selected
          for (final otherFeed in feeds) {
            if (otherFeed.id != feed.id) {
              expect(
                selectionManager.isSelected(otherFeed.id),
                isFalse,
                reason: 'Feed ${otherFeed.id} should not be selected',
              );
            }
          }
        }
      },
    );

    // Property 20b: Selecting null should represent "All" feeds
    Glados(any.feedList).test(
      'Property 20b: Selecting null represents "All" feeds selection',
      (List<Feed> feeds) {
        final selectionManager = FeedSelectionManager();

        // First select a specific feed
        if (feeds.isNotEmpty) {
          selectionManager.selectFeed(feeds.first.id);
          expect(selectionManager.selectedFeedId, isNotNull);
        }

        // Then select "All" (null)
        selectionManager.selectFeed(null);

        expect(
          selectionManager.selectedFeedId,
          isNull,
          reason: 'Selected feed ID should be null for "All"',
        );
        expect(
          selectionManager.isSelected(null),
          isTrue,
          reason: '"All" (null) should be marked as selected',
        );

        // No specific feed should be selected
        for (final feed in feeds) {
          expect(
            selectionManager.isSelected(feed.id),
            isFalse,
            reason:
                'Feed ${feed.id} should not be selected when "All" is selected',
          );
        }
      },
    );

    // Property 20c: Selection change should trigger content refresh callback
    Glados(any.feedList).test(
      'Property 20c: Selection change triggers content refresh',
      (List<Feed> feeds) {
        final selectionManager = FeedSelectionManager();
        final refreshTracker = ContentRefreshTracker();

        if (feeds.isEmpty) return;

        // Simulate selection with refresh callback
        void onFeedSelected(String? feedId) {
          final changed = selectionManager.selectFeed(feedId);
          if (changed) {
            refreshTracker.onFeedSelected(feedId);
          }
        }

        // Select each feed
        for (final feed in feeds) {
          onFeedSelected(feed.id);
        }

        // Select "All"
        onFeedSelected(null);

        // Verify refresh was triggered for each unique selection
        expect(
          refreshTracker.refreshedForFeedIds.length,
          equals(selectionManager.selectionChangeCount),
          reason: 'Refresh should be triggered for each selection change',
        );
      },
    );

    // Property 20d: Selecting the same feed twice should not trigger refresh
    Glados(any.feedId).test(
      'Property 20d: Selecting same feed twice does not trigger extra refresh',
      (String feedId) {
        final selectionManager = FeedSelectionManager();
        final refreshTracker = ContentRefreshTracker();

        void onFeedSelected(String? id) {
          final changed = selectionManager.selectFeed(id);
          if (changed) {
            refreshTracker.onFeedSelected(id);
          }
        }

        // Select the feed twice
        onFeedSelected(feedId);
        onFeedSelected(feedId);

        expect(
          refreshTracker.refreshedForFeedIds.length,
          equals(1),
          reason: 'Refresh should only be triggered once for same selection',
        );
        expect(
          selectionManager.selectionChangeCount,
          equals(1),
          reason: 'Selection change count should be 1',
        );
      },
    );

    // Property 20e: Selection history should be maintained correctly
    Glados(any.feedList).test(
      'Property 20e: Selection history is maintained correctly',
      (List<Feed> feeds) {
        final selectionManager = FeedSelectionManager();

        if (feeds.length < 2) return;

        final expectedHistory = <String?>[];

        // Select first feed
        selectionManager.selectFeed(feeds[0].id);
        expectedHistory.add(feeds[0].id);

        // Select second feed
        selectionManager.selectFeed(feeds[1].id);
        expectedHistory.add(feeds[1].id);

        // Select "All"
        selectionManager.selectFeed(null);
        expectedHistory.add(null);

        // Select first feed again
        selectionManager.selectFeed(feeds[0].id);
        expectedHistory.add(feeds[0].id);

        expect(
          selectionManager.selectionHistory,
          equals(expectedHistory),
          reason: 'Selection history should match expected sequence',
        );
      },
    );
  });

  group('Feed Selection Edge Cases', () {
    late FeedSelectionManager selectionManager;

    setUp(() {
      selectionManager = FeedSelectionManager();
    });

    test('Initial state should have null selection', () {
      expect(selectionManager.selectedFeedId, isNull);
      expect(selectionManager.selectionChangeCount, equals(0));
      expect(selectionManager.selectionHistory, isEmpty);
    });

    test('Selecting null from initial state should not count as change', () {
      // Initial state is null, selecting null should not change
      final changed = selectionManager.selectFeed(null);

      expect(changed, isFalse);
      expect(selectionManager.selectionChangeCount, equals(0));
    });

    test('Reset should clear all state', () {
      selectionManager.selectFeed('feed_1');
      selectionManager.selectFeed('feed_2');

      selectionManager.reset();

      expect(selectionManager.selectedFeedId, isNull);
      expect(selectionManager.selectionChangeCount, equals(0));
      expect(selectionManager.selectionHistory, isEmpty);
    });

    test('Empty feed ID should be treated as valid selection', () {
      selectionManager.selectFeed('');

      expect(selectionManager.selectedFeedId, equals(''));
      expect(selectionManager.isSelected(''), isTrue);
    });

    test('Rapid selection changes should all be tracked', () {
      final feedIds = List.generate(100, (i) => 'feed_$i');

      for (final id in feedIds) {
        selectionManager.selectFeed(id);
      }

      expect(selectionManager.selectionChangeCount, equals(100));
      expect(selectionManager.selectionHistory.length, equals(100));
    });
  });

  group('Content Refresh Tracker Tests', () {
    late ContentRefreshTracker tracker;

    setUp(() {
      tracker = ContentRefreshTracker();
    });

    test('Initial state should have empty refresh list', () {
      expect(tracker.refreshedForFeedIds, isEmpty);
    });

    test('onFeedSelected should add to refresh list', () {
      tracker.onFeedSelected('feed_1');
      tracker.onFeedSelected('feed_2');
      tracker.onFeedSelected(null);

      expect(tracker.refreshedForFeedIds, equals(['feed_1', 'feed_2', null]));
    });

    test('Reset should clear refresh list', () {
      tracker.onFeedSelected('feed_1');
      tracker.reset();

      expect(tracker.refreshedForFeedIds, isEmpty);
    });
  });
}
