import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:rss_reader/core/logging/log_level.dart';

/// 应用日志记录器
///
/// 单例模式，提供统一的日志输出接口
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();

  /// 获取日志记录器实例
  static AppLogger get instance => _instance;

  /// 当前日志配置
  LogConfig _config = kDebugMode ? LogConfig.debug : LogConfig.release;

  /// 时间戳格式化器
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');

  AppLogger._internal();

  /// 初始化日志配置
  void init(LogConfig config) {
    _config = config;
  }

  /// 获取当前配置
  LogConfig get config => _config;

  /// 设置最小日志级别
  void setMinLevel(LogLevel level) {
    _config = _config.copyWith(minLevel: level);
  }

  /// 启用/禁用日志
  void setEnabled(bool enabled) {
    _config = _config.copyWith(enabled: enabled);
  }

  /// 启用/禁用颜色
  void setColorEnabled(bool enabled) {
    _config = _config.copyWith(enableColor: enabled);
  }

  /// 获取带标签的日志记录器
  TaggedLogger tag(String tag) => TaggedLogger(this, tag);

  /// 记录调试日志
  void debug(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.debug, message,
        tag: tag, error: error, stackTrace: stackTrace);
  }

  /// 记录信息日志
  void info(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.info, message,
        tag: tag, error: error, stackTrace: stackTrace);
  }

  /// 记录警告日志
  void warning(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.warning, message,
        tag: tag, error: error, stackTrace: stackTrace);
  }

  /// 记录错误日志
  void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.error, message,
        tag: tag, error: error, stackTrace: stackTrace);
  }

  /// 内部日志方法
  void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    // 检查是否启用日志
    if (!_config.enabled) return;

    // 检查日志级别
    if (!level.shouldLog(_config.minLevel)) return;

    try {
      final output = _formatMessage(level, message,
          tag: tag, error: error, stackTrace: stackTrace);
      // ignore: avoid_print
      print(output);
    } catch (e) {
      // 日志系统自身错误，尝试输出原始消息
      // ignore: avoid_print
      print('[LOG ERROR] $message');
    }
  }

  /// 格式化日志消息
  String _formatMessage(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final buffer = StringBuffer();
    final timestamp = _dateFormat.format(DateTime.now());

    // 构建基本日志行
    if (_config.enableColor) {
      buffer.write(level.colorCode);
    }

    buffer.write('[$timestamp] [${level.label}]');

    if (tag != null && tag.isNotEmpty) {
      buffer.write(' [$tag]');
    }

    buffer.write(' $message');

    if (_config.enableColor) {
      buffer.write(LogLevel.resetCode);
    }

    // 添加错误信息
    if (error != null) {
      buffer.writeln();
      buffer.write('  Error: $error');
    }

    // 添加堆栈跟踪
    if (stackTrace != null) {
      buffer.writeln();
      buffer.write('  StackTrace:');
      final lines = stackTrace.toString().split('\n');
      for (final line in lines.take(10)) {
        if (line.trim().isNotEmpty) {
          buffer.writeln();
          buffer.write('    $line');
        }
      }
      if (lines.length > 10) {
        buffer.writeln();
        buffer.write('    ... ${lines.length - 10} more lines');
      }
    }

    return buffer.toString();
  }

  /// 格式化日志消息（用于测试）
  String formatMessageForTest(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return _formatMessage(level, message,
        tag: tag, error: error, stackTrace: stackTrace);
  }
}

/// 带标签的日志记录器
///
/// 自动在所有日志消息中包含指定的标签
class TaggedLogger {
  final AppLogger _logger;
  final String _tag;

  TaggedLogger(this._logger, this._tag);

  /// 获取标签
  String get tag => _tag;

  /// 记录调试日志
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.debug(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  /// 记录信息日志
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.info(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  /// 记录警告日志
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.warning(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  /// 记录错误日志
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.error(message, tag: _tag, error: error, stackTrace: stackTrace);
  }
}

/// 全局日志快捷访问
final logger = AppLogger.instance;
