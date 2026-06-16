import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/services/rss_parser_service.dart';
import 'package:rss_reader/core/services/rss_parser_service_impl.dart';

part 'rss_parser_provider.g.dart';

@riverpod
RssParserService rssParserService(Ref ref) {
  return RssParserServiceImpl();
}
