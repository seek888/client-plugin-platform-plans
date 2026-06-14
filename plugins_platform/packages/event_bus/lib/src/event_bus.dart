import 'dart:async';
import 'package:core/core.dart';
import 'package:plugin_manager/plugin_manager.dart';
import 'package:riverpod/riverpod.dart';

/// 事件类型定义
class SystemEvents {
  static const String onAppStart = 'onAppStart';
  static const String onAppEnterForeground = 'onAppEnterForeground';
  static const String onAppEnterBackground = 'onAppEnterBackground';
  static const String onUserLogin = 'onUserLogin';
  static const String onUserLogout = 'onUserLogout';
  static const String onNetworkChange = 'onNetworkChange';
  static const String onPushMessage = 'onPushMessage';
  static const String onLocaleChange = 'onLocaleChange';
  static const String onThemeChange = 'onThemeChange';
}

/// 事件数据
class STACEvent {
  /// 事件名
  final String name;

  /// 事件数据
  final Map<String, dynamic> payload;

  /// 时间戳
  final DateTime timestamp;

  STACEvent({
    required this.name,
    required this.payload,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// 事件订阅
class STACEventSubscription {
  final String eventId;
  final String eventName;
  final Function(STACEvent) callback;
  final StreamSubscription<STACEvent>? subscription;

  STACEventSubscription({
    required this.eventId,
    required this.eventName,
    required this.callback,
    this.subscription,
  });

  void cancel() {
    subscription?.cancel();
  }
}

/// 事件总线
///
/// 负责系统事件和业务事件的分发
class EventBus {
  final StreamController<STACEvent> _controller = StreamController<STACEvent>.broadcast();
  final Map<String, List<STACEventSubscription>> _subscriptions = {};

  /// 事件流
  Stream<STACEvent> get eventStream => _controller.stream;

  /// 发布事件
  void emit(String eventName, Map<String, dynamic> payload) {
    final event = STACEvent(name: eventName, payload: payload);
    _controller.add(event);
  }

  /// 订阅事件
  STACEventSubscription on(
    String eventName,
    Function(STACEvent) callback, {
    String? eventId,
  }) {
    final id = eventId ?? 'sub_${DateTime.now().millisecondsSinceEpoch}';

    final subscription = _controller.stream
        .where((event) => event.name == eventName)
        .listen(callback);

    final eventSubscription = STACEventSubscription(
      eventId: id,
      eventName: eventName,
      callback: callback,
      subscription: subscription,
    );

    _subscriptions.putIfAbsent(eventName, () => []).add(eventSubscription);

    return eventSubscription;
  }

  /// 取消订阅
  void off(STACEventSubscription subscription) {
    subscription.cancel();
    _subscriptions[subscription.eventName]?.remove(subscription);
  }

  /// 取消某个事件的所有订阅
  void offAll(String eventName) {
    final subs = _subscriptions[eventName];
    if (subs != null) {
      for (final sub in subs) {
        sub.cancel();
      }
      _subscriptions[eventName] = [];
    }
  }

  /// 销毁事件总线
  void dispose() {
    _controller.close();
    _subscriptions.clear();
  }
}

/// 事件总线 Provider
final eventBusProvider = Provider<EventBus>((ref) {
  final bus = EventBus();

  ref.onDispose(() {
    bus.dispose();
  });

  return bus;
});

/// 懒加载激活管理器
///
/// 根据 activationEvents 懒激活插件
class LazyActivationManager {
  final PluginManager _pluginManager;
  final EventBus _eventBus;

  /// 插件激活事件映射
  final Map<String, List<String>> _activationEvents = {};

  LazyActivationManager(this._pluginManager, this._eventBus);

  /// 注册插件的激活事件
  void registerPlugin(PluginManifest manifest) {
    for (final event in manifest.activationEvents) {
      _activationEvents.putIfAbsent(event, () => []).add(manifest.id);
    }
  }

  /// 注销插件
  void unregisterPlugin(String pluginId) {
    for (final events in _activationEvents.values) {
      events.remove(pluginId);
    }
  }

  /// 处理事件，触发懒激活
  Future<void> handleEvent(String eventName, Map<String, dynamic> payload) async {
    final pluginIds = _activationEvents[eventName];
    if (pluginIds == null || pluginIds.isEmpty) return;

    for (final pluginId in pluginIds) {
      // 检查插件是否已安装
      if (!_pluginManager.isInstalled(pluginId)) continue;

      // 检查插件是否已激活
      if (_pluginManager.isActivated(pluginId)) continue;

      // 懒激活插件
      try {
        await _pluginManager.activate(pluginId);

        // 分发事件到新激活的插件
        final runtime = _pluginManager.getRuntime(pluginId);
        if (runtime != null) {
          await runtime.dispatchEvent(eventName, payload);
        }
      } catch (e) {
        // 激活失败，忽略
        // TODO: 添加错误日志
      }
    }
  }

  /// 启动懒加载管理
  void start() {
    // 订阅系统事件
    final subscription = _eventBus.on('*', (event) async {
      await handleEvent(event.name, event.payload);
    });
  }
}

/// 懒加载管理器 Provider
final lazyActivationProvider = Provider<LazyActivationManager>((ref) {
  final pluginManager = ref.watch(pluginManagerProvider);
  final eventBus = ref.watch(eventBusProvider);

  final manager = LazyActivationManager(pluginManager, eventBus);

  ref.onDispose(() {
    // 清理
  });

  return manager;
});
