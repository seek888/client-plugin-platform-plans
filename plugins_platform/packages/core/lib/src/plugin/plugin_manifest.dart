import 'package:freezed_annotation/freezed_annotation.dart';

part 'plugin_manifest.freezed.dart';
part 'plugin_manifest.g.dart';

/// 插件 Manifest 数据模型
///
/// 描述了插件的元数据、配置和权限声明
@freezed
class PluginManifest with _$PluginManifest {
  const factory PluginManifest({
    /// 插件唯一标识符（反向域名格式）
    required String id,

    /// 展示名称
    required String name,

    /// 描述
    String? description,

    /// 版本号（语义化版本）
    required String version,

    /// 发布者
    required String publisher,

    /// 插件类型
    required PluginType type,

    /// 支持的平台列表
    required List<String> platforms,

    /// 最低宿主版本要求
    required String minHostVersion,

    /// JS 引擎配置（JS 插件必需）
    EngineConfig? engine,

    /// 激活事件列表（用于懒加载）
    @Default([]) List<String> activationEvents,

    /// 权限声明列表
    @Default([]) List<String> permissions,

    /// 能力配置列表
    @Default([]) List<CapabilityConfig> capabilities,

    /// STAC 配置（JS 插件必需）
    STACConfig? stac,

    /// 性能预算
    PerformanceBudget? performanceBudget,

    /// 更新策略
    UpdatePolicy? updatePolicy,
  }) = _PluginManifest;

  factory PluginManifest.fromJson(Map<String, dynamic> json) =>
      _$PluginManifestFromJson(json);

  const PluginManifest._();
}

/// 插件类型
enum PluginType {
  /// JS 插件（使用 QuickJS 运行时）
  @JsonValue('js')
  js,

  /// 内置 Flutter 模块（编译期内置）
  @JsonValue('builtin')
  builtin,

  /// WebView 插件（白名单 Web 应用）
  @JsonValue('webview')
  webview,

  /// 能力编排型插件（纯 Schema，无 JS）
  @JsonValue('capability_composition')
  capabilityComposition,

  /// 远端插件服务（逻辑在服务端）
  @JsonValue('remote_action')
  remoteAction,
}

/// JS 引擎配置
@freezed
class EngineConfig with _$EngineConfig {
  const factory EngineConfig({
    /// 运行时类型（quickjs / v8）
    required String runtime,

    /// JS Bundle URL
    required String bundle,

    /// Bundle SHA-256 签名
    required String bundleHash,

    /// Bundle 大小（字节）
    int? bundleSize,

    /// 入口函数名
    @Default('onActivate') String entryFunction,

    /// 内存限制（MB）
    @Default(16) int memoryLimitMb,

    /// 执行超时（毫秒）
    @Default(5000) int executionTimeoutMs,

    /// 是否允许后台常驻
    @Default(false) bool background,
  }) = _EngineConfig;

  factory EngineConfig.fromJson(Map<String, dynamic> json) =>
      _$EngineConfigFromJson(json);
}

/// STAC 配置
@freezed
class STACConfig with _$STACConfig {
  const factory STACConfig({
    /// Schema 版本
    required String schemaVersion,

    /// 使用的组件列表
    @Default([]) List<String> components,

    /// 自定义组件列表
    @Default([]) List<String> customComponents,
  }) = _STACConfig;

  factory STACConfig.fromJson(Map<String, dynamic> json) =>
      _$STACConfigFromJson(json);
}

/// 能力配置
@freezed
class CapabilityConfig with _$CapabilityConfig {
  const factory CapabilityConfig({
    /// 能力 ID
    required String id,

    /// 能力类型（data / action）
    required String type,

    /// 所需权限
    @Default([]) List<String> permissions,
  }) = _CapabilityConfig;

  factory CapabilityConfig.fromJson(Map<String, dynamic> json) =>
      _$CapabilityConfigFromJson(json);
}

/// 性能预算
@freezed
class PerformanceBudget with _$PerformanceBudget {
  const factory PerformanceBudget({
    /// 启动时间预算（毫秒）
    @Default(1500) int startupMs,

    /// 首屏渲染时间预算（毫秒）
    @Default(3000) int firstScreenMs,

    /// 最大内存占用（MB）
    @Default(16) int maxMemoryMb,

    /// 最大 CPU 占用百分比
    @Default(15) int maxCpuPercent,
  }) = _PerformanceBudget;

  factory PerformanceBudget.fromJson(Map<String, dynamic> json) =>
      _$PerformanceBudgetFromJson(json);
}

/// 更新策略
@freezed
class UpdatePolicy with _$UpdatePolicy {
  const factory UpdatePolicy({
    /// 更新渠道（stable / beta / canary）
    @Default('stable') String channel,

    /// 是否允许自动更新
    @Default(true) bool allowAutoUpdate,

    /// 是否允许回滚
    @Default(true) bool allowRollback,

    /// 是否允许远程配置
    @Default(true) bool allowRemoteConfig,

    /// 是否允许远程 Schema
    @Default(true) bool allowRemoteSchema,

    /// 是否允许远程代码
    @Default(true) bool allowRemoteCode,

    /// 是否需要签名
    @Default(true) bool signatureRequired,
  }) = _UpdatePolicy;

  factory UpdatePolicy.fromJson(Map<String, dynamic> json) =>
      _$UpdatePolicyFromJson(json);
}
