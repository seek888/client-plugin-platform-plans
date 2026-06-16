import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rss_reader/core/network/network_info_service.dart';

/// 网络信息服务实现
/// 使用 connectivity_plus 监听网络状态变化
class NetworkInfoServiceImpl implements NetworkInfoService {
  final Connectivity _connectivity;
  StreamController<NetworkStatus>? _statusController;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  NetworkInfoServiceImpl({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity() {
    _init();
  }

  void _init() {
    _statusController = StreamController<NetworkStatus>.broadcast();
    _subscription = _connectivity.onConnectivityChanged.listen(
      _handleConnectivityChange,
    );
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    final status = _mapResultsToStatus(results);
    _statusController?.add(status);
  }

  NetworkStatus _mapResultsToStatus(List<ConnectivityResult> results) {
    // 离线模式已禁用 - 始终返回已连接状态
    // 这样即使在内网环境（无公网互联网）也能正常使用所有功能
    return NetworkStatus.connected;
  }

  @override
  Future<NetworkStatus> get currentStatus async {
    final results = await _connectivity.checkConnectivity();
    return _mapResultsToStatus(results);
  }

  @override
  Future<bool> get isConnected async {
    final status = await currentStatus;
    return status == NetworkStatus.connected;
  }

  @override
  Stream<NetworkStatus> get onStatusChange =>
      _statusController?.stream ?? const Stream.empty();

  @override
  Future<List<ConnectivityResult>> get connectionTypes =>
      _connectivity.checkConnectivity();

  @override
  void dispose() {
    _subscription?.cancel();
    _statusController?.close();
    _subscription = null;
    _statusController = null;
  }
}
