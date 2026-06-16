import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:core/core.dart';
import 'package:host_bridge/host_bridge.dart';

/// 插件管理器
///
/// 负责插件的生命周期管理，包括安装、激活、停用、卸载
class PluginManager {
  final JSEngine _engine;
  final HostBridge _bridge;

  /// 已安装的插件 Manifest
  final Map<String, PluginManifest> _manifests = {};

  /// 插件状态信息
  final Map<String, PluginInfo> _pluginInfos = {};

  /// 活跃的 Runtime
  final Map<String, JSRuntime> _runtimes = {};

  /// 插件存储目录
  Directory? _pluginsDir;

  late final Future<void> _initialization;

  PluginManager({
    required JSEngine engine,
    required HostBridge bridge,
  })  : _engine = engine,
        _bridge = bridge {
    _initialization = _initialize();
  }

  /// 初始化完成后可等待的 Future
  Future<void> get ready => _initialization;

  /// 初始化插件管理器
  Future<void> _initialize() async {
    _log('initialize: start');
    // 获取插件存储目录
    final appDocDir = await getApplicationDocumentsDirectory();
    _pluginsDir = Directory('${appDocDir.path}/plugins');
    _log('initialize: pluginsDir=${_pluginsDir!.path}');

    // 创建目录
    if (!_pluginsDir!.existsSync()) {
      await _pluginsDir!.create(recursive: true);
    }

    // 加载已安装的插件
    await _loadInstalledPlugins();
    _log('initialize: loaded ${_manifests.length} plugins');
  }

  /// 加载已安装的插件
  Future<void> _loadInstalledPlugins() async {
    if (!_pluginsDir!.existsSync()) return;

    final manifestFiles = _pluginsDir!
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('/manifest.json'));

