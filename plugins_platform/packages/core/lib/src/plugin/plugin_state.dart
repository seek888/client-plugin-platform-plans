import 'plugin_manifest.dart';

/// 插件状态
enum PluginState {
  /// 已安装
  installed,

  /// 已激活
  activated,

  /// 运行中
  running,

  /// 空闲
  idle,

  /// 已停用
  deactivated,

  /// 已卸载
  uninstalled,

  /// 错误状态
  error,
}

/// 插件信息
///
/// 包含 Manifest 和运行时状态
class PluginInfo {
  final PluginManifest manifest;
  final PluginState state;
  final String? runtimeId;
  final DateTime? installedAt;
  final DateTime? activatedAt;
  final String? errorMessage;

  const PluginInfo({
    required this.manifest,
    required this.state,
    this.runtimeId,
    this.installedAt,
    this.activatedAt,
    this.errorMessage,
  });

  /// 是否已激活
  bool get isActivated =>
      state == PluginState.activated ||
      state == PluginState.running ||
      state == PluginState.idle;

  /// 是否有错误
  bool get hasError => state == PluginState.error;

  /// 创建副本并修改指定字段
  PluginInfo copyWith({
    PluginManifest? manifest,
    PluginState? state,
    String? runtimeId,
    DateTime? installedAt,
    DateTime? activatedAt,
    String? errorMessage,
  }) {
    return PluginInfo(
      manifest: manifest ?? this.manifest,
      state: state ?? this.state,
      runtimeId: runtimeId ?? this.runtimeId,
      installedAt: installedAt ?? this.installedAt,
      activatedAt: activatedAt ?? this.activatedAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// 插件错误
class PluginError implements Exception {
  final String message;
  final String? pluginId;
  final dynamic cause;

  PluginError(this.message, {this.pluginId, this.cause});

  /// 插件未找到错误
  factory PluginError.notFound(String pluginId) {
    return PluginError(
      'Plugin not found: $pluginId',
      pluginId: pluginId,
    );
  }

  /// 插件已存在错误
  factory PluginError.alreadyExists(String pluginId) {
    return PluginError(
      'Plugin already exists: $pluginId',
      pluginId: pluginId,
    );
  }

  /// 插件未激活错误
  factory PluginError.notActivated(String pluginId) {
    return PluginError(
      'Plugin not activated: $pluginId',
      pluginId: pluginId,
    );
  }

  /// 插件版本不兼容错误
  factory PluginError.incompatibleVersion(
    String pluginId,
    String pluginVersion,
    String hostVersion,
  ) {
    return PluginError(
      'Plugin $pluginId (v$pluginVersion) is not compatible with host v$hostVersion',
      pluginId: pluginId,
    );
  }

  /// 插件签名校验失败错误
  factory PluginError.signatureVerificationFailed(String pluginId) {
    return PluginError(
      'Plugin signature verification failed: $pluginId',
      pluginId: pluginId,
    );
  }

  @override
  String toString() =>
      'PluginError${pluginId != null ? ' [$pluginId]' : ''}: $message${cause != null ? ' ($cause)' : ''}';
}
