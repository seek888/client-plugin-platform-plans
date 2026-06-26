import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';

void main() {
  group('Plugin feed DAO identity lookup', () {
    late AppDatabase database;
    late FeedDao feedDao;

    setUp(() {
      database = AppDatabase.forTesting(NativeDatabase.memory());
      feedDao = FeedDao(database);
    });

    tearDown(() async {
      await database.close();
    });

    test(
      'matches plugin feeds by canonical plugin URL for legacy rows',
      () async {
        await feedDao.insertFeed(
          FeedsTableCompanion(
            id: const Value('legacy-ai-news'),
            url: const Value('plugin://com.rss.ai_news_daily/ai-news'),
            title: const Value('AI 资讯快报'),
            sourceType: const Value('plugin'),
            createdAt: Value(DateTime(2026)),
            updatedAt: Value(DateTime(2026)),
          ),
        );

        final feeds = await feedDao.getPluginFeedsByIdentity(
          'com.rss.ai_news_daily',
          'ai-news',
        );

        expect(feeds, hasLength(1));
        expect(feeds.single.id, 'legacy-ai-news');
      },
    );

    test('returns all duplicate rows in stable creation order', () async {
      await feedDao.insertFeed(
        FeedsTableCompanion(
          id: const Value('first'),
          url: const Value('plugin://com.rss.ai_news_daily/ai-news'),
          title: const Value('AI 资讯快报'),
          sourceType: const Value('plugin'),
          createdAt: Value(DateTime(2026)),
          updatedAt: Value(DateTime(2026)),
        ),
      );
      await feedDao.insertFeed(
        FeedsTableCompanion(
          id: const Value('second'),
          url: const Value('plugin://com.rss.ai_news_daily/ai-news'),
          title: const Value('AI 资讯快报'),
          sourceType: const Value('plugin'),
          pluginId: const Value('com.rss.ai_news_daily'),
          pluginFeedKey: const Value('ai-news'),
          createdAt: Value(DateTime(2026, 1, 2)),
          updatedAt: Value(DateTime(2026, 1, 2)),
        ),
      );

      final feeds = await feedDao.getPluginFeedsByIdentity(
        'com.rss.ai_news_daily',
        'ai-news',
      );

      expect(feeds.map((feed) => feed.id), ['first', 'second']);
    });
  });
}
