// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plugin_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PluginManifest _$PluginManifestFromJson(Map<String, dynamic> json) {
  return _PluginManifest.fromJson(json);
}

/// @nodoc
mixin _$PluginManifest {
  /// 插件唯一标识符（反向域名格式）
  String get id => throw _privateConstructorUsedError;

  /// 展示名称
  String get name => throw _privateConstructorUsedError;

  /// 描述
  String? get description => throw _privateConstructorUsedError;

  /// 版本号（语义化版本）
  String get version => throw _privateConstructorUsedError;

  /// 发布者
  String get publisher => throw _privateConstructorUsedError;

  /// 插件类型
  PluginType get type => throw _privateConstructorUsedError;

  /// 支持的平台列表
  List<String> get platforms => throw _privateConstructorUsedError;

  /// 最低宿主版本要求
  String get minHostVersion => throw _privateConstructorUsedError;

  /// JS 引擎配置（JS 插件必需）
  EngineConfig? get engine => throw _privateConstructorUsedError;

  /// 激活事件列表（用于懒加载）
  List<String> get activationEvents => throw _privateConstructorUsedError;

  /// 权限声明列表
  List<String> get permissions => throw _privateConstructorUsedError;

  /// 能力配置列表
  List<CapabilityConfig> get capabilities => throw _privateConstructorUsedError;

  /// STAC 配置（JS 插件必需）
  STACConfig? get stac => throw _privateConstructorUsedError;

  /// 性能预算
  PerformanceBudget? get performanceBudget =>
      throw _privateConstructorUsedError;

  /// 更新策略
  UpdatePolicy? get updatePolicy => throw _privateConstructorUsedError;

  /// Serializes this PluginManifest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PluginManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PluginManifestCopyWith<PluginManifest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PluginManifestCopyWith<$Res> {
  factory $PluginManifestCopyWith(
          PluginManifest value, $Res Function(PluginManifest) then) =
      _$PluginManifestCopyWithImpl<$Res, PluginManifest>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String version,
      String publisher,
      PluginType type,
      List<String> platforms,
      String minHostVersion,
      EngineConfig? engine,
      List<String> activationEvents,
      List<String> permissions,
      List<CapabilityConfig> capabilities,
      STACConfig? stac,
      PerformanceBudget? performanceBudget,
      UpdatePolicy? updatePolicy});

  $EngineConfigCopyWith<$Res>? get engine;
  $STACConfigCopyWith<$Res>? get stac;
  $PerformanceBudgetCopyWith<$Res>? get performanceBudget;
  $UpdatePolicyCopyWith<$Res>? get updatePolicy;
}

