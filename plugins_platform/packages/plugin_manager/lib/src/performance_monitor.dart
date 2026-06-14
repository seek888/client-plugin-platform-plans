import 'package:core/core.dart';

/// 性能监控器
///
/// 监控插件的性能指标：启动时间、内存占用、CPU 使用率等
class PerformanceMonitor {
  /// 插件性能数据
  final Map<String, PluginPerformanceData> _performanceData = {};

  /// 性能预算配置
  final Map<String, PerformanceBudget> _budgets = {};

  /// 告警回调
  final Function(PerformanceAlert)? _onAlert;

  PerformanceMonitor({Function(PerformanceAlert)? onAlert})
      : _onAlert = onAlert;

  /// 记录启动时间
  void recordStartupTime(String pluginId, Duration duration) {
    _ensureData(pluginId);
    _performanceData[pluginId]!.startupTime = duration;

    // 检查是否超出预算
    _checkPerformance(pluginId);
  }

  /// 记录首屏渲染时间
  void recordFirstScreenTime(String pluginId, Duration duration) {
    _ensureData(pluginId);
    _performanceData[pluginId]!.firstScreenTime = duration;

    _checkPerformance(pluginId);
  }

  /// 更新内存占用
  void updateMemoryUsage(String pluginId, int memoryBytes) {
    _ensureData(pluginId);
    _performanceData[pluginId]!.currentMemoryMb = memoryBytes / (1024 * 1024);

    _checkPerformance(pluginId);
  }

  /// 更新 CPU 占用
  void updateCpuUsage(String pluginId, double cpuPercent) {
    _ensureData(pluginId);
    _performanceData[pluginId]!.currentCpuPercent = cpuPercent;

    _checkPerformance(pluginId);
  }

  /// 记录函数调用时间
  void recordFunctionCall(
      String pluginId, String functionName, Duration duration) {
    _ensureData(pluginId);
    _performanceData[pluginId]!.functionCalls[functionName] = duration;
  }

  /// 获取性能数据
  PluginPerformanceData? getPerformanceData(String pluginId) {
    return _performanceData[pluginId];
  }

  /// 获取所有性能数据
  Map<String, PluginPerformanceData> getAllPerformanceData() {
    return Map.from(_performanceData);
  }

  /// 设置性能预算
  void setBudget(String pluginId, PerformanceBudget budget) {
    _budgets[pluginId] = budget;
  }

  /// 获取性能预算
  PerformanceBudget? getBudget(String pluginId) => _budgets[pluginId];

  /// 检查性能是否达标
  void _checkPerformance(String pluginId) {
    final data = _performanceData[pluginId];
    final budget = _budgets[pluginId];

    if (data == null || budget == null) return;

    final alerts = <PerformanceAlert>[];

    // 检查启动时间
    if (data.startupTime != null &&
        data.startupTime!.inMilliseconds > budget.startupMs) {
      alerts.add(PerformanceAlert(
        type: PerformanceAlertType.startupTimeout,
        pluginId: pluginId,
        message:
            'Startup time ${data.startupTime!.inMilliseconds}ms exceeds budget ${budget.startupMs}ms',
        severity: AlertSeverity.warning,
      ));
    }

    // 检查首屏时间
    if (data.firstScreenTime != null &&
        data.firstScreenTime!.inMilliseconds > budget.firstScreenMs) {
      alerts.add(PerformanceAlert(
        type: PerformanceAlertType.firstScreenTimeout,
        pluginId: pluginId,
        message:
            'First screen time ${data.firstScreenTime!.inMilliseconds}ms exceeds budget ${budget.firstScreenMs}ms',
        severity: AlertSeverity.warning,
      ));
    }

    // 检查内存占用
    if (data.currentMemoryMb != null &&
        data.currentMemoryMb! > budget.maxMemoryMb) {
      alerts.add(PerformanceAlert(
        type: PerformanceAlertType.memoryExceeded,
        pluginId: pluginId,
        message:
            'Memory usage ${data.currentMemoryMb}MB exceeds budget ${budget.maxMemoryMb}MB',
        severity: AlertSeverity.critical,
      ));
    }

    // 检查 CPU 占用
    if (data.currentCpuPercent != null &&
        data.currentCpuPercent! > budget.maxCpuPercent) {
      alerts.add(PerformanceAlert(
        type: PerformanceAlertType.cpuExceeded,
        pluginId: pluginId,
        message:
            'CPU usage ${data.currentCpuPercent}% exceeds budget ${budget.maxCpuPercent}%',
        severity: data.currentCpuPercent! > budget.maxCpuPercent * 1.5
            ? AlertSeverity.critical
            : AlertSeverity.warning,
      ));
    }

    // 触发告警
    for (final alert in alerts) {
      _onAlert?.call(alert);
    }
  }

