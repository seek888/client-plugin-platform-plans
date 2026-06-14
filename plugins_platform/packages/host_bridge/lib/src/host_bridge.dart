import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core/core.dart';
import 'capability_registry.dart';
import 'permission_checker.dart';

/// Host Bridge 实现
///
/// 实现宿主能力桥，负责能力注册、权限校验和调用处理
class HostBridge {
  final CapabilityRegistry _registry = CapabilityRegistryImpl();
  final PermissionChecker _permissionChecker = PermissionCheckerImpl();

  /// 导航器 Key（用于页面导航）
  final GlobalKey<NavigatorState>? navigatorKey;

  /// 插件权限缓存
  final Map<String, List<String>> _pluginPermissions = {};

  HostBridge({this.navigatorKey}) {
    registerBuiltinCapabilities();
  }

  /// 获取能力注册表
  CapabilityRegistry get registry => _registry;

  /// 注册内置能力
  void registerBuiltinCapabilities() {
    // ===== UI 能力 =====

    // Toast 显示
    _registry.register(Capability(
      id: 'toast.show',
      handler: _showToast,
    ));

    // Dialog Alert
    _registry.register(Capability(
      id: 'dialog.alert',
      handler: _showAlert,
    ));

    // Dialog Confirm
    _registry.register(Capability(
      id: 'dialog.confirm',
      handler: _showConfirm,
    ));

    // Loading 显示
    _registry.register(Capability(
      id: 'loading.show',
      handler: _showLoading,
    ));

    // Loading 隐藏
    _registry.register(Capability(
      id: 'loading.hide',
      handler: _hideLoading,
    ));

    // ===== 导航能力 =====

    // 打开页面
    _registry.register(Capability(
      id: 'navigation.open',
      handler: _navigateTo,
    ));

    // 返回上一页
    _registry.register(Capability(
      id: 'navigation.back',
      handler: _navigateBack,
    ));

    // 替换当前页面
    _registry.register(Capability(
      id: 'navigation.replace',
      handler: _navigateReplace,
    ));

    // ===== 存储能力 =====

    // 获取存储值
    _registry.register(Capability(
      id: 'storage.get',
      handler: _storageGet,
      requiredPermissions: ['storage.local'],
    ));

    // 设置存储值
    _registry.register(Capability(
      id: 'storage.set',
      handler: _storageSet,
      requiredPermissions: ['storage.local'],
    ));

    // 删除存储值
    _registry.register(Capability(
      id: 'storage.remove',
      handler: _storageRemove,
      requiredPermissions: ['storage.local'],
    ));

    // 清空存储
    _registry.register(Capability(
      id: 'storage.clear',
      handler: _storageClear,
      requiredPermissions: ['storage.local'],
    ));

    // ===== 剪贴板能力 =====

    // 写入剪贴板
    _registry.register(Capability(
      id: 'clipboard.write',
      handler: _clipboardWrite,
      requiredPermissions: ['clipboard.write'],
    ));

    // 读取剪贴板
    _registry.register(Capability(
      id: 'clipboard.read',
      handler: _clipboardRead,
      requiredPermissions: ['clipboard.read'],
    ));

    // ===== 通知能力 =====

    // 发送通知
    _registry.register(Capability(
      id: 'notification.send',
      handler: _sendNotification,
      requiredPermissions: ['notification.send'],
    ));
  }

  /// 设置插件权限
  void setPluginPermissions(String pluginId, List<String> permissions) {
    _pluginPermissions[pluginId] = permissions;
  }

  /// 获取插件权限
  List<String> getPluginPermissions(String pluginId) {
    return _pluginPermissions[pluginId] ?? [];
  }

  /// 处理能力调用
  Future<Map<String, dynamic>> handleInvoke({
    required String pluginId,
    required String method,
    required Map<String, dynamic> params,
  }) async {
    // 查找能力
    final capability = _registry.get(method);
    if (capability == null) {
      throw HostBridgeError.methodNotFound(method);
    }

    // 权限校验
    final pluginPermissions = getPluginPermissions(pluginId);
    final hasPermission = _permissionChecker.check(
      pluginPermissions: pluginPermissions,
      requiredPermissions: capability.requiredPermissions,
    );

    if (!hasPermission) {
      throw HostBridgeError.permissionDenied(
        method,
        capability.requiredPermissions,
      );
    }

    // 执行能力
    try {
      final result = await capability.handler(params);
      return {'success': true, 'data': result};
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  // ===== 能力实现 =====

  Future<Map<String, dynamic>> _showToast(Map<String, dynamic> params) async {
    final message = params['message'] as String? ?? '';
    final duration = params['duration'] as String? ?? 'short';

    // 获取当前 context
    final context = _getCurrentContext();
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration == 'long'
              ? const Duration(seconds: 3)
              : const Duration(seconds: 1),
        ),
      );
    }

