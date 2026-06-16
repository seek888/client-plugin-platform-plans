import 'package:connectivity_plus/connectivity_plus.dart';

/// 网络状态枚举
enum NetworkStatus {
  /// 已连接（WiFi、移动数据或以太网）
  connected,

  /// 未连接
  disconnected,
}

/// 网络信息服务接口
/// 负责监听和检测网络状态变化
abstract class NetworkInfoService {
  /// 获取当前网络状态
  Future<NetworkStatus> get currentStatus;

  /// 检查当前是否有网络连接
  Future<bool> get isConnected;

  /// 网络状态变化流
  Stream<NetworkStatus> get onStatusChange;

  /// 获取当前连接类型列表
  Future<List<ConnectivityResult>> get connectionTypes;

  /// 释放资源
  void dispose();
}