  void _ensureData(String pluginId) {
    _performanceData.putIfAbsent(
      pluginId,
      () => PluginPerformanceData(pluginId: pluginId),
    );
  }

  /// 重置性能数据
  void reset(String pluginId) {
    _performanceData.remove(pluginId);
  }

  /// 清空所有数据
  void clear() {
    _performanceData.clear();
    _budgets.clear();
  }
}

/// 插件性能数据
class PluginPerformanceData {
  /// 插件 ID
  final String pluginId;

  /// 启动时间
  Duration? startupTime;

  /// 首屏渲染时间
  Duration? firstScreenTime;

  /// 当前内存占用（MB）
  double? currentMemoryMb;

  /// 当前 CPU 占用（%）
  double? currentCpuPercent;

  /// 函数调用时间
  final Map<String, Duration> functionCalls;

  /// 调用次数统计
  final Map<String, int> callCounts;

  /// 错误次数
  int errorCount;

  /// 崩溃次数
  int crashCount;

  PluginPerformanceData({
    required this.pluginId,
    this.startupTime,
    this.firstScreenTime,
    this.currentMemoryMb,
    this.currentCpuPercent,
    Map<String, Duration>? functionCalls,
    Map<String, int>? callCounts,
    this.errorCount = 0,
    this.crashCount = 0,
  })  : functionCalls = functionCalls ?? {},
        callCounts = callCounts ?? {};
}

/// 性能告警
class PerformanceAlert {
  /// 告警类型
  final PerformanceAlertType type;

  /// 插件 ID
  final String pluginId;

  /// 告警消息
  final String message;

  /// 严重程度
  final AlertSeverity severity;

  /// 时间戳
  final DateTime timestamp;

  PerformanceAlert({
    required this.type,
    required this.pluginId,
    required this.message,
    required this.severity,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// 性能告警类型
enum PerformanceAlertType {
  /// 启动超时
  startupTimeout,

  /// 首屏超时
  firstScreenTimeout,

  /// 内存超限
  memoryExceeded,

  /// CPU 超限
  cpuExceeded,

  /// 错误率过高
  highErrorRate,

  /// 崩溃
  crash,
}

/// 告警严重程度
enum AlertSeverity {
  /// 信息
  info,

  /// 警告
  warning,

  /// 严重
  critical,

  /// 紧急
  urgent,
}

/// 性能限流器
///
/// 对插件资源使用进行限流
class PerformanceRateLimiter {
  /// 内存限制
  final int memoryLimitMb;

  /// CPU 限制
  final int cpuLimitPercent;

  /// 调用频率限制
  final int callRateLimit;

  /// 当前状态
  final Map<String, RateLimitState> _states = {};

  PerformanceRateLimiter({
    this.memoryLimitMb = 16,
    this.cpuLimitPercent = 15,
    this.callRateLimit = 100,
  });

  /// 检查是否允许调用
  bool checkCallAllowed(String pluginId) {
    final state = _states.putIfAbsent(
      pluginId,
      () => RateLimitState(),
    );

    final now = DateTime.now();
    final windowStart = now.subtract(const Duration(seconds: 1));

    // 清理过期记录
    state.calls.removeWhere((time) => time.isBefore(windowStart));

    // 检查频率限制
    if (state.calls.length >= callRateLimit) {
      return false;
    }

    // 记录调用
    state.calls.add(now);
    return true;
  }

  /// 调用次数
  int getCallCount(String pluginId) {
    return _states[pluginId]?.calls.length ?? 0;
  }

  /// 重置状态
  void reset(String pluginId) {
    _states.remove(pluginId);
  }
}

/// 限流状态
class RateLimitState {
  /// 调用记录
  final List<DateTime> calls = [];

  /// 当前内存使用（MB）
  double? currentMemory;

  /// 当前 CPU 使用（%）
  double? currentCpu;

  /// 是否被限流
  bool isThrottled = false;
}
