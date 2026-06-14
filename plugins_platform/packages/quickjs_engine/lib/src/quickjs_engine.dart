import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:core/core.dart';
import 'package:quickjs_engine/quickjs_engine.dart' as quickjs;

/// QuickJS 引擎实现。
///
/// 这里是项目自己的适配层，底层 JS runtime 来自远程 quickjs_engine 包。
class QuickJSEngine implements JSEngine {
  final Map<String, HostHandler> _handlers = {};

  QuickJSEngine();

  @override
  JSRuntime createRuntime({
    String? pluginId,
    int memoryLimitBytes = 16 * 1024 * 1024,
    Duration? executionTimeout,
  }) {
    return QuickJSRuntime(
      engine: this,
      pluginId: pluginId ?? '',
      memoryLimitBytes: memoryLimitBytes,
      executionTimeout: executionTimeout,
    );
  }

  @override
  void registerHostHandler(String method, HostHandler handler) {
    _handlers[method] = handler;
  }

  HostHandler? getHandler(String method) => _handlers[method];

  @override
  void dispose() {}
}

/// QuickJS Runtime 实现。
///
/// 每个插件实例持有一个独立的 QuickJS-NG runtime。
class QuickJSRuntime implements JSRuntime {
  static const _hostBridgeChannel = '__plugins_host_bridge__';

  final QuickJSEngine _engine;
  final int memoryLimitBytes;
  final Duration? executionTimeout;
  final Map<String, HostHandler> _runtimeHandlers = {};

  quickjs.JavascriptRuntime? _jsRuntime;
  String _runtimeId = '';
  final String _pluginId;
  RuntimeState _state = RuntimeState.uninitialized;

  QuickJSRuntime({
    required QuickJSEngine engine,
    required String pluginId,
    required this.memoryLimitBytes,
    this.executionTimeout,
  }) : _engine = engine,
       _pluginId = pluginId {
    _initialize();
  }

  void _initialize() {
    _runtimeId = 'rt_${DateTime.now().millisecondsSinceEpoch}';
    _state = RuntimeState.loading;
    _jsRuntime = quickjs.QuickJsRuntime2(
      memoryLimit: Platform.isMacOS ? null : memoryLimitBytes,
      timeout: executionTimeout?.inMilliseconds,
    );
    _installHostBridge();
    _state = RuntimeState.ready;
  }

  void _installHostBridge() {
    try {
      _jsRuntime!.onMessage(_hostBridgeChannel, (dynamic args) {
        return _handleHostInvoke(args);
      });

      final result = _jsRuntime!.evaluate(r'''
        globalThis.invokeHost = function(method, params) {
          return sendMessage('__plugins_host_bridge__', JSON.stringify({
            method: method,
            params: params || {}
          }));
        };
      ''');
      if (result.isError) {
        throw result.rawResult ?? result.stringResult;
      }
      _pumpJobs();
    } catch (e) {
      _state = RuntimeState.error;
      throw JSRuntimeError(
        'Failed to register invokeHost',
        runtimeId: _runtimeId,
        cause: e,
      );
    }
  }

  Future<Map<String, dynamic>> _handleHostInvoke(dynamic args) async {
    final data = _asStringKeyMap(args);
    final method = data['method'] as String?;
    final params = _asStringKeyMap(data['params']);

    if (method == null || method.isEmpty) {
      throw JSRuntimeError('Host method is required', runtimeId: _runtimeId);
    }

    final handler = _runtimeHandlers[method] ?? _engine.getHandler(method);
    if (handler == null) {
      throw JSRuntimeError(
        'Host method is not registered: $method',
        runtimeId: _runtimeId,
      );
    }

    return handler(params);
  }

  @override
  String get runtimeId => _runtimeId;

  @override
  String get pluginId => _pluginId;

  @override
  RuntimeState get state => _state;

  @override
  Future<void> loadBundle(String jsSource) async {
    _ensureUsable();

    try {
      final result = _jsRuntime!.evaluate(_normalizeBundle(jsSource));
      if (result.isError) {
        throw result.rawResult ?? result.stringResult;
      }
      await _resolveJsValue(result.rawResult);
      _state = RuntimeState.ready;
    } catch (e) {
      _state = RuntimeState.error;
      throw JSRuntimeError(
        'Failed to load bundle',
        runtimeId: _runtimeId,
        cause: e,
      );
    }
  }

