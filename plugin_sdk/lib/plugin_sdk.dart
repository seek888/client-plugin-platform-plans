import 'package:core/core.dart';

/// 插件上下文
///
/// 提供给插件使用的运行时 API
class PluginContext {
  /// 插件 ID
  final String pluginId;

  /// 日志记录
  void log(String message) {
    print('[$pluginId] $message');
  }

  /// 调用宿主能力
  Future<Map<String, dynamic>> invokeHost(
    String method,
    Map<String, dynamic> params,
  ) async {
    // 在实际 JS 运行时中，这会被桥接
    // 这里只是类型定义
    throw UnimplementedError('invokeHost must be implemented by runtime');
  }

  /// 订阅事件
  void subscribe(String eventName, Function(dynamic) callback) {
    // 事件订阅
  }

  /// 取消订阅
  void unsubscribe(String eventName) {
    // 取消订阅
  }

  /// 发布自定义事件
  Future<void> publishEvent(
    String eventName,
    Map<String, dynamic> payload,
  ) async {
    await invokeHost('event.publish', {
      'event': eventName,
      'payload': payload,
    });
  }
}

/// 插件入口函数类型
typedef PluginActivateFunction = void Function(PluginContext context);

typedef PluginDeactivateFunction = void Function();

typedef PluginRenderPageFunction = STACSchema Function(Map<String, dynamic> route);

typedef PluginRenderCardFunction = STACSchema Function(Map<String, dynamic> context);

typedef PluginEventHandler = Future<STACUpdate?> Function(
  Map<String, dynamic> state,
  PluginContext context,
);

/// 插件类型定义
///
/// 定义插件的基本接口
abstract class Plugin {
  /// 插件 ID
  String get id;

  /// 插件名称
  String get name;

  /// 插件描述
  String get description => '';

  /// 插件版本
  String get version;

  /// 激活回调
  void onActivate(PluginContext context) {}

  /// 停用回调
  void onDeactivate() {}

  /// 渲染页面
  STACSchema? renderPage(Map<String, dynamic> route) => null;

  /// 渲染卡片
  STACSchema? renderCard(Map<String, dynamic> context) => null;
}

/// 简单插件基类
///
/// 提供默认实现的插件基类
abstract class SimplePlugin extends Plugin {
  @override
  void onActivate(PluginContext context) {
    // 默认实现：无操作
  }

  @override
  void onDeactivate() {
    // 默认实现：无操作
  }
}

/// 状态管理插件基类
///
/// 带状态管理的插件基类
abstract class StatefulPlugin extends Plugin {
  /// 当前状态
  Map<String, dynamic> state = {};

  /// 更新状态
  void setState(Map<String, dynamic> newState) {
    state = {...state, ...newState};
  }

  /// 获取状态值
  T? getState<T>(String key) {
    return state[key] as T?;
  }
}

/// 表单插件基类
///
/// 专门用于表单类插件的基类
abstract class FormPlugin extends SimplePlugin {
  /// 表单字段定义
  List<FormFieldDefinition> get fields;

  /// 表单提交处理
  Future<Map<String, dynamic>> handleSubmit(Map<String, dynamic> data);

  /// 表单校验
  Map<String, String>? validate(Map<String, dynamic> data) {
    return null;
  }
}

/// 表单字段定义
class FormFieldDefinition {
  /// 字段 ID
  final String id;

  /// 字段类型
  final String type;

  /// 字段标签
  final String label;

  /// 是否必填
  final bool required;

  /// 默认值
  final dynamic defaultValue;

  /// 校验规则
  final List<STACValidation>? validations;

  /// 额外属性
  final Map<String, dynamic> props;

  const FormFieldDefinition({
    required this.id,
    required this.type,
    required this.label,
    this.required = false,
    this.defaultValue,
    this.validations,
    this.props = const {},
  });
}
