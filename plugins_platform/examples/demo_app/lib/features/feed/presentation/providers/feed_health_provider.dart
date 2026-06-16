import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/database/database_provider.dart';
import 'package:rss_reader/core/services/rss_parser_service_impl.dart';
import 'package:rss_reader/features/feed/data/services/feed_health_service_impl.dart';
import 'package:rss_reader/features/feed/data/services/feed_validator_impl.dart';
import 'package:rss_reader/features/feed/domain/services/feed_health_service.dart';

part 'feed_health_provider.g.dart';

/// 订阅源健康检测服务 Provider
@riverpod
FeedHealthService feedHealthService(Ref ref) {
  final feedDao = ref.watch(feedDaoProvider);
  final rssParserService = RssParserServiceImpl();
  final feedValidator = FeedValidatorImpl(rssParserService: rssParserService);

  return FeedHealthServiceImpl(feedValidator: feedValidator, feedDao: feedDao);
}
