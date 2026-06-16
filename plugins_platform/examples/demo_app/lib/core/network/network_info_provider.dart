import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/core/network/network_info_service.dart';
import 'package:rss_reader/core/network/network_info_service_impl.dart';

part 'network_info_provider.g.dart';

/// 网络信息服务 Provider
@Riverpod(keepAlive: true)
NetworkInfoService networkInfoService(Ref ref) {
  final service = NetworkInfoServiceImpl();
  ref.onDispose(() => service.dispose());
  return service;
}

/// 网络状态 Provider
/// 监听网络状态变化并更新状态
@riverpod
class NetworkStatusNotifier extends _$NetworkStatusNotifier {
  @override
  NetworkStatus build() {
    final service = ref.watch(networkInfoServiceProvider);

    // 监听网络状态变化
    final subscription = service.onStatusChange.listen((status) {
      state = status;
    });

    // 初始化时检查当前状态
    _checkInitialStatus();

    ref.onDispose(() => subscription.cancel());

    // 默认假设已连接，等待实际检查结果
    return NetworkStatus.connected;
  }

  Future<void> _checkInitialStatus() async {
    final service = ref.read(networkInfoServiceProvider);
    final status = await service.currentStatus;
    state = status;
  }

  /// 手动刷新网络状态
  Future<void> refresh() async {
    final service = ref.read(networkInfoServiceProvider);
    state = await service.currentStatus;
  }
}

/// 是否离线的便捷 Provider
@riverpod
bool isOffline(Ref ref) {
  final status = ref.watch(networkStatusNotifierProvider);
  return status == NetworkStatus.disconnected;
}

/// 是否在线的便捷 Provider
@riverpod
bool isOnline(Ref ref) {
  final status = ref.watch(networkStatusNotifierProvider);
  return status == NetworkStatus.connected;
}