  String _normalizeBundle(String jsSource) {
    return jsSource
        .replaceAll(RegExp(r'export\s+async\s+function\s+'), 'async function ')
        .replaceAll(RegExp(r'export\s+function\s+'), 'function ')
        .replaceAll(RegExp(r'export\s+const\s+'), 'const ')
        .replaceAll(RegExp(r'export\s+let\s+'), 'let ')
        .replaceAll(RegExp(r'export\s+var\s+'), 'var ');
  }

  @override
  Future<dynamic> evaluate(String expression) async {
    _ensureReady();
    _state = RuntimeState.running;

    try {
      final result = _jsRuntime!.evaluate(expression);
      if (result.isError) {
        throw result.rawResult ?? result.stringResult;
      }
      final value = await _resolveJsValue(result.rawResult);
      _state = RuntimeState.ready;
      return value;
    } catch (e) {
      _state = RuntimeState.ready;
      throw JSRuntimeError(
        'Failed to evaluate expression',
        runtimeId: _runtimeId,
        cause: e,
      );
    }
  }

  @override
  Future<dynamic> callFunction(String functionName, List<dynamic> args) async {
    _ensureReady();
    _validateFunctionName(functionName);
    _state = RuntimeState.running;

    try {
      final result = _jsRuntime!.evaluate('''
        (function() {
          const fn = $functionName;
          if (typeof fn !== 'function') {
            return null;
          }
          return fn(...${jsonEncode(args)});
        })()
      ''');
      if (result.isError) {
        throw result.rawResult ?? result.stringResult;
      }
      final value = await _resolveJsValue(result.rawResult);
      _state = RuntimeState.ready;
      return value;
    } catch (e) {
      _state = RuntimeState.ready;
      throw JSRuntimeError(
        'Failed to call function: $functionName',
        runtimeId: _runtimeId,
        cause: e,
      );
    }
  }

  @override
  void registerHostBridge(String method, HostHandler handler) {
    _runtimeHandlers[method] = handler;
  }

  @override
  Future<void> dispatchEvent(
    String eventName,
    Map<String, dynamic> payload,
  ) async {
    if (_state != RuntimeState.ready) {
      throw JSRuntimeError(
        'Runtime is not ready: ${_state.name}',
        runtimeId: _runtimeId,
      );
    }

    try {
      final functionName = 'on${_capitalize(eventName)}';
      await callFunction(functionName, [payload]);
    } catch (_) {
      // 事件处理失败不应打断宿主流程。
    }
  }

  @override
  void dispose() {
    _jsRuntime?.dispose();
    _jsRuntime = null;
    _state = RuntimeState.disposed;
  }

  void _ensureUsable() {
    if (_state == RuntimeState.disposed || _jsRuntime == null) {
      throw JSRuntimeError('Runtime is disposed', runtimeId: _runtimeId);
    }
  }

  void _ensureReady() {
    _ensureUsable();
    if (_state != RuntimeState.ready) {
      throw JSRuntimeError(
        'Runtime is not ready: ${_state.name}',
        runtimeId: _runtimeId,
      );
    }
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  void _validateFunctionName(String functionName) {
    final pattern = RegExp(
      r'^[A-Za-z_$][A-Za-z0-9_$]*(\.[A-Za-z_$][A-Za-z0-9_$]*)*$',
    );
    if (!pattern.hasMatch(functionName)) {
      throw JSRuntimeError(
        'Invalid function name: $functionName',
        runtimeId: _runtimeId,
      );
    }
  }

  Future<dynamic> _resolveJsValue(dynamic value) async {
    _pumpJobs();

    if (value is Future) {
      final completer = Completer<dynamic>();
      value.then(completer.complete, onError: completer.completeError);

      while (!completer.isCompleted) {
        _pumpJobs();
        await Future<void>.delayed(const Duration(milliseconds: 1));
      }

      final resolved = await completer.future;
      _pumpJobs();
      return _normalizeDartValue(resolved);
    }

    return _normalizeDartValue(value);
  }

  dynamic _normalizeDartValue(dynamic value) {
    if (value is Map) {
      return _asStringKeyMap(value);
    }
    if (value is List) {
      return value.map(_normalizeDartValue).toList();
    }
    return value;
  }

  Map<String, dynamic> _asStringKeyMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, value) {
        return MapEntry(key.toString(), _normalizeDartValue(value));
      });
    }
    return <String, dynamic>{};
  }

  void _pumpJobs() {
    _jsRuntime?.executePendingJob();
  }
}
