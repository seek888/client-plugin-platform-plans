import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import 'package:host_bridge/host_bridge.dart';
import 'package:plugins_quickjs_engine/plugins_quickjs_engine.dart';
import '../plugin_manager.dart';

/// JS 引擎 Provider
final jsEngineProvider = Provider<JSEngine>((ref) {
  final engine = QuickJSEngine();

  // 确保在 Provider 销毁时清理资源
  ref.onDispose(() {
    engine.dispose();
  });

  return engine;
});

/// 插件列表 Provider
final pluginListProvider = StateProvider<List<PluginInfo>>((ref) => []);

/// 活跃的 Plugin Provider
final activePluginProvider = StateProvider<Map<String, JSRuntime>>((ref) => {});

/// Host Bridge Provider
///
/// 需要在使用时提供具体的 HostBridge 实现
final hostBridgeProvider = Provider<HostBridge>((ref) {
  throw UnimplementedError(
    'HostBridge must be provided by the host app',
  );
});

/// Plugin Manager Provider
final pluginManagerProvider = Provider<PluginManager>((ref) {
  final engine = ref.watch(jsEngineProvider);
  final bridge = ref.watch(hostBridgeProvider);

  final manager = PluginManager(
    engine: engine,
    bridge: bridge,
  );

  // 确保在 Provider 销毁时清理资源
  ref.onDispose(() {
    // 清理所有活跃的插件
    for (final plugin in manager.getActivatedPlugins()) {
      manager.deactivate(plugin.manifest.id);
    }
  });

  return manager;
});

/// 插件状态 Provider
///
/// 监听单个插件的状态变化
final pluginStateProvider = Provider.family<PluginState, String>(
  (ref, pluginId) {
    final manager = ref.watch(pluginManagerProvider);
    final info = manager.getPluginInfo(pluginId);
    return info?.state ?? PluginState.uninstalled;
  },
);

/// 插件 Runtime Provider
///
/// 获取指定插件的 Runtime
final pluginRuntimeProvider = Provider.family<JSRuntime?, String>(
  (ref, pluginId) {
    final manager = ref.watch(pluginManagerProvider);
    return manager.getRuntime(pluginId);
  },
);
