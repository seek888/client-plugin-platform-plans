import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/presentation/widgets/feed_list_panel.dart';

void main() {
  Widget buildSubject({
    List<Feed> feeds = const [],
    int unreadCount = 0,
    VoidCallback? onAddFeed,
    VoidCallback? onSearchPressed,
  }) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 360,
            child: FeedListPanel(
              feeds: feeds,
              categories: const [],
              totalUnreadCount: unreadCount,
              onFeedSelected: (_) {},
              onRefresh: () {},
              onAddFeed: onAddFeed ?? () {},
              onSearchPressed: onSearchPressed ?? () {},
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders feed panel status and empty state', (tester) async {
    await tester.pumpWidget(buildSubject());

    expect(find.text('订阅源'), findsOneWidget);
    expect(find.text('0 个订阅'), findsOneWidget);
    expect(find.text('0 未读'), findsOneWidget);
    expect(find.text('还没有订阅源'), findsOneWidget);
    expect(find.text('添加订阅源'), findsWidgets);
  });

  testWidgets('renders feed and unread counts from data', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        unreadCount: 12,
        feeds: [
          Feed(
            id: 'feed-1',
            url: 'https://example.com/rss',
            title: 'Example Feed',
            unreadCount: 12,
          ),
        ],
      ),
    );

    expect(find.text('1 个订阅'), findsOneWidget);
    expect(find.text('12 未读'), findsOneWidget);
    expect(find.text('Example Feed'), findsOneWidget);
  });
}
