import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core/core.dart';
import 'capability_registry.dart';
import 'capabilities/business_capabilities.dart';
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

    // ===== 组织 / IM / 审批能力 =====
    _registry.register(AccountCapabilities.searchContacts(
      handler: _searchContacts,
    ));
    _registry.register(AccountCapabilities.getContactById(
      handler: _getContactById,
    ));
    _registry.register(AccountCapabilities.pickContacts(
      handler: _pickContacts,
    ));
    _registry.register(AccountCapabilities.getDepartments(
      handler: _getDepartments,
    ));
    _registry.register(ApprovalCapabilities.getApprovalList(
      handler: _getApprovalList,
    ));
    _registry.register(ApprovalCapabilities.getApprovalDetail(
      handler: _getApprovalDetail,
    ));
    _registry.register(ApprovalCapabilities.submitApproval(
      handler: _submitApproval,
    ));
    _registry.register(ApprovalCapabilities.getApprovalHistory(
      handler: _getApprovalHistory,
    ));
    _registry.register(ApprovalCapabilities.cancelApproval(
      handler: _cancelApproval,
    ));
    _registry.register(ApprovalCapabilities.forwardApproval(
      handler: _forwardApproval,
    ));
    _registry.register(NotificationCapabilities.sendNotification(
      handler: _sendNotification,
    ));
    _registry.register(NotificationCapabilities.cancelNotification(
      handler: _cancelNotification,
    ));
    _registry.register(NotificationCapabilities.setBadge(
      handler: _setBadge,
    ));
    _registry.register(NotificationCapabilities.getNotifications(
      handler: _getNotifications,
    ));
    _registry.register(NotificationCapabilities.markAsRead(
      handler: _markNotificationAsRead,
    ));
    _registry.register(NetworkCapabilities.request(
      handler: _networkRequest,
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

  Future<Map<String, dynamic>> _searchContacts(
    Map<String, dynamic> params,
  ) async {
    final keyword = (params['keyword'] as String? ?? '').trim().toLowerCase();
    final allContacts = _mockContacts();
    final matched = allContacts.where((contact) {
      if (keyword.isEmpty) return true;
      return contact['name'].toString().toLowerCase().contains(keyword) ||
          contact['department'].toString().toLowerCase().contains(keyword) ||
          contact['imId'].toString().toLowerCase().contains(keyword);
    }).toList(growable: false);
    return {'items': matched, 'total': matched.length};
  }

  Future<Map<String, dynamic>> _getContactById(
    Map<String, dynamic> params,
  ) async {
    final id = params['id']?.toString();
    final contact = _mockContacts().firstWhere(
      (item) => item['id'].toString() == id,
      orElse: () => <String, dynamic>{},
    );
    return {'item': contact};
  }

  Future<Map<String, dynamic>> _pickContacts(
    Map<String, dynamic> params,
  ) async {
    final selectedIds =
        (params['selectedIds'] as List?)?.map((e) => e.toString()).toList() ??
            const [];
    final multiple = params['multiple'] != false;
    final contacts = _mockContacts();
    final picked = contacts
        .where((contact) =>
            selectedIds.isEmpty ||
            selectedIds.contains(contact['id'].toString()))
        .take(multiple ? contacts.length : 1)
        .toList(growable: false);
    return {
      'items': picked.isNotEmpty
          ? picked
          : contacts.take(multiple ? 3 : 1).toList(growable: false),
      'multiple': multiple,
    };
  }

  Future<Map<String, dynamic>> _getDepartments() async {
    return {
      'items': [
        {'id': 'dept_product', 'name': '产品部'},
        {'id': 'dept_engineering', 'name': '研发部'},
        {'id': 'dept_hr', 'name': '人事部'},
      ]
    };
  }

  Future<Map<String, dynamic>> _getApprovalList(
    Map<String, dynamic> params,
  ) async {
    return {
      'items': [
        {
          'id': 'apr_1001',
          'title': '合同审批',
          'status': 'pending',
          'owner': '法务',
        },
        {
          'id': 'apr_1002',
          'title': '差旅报销',
          'status': 'approved',
          'owner': '财务',
        }
      ]
    };
  }

  Future<Map<String, dynamic>> _getApprovalDetail(
    Map<String, dynamic> params,
  ) async {
    final id = params['id']?.toString() ?? 'apr_1001';
    return {
      'item': {
        'id': id,
        'title': '合同审批',
        'status': 'pending',
        'steps': [
          {'name': '提交', 'state': 'done'},
          {'name': '法务审核', 'state': 'current'},
          {'name': '归档', 'state': 'todo'},
        ]
      }
    };
  }

  Future<Map<String, dynamic>> _submitApproval(
    Map<String, dynamic> params,
  ) async {
    return {'submitted': true, 'payload': params};
  }

  Future<Map<String, dynamic>> _getApprovalHistory(
    Map<String, dynamic> params,
  ) async {
    return {
      'items': [
        {'action': 'submitted', 'at': DateTime.now().toIso8601String()},
        {'action': 'approved', 'at': DateTime.now().toIso8601String()},
      ]
    };
  }

  Future<Map<String, dynamic>> _cancelApproval(
    Map<String, dynamic> params,
  ) async {
    return {'cancelled': true, 'payload': params};
  }

  Future<Map<String, dynamic>> _forwardApproval(
    Map<String, dynamic> params,
  ) async {
    return {'forwarded': true, 'payload': params};
  }

  Future<Map<String, dynamic>> _cancelNotification(
    Map<String, dynamic> params,
  ) async {
    return {'cancelled': true, 'payload': params};
  }

  Future<Map<String, dynamic>> _setBadge(Map<String, dynamic> params) async {
    return {'badge': params['count'] ?? 0};
  }

  Future<Map<String, dynamic>> _getNotifications(
    Map<String, dynamic> params,
  ) async {
    return {
      'items': [
        {'id': 'ntf_1', 'title': '待审批提醒', 'read': false},
        {'id': 'ntf_2', 'title': '会议开始前 10 分钟', 'read': true},
      ]
    };
  }

  Future<Map<String, dynamic>> _markNotificationAsRead(
    Map<String, dynamic> params,
  ) async {
    return {'marked': true, 'payload': params};
  }

  Future<Map<String, dynamic>> _networkRequest(
    Map<String, dynamic> params,
  ) async {
    final method = (params['method'] as String? ?? 'GET').toUpperCase();
    final url = params['url'] as String?;
    if (url == null || url.isEmpty) {
      throw ArgumentError('url is required');
    }

    final headers = _stringMap(params['headers']);
    final query = _stringMap(params['query']);
    final body = params['body'];
    final uri = Uri.parse(url).replace(
      queryParameters: query.isEmpty ? null : query,
    );

    final client = http.Client();
    try {
      late final http.Response response;
      switch (method) {
        case 'GET':
          response = await client.get(uri, headers: headers);
          break;
        case 'POST':
          response = await client.post(
            uri,
            headers: headers,
            body: body == null
                ? null
                : body is String
                    ? body
                    : jsonEncode(body),
          );
          break;
        default:
          throw ArgumentError('Unsupported method: $method');
      }

      return {
        'statusCode': response.statusCode,
        'headers': response.headers,
        'body': response.body,
        'json': _tryDecodeJson(response.body),
      };
    } finally {
      client.close();
    }
  }

  Map<String, String> _stringMap(dynamic value) {
    if (value is Map) {
      return value.map((key, value) => MapEntry(
            key.toString(),
            value?.toString() ?? '',
          ));
    }
    return const {};
  }

  dynamic _tryDecodeJson(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }

  List<Map<String, dynamic>> _mockContacts() {
    return const [
      {
        'id': 'u_1001',
        'name': '张三',
        'department': '产品部',
        'imId': 'zhangsan',
        'avatar': '',
      },
      {
        'id': 'u_1002',
        'name': '李四',
        'department': '研发部',
        'imId': 'lisi',
        'avatar': '',
      },
      {
        'id': 'u_1003',
        'name': '王五',
        'department': '法务部',
        'imId': 'wangwu',
        'avatar': '',
      },
      {
        'id': 'u_1004',
        'name': '赵敏',
        'department': '财务部',
        'imId': 'zhaomin',
        'avatar': '',
      },
    ];
  }

  /// 获取当前 Context
  BuildContext? _getCurrentContext() {
    return navigatorKey?.currentContext;
  }
}
