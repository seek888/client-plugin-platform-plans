import 'package:core/core.dart';
import 'plugin_manager.dart';

/// 后台插件管理器
///
/// 管理常驻后台的插件，有严格的资源限制
class BackgroundPluginManager {
  final PluginManager _pluginManager;

  /// 后台插件列表
  final Map<String, JSRuntime> _backgroundPlugins = {};

  /// 资源预算配置
  final BackgroundResourceBudget _resourceBudget;

  BackgroundPluginManager(
    this._pluginManager, {
    BackgroundResourceBudget? budget,
  }) : _resourceBudget = budget ?? BackgroundResourceBudget.defaultBudget;

  /// 注册后台插件
  Future<void> registerBackgroundPlugin(String pluginId) async {
    if (_backgroundPlugins.containsKey(pluginId)) {
      return; // 已注册
    }

    final manifest = _pluginManager.getPluginInfo(pluginId)?.manifest;
    if (manifest == null) {
      throw PluginError.notFound(pluginId);
    }

    // 检查是否允许后台
    if (manifest.engine?.background != true) {
      throw PluginError(
        'Plugin does not support background mode',
        pluginId: pluginId,
      );
    }

    // 激活插件
    final runtime = await _pluginManager.activate(pluginId);
    _backgroundPlugins[pluginId] = runtime;

    // 应用资源限制
    await _applyResourceLimits(runtime);
  }

  /// 注销后台插件
  Future<void> unregisterBackgroundPlugin(String pluginId) async {
    final runtime = _backgroundPlugins.remove(pluginId);
    if (runtime != null) {
      _pluginManager.deactivate(pluginId);
    }
  }

  /// 分发事件到后台插件
  Future<void> dispatchEvent(
    String eventName,
    Map<String, dynamic> payload,
  ) async {
    final futures = <Future<void>>[];

    for (final entry in _backgroundPlugins.entries) {
      final pluginId = entry.key;
      final runtime = entry.value;

      // 检查插件是否订阅了此事件
      final manifest = _pluginManager.getPluginInfo(pluginId)?.manifest;
      if (manifest != null && _shouldReceiveEvent(manifest, eventName)) {
        futures.add(_dispatchWithTimeout(runtime, eventName, payload));
      }
    }

    await Future.wait(futures, eagerError: false);
  }

  /// 应用资源限制
  Future<void> _applyResourceLimits(JSRuntime runtime) async {
    // 在实际实现中，这里需要与引擎交互
    // 设置 CPU 限制、内存限制等
    // 当前 QuickJS 实现可能不支持动态调整
  }

  /// 检查插件是否应该接收此事件
  bool _shouldReceiveEvent(PluginManifest manifest, String eventName) {
    // 检查 activationEvents
    for (final event in manifest.activationEvents) {
      if (event == eventName || event.startsWith('onEvent:')) {
        return true;
      }
    }
    return false;
  }

  /// 带超时的分发
  Future<void> _dispatchWithTimeout(
    JSRuntime runtime,
    String eventName,
    Map<String, dynamic> payload,
  ) async {
    try {
      await runtime.dispatchEvent(eventName, payload).timeout(
        Duration(milliseconds: _resourceBudget.eventTimeoutMs),
        onTimeout: () {
          // 超时处理
        },
      );
    } catch (e) {
      // 错误隔离，不影响其他插件
    }
  }

  /// 获取后台插件列表
  List<String> getBackgroundPluginIds() => _backgroundPlugins.keys.toList();

  /// 检查是否是后台插件
  bool isBackgroundPlugin(String pluginId) =>
      _backgroundPlugins.containsKey(pluginId);

  /// 销毁所有后台插件
  Future<void> dispose() async {
    for (final pluginId in _backgroundPlugins.keys.toList()) {
      await unregisterBackgroundPlugin(pluginId);
    }
  }
}

/// 后台资源预算配置
class BackgroundResourceBudget {
  /// 最大内存限制（MB）
  final int maxMemoryMb;

  /// 最大 CPU 使用率（%）
  final int maxCpuPercent;

  /// 事件超时时间（毫秒）
  final int eventTimeoutMs;

  /// 心跳间隔（毫秒）
  final int heartbeatIntervalMs;

  /// 最大心跳超时次数
  final int maxHeartbeatMisses;

  const BackgroundResourceBudget({
    this.maxMemoryMb = 8,
    this.maxCpuPercent = 5,
    this.eventTimeoutMs = 10000,
    this.heartbeatIntervalMs = 60000,
    this.maxHeartbeatMisses = 3,
  });

  /// 默认配置
  static const BackgroundResourceBudget defaultBudget =
      BackgroundResourceBudget();
}

/// 能力编排型插件管理器
///
/// 管理纯 Schema 的插件，无需 JS 运行时
class CapabilityOrchestratorPlugin {
  final PluginManager _pluginManager;

  /// 能力编排插件缓存
  final Map<String, STACSchema> _schemas = {};

  CapabilityOrchestratorPlugin(this._pluginManager);

  /// 注册能力编排插件
  void registerSchema(String pluginId, STACSchema schema) {
    _schemas[pluginId] = schema;
  }

  /// 获取插件 Schema
  STACSchema? getSchema(String pluginId) => _schemas[pluginId];

  /// 移除插件 Schema
  void removeSchema(String pluginId) {
    _schemas.remove(pluginId);
  }

  /// 执行能力编排
  Future<Map<String, dynamic>> executeCapability({
    required String pluginId,
    required String capabilityId,
    required Map<String, dynamic> params,
  }) async {
    if (_pluginManager.getPluginInfo(pluginId) == null) {
      throw PluginError.notFound(pluginId);
    }

    // 在实际实现中，这里需要：
    // 1. 获取插件定义的动作链
    // 2. 按顺序执行各个能力调用
    // 3. 组合结果
    // 4. 返回最终结果

    // 简化实现：直接调用 Host Bridge
    // TODO: 实现动作链执行逻辑

    return {};
  }
}

/// 远端插件服务管理器
///
/// 管理逻辑运行在服务端的插件
class RemotePluginService {
  final PluginManager _pluginManager;

  /// 远端插件配置
  final Map<String, RemotePluginConfig> _configs = {};

  RemotePluginService(this._pluginManager);

  /// 注册远端插件
  void registerRemotePlugin(String pluginId, RemotePluginConfig config) {
    _configs[pluginId] = config;
  }

  /// 调用远端插件
  Future<Map<String, dynamic>> invokeRemotePlugin({
    required String pluginId,
    required String action,
    required Map<String, dynamic> params,
  }) async {
    if (_pluginManager.getPluginInfo(pluginId) == null) {
      throw PluginError.notFound(pluginId);
    }

    final config = _configs[pluginId];
    if (config == null) {
      throw PluginError.notFound(pluginId);
    }

    // 通过 HTTP 调用远端插件服务
    // TODO: 实现网络调用逻辑

    return {};
  }
}

/// 远端插件配置
class RemotePluginConfig {
  /// 服务端点 URL
  final String endpoint;

  /// API Key
  final String? apiKey;

  /// 超时时间（毫秒）
  final int timeoutMs;

  /// 是否需要鉴权
  final bool requireAuth;

  const RemotePluginConfig({
    required this.endpoint,
    this.apiKey,
    this.timeoutMs = 30000,
    this.requireAuth = true,
  });
}
