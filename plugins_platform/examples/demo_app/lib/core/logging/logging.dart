/// 日志系统统一导出
///
/// 使用方式:
/// ```dart
/// import 'package:rss_reader/core/logging/logging.dart';
///
/// // 使用全局 logger
/// logger.info('Hello World');
///
/// // 使用带标签的 logger
/// final log = logger.tag(LogTags.network);
/// log.debug('Fetching data...');
/// ```
library;

export 'log_level.dart';
export 'app_logger.dart';
export 'log_tags.dart';
export 'logging_provider.dart';
