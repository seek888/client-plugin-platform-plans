/// 日志级别枚举
///
/// 定义四个日志级别，每个级别包含优先级、标签和 ANSI 颜色代码
enum LogLevel {
  /// 调试级别 - 青色
  debug(0, 'DEBUG', '\x1B[36m'),

  /// 信息级别 - 绿色
  info(1, 'INFO', '\x1B[32m'),

  /// 警告级别 - 黄色
  warning(2, 'WARN', '\x1B[33m'),

  /// 错误级别 - 红色
  error(3, 'ERROR', '\x1B[31m');

  const LogLevel(this.priority, this.label, this.colorCode);

  /// 日志级别优先级，数值越大优先级越高
  final int priority;

  /// 日志级别标签，用于输出显示
  final String label;

  /// ANSI 颜色代码
  final String colorCode;

  /// ANSI 重置代码
  static const String resetCode = '\x1B[0m';

  /// 判断当前级别是否应该输出（基于最小级别）
  bool shouldLog(LogLevel minLevel) => priority >= minLevel.priority;
}

/// 日志配置类
///
/// 控制日志系统的行为，包括最小级别、颜色开关和启用状态
class LogConfig {
  /// 最小日志级别，低于此级别的日志不会输出
  final LogLevel minLevel;

  /// 是否启用终端颜色
  final bool enableColor;

  /// 是否启用日志输出
  final bool enabled;

  const LogConfig({
    this.minLevel = LogLevel.debug,
    this.enableColor = true,
    this.enabled = true,
  });

  /// Release 模式默认配置
  /// - 只输出 warning 及以上级别
  /// - 禁用颜色
  static const LogConfig release = LogConfig(
    minLevel: LogLevel.warning,
    enableColor: false,
    enabled: true,
  );

  /// Debug 模式默认配置
  /// - 输出所有级别
  /// - 启用颜色
  static const LogConfig debug = LogConfig(
    minLevel: LogLevel.debug,
    enableColor: true,
    enabled: true,
  );

  /// 禁用日志的配置
  static const LogConfig disabled = LogConfig(
    enabled: false,
  );

  /// 复制并修改配置
  LogConfig copyWith({
    LogLevel? minLevel,
    bool? enableColor,
    bool? enabled,
  }) {
    return LogConfig(
      minLevel: minLevel ?? this.minLevel,
      enableColor: enableColor ?? this.enableColor,
      enabled: enabled ?? this.enabled,
    );
  }
}
