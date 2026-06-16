import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rss_reader/core/logging/logging.dart';

/// 全局日志记录器 Provider
final loggerProvider = Provider<AppLogger>((ref) {
  return AppLogger.instance;
});

/// 数据库日志 Provider
final databaseLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.database);
});

/// 网络日志 Provider
final networkLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.network);
});

/// 同步服务日志 Provider
final syncLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.sync);
});

/// 订阅源日志 Provider
final feedLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.feed);
});

/// 文章日志 Provider
final articleLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.article);
});

/// RSS 解析日志 Provider
final parserLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.parser);
});

/// UI 日志 Provider
final uiLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.ui);
});

/// 导航日志 Provider
final navigationLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.navigation);
});

/// 设置日志 Provider
final settingsLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.settings);
});

/// 通知日志 Provider
final notificationLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.notification);
});

/// 缓存日志 Provider
final cacheLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.cache);
});

/// 搜索日志 Provider
final searchLoggerProvider = Provider<TaggedLogger>((ref) {
  return AppLogger.instance.tag(LogTags.search);
});
