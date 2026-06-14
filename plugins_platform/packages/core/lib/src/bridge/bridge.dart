import '../engine/js_engine.dart';

/// 能力定义
///
/// 描述了一个宿主能力的元数据和处理器
class Capability {
  /// 能力唯一标识符
  final String id;

  /// 输入参数 Schema (JSON Schema)
  final String? inputSchema;

  /// 输出结果 Schema (JSON Schema)
  final String? outputSchema;

  /// 所需权限列表
  final List<String> requiredPermissions;

  /// 最低宿主版本要求
  final String minHostVersion;

  /// 支持的平台列表，'all' 表示支持所有平台
  final List<String> platforms;

  /// 能力处理器
  final HostHandler handler;

  const Capability({
    required this.id,
    this.inputSchema,
    this.outputSchema,
    this.requiredPermissions = const [],
    this.minHostVersion = '1.0.0',
    this.platforms = const ['all'],
    required this.handler,
  });

  /// 检查是否支持指定平台
  bool supportsPlatform(String platform) {
    return platforms.contains('all') || platforms.contains(platform);
  }
}

/// 能力注册表
///
/// 管理所有已注册的宿主能力
abstract class CapabilityRegistry {
  /// 注册能力
  void register(Capability capability);

  /// 注销能力
  void unregister(String capabilityId);

  /// 获取能力
  Capability? get(String capabilityId);

  /// 检查能力是否存在
  bool has(String capabilityId);

  /// 获取所有能力
  List<Capability> getAll();

  /// 清空所有能力
  void clear();
}

/// 宿主桥接错误
class HostBridgeError implements Exception {
  final String message;
  final String? capabilityId;
  final dynamic cause;

  HostBridgeError(this.message, {this.capabilityId, this.cause});

  /// 创建方法未找到错误
  factory HostBridgeError.methodNotFound(String method) {
    return HostBridgeError(
      'Method not found: $method',
      capabilityId: method,
    );
  }

  /// 创建权限拒绝错误
  factory HostBridgeError.permissionDenied(
    String method,
    List<String> requiredPermissions,
  ) {
    return HostBridgeError(
      'Permission denied: $method requires ${requiredPermissions.join(', ')}',
      capabilityId: method,
    );
  }

  /// 创建平台不支持错误
  factory HostBridgeError.platformNotSupported(String method, String platform) {
    return HostBridgeError(
      'Method $method is not supported on platform $platform',
      capabilityId: method,
    );
  }

  @override
  String toString() =>
      'HostBridgeError${capabilityId != null ? ' [$capabilityId]' : ''}: $message${cause != null ? ' ($cause)' : ''}';
}

/// 权限检查器
///
/// 检查插件是否具有执行某个能力的权限
abstract class PermissionChecker {
  /// 检查权限
  ///
  /// [pluginPermissions] - 插件拥有的权限列表
  /// [requiredPermissions] - 能力所需的权限列表
  /// 返回是否具有权限
  bool check({
    required List<String> pluginPermissions,
    required List<String> requiredPermissions,
  });
}
