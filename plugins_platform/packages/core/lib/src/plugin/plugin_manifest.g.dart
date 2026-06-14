// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PluginManifestImpl _$$PluginManifestImplFromJson(Map<String, dynamic> json) =>
    _$PluginManifestImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      version: json['version'] as String,
      publisher: json['publisher'] as String,
      type: $enumDecode(_$PluginTypeEnumMap, json['type']),
      platforms:
          (json['platforms'] as List<dynamic>).map((e) => e as String).toList(),
      minHostVersion: json['minHostVersion'] as String,
      engine: json['engine'] == null
          ? null
          : EngineConfig.fromJson(json['engine'] as Map<String, dynamic>),
      activationEvents: (json['activationEvents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      capabilities: (json['capabilities'] as List<dynamic>?)
              ?.map((e) => CapabilityConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      stac: json['stac'] == null
          ? null
          : STACConfig.fromJson(json['stac'] as Map<String, dynamic>),
      performanceBudget: json['performanceBudget'] == null
          ? null
          : PerformanceBudget.fromJson(
              json['performanceBudget'] as Map<String, dynamic>),
      updatePolicy: json['updatePolicy'] == null
          ? null
          : UpdatePolicy.fromJson(json['updatePolicy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PluginManifestImplToJson(
        _$PluginManifestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'version': instance.version,
      'publisher': instance.publisher,
      'type': _$PluginTypeEnumMap[instance.type]!,
      'platforms': instance.platforms,
      'minHostVersion': instance.minHostVersion,
      'engine': instance.engine,
      'activationEvents': instance.activationEvents,
      'permissions': instance.permissions,
      'capabilities': instance.capabilities,
      'stac': instance.stac,
      'performanceBudget': instance.performanceBudget,
      'updatePolicy': instance.updatePolicy,
    };

const _$PluginTypeEnumMap = {
  PluginType.js: 'js',
  PluginType.builtin: 'builtin',
  PluginType.webview: 'webview',
  PluginType.capabilityComposition: 'capability_composition',
  PluginType.remoteAction: 'remote_action',
};

_$EngineConfigImpl _$$EngineConfigImplFromJson(Map<String, dynamic> json) =>
    _$EngineConfigImpl(
      runtime: json['runtime'] as String,
      bundle: json['bundle'] as String,
      bundleHash: json['bundleHash'] as String,
      bundleSize: (json['bundleSize'] as num?)?.toInt(),
      entryFunction: json['entryFunction'] as String? ?? 'onActivate',
      memoryLimitMb: (json['memoryLimitMb'] as num?)?.toInt() ?? 16,
      executionTimeoutMs: (json['executionTimeoutMs'] as num?)?.toInt() ?? 5000,
      background: json['background'] as bool? ?? false,
    );

Map<String, dynamic> _$$EngineConfigImplToJson(_$EngineConfigImpl instance) =>
    <String, dynamic>{
      'runtime': instance.runtime,
      'bundle': instance.bundle,
      'bundleHash': instance.bundleHash,
      'bundleSize': instance.bundleSize,
      'entryFunction': instance.entryFunction,
      'memoryLimitMb': instance.memoryLimitMb,
      'executionTimeoutMs': instance.executionTimeoutMs,
      'background': instance.background,
    };

_$STACConfigImpl _$$STACConfigImplFromJson(Map<String, dynamic> json) =>
    _$STACConfigImpl(
      schemaVersion: json['schemaVersion'] as String,
      components: (json['components'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      customComponents: (json['customComponents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$STACConfigImplToJson(_$STACConfigImpl instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'components': instance.components,
      'customComponents': instance.customComponents,
    };

_$CapabilityConfigImpl _$$CapabilityConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$CapabilityConfigImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CapabilityConfigImplToJson(
        _$CapabilityConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'permissions': instance.permissions,
    };

_$PerformanceBudgetImpl _$$PerformanceBudgetImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceBudgetImpl(
      startupMs: (json['startupMs'] as num?)?.toInt() ?? 1500,
      firstScreenMs: (json['firstScreenMs'] as num?)?.toInt() ?? 3000,
      maxMemoryMb: (json['maxMemoryMb'] as num?)?.toInt() ?? 16,
      maxCpuPercent: (json['maxCpuPercent'] as num?)?.toInt() ?? 15,
    );

Map<String, dynamic> _$$PerformanceBudgetImplToJson(
        _$PerformanceBudgetImpl instance) =>
    <String, dynamic>{
      'startupMs': instance.startupMs,
      'firstScreenMs': instance.firstScreenMs,
      'maxMemoryMb': instance.maxMemoryMb,
      'maxCpuPercent': instance.maxCpuPercent,
    };

_$UpdatePolicyImpl _$$UpdatePolicyImplFromJson(Map<String, dynamic> json) =>
    _$UpdatePolicyImpl(
      channel: json['channel'] as String? ?? 'stable',
      allowAutoUpdate: json['allowAutoUpdate'] as bool? ?? true,
      allowRollback: json['allowRollback'] as bool? ?? true,
      allowRemoteConfig: json['allowRemoteConfig'] as bool? ?? true,
      allowRemoteSchema: json['allowRemoteSchema'] as bool? ?? true,
      allowRemoteCode: json['allowRemoteCode'] as bool? ?? true,
      signatureRequired: json['signatureRequired'] as bool? ?? true,
    );

Map<String, dynamic> _$$UpdatePolicyImplToJson(_$UpdatePolicyImpl instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'allowAutoUpdate': instance.allowAutoUpdate,
      'allowRollback': instance.allowRollback,
      'allowRemoteConfig': instance.allowRemoteConfig,
      'allowRemoteSchema': instance.allowRemoteSchema,
      'allowRemoteCode': instance.allowRemoteCode,
      'signatureRequired': instance.signatureRequired,
    };