/// @nodoc
class _$PluginManifestCopyWithImpl<$Res, $Val extends PluginManifest>
    implements $PluginManifestCopyWith<$Res> {
  _$PluginManifestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PluginManifest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? version = null,
    Object? publisher = null,
    Object? type = null,
    Object? platforms = null,
    Object? minHostVersion = null,
    Object? engine = freezed,
    Object? activationEvents = null,
    Object? permissions = null,
    Object? capabilities = null,
    Object? stac = freezed,
    Object? performanceBudget = freezed,
    Object? updatePolicy = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      publisher: null == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PluginType,
      platforms: null == platforms
          ? _value.platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      minHostVersion: null == minHostVersion
          ? _value.minHostVersion
          : minHostVersion // ignore: cast_nullable_to_non_nullable
              as String,
      engine: freezed == engine
          ? _value.engine
          : engine // ignore: cast_nullable_to_non_nullable
              as EngineConfig?,
      activationEvents: null == activationEvents
          ? _value.activationEvents
          : activationEvents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      capabilities: null == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as List<CapabilityConfig>,
      stac: freezed == stac
          ? _value.stac
          : stac // ignore: cast_nullable_to_non_nullable
              as STACConfig?,
      performanceBudget: freezed == performanceBudget
          ? _value.performanceBudget
          : performanceBudget // ignore: cast_nullable_to_non_nullable
              as PerformanceBudget?,
      updatePolicy: freezed == updatePolicy
          ? _value.updatePolicy
          : updatePolicy // ignore: cast_nullable_to_non_nullable
              as UpdatePolicy?,
    ) as $Val);
  }

  /// Create a copy of PluginManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EngineConfigCopyWith<$Res>? get engine {
    if (_value.engine == null) {
      return null;
    }

    return $EngineConfigCopyWith<$Res>(_value.engine!, (value) {
      return _then(_value.copyWith(engine: value) as $Val);
    });
  }

  /// Create a copy of PluginManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $STACConfigCopyWith<$Res>? get stac {
    if (_value.stac == null) {
      return null;
    }

    return $STACConfigCopyWith<$Res>(_value.stac!, (value) {
      return _then(_value.copyWith(stac: value) as $Val);
    });
  }

  /// Create a copy of PluginManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PerformanceBudgetCopyWith<$Res>? get performanceBudget {
    if (_value.performanceBudget == null) {
      return null;
    }

    return $PerformanceBudgetCopyWith<$Res>(_value.performanceBudget!, (value) {
      return _then(_value.copyWith(performanceBudget: value) as $Val);
    });
  }

  /// Create a copy of PluginManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdatePolicyCopyWith<$Res>? get updatePolicy {
    if (_value.updatePolicy == null) {
      return null;
    }

    return $UpdatePolicyCopyWith<$Res>(_value.updatePolicy!, (value) {
      return _then(_value.copyWith(updatePolicy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PluginManifestImplCopyWith<$Res>
    implements $PluginManifestCopyWith<$Res> {
  factory _$$PluginManifestImplCopyWith(_$PluginManifestImpl value,
          $Res Function(_$PluginManifestImpl) then) =
      __$$PluginManifestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String version,
      String publisher,
      PluginType type,
      List<String> platforms,
      String minHostVersion,
      EngineConfig? engine,
      List<String> activationEvents,
      List<String> permissions,
      List<CapabilityConfig> capabilities,
      STACConfig? stac,
      PerformanceBudget? performanceBudget,
      UpdatePolicy? updatePolicy});

  @override
  $EngineConfigCopyWith<$Res>? get engine;
  @override
  $STACConfigCopyWith<$Res>? get stac;
  @override
  $PerformanceBudgetCopyWith<$Res>? get performanceBudget;
  @override
  $UpdatePolicyCopyWith<$Res>? get updatePolicy;
}

/// @nodoc
class __$$PluginManifestImplCopyWithImpl<$Res>
    extends _$PluginManifestCopyWithImpl<$Res, _$PluginManifestImpl>
    implements _$$PluginManifestImplCopyWith<$Res> {
  __$$PluginManifestImplCopyWithImpl(
      _$PluginManifestImpl _value, $Res Function(_$PluginManifestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PluginManifest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? version = null,
    Object? publisher = null,
    Object? type = null,
    Object? platforms = null,
    Object? minHostVersion = null,
    Object? engine = freezed,
    Object? activationEvents = null,
    Object? permissions = null,
    Object? capabilities = null,
    Object? stac = freezed,
    Object? performanceBudget = freezed,
    Object? updatePolicy = freezed,
  }) {
    return _then(_$PluginManifestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      publisher: null == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PluginType,
      platforms: null == platforms
          ? _value._platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      minHostVersion: null == minHostVersion
          ? _value.minHostVersion
          : minHostVersion // ignore: cast_nullable_to_non_nullable
              as String,
      engine: freezed == engine
          ? _value.engine
          : engine // ignore: cast_nullable_to_non_nullable
              as EngineConfig?,
      activationEvents: null == activationEvents
          ? _value._activationEvents
          : activationEvents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      capabilities: null == capabilities
          ? _value._capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as List<CapabilityConfig>,
      stac: freezed == stac
          ? _value.stac
          : stac // ignore: cast_nullable_to_non_nullable
              as STACConfig?,
      performanceBudget: freezed == performanceBudget
          ? _value.performanceBudget
          : performanceBudget // ignore: cast_nullable_to_non_nullable
              as PerformanceBudget?,
      updatePolicy: freezed == updatePolicy
          ? _value.updatePolicy
          : updatePolicy // ignore: cast_nullable_to_non_nullable
              as UpdatePolicy?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PluginManifestImpl extends _PluginManifest {
  const _$PluginManifestImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.version,
      required this.publisher,
      required this.type,
      required final List<String> platforms,
      required this.minHostVersion,
      this.engine,
      final List<String> activationEvents = const [],
      final List<String> permissions = const [],
      final List<CapabilityConfig> capabilities = const [],
      this.stac,
      this.performanceBudget,
      this.updatePolicy})
      : _platforms = platforms,
        _activationEvents = activationEvents,
        _permissions = permissions,
        _capabilities = capabilities,
        super._();

  factory _$PluginManifestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PluginManifestImplFromJson(json);

  /// 插件唯一标识符（反向域名格式）
  @override
  final String id;

  /// 展示名称
  @override
  final String name;

  /// 描述
  @override
  final String? description;

  /// 版本号（语义化版本）
  @override
  final String version;

  /// 发布者
  @override
  final String publisher;

  /// 插件类型
  @override
  final PluginType type;

  /// 支持的平台列表
  final List<String> _platforms;

  /// 支持的平台列表
  @override
  List<String> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  /// 最低宿主版本要求
  @override
  final String minHostVersion;

  /// JS 引擎配置（JS 插件必需）
  @override
  final EngineConfig? engine;

  /// 激活事件列表（用于懒加载）
  final List<String> _activationEvents;

  /// 激活事件列表（用于懒加载）
  @override
  @JsonKey()
  List<String> get activationEvents {
    if (_activationEvents is EqualUnmodifiableListView)
      return _activationEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activationEvents);
  }

  /// 权限声明列表
  final List<String> _permissions;

  /// 权限声明列表
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  /// 能力配置列表
  final List<CapabilityConfig> _capabilities;

  /// 能力配置列表
  @override
  @JsonKey()
  List<CapabilityConfig> get capabilities {
    if (_capabilities is EqualUnmodifiableListView) return _capabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_capabilities);
  }

  /// STAC 配置（JS 插件必需）
  @override
  final STACConfig? stac;

  /// 性能预算
  @override
  final PerformanceBudget? performanceBudget;

  /// 更新策略
  @override
  final UpdatePolicy? updatePolicy;

  @override
  String toString() {
    return 'PluginManifest(id: $id, name: $name, description: $description, version: $version, publisher: $publisher, type: $type, platforms: $platforms, minHostVersion: $minHostVersion, engine: $engine, activationEvents: $activationEvents, permissions: $permissions, capabilities: $capabilities, stac: $stac, performanceBudget: $performanceBudget, updatePolicy: $updatePolicy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PluginManifestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.publisher, publisher) ||
                other.publisher == publisher) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._platforms, _platforms) &&
            (identical(other.minHostVersion, minHostVersion) ||
                other.minHostVersion == minHostVersion) &&
            (identical(other.engine, engine) || other.engine == engine) &&
            const DeepCollectionEquality()
                .equals(other._activationEvents, _activationEvents) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            const DeepCollectionEquality()
                .equals(other._capabilities, _capabilities) &&
            (identical(other.stac, stac) || other.stac == stac) &&
            (identical(other.performanceBudget, performanceBudget) ||
                other.performanceBudget == performanceBudget) &&
            (identical(other.updatePolicy, updatePolicy) ||
                other.updatePolicy == updatePolicy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      version,
      publisher,
      type,
      const DeepCollectionEquality().hash(_platforms),
      minHostVersion,
      engine,
      const DeepCollectionEquality().hash(_activationEvents),
      const DeepCollectionEquality().hash(_permissions),
      const DeepCollectionEquality().hash(_capabilities),
      stac,
      performanceBudget,
      updatePolicy);

  /// Create a copy of PluginManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PluginManifestImplCopyWith<_$PluginManifestImpl> get copyWith =>
      __$$PluginManifestImplCopyWithImpl<_$PluginManifestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PluginManifestImplToJson(
      this,
    );
  }
}

