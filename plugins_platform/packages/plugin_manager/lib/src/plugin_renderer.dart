import 'package:flutter/widgets.dart';
import 'package:core/core.dart';
import 'package:stac_renderer/stac_renderer.dart';
import 'plugin_manager.dart';

/// 插件渲染器
///
/// 负责管理 JS 插件的 STAC 渲染流程
class PluginRenderer {
  final PluginManager _manager;

  /// 当前渲染的数据
  Map<String, dynamic> _currentData = {};

  /// 表单 Key
  final STACFormKey _formKey = STACFormKey();

  PluginRenderer(this._manager);

  /// 渲染插件页面
  ///
  /// [pluginId] - 插件 ID
  /// [route] - 路由参数
  /// [onUpdate] - 更新回调
  Future<Widget> renderPage({
    required String pluginId,
    Map<String, dynamic>? route,
    Function(STACUpdate)? onUpdate,
  }) async {
    final runtime = _manager.getRuntime(pluginId);
    if (runtime == null) {
      throw PluginError.notActivated(pluginId);
    }

    // 调用 JS 的 renderPage 函数
    final result = await runtime.callFunction('renderPage', [
      {'route': route ?? {}}
    ]);

    if (result == null) {
      throw PluginError('renderPage returned null', pluginId: pluginId);
    }

    // 解析 Schema
    final schemaData = result is Map<String, dynamic>
        ? result
        : (result is Map ? result as Map<String, dynamic> : null);

    if (schemaData == null) {
      throw PluginError('Invalid schema format', pluginId: pluginId);
    }

    final schema = STACSchema.fromJson(schemaData);

    // 处理数据源
    await _processDataSources(schema, runtime);

    return STACRenderer.render(
      schema,
      data: _currentData,
      formKey: _formKey,
      eventHandler: (eventName, params) async {
        return await _handleEvent(
          pluginId,
          runtime,
          eventName,
          params,
          onUpdate,
        );
      },
    );
  }

  /// 渲染插件卡片
  Future<Widget> renderCard({
    required String pluginId,
    Map<String, dynamic>? context,
    Function(STACUpdate)? onUpdate,
  }) async {
    final runtime = _manager.getRuntime(pluginId);
    if (runtime == null) {
      throw PluginError.notActivated(pluginId);
    }

    // 调用 JS 的 renderCard 函数
    final result = await runtime.callFunction('renderCard', [
      {'context': context ?? {}}
    ]);

    if (result == null) {
      throw PluginError('renderCard returned null', pluginId: pluginId);
    }

    final schemaData = result is Map<String, dynamic>
        ? result
        : (result is Map ? result as Map<String, dynamic> : null);

    if (schemaData == null) {
      throw PluginError('Invalid schema format', pluginId: pluginId);
    }

    final schema = STACSchema.fromJson(schemaData);

    // 处理数据源
    await _processDataSources(schema, runtime);

    return STACRenderer.render(
      schema,
      data: _currentData,
      eventHandler: (eventName, params) async {
        return await _handleEvent(
          pluginId,
          runtime,
          eventName,
          params,
          onUpdate,
        );
      },
    );
  }

  /// 处理数据源
  Future<void> _processDataSources(
    STACSchema schema,
    JSRuntime runtime,
  ) async {
    if (schema.dataSources == null || schema.dataSources!.isEmpty) {
      return;
    }

    _currentData = {};

    for (final entry in schema.dataSources!.entries) {
      final key = entry.key;
      final source = entry.value;

      try {
        // 如果是 capability 类型的数据源，通过 invokeHost 获取
        if (source.sourceType == 'capability' && source.capability != null) {
          final result = await runtime.callFunction('invokeHost', [
            source.capability!,
            source.params,
          ]);

          // 应用转换
          if (source.transform != null && result is Map) {
            final transformed = <String, dynamic>{};
            source.transform!.forEach((toKey, fromKey) {
              transformed[toKey] = result[fromKey];
            });
            _currentData[key] = transformed;
          } else {
            _currentData[key] = result;
          }
        } else {
          // 使用默认值
          _currentData[key] = source.defaultValue;
        }
      } catch (e) {
        // 数据源获取失败，使用默认值
        _currentData[key] = source.defaultValue;
      }
    }
  }

  /// 处理事件
  Future<STACUpdate?> _handleEvent(
    String pluginId,
    JSRuntime runtime,
    String eventName,
    Map<String, dynamic> params,
    Function(STACUpdate)? onUpdate,
  ) async {
    try {
      // 从参数中获取处理函数名
      final handler = params['handler'] as String?;
      if (handler == null) {
        return null;
      }

      // 构建状态参数
      final stateParams = <String, dynamic>{
        'route': params['route'] ?? {},
        'form': _formKey.getValues(),
        ...params,
      };

      // 调用 JS 的事件处理函数
      final result = await runtime.callFunction(handler, [stateParams]);

      // 解析返回的更新指令
      final update = STACUpdate.fromJsResult(result);

      // 如果有更新，通知回调
      if (update.type != STACUpdateType.none && onUpdate != null) {
        onUpdate(update);
      }

      return update;
    } catch (e) {
      // 事件处理失败
      // TODO: 添加错误日志
      return null;
    }
  }

  /// 获取表单值
  Map<String, dynamic> getFormValues() {
    return _formKey.getValues();
  }

  /// 验证表单
  bool validateForm() {
    return _formKey.validate();
  }

  /// 获取表单 Key
  STACFormKey get formKey => _formKey;
}