    return {'shown': true};
  }

  Future<Map<String, dynamic>> _showAlert(Map<String, dynamic> params) async {
    final title = params['title'] as String? ?? '提示';
    final message = params['message'] as String? ?? '';

    final context = _getCurrentContext();
    if (context != null) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('确定'),
            ),
          ],
        ),
      );
    }

    return {'confirmed': true};
  }

  Future<Map<String, dynamic>> _showConfirm(Map<String, dynamic> params) async {
    final title = params['title'] as String? ?? '确认';
    final message = params['message'] as String? ?? '';

    final context = _getCurrentContext();
    bool confirmed = false;

    if (context != null) {
      confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('确定'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return {'confirmed': confirmed};
  }

  Future<Map<String, dynamic>> _showLoading(Map<String, dynamic> params) async {
    final message = params['message'] as String? ?? '加载中...';

    final context = _getCurrentContext();
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Text(message),
            ],
          ),
        ),
      );
    }

    return {'shown': true};
  }

  Future<Map<String, dynamic>> _hideLoading(Map<String, dynamic> params) async {
    final context = _getCurrentContext();
    if (context != null) {
      Navigator.pop(context);
    }
    return {'hidden': true};
  }

  Future<Map<String, dynamic>> _navigateTo(Map<String, dynamic> params) async {
    final route = params['route'] as String? ?? '/';
    final arguments = params['arguments'];

    final context = _getCurrentContext();
    if (context != null) {
      await Navigator.pushNamed(context, route, arguments: arguments);
    }

    return {'navigated': true};
  }

  Future<Map<String, dynamic>> _navigateBack(
      Map<String, dynamic> params) async {
    final context = _getCurrentContext();
    if (context != null) {
      Navigator.pop(context);
    }
    return {'navigated': true};
  }

  Future<Map<String, dynamic>> _navigateReplace(
    Map<String, dynamic> params,
  ) async {
    final route = params['route'] as String? ?? '/';
    final arguments = params['arguments'];

    final context = _getCurrentContext();
    if (context != null) {
      await Navigator.pushReplacementNamed(
        context,
        route,
        arguments: arguments,
      );
    }

    return {'navigated': true};
  }

  Future<Map<String, dynamic>> _storageGet(Map<String, dynamic> params) async {
    final key = params['key'] as String?;
    if (key == null) {
      throw ArgumentError('key is required');
    }

    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);

    return {'value': value};
  }

  Future<Map<String, dynamic>> _storageSet(Map<String, dynamic> params) async {
    final key = params['key'] as String?;
    final value = params['value']?.toString();

    if (key == null) {
      throw ArgumentError('key is required');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value ?? '');

    return {'saved': true};
  }

  Future<Map<String, dynamic>> _storageRemove(
    Map<String, dynamic> params,
  ) async {
    final key = params['key'] as String?;
    if (key == null) {
      throw ArgumentError('key is required');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);

    return {'removed': true};
  }

  Future<Map<String, dynamic>> _storageClear(
    Map<String, dynamic> params,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    return {'cleared': true};
  }

  Future<Map<String, dynamic>> _clipboardWrite(
    Map<String, dynamic> params,
  ) async {
    final text = params['text'] as String? ?? '';

    // TODO: 实现剪贴板写入
    // 需要使用 flutter/services 的 ClipboardData

    return {'written': true, 'text': text};
  }

  Future<Map<String, dynamic>> _clipboardRead(
    Map<String, dynamic> params,
  ) async {
    // TODO: 实现剪贴板读取
    // 需要使用 flutter/services 的 ClipboardData

    return {'text': ''};
  }

  Future<Map<String, dynamic>> _sendNotification(
    Map<String, dynamic> params,
  ) async {
    final title = params['title'] as String? ?? '';
    final body = params['body'] as String? ?? '';

    // TODO: 实现通知发送
    // 需要使用 flutter_local_notifications

    return {'sent': true, 'title': title, 'body': body};
  }

  /// 获取当前 Context
  BuildContext? _getCurrentContext() {
    return navigatorKey?.currentContext;
  }
}
