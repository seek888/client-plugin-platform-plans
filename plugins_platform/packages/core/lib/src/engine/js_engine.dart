import 'js_runtime.dart';

/// JS 引擎抽象接口
///
/// 定义了 JS 引擎的统一接口，支持不同的引擎实现（如 QuickJS、V8）
abstract class JSEngine {
  /// 创建独立的 JS Runtime 实例
  ///
  /// [pluginId] - 关联的插件 ID
  /// [memoryLimitBytes] - 内存限制，默认 16MB
  /// [executionTimeout] - 执行超时时间
  JSRuntime createRuntime({
    String? pluginId,
    int memoryLimitBytes,
    Duration? executionTimeout,
  });

  /// 全局能力桥注册
  ///
  /// 注册一个宿主能力处理器，供 JS Runtime 调用
  void registerHostHandler(String method, HostHandler handler);

  /// 销毁引擎
  void dispose();
}

/// 宿主能力处理器
///
/// 定义了宿主能力的处理函数类型
typedef HostHandler = Future<Map<String, dynamic>> Function(
  Map<String, dynamic> params,
);

/// JS 引擎错误
class JSEngineError implements Exception {
  final String message;
  final dynamic cause;

  JSEngineError(this.message, [this.cause]);

  @override
  String toString() =>
      'JSEngineError: $message${cause != null ? ' ($cause)' : ''}';
}

/// JS 运行时错误
class JSRuntimeError implements Exception {
  final String message;
  final String? runtimeId;
  final dynamic cause;

  JSRuntimeError(this.message, {this.runtimeId, this.cause});

  @override
  String toString() =>
      'JSRuntimeError${runtimeId != null ? ' [$runtimeId]' : ''}: $message${cause != null ? ' ($cause)' : ''}';
}
