import 'js_engine.dart';

/// 单个插件的 JS 运行时
///
/// 每个插件拥有独立的 JS Runtime，实现内存和执行隔离
abstract class JSRuntime {
  /// Runtime 唯一标识符
  String get runtimeId;

  /// 关联的插件 ID
  String get pluginId;

  /// 当前状态
  RuntimeState get state;

  /// 加载并执行 JS Bundle
  ///
  /// [jsSource] - JavaScript 源代码
  Future<void> loadBundle(String jsSource);

  /// 调用 JS 侧表达式
  ///
  /// [expression] - JavaScript 表达式
  /// 返回执行结果
  Future<dynamic> evaluate(String expression);

  /// 调用 JS 侧具名函数
  ///
  /// [functionName] - 函数名
  /// [args] - 参数列表
  /// 返回函数执行结果
  Future<dynamic> callFunction(String functionName, List<dynamic> args);

  /// 注册宿主能力供 JS 调用
  ///
  /// [method] - 能力方法名
  /// [handler] - 能力处理器
  void registerHostBridge(String method, HostHandler handler);

  /// 触发 JS 侧事件回调
  ///
  /// [eventName] - 事件名
  /// [payload] - 事件数据
  Future<void> dispatchEvent(String eventName, Map<String, dynamic> payload);

  /// 销毁运行时，释放资源
  void dispose();
}

/// Runtime 状态
enum RuntimeState {
  /// 未初始化
  uninitialized,

  /// 加载中
  loading,

  /// 就绪
  ready,

  /// 运行中
  running,

  /// 错误
  error,

  /// 已销毁
  disposed,
}