abstract class _PluginManifest extends PluginManifest {
  const factory _PluginManifest(
      {required final String id,
      required final String name,
      final String? description,
      required final String version,
      required final String publisher,
      required final PluginType type,
      required final List<String> platforms,
      required final String minHostVersion,
      final EngineConfig? engine,
      final List<String> activationEvents,
      final List<String> permissions,
      final List<CapabilityConfig> capabilities,
      final STACConfig? stac,
      final PerformanceBudget? performanceBudget,
      final UpdatePolicy? updatePolicy}) = _$PluginManifestImpl;
  const _PluginManifest._() : super._();

  factory _PluginManifest.fromJson(Map<String, dynamic> json) =
      _$PluginManifestImpl.fromJson;

  /// 插件唯一标识符（反向域名格式）
  @override
  String get id;

  /// 展示名称
  @override
  String get name;

  /// 描述
  @override
  String? get description;

  /// 版本号（语义化版本）
  @override
  String get version;

  /// 发布者
  @override
  String get publisher;

  /// 插件类型
  @override
  PluginType get type;

  /// 支持的平台列表
  @override
  List<String> get platforms;

  /// 最低宿主版本要求
  @override
  String get minHostVersion;

  /// JS 引擎配置（JS 插件必需）
  @override
  EngineConfig? get engine;

  /// 激活事件列表（用于懒加载）
  @override
  List<String> get activationEvents;

  /// 权限声明列表
  @override
  List<String> get permissions;

  /// 能力配置列表
  @override
  List<CapabilityConfig> get capabilities;

  /// STAC 配置（JS 插件必需）
  @override
  STACConfig? get stac;

  /// 性能预算
  @override
  PerformanceBudget? get performanceBudget;

  /// 更新策略
  @override
  UpdatePolicy? get updatePolicy;

  /// Create a copy of PluginManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PluginManifestImplCopyWith<_$PluginManifestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EngineConfig _$EngineConfigFromJson(Map<String, dynamic> json) {
  return _EngineConfig.fromJson(json);
}

/// @nodoc
mixin _$EngineConfig {
  /// 运行时类型（quickjs / v8）
  String get runtime => throw _privateConstructorUsedError;

  /// JS Bundle URL
  String get bundle => throw _privateConstructorUsedError;

  /// Bundle SHA-256 签名
  String get bundleHash => throw _privateConstructorUsedError;

  /// Bundle 大小（字节）
  int? get bundleSize => throw _privateConstructorUsedError;

  /// 入口函数名
  String get entryFunction => throw _privateConstructorUsedError;

  /// 内存限制（MB）
  int get memoryLimitMb => throw _privateConstructorUsedError;

  /// 执行超时（毫秒）
  int get executionTimeoutMs => throw _privateConstructorUsedError;

  /// 是否允许后台常驻
  bool get background => throw _privateConstructorUsedError;

  /// Serializes this EngineConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EngineConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngineConfigCopyWith<EngineConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngineConfigCopyWith<$Res> {
  factory $EngineConfigCopyWith(
          EngineConfig value, $Res Function(EngineConfig) then) =
      _$EngineConfigCopyWithImpl<$Res, EngineConfig>;
  @useResult
  $Res call(
      {String runtime,
      String bundle,
      String bundleHash,
      int? bundleSize,
      String entryFunction,
      int memoryLimitMb,
      int executionTimeoutMs,
      bool background});
}