    for (final file in manifestFiles) {
      try {
        final json = jsonDecode(await file.readAsString());
        final manifest = PluginManifest.fromJson(json);
        _manifests[manifest.id] = manifest;
        _pluginInfos[manifest.id] = PluginInfo(
          manifest: manifest,
          state: PluginState.installed,
          installedAt: file.lastModifiedSync(),
        );
        _log('loadInstalled: ${manifest.id}');
      } catch (e, stackTrace) {
        _log(
          'loadInstalled failed: ${file.path}',
          error: e,
          stackTrace: stackTrace,
        );
        // 跳过损坏的 Manifest
        continue;
      }
    }
  }

  /// 安装插件
  ///
  /// [manifest] - 插件 Manifest
  /// [bundleSource] - JS Bundle 源代码（可选，如果为空则从 URL 下载）
  Future<void> install(
    PluginManifest manifest, {
    String? bundleSource,
  }) async {
    await _initialization;
    _log('install: start id=${manifest.id}');
    _log('install: bundleLength=${bundleSource?.length ?? 0}');

    // 检查是否已安装
    if (_manifests.containsKey(manifest.id)) {
      _log('install: already exists id=${manifest.id}');
      throw PluginError.alreadyExists(manifest.id);
    }

    // 版本兼容性检查
    // TODO: 实现版本比较逻辑

    // 创建插件目录
    final pluginDir = Directory('${_pluginsDir!.path}/${manifest.id}');
    _log('install: pluginDir=${pluginDir.path}');
    if (!pluginDir.existsSync()) {
      await pluginDir.create(recursive: true);
    }

    try {
      // 保存 Manifest
      final manifestFile = File('${pluginDir.path}/manifest.json');
      await manifestFile.writeAsString(
        jsonEncode(manifest.toJson()),
      );

      // 保存 Bundle
      if (bundleSource != null) {
        await _saveBundle(manifest, bundleSource, pluginDir);
      }

      // 注册插件
      _manifests[manifest.id] = manifest;
      _pluginInfos[manifest.id] = PluginInfo(
        manifest: manifest,
        state: PluginState.installed,
        installedAt: DateTime.now(),
      );
      _log('install: success id=${manifest.id}');
    } catch (e, stackTrace) {
      _log(
        'install: failed id=${manifest.id}',
        error: e,
        stackTrace: stackTrace,
      );
      // 清理失败的安装
      if (pluginDir.existsSync()) {
        await pluginDir.delete(recursive: true);
      }
      rethrow;
    }
  }

  /// 保存 Bundle
  Future<void> _saveBundle(
    PluginManifest manifest,
    String bundleSource,
    Directory pluginDir,
  ) async {
    // 验证签名
    final expectedHash = manifest.engine?.bundleHash;
    if (expectedHash != null && expectedHash.isNotEmpty) {
      final hash = sha256.convert(utf8.encode(bundleSource)).toString();
      _log('saveBundle: hash=$hash expected=$expectedHash');
      if (hash != expectedHash) {
        throw PluginError.signatureVerificationFailed(manifest.id);
      }
    } else {
      _log('saveBundle: skip hash verification');
    }

    // 保存 Bundle
    final bundleFile = File('${pluginDir.path}/bundle.js');
    await bundleFile.writeAsString(bundleSource);
    _log('saveBundle: wrote ${bundleFile.path}');
  }

  /// 激活插件
  ///
  /// [pluginId] - 插件 ID
  Future<JSRuntime> activate(String pluginId) async {
    await _initialization;
    _log('activate: start id=$pluginId');

    final manifest = _manifests[pluginId];
    if (manifest == null) {
      _log('activate: manifest not found id=$pluginId');
      throw PluginError.notFound(pluginId);
    }

    // 检查是否已激活
    if (_runtimes.containsKey(pluginId)) {
      _log('activate: already active id=$pluginId');
      return _runtimes[pluginId]!;
    }

    // 只有 JS 插件需要创建 Runtime
    if (manifest.type != PluginType.js) {
      throw PluginError(
        'Cannot activate non-JS plugin',
        pluginId: pluginId,
      );
    }

    try {
      // 读取 Bundle
      final bundleFile = File('${_pluginsDir!.path}/$pluginId/bundle.js');
      if (!bundleFile.existsSync()) {
        _log('activate: bundle missing path=${bundleFile.path}');
        throw PluginError(
          'Bundle not found',
          pluginId: pluginId,
        );
      }
      final bundleSource = await bundleFile.readAsString();
      _log('activate: bundleLength=${bundleSource.length}');

      // 创建 Runtime
      final runtime = _engine.createRuntime(
        pluginId: pluginId,
        memoryLimitBytes: (manifest.engine?.memoryLimitMb ?? 16) * 1024 * 1024,
        executionTimeout: Duration(
          milliseconds: manifest.engine?.executionTimeoutMs ?? 5000,
        ),
      );

      // 加载 Bundle
      await runtime.loadBundle(bundleSource);
      _log('activate: bundle loaded id=$pluginId');

      // 注册能力桥
      _registerHostBridge(runtime, manifest);

      // 调用 onActivate
      try {
        await runtime.callFunction('onActivate', []);
      } catch (e, stackTrace) {
        _log(
          'activate: onActivate failed id=$pluginId',
          error: e,
          stackTrace: stackTrace,
        );
        // onActivate 失败不影响激活
      }

      // 保存 Runtime
      _runtimes[pluginId] = runtime;

      // 更新状态
      _pluginInfos[pluginId] = _pluginInfos[pluginId]!.copyWith(
        state: PluginState.activated,
        activatedAt: DateTime.now(),
      );

      return runtime;
    } catch (e, stackTrace) {
      _log(
        'activate: failed id=$pluginId',
        error: e,
        stackTrace: stackTrace,
      );
      // 清理失败的激活
      _runtimes.remove(pluginId);
      _pluginInfos[pluginId] = _pluginInfos[pluginId]!.copyWith(
        state: PluginState.error,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  /// 注册宿主能力桥
  void _registerHostBridge(JSRuntime runtime, PluginManifest manifest) {
    _bridge.setPluginPermissions(manifest.id, manifest.permissions);

    for (final capability in _bridge.registry.getAll()) {
      runtime.registerHostBridge(capability.id, (params) {
        return _bridge.handleInvoke(
          pluginId: manifest.id,
          method: capability.id,
          params: params,
        );
      });
    }
  }

  /// 停用插件
  ///
  /// [pluginId] - 插件 ID
  void deactivate(String pluginId) {
    final runtime = _runtimes.remove(pluginId);
    if (runtime != null) {
      // 调用 onDeactivate
      try {
        runtime.callFunction('onDeactivate', []);
      } catch (e) {
        // 忽略错误
      }

      // 销毁 Runtime
      runtime.dispose();
    }

    // 更新状态
    if (_pluginInfos.containsKey(pluginId)) {
      _pluginInfos[pluginId] = _pluginInfos[pluginId]!.copyWith(
        state: PluginState.deactivated,
      );
    }
  }

  /// 卸载插件
  ///
  /// [pluginId] - 插件 ID
  Future<void> uninstall(String pluginId) async {
    // 先停用
    deactivate(pluginId);

    // 删除插件目录
    final pluginDir = Directory('${_pluginsDir!.path}/$pluginId');
    if (pluginDir.existsSync()) {
      await pluginDir.delete(recursive: true);
    }

    // 移除注册
    _manifests.remove(pluginId);
    _pluginInfos.remove(pluginId);
  }

  /// 获取插件信息
  PluginInfo? getPluginInfo(String pluginId) => _pluginInfos[pluginId];

  /// 获取所有插件
  List<PluginInfo> getAllPlugins() => _pluginInfos.values.toList();

  /// 获取已激活的插件
  List<PluginInfo> getActivatedPlugins() =>
      _pluginInfos.values.where((p) => p.isActivated).toList();

  /// 获取 Runtime
  JSRuntime? getRuntime(String pluginId) => _runtimes[pluginId];

  /// 调用插件导出函数
  Future<dynamic> callPluginFunction(
    String pluginId,
    String functionName,
    List<dynamic> args,
  ) async {
    final runtime = _runtimes[pluginId];
    if (runtime == null) {
      throw PluginError.notActivated(pluginId);
    }
    return runtime.callFunction(functionName, args);
  }

  /// 安装内置插件资产
  Future<void> installFromAsset({
    required PluginManifest manifest,
    required String bundleSource,
  }) async {
    await install(manifest, bundleSource: bundleSource);
  }

  /// 检查插件是否已安装
  bool isInstalled(String pluginId) => _manifests.containsKey(pluginId);

  /// 检查插件是否已激活
  bool isActivated(String pluginId) => _runtimes.containsKey(pluginId);

  void _log(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: 'PluginManager',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