/// @nodoc
class _$EngineConfigCopyWithImpl<$Res, $Val extends EngineConfig>
    implements $EngineConfigCopyWith<$Res> {
  _$EngineConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EngineConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? runtime = null,
    Object? bundle = null,
    Object? bundleHash = null,
    Object? bundleSize = freezed,
    Object? entryFunction = null,
    Object? memoryLimitMb = null,
    Object? executionTimeoutMs = null,
    Object? background = null,
  }) {
    return _then(_value.copyWith(
      runtime: null == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as String,
      bundle: null == bundle
          ? _value.bundle
          : bundle // ignore: cast_nullable_to_non_nullable
              as String,
      bundleHash: null == bundleHash
          ? _value.bundleHash
          : bundleHash // ignore: cast_nullable_to_non_nullable
              as String,
      bundleSize: freezed == bundleSize
          ? _value.bundleSize
          : bundleSize // ignore: cast_nullable_to_non_nullable
              as int?,
      entryFunction: null == entryFunction
          ? _value.entryFunction
          : entryFunction // ignore: cast_nullable_to_non_nullable
              as String,
      memoryLimitMb: null == memoryLimitMb
          ? _value.memoryLimitMb
          : memoryLimitMb // ignore: cast_nullable_to_non_nullable
              as int,
      executionTimeoutMs: null == executionTimeoutMs
          ? _value.executionTimeoutMs
          : executionTimeoutMs // ignore: cast_nullable_to_non_nullable
              as int,
      background: null == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EngineConfigImplCopyWith<$Res>
    implements $EngineConfigCopyWith<$Res> {
  factory _$$EngineConfigImplCopyWith(
          _$EngineConfigImpl value, $Res Function(_$EngineConfigImpl) then) =
      __$$EngineConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String runtime,
      String bundle,
      String bundleHash,
      int? bundleSize,
      String entryFunction,
      int memoryLimitMb,
      int executionTimeoutMs,
      bool background});
}

/// @nodoc
class __$$EngineConfigImplCopyWithImpl<$Res>
    extends _$EngineConfigCopyWithImpl<$Res, _$EngineConfigImpl>
    implements _$$EngineConfigImplCopyWith<$Res> {
  __$$EngineConfigImplCopyWithImpl(
      _$EngineConfigImpl _value, $Res Function(_$EngineConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of EngineConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? runtime = null,
    Object? bundle = null,
    Object? bundleHash = null,
    Object? bundleSize = freezed,
    Object? entryFunction = null,
    Object? memoryLimitMb = null,
    Object? executionTimeoutMs = null,
    Object? background = null,
  }) {
    return _then(_$EngineConfigImpl(
      runtime: null == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as String,
      bundle: null == bundle
          ? _value.bundle
          : bundle // ignore: cast_nullable_to_non_nullable
              as String,
      bundleHash: null == bundleHash
          ? _value.bundleHash
          : bundleHash // ignore: cast_nullable_to_non_nullable
              as String,
      bundleSize: freezed == bundleSize
          ? _value.bundleSize
          : bundleSize // ignore: cast_nullable_to_non_nullable
              as int?,
      entryFunction: null == entryFunction
          ? _value.entryFunction
          : entryFunction // ignore: cast_nullable_to_non_nullable
              as String,
      memoryLimitMb: null == memoryLimitMb
          ? _value.memoryLimitMb
          : memoryLimitMb // ignore: cast_nullable_to_non_nullable
              as int,
      executionTimeoutMs: null == executionTimeoutMs
          ? _value.executionTimeoutMs
          : executionTimeoutMs // ignore: cast_nullable_to_non_nullable
              as int,
      background: null == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EngineConfigImpl implements _EngineConfig {
  const _$EngineConfigImpl(
      {required this.runtime,
      required this.bundle,
      required this.bundleHash,
      this.bundleSize,
      this.entryFunction = 'onActivate',
      this.memoryLimitMb = 16,
      this.executionTimeoutMs = 5000,
      this.background = false});

  factory _$EngineConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$EngineConfigImplFromJson(json);

  /// 运行时类型（quickjs / v8）
  @override
  final String runtime;

  /// JS Bundle URL
  @override
  final String bundle;

  /// Bundle SHA-256 签名
  @override
  final String bundleHash;

  /// Bundle 大小（字节）
  @override
  final int? bundleSize;

  /// 入口函数名
  @override
  @JsonKey()
  final String entryFunction;

  /// 内存限制（MB）
  @override
  @JsonKey()
  final int memoryLimitMb;

  /// 执行超时（毫秒）
  @override
  @JsonKey()
  final int executionTimeoutMs;

  /// 是否允许后台常驻
  @override
  @JsonKey()
  final bool background;

  @override
  String toString() {
    return 'EngineConfig(runtime: $runtime, bundle: $bundle, bundleHash: $bundleHash, bundleSize: $bundleSize, entryFunction: $entryFunction, memoryLimitMb: $memoryLimitMb, executionTimeoutMs: $executionTimeoutMs, background: $background)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngineConfigImpl &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            (identical(other.bundle, bundle) || other.bundle == bundle) &&
            (identical(other.bundleHash, bundleHash) ||
                other.bundleHash == bundleHash) &&
            (identical(other.bundleSize, bundleSize) ||
                other.bundleSize == bundleSize) &&
            (identical(other.entryFunction, entryFunction) ||
                other.entryFunction == entryFunction) &&
            (identical(other.memoryLimitMb, memoryLimitMb) ||
                other.memoryLimitMb == memoryLimitMb) &&
            (identical(other.executionTimeoutMs, executionTimeoutMs) ||
                other.executionTimeoutMs == executionTimeoutMs) &&
            (identical(other.background, background) ||
                other.background == background));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, runtime, bundle, bundleHash,
      bundleSize, entryFunction, memoryLimitMb, executionTimeoutMs, background);

  /// Create a copy of EngineConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngineConfigImplCopyWith<_$EngineConfigImpl> get copyWith =>
      __$$EngineConfigImplCopyWithImpl<_$EngineConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EngineConfigImplToJson(
      this,
    );
  }
}

abstract class _EngineConfig implements EngineConfig {
  const factory _EngineConfig(
      {required final String runtime,
      required final String bundle,
      required final String bundleHash,
      final int? bundleSize,
      final String entryFunction,
      final int memoryLimitMb,
      final int executionTimeoutMs,
      final bool background}) = _$EngineConfigImpl;

  factory _EngineConfig.fromJson(Map<String, dynamic> json) =
      _$EngineConfigImpl.fromJson;

  /// 运行时类型（quickjs / v8）
  @override
  String get runtime;

  /// JS Bundle URL
  @override
  String get bundle;

  /// Bundle SHA-256 签名
  @override
  String get bundleHash;

  /// Bundle 大小（字节）
  @override
  int? get bundleSize;

  /// 入口函数名
  @override
  String get entryFunction;

  /// 内存限制（MB）
  @override
  int get memoryLimitMb;

  /// 执行超时（毫秒）
  @override
  int get executionTimeoutMs;

  /// 是否允许后台常驻
  @override
  bool get background;

  /// Create a copy of EngineConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngineConfigImplCopyWith<_$EngineConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

STACConfig _$STACConfigFromJson(Map<String, dynamic> json) {
  return _STACConfig.fromJson(json);
}

/// @nodoc
mixin _$STACConfig {
  /// Schema 版本
  String get schemaVersion => throw _privateConstructorUsedError;

  /// 使用的组件列表
  List<String> get components => throw _privateConstructorUsedError;

  /// 自定义组件列表
  List<String> get customComponents => throw _privateConstructorUsedError;

  /// Serializes this STACConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of STACConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $STACConfigCopyWith<STACConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $STACConfigCopyWith<$Res> {
  factory $STACConfigCopyWith(
          STACConfig value, $Res Function(STACConfig) then) =
      _$STACConfigCopyWithImpl<$Res, STACConfig>;
  @useResult
  $Res call(
      {String schemaVersion,
      List<String> components,
      List<String> customComponents});
}

/// @nodoc
class _$STACConfigCopyWithImpl<$Res, $Val extends STACConfig>
    implements $STACConfigCopyWith<$Res> {
  _$STACConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of STACConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemaVersion = null,
    Object? components = null,
    Object? customComponents = null,
  }) {
    return _then(_value.copyWith(
      schemaVersion: null == schemaVersion
          ? _value.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as String,
      components: null == components
          ? _value.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customComponents: null == customComponents
          ? _value.customComponents
          : customComponents // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$STACConfigImplCopyWith<$Res>
    implements $STACConfigCopyWith<$Res> {
  factory _$$STACConfigImplCopyWith(
          _$STACConfigImpl value, $Res Function(_$STACConfigImpl) then) =
      __$$STACConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String schemaVersion,
      List<String> components,
      List<String> customComponents});
}

/// @nodoc
class __$$STACConfigImplCopyWithImpl<$Res>
    extends _$STACConfigCopyWithImpl<$Res, _$STACConfigImpl>
    implements _$$STACConfigImplCopyWith<$Res> {
  __$$STACConfigImplCopyWithImpl(
      _$STACConfigImpl _value, $Res Function(_$STACConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of STACConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemaVersion = null,
    Object? components = null,
    Object? customComponents = null,
  }) {
    return _then(_$STACConfigImpl(
      schemaVersion: null == schemaVersion
          ? _value.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as String,
      components: null == components
          ? _value._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customComponents: null == customComponents
          ? _value._customComponents
          : customComponents // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$STACConfigImpl implements _STACConfig {
  const _$STACConfigImpl(
      {required this.schemaVersion,
      final List<String> components = const [],
      final List<String> customComponents = const []})
      : _components = components,
        _customComponents = customComponents;

  factory _$STACConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$STACConfigImplFromJson(json);

  /// Schema 版本
  @override
  final String schemaVersion;

  /// 使用的组件列表
  final List<String> _components;

  /// 使用的组件列表
  @override
  @JsonKey()
  List<String> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
  }

  /// 自定义组件列表
  final List<String> _customComponents;

  /// 自定义组件列表
  @override
  @JsonKey()
  List<String> get customComponents {
    if (_customComponents is EqualUnmodifiableListView)
      return _customComponents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customComponents);
  }

  @override
  String toString() {
    return 'STACConfig(schemaVersion: $schemaVersion, components: $components, customComponents: $customComponents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$STACConfigImpl &&
            (identical(other.schemaVersion, schemaVersion) ||
                other.schemaVersion == schemaVersion) &&
            const DeepCollectionEquality()
                .equals(other._components, _components) &&
            const DeepCollectionEquality()
                .equals(other._customComponents, _customComponents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      schemaVersion,
      const DeepCollectionEquality().hash(_components),
      const DeepCollectionEquality().hash(_customComponents));

  /// Create a copy of STACConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$STACConfigImplCopyWith<_$STACConfigImpl> get copyWith =>
      __$$STACConfigImplCopyWithImpl<_$STACConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$STACConfigImplToJson(
      this,
    );
  }
}

abstract class _STACConfig implements STACConfig {
  const factory _STACConfig(
      {required final String schemaVersion,
      final List<String> components,
      final List<String> customComponents}) = _$STACConfigImpl;

  factory _STACConfig.fromJson(Map<String, dynamic> json) =
      _$STACConfigImpl.fromJson;

  /// Schema 版本
  @override
  String get schemaVersion;

  /// 使用的组件列表
  @override
  List<String> get components;

  /// 自定义组件列表
  @override
  List<String> get customComponents;

  /// Create a copy of STACConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$STACConfigImplCopyWith<_$STACConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CapabilityConfig _$CapabilityConfigFromJson(Map<String, dynamic> json) {
  return _CapabilityConfig.fromJson(json);
}

/// @nodoc
mixin _$CapabilityConfig {
  /// 能力 ID
  String get id => throw _privateConstructorUsedError;

  /// 能力类型（data / action）
  String get type => throw _privateConstructorUsedError;

  /// 所需权限
  List<String> get permissions => throw _privateConstructorUsedError;

  /// Serializes this CapabilityConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CapabilityConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CapabilityConfigCopyWith<CapabilityConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapabilityConfigCopyWith<$Res> {
  factory $CapabilityConfigCopyWith(
          CapabilityConfig value, $Res Function(CapabilityConfig) then) =
      _$CapabilityConfigCopyWithImpl<$Res, CapabilityConfig>;
  @useResult
  $Res call({String id, String type, List<String> permissions});
}

/// @nodoc
class _$CapabilityConfigCopyWithImpl<$Res, $Val extends CapabilityConfig>
    implements $CapabilityConfigCopyWith<$Res> {
  _$CapabilityConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CapabilityConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? permissions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CapabilityConfigImplCopyWith<$Res>
    implements $CapabilityConfigCopyWith<$Res> {
  factory _$$CapabilityConfigImplCopyWith(_$CapabilityConfigImpl value,
          $Res Function(_$CapabilityConfigImpl) then) =
      __$$CapabilityConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String type, List<String> permissions});
}

/// @nodoc
class __$$CapabilityConfigImplCopyWithImpl<$Res>
    extends _$CapabilityConfigCopyWithImpl<$Res, _$CapabilityConfigImpl>
    implements _$$CapabilityConfigImplCopyWith<$Res> {
  __$$CapabilityConfigImplCopyWithImpl(_$CapabilityConfigImpl _value,
      $Res Function(_$CapabilityConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of CapabilityConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? permissions = null,
  }) {
    return _then(_$CapabilityConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CapabilityConfigImpl implements _CapabilityConfig {
  const _$CapabilityConfigImpl(
      {required this.id,
      required this.type,
      final List<String> permissions = const []})
      : _permissions = permissions;

  factory _$CapabilityConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$CapabilityConfigImplFromJson(json);

  /// 能力 ID
  @override
  final String id;

  /// 能力类型（data / action）
  @override
  final String type;

  /// 所需权限
  final List<String> _permissions;

  /// 所需权限
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  String toString() {
    return 'CapabilityConfig(id: $id, type: $type, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapabilityConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, const DeepCollectionEquality().hash(_permissions));

  /// Create a copy of CapabilityConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CapabilityConfigImplCopyWith<_$CapabilityConfigImpl> get copyWith =>
      __$$CapabilityConfigImplCopyWithImpl<_$CapabilityConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CapabilityConfigImplToJson(
      this,
    );
  }
}

abstract class _CapabilityConfig implements CapabilityConfig {
  const factory _CapabilityConfig(
      {required final String id,
      required final String type,
      final List<String> permissions}) = _$CapabilityConfigImpl;

  factory _CapabilityConfig.fromJson(Map<String, dynamic> json) =
      _$CapabilityConfigImpl.fromJson;

  /// 能力 ID
  @override
  String get id;

  /// 能力类型（data / action）
  @override
  String get type;

  /// 所需权限
  @override
  List<String> get permissions;

  /// Create a copy of CapabilityConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CapabilityConfigImplCopyWith<_$CapabilityConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PerformanceBudget _$PerformanceBudgetFromJson(Map<String, dynamic> json) {
  return _PerformanceBudget.fromJson(json);
}

/// @nodoc
mixin _$PerformanceBudget {
  /// 启动时间预算（毫秒）
  int get startupMs => throw _privateConstructorUsedError;

  /// 首屏渲染时间预算（毫秒）
  int get firstScreenMs => throw _privateConstructorUsedError;

  /// 最大内存占用（MB）
  int get maxMemoryMb => throw _privateConstructorUsedError;

  /// 最大 CPU 占用百分比
  int get maxCpuPercent => throw _privateConstructorUsedError;

  /// Serializes this PerformanceBudget to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PerformanceBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PerformanceBudgetCopyWith<PerformanceBudget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceBudgetCopyWith<$Res> {
  factory $PerformanceBudgetCopyWith(
          PerformanceBudget value, $Res Function(PerformanceBudget) then) =
      _$PerformanceBudgetCopyWithImpl<$Res, PerformanceBudget>;
  @useResult
  $Res call(
      {int startupMs, int firstScreenMs, int maxMemoryMb, int maxCpuPercent});
}

/// @nodoc
class _$PerformanceBudgetCopyWithImpl<$Res, $Val extends PerformanceBudget>
    implements $PerformanceBudgetCopyWith<$Res> {
  _$PerformanceBudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PerformanceBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startupMs = null,
    Object? firstScreenMs = null,
    Object? maxMemoryMb = null,
    Object? maxCpuPercent = null,
  }) {
    return _then(_value.copyWith(
      startupMs: null == startupMs
          ? _value.startupMs
          : startupMs // ignore: cast_nullable_to_non_nullable
              as int,
      firstScreenMs: null == firstScreenMs
          ? _value.firstScreenMs
          : firstScreenMs // ignore: cast_nullable_to_non_nullable
              as int,
      maxMemoryMb: null == maxMemoryMb
          ? _value.maxMemoryMb
          : maxMemoryMb // ignore: cast_nullable_to_non_nullable
              as int,
      maxCpuPercent: null == maxCpuPercent
          ? _value.maxCpuPercent
          : maxCpuPercent // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerformanceBudgetImplCopyWith<$Res>
    implements $PerformanceBudgetCopyWith<$Res> {
  factory _$$PerformanceBudgetImplCopyWith(_$PerformanceBudgetImpl value,
          $Res Function(_$PerformanceBudgetImpl) then) =
      __$$PerformanceBudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int startupMs, int firstScreenMs, int maxMemoryMb, int maxCpuPercent});
}

/// @nodoc
class __$$PerformanceBudgetImplCopyWithImpl<$Res>
    extends _$PerformanceBudgetCopyWithImpl<$Res, _$PerformanceBudgetImpl>
    implements _$$PerformanceBudgetImplCopyWith<$Res> {
  __$$PerformanceBudgetImplCopyWithImpl(_$PerformanceBudgetImpl _value,
      $Res Function(_$PerformanceBudgetImpl) _then)
      : super(_value, _then);

  /// Create a copy of PerformanceBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startupMs = null,
    Object? firstScreenMs = null,
    Object? maxMemoryMb = null,
    Object? maxCpuPercent = null,
  }) {
    return _then(_$PerformanceBudgetImpl(
      startupMs: null == startupMs
          ? _value.startupMs
          : startupMs // ignore: cast_nullable_to_non_nullable
              as int,
      firstScreenMs: null == firstScreenMs
          ? _value.firstScreenMs
          : firstScreenMs // ignore: cast_nullable_to_non_nullable
              as int,
      maxMemoryMb: null == maxMemoryMb
          ? _value.maxMemoryMb
          : maxMemoryMb // ignore: cast_nullable_to_non_nullable
              as int,
      maxCpuPercent: null == maxCpuPercent
          ? _value.maxCpuPercent
          : maxCpuPercent // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerformanceBudgetImpl implements _PerformanceBudget {
  const _$PerformanceBudgetImpl(
      {this.startupMs = 1500,
      this.firstScreenMs = 3000,
      this.maxMemoryMb = 16,
      this.maxCpuPercent = 15});

  factory _$PerformanceBudgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerformanceBudgetImplFromJson(json);

  /// 启动时间预算（毫秒）
  @override
  @JsonKey()
  final int startupMs;

  /// 首屏渲染时间预算（毫秒）
  @override
  @JsonKey()
  final int firstScreenMs;

  /// 最大内存占用（MB）
  @override
  @JsonKey()
  final int maxMemoryMb;

  /// 最大 CPU 占用百分比
  @override
  @JsonKey()
  final int maxCpuPercent;

  @override
  String toString() {
    return 'PerformanceBudget(startupMs: $startupMs, firstScreenMs: $firstScreenMs, maxMemoryMb: $maxMemoryMb, maxCpuPercent: $maxCpuPercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceBudgetImpl &&
            (identical(other.startupMs, startupMs) ||
                other.startupMs == startupMs) &&
            (identical(other.firstScreenMs, firstScreenMs) ||
                other.firstScreenMs == firstScreenMs) &&
            (identical(other.maxMemoryMb, maxMemoryMb) ||
                other.maxMemoryMb == maxMemoryMb) &&
            (identical(other.maxCpuPercent, maxCpuPercent) ||
                other.maxCpuPercent == maxCpuPercent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, startupMs, firstScreenMs, maxMemoryMb, maxCpuPercent);

  /// Create a copy of PerformanceBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceBudgetImplCopyWith<_$PerformanceBudgetImpl> get copyWith =>
      __$$PerformanceBudgetImplCopyWithImpl<_$PerformanceBudgetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerformanceBudgetImplToJson(
      this,
    );
  }
}

abstract class _PerformanceBudget implements PerformanceBudget {
  const factory _PerformanceBudget(
      {final int startupMs,
      final int firstScreenMs,
      final int maxMemoryMb,
      final int maxCpuPercent}) = _$PerformanceBudgetImpl;

  factory _PerformanceBudget.fromJson(Map<String, dynamic> json) =
      _$PerformanceBudgetImpl.fromJson;

  /// 启动时间预算（毫秒）
  @override
  int get startupMs;

  /// 首屏渲染时间预算（毫秒）
  @override
  int get firstScreenMs;

  /// 最大内存占用（MB）
  @override
  int get maxMemoryMb;

  /// 最大 CPU 占用百分比
  @override
  int get maxCpuPercent;

  /// Create a copy of PerformanceBudget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceBudgetImplCopyWith<_$PerformanceBudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdatePolicy _$UpdatePolicyFromJson(Map<String, dynamic> json) {
  return _UpdatePolicy.fromJson(json);
}

/// @nodoc
mixin _$UpdatePolicy {
  /// 更新渠道（stable / beta / canary）
  String get channel => throw _privateConstructorUsedError;

  /// 是否允许自动更新
  bool get allowAutoUpdate => throw _privateConstructorUsedError;

  /// 是否允许回滚
  bool get allowRollback => throw _privateConstructorUsedError;

  /// 是否允许远程配置
  bool get allowRemoteConfig => throw _privateConstructorUsedError;

  /// 是否允许远程 Schema
  bool get allowRemoteSchema => throw _privateConstructorUsedError;

  /// 是否允许远程代码
  bool get allowRemoteCode => throw _privateConstructorUsedError;

  /// 是否需要签名
  bool get signatureRequired => throw _privateConstructorUsedError;

  /// Serializes this UpdatePolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePolicyCopyWith<UpdatePolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePolicyCopyWith<$Res> {
  factory $UpdatePolicyCopyWith(
          UpdatePolicy value, $Res Function(UpdatePolicy) then) =
      _$UpdatePolicyCopyWithImpl<$Res, UpdatePolicy>;
  @useResult
  $Res call(
      {String channel,
      bool allowAutoUpdate,
      bool allowRollback,
      bool allowRemoteConfig,
      bool allowRemoteSchema,
      bool allowRemoteCode,
      bool signatureRequired});
}

/// @nodoc
class _$UpdatePolicyCopyWithImpl<$Res, $Val extends UpdatePolicy>
    implements $UpdatePolicyCopyWith<$Res> {
  _$UpdatePolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = null,
    Object? allowAutoUpdate = null,
    Object? allowRollback = null,
    Object? allowRemoteConfig = null,
    Object? allowRemoteSchema = null,
    Object? allowRemoteCode = null,
    Object? signatureRequired = null,
  }) {
    return _then(_value.copyWith(
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      allowAutoUpdate: null == allowAutoUpdate
          ? _value.allowAutoUpdate
          : allowAutoUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRollback: null == allowRollback
          ? _value.allowRollback
          : allowRollback // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRemoteConfig: null == allowRemoteConfig
          ? _value.allowRemoteConfig
          : allowRemoteConfig // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRemoteSchema: null == allowRemoteSchema
          ? _value.allowRemoteSchema
          : allowRemoteSchema // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRemoteCode: null == allowRemoteCode
          ? _value.allowRemoteCode
          : allowRemoteCode // ignore: cast_nullable_to_non_nullable
              as bool,
      signatureRequired: null == signatureRequired
          ? _value.signatureRequired
          : signatureRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePolicyImplCopyWith<$Res>
    implements $UpdatePolicyCopyWith<$Res> {
  factory _$$UpdatePolicyImplCopyWith(
          _$UpdatePolicyImpl value, $Res Function(_$UpdatePolicyImpl) then) =
      __$$UpdatePolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String channel,
      bool allowAutoUpdate,
      bool allowRollback,
      bool allowRemoteConfig,
      bool allowRemoteSchema,
      bool allowRemoteCode,
      bool signatureRequired});
}

/// @nodoc
class __$$UpdatePolicyImplCopyWithImpl<$Res>
    extends _$UpdatePolicyCopyWithImpl<$Res, _$UpdatePolicyImpl>
    implements _$$UpdatePolicyImplCopyWith<$Res> {
  __$$UpdatePolicyImplCopyWithImpl(
      _$UpdatePolicyImpl _value, $Res Function(_$UpdatePolicyImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = null,
    Object? allowAutoUpdate = null,
    Object? allowRollback = null,
    Object? allowRemoteConfig = null,
    Object? allowRemoteSchema = null,
    Object? allowRemoteCode = null,
    Object? signatureRequired = null,
  }) {
    return _then(_$UpdatePolicyImpl(
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      allowAutoUpdate: null == allowAutoUpdate
          ? _value.allowAutoUpdate
          : allowAutoUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRollback: null == allowRollback
          ? _value.allowRollback
          : allowRollback // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRemoteConfig: null == allowRemoteConfig
          ? _value.allowRemoteConfig
          : allowRemoteConfig // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRemoteSchema: null == allowRemoteSchema
          ? _value.allowRemoteSchema
          : allowRemoteSchema // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRemoteCode: null == allowRemoteCode
          ? _value.allowRemoteCode
          : allowRemoteCode // ignore: cast_nullable_to_non_nullable
              as bool,
      signatureRequired: null == signatureRequired
          ? _value.signatureRequired
          : signatureRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePolicyImpl implements _UpdatePolicy {
  const _$UpdatePolicyImpl(
      {this.channel = 'stable',
      this.allowAutoUpdate = true,
      this.allowRollback = true,
      this.allowRemoteConfig = true,
      this.allowRemoteSchema = true,
      this.allowRemoteCode = true,
      this.signatureRequired = true});

  factory _$UpdatePolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePolicyImplFromJson(json);

  /// 更新渠道（stable / beta / canary）
  @override
  @JsonKey()
  final String channel;

  /// 是否允许自动更新
  @override
  @JsonKey()
  final bool allowAutoUpdate;

  /// 是否允许回滚
  @override
  @JsonKey()
  final bool allowRollback;

  /// 是否允许远程配置
  @override
  @JsonKey()
  final bool allowRemoteConfig;

  /// 是否允许远程 Schema
  @override
  @JsonKey()
  final bool allowRemoteSchema;

  /// 是否允许远程代码
  @override
  @JsonKey()
  final bool allowRemoteCode;

  /// 是否需要签名
  @override
  @JsonKey()
  final bool signatureRequired;

  @override
  String toString() {
    return 'UpdatePolicy(channel: $channel, allowAutoUpdate: $allowAutoUpdate, allowRollback: $allowRollback, allowRemoteConfig: $allowRemoteConfig, allowRemoteSchema: $allowRemoteSchema, allowRemoteCode: $allowRemoteCode, signatureRequired: $signatureRequired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePolicyImpl &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.allowAutoUpdate, allowAutoUpdate) ||
                other.allowAutoUpdate == allowAutoUpdate) &&
            (identical(other.allowRollback, allowRollback) ||
                other.allowRollback == allowRollback) &&
            (identical(other.allowRemoteConfig, allowRemoteConfig) ||
                other.allowRemoteConfig == allowRemoteConfig) &&
            (identical(other.allowRemoteSchema, allowRemoteSchema) ||
                other.allowRemoteSchema == allowRemoteSchema) &&
            (identical(other.allowRemoteCode, allowRemoteCode) ||
                other.allowRemoteCode == allowRemoteCode) &&
            (identical(other.signatureRequired, signatureRequired) ||
                other.signatureRequired == signatureRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      channel,
      allowAutoUpdate,
      allowRollback,
      allowRemoteConfig,
      allowRemoteSchema,
      allowRemoteCode,
      signatureRequired);

  /// Create a copy of UpdatePolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePolicyImplCopyWith<_$UpdatePolicyImpl> get copyWith =>
      __$$UpdatePolicyImplCopyWithImpl<_$UpdatePolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePolicyImplToJson(
      this,
    );
  }
}

abstract class _UpdatePolicy implements UpdatePolicy {
  const factory _UpdatePolicy(
      {final String channel,
      final bool allowAutoUpdate,
      final bool allowRollback,
      final bool allowRemoteConfig,
      final bool allowRemoteSchema,
      final bool allowRemoteCode,
      final bool signatureRequired}) = _$UpdatePolicyImpl;

  factory _UpdatePolicy.fromJson(Map<String, dynamic> json) =
      _$UpdatePolicyImpl.fromJson;

  /// 更新渠道（stable / beta / canary）
  @override
  String get channel;

  /// 是否允许自动更新
  @override
  bool get allowAutoUpdate;

  /// 是否允许回滚
  @override
  bool get allowRollback;

  /// 是否允许远程配置
  @override
  bool get allowRemoteConfig;

  /// 是否允许远程 Schema
  @override
  bool get allowRemoteSchema;

  /// 是否允许远程代码
  @override
  bool get allowRemoteCode;

  /// 是否需要签名
  @override
  bool get signatureRequired;

  /// Create a copy of UpdatePolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePolicyImplCopyWith<_$UpdatePolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
