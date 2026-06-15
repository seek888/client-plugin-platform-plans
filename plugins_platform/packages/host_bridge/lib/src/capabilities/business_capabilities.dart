import 'package:core/core.dart';

/// Account & Org 相关能力
class AccountCapabilities {
  /// 获取用户信息
  static Capability getUserProfile({
    required Future<Map<String, dynamic>> Function() handler,
  }) {
    return Capability(
      id: 'user.profile.get',
      requiredPermissions: ['user.profile.read'],
      handler: (params) async => await handler(),
    );
  }

  /// 更新用户信息
  static Capability updateUserProfile({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'user.profile.update',
      requiredPermissions: ['user.profile.write'],
      handler: handler,
    );
  }

  /// 搜索联系人
  static Capability searchContacts({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'org.contacts.search',
      requiredPermissions: ['org.contacts.read'],
      handler: handler,
    );
  }

  /// 获取联系人详情
  static Capability getContactById({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'org.contacts.getById',
      requiredPermissions: ['org.contacts.read'],
      handler: handler,
    );
  }

  /// 选择联系人
  ///
  /// 由 Flutter 宿主对接 IM/组织通讯录等业务数据源，插件只通过能力桥获取结果。
  static Capability pickContacts({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'org.contacts.pick',
      requiredPermissions: ['org.contacts.read'],
      handler: handler,
    );
  }

  /// 获取部门列表
  static Capability getDepartments({
    required Future<Map<String, dynamic>> Function() handler,
  }) {
    return Capability(
      id: 'org.department.list',
      requiredPermissions: ['org.department.read'],
      handler: (params) async => await handler(),
    );
  }
}

/// IM 相关能力
class IMCapabilities {
  /// 发送消息
  static Capability sendMessage({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'im.message.send',
      requiredPermissions: ['im.message.send'],
      handler: handler,
    );
  }

  /// 打开聊天
  static Capability openChat({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'im.chat.open',
      requiredPermissions: ['im.chat.read'],
      handler: handler,
    );
  }

  /// 搜索消息
  static Capability searchMessages({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'im.message.search',
      requiredPermissions: ['im.message.read'],
      handler: handler,
    );
  }

  /// 分享文件
  static Capability shareFile({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'im.file.share',
      requiredPermissions: ['im.message.send'],
      handler: handler,
    );
  }
}

/// 审批相关能力
class ApprovalCapabilities {
  /// 获取审批详情
  static Capability getApprovalDetail({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'approval.detail.get',
      requiredPermissions: ['approval.read'],
      handler: handler,
    );
  }

  /// 提交审批
  static Capability submitApproval({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'approval.submit',
      requiredPermissions: ['approval.write'],
      handler: handler,
    );
  }

  /// 获取审批列表
  static Capability getApprovalList({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'approval.list',
      requiredPermissions: ['approval.read'],
      handler: handler,
    );
  }

  /// 获取审批历史
  static Capability getApprovalHistory({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'approval.history',
      requiredPermissions: ['approval.read'],
      handler: handler,
    );
  }

  /// 撤销审批
  static Capability cancelApproval({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'approval.cancel',
      requiredPermissions: ['approval.write'],
      handler: handler,
    );
  }

  /// 转发审批
  static Capability forwardApproval({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'approval.forward',
      requiredPermissions: ['approval.write'],
      handler: handler,
    );
  }
}

/// 通知相关能力
class NotificationCapabilities {
  /// 发送通知
  static Capability sendNotification({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'notification.send',
      requiredPermissions: ['notification.send'],
      handler: handler,
    );
  }

  /// 取消通知
  static Capability cancelNotification({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'notification.cancel',
      requiredPermissions: ['notification.send'],
      handler: handler,
    );
  }

  /// 设置角标
  static Capability setBadge({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'notification.badge.set',
      requiredPermissions: ['notification.send'],
      handler: handler,
    );
  }

  /// 获取通知列表
  static Capability getNotifications({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'notification.list',
      requiredPermissions: ['notification.read'],
      handler: handler,
    );
  }

  /// 标记已读
  static Capability markAsRead({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'notification.markRead',
      requiredPermissions: ['notification.write'],
      handler: handler,
    );
  }
}

/// 设备相关能力
class DeviceCapabilities {
  /// 获取位置
  static Capability getLocation({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'device.location.get',
      requiredPermissions: ['device.location.read'],
      handler: handler,
    );
  }

  /// 扫码
  static Capability scanCode({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'device.camera.scan',
      requiredPermissions: ['device.camera.use'],
      handler: handler,
    );
  }

  /// 蓝牙扫描
  static Capability scanBluetooth({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'device.bluetooth.scan',
      requiredPermissions: ['device.bluetooth.use'],
      handler: handler,
    );
  }

  /// 获取设备信息
  static Capability getDeviceInfo({
    required Future<Map<String, dynamic>> Function() handler,
  }) {
    return Capability(
      id: 'device.info.get',
      requiredPermissions: ['device.info.read'],
      handler: (params) async => await handler(),
    );
  }

  /// 选择文件
  static Capability pickFile({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'file.pick',
      requiredPermissions: ['file.pick'],
      handler: handler,
    );
  }

  /// 上传文件
  static Capability uploadFile({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'file.upload',
      requiredPermissions: ['file.upload'],
      handler: handler,
    );
  }
}

/// 网络相关能力
class NetworkCapabilities {
  /// 发起网络请求（代理）
  static Capability request({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'network.request',
      requiredPermissions: ['network.request'],
      handler: handler,
    );
  }

  /// 上传文件
  static Capability upload({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'network.upload',
      requiredPermissions: ['network.request'],
      handler: handler,
    );
  }

  /// 下载文件
  static Capability download({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'network.download',
      requiredPermissions: ['network.request'],
      handler: handler,
    );
  }
}

/// UI 辅助能力
class UIHelperCapabilities {
  /// 显示加载状态
  static Capability showLoading({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'loading.show',
      handler: handler,
    );
  }

  /// 隐藏加载状态
  static Capability hideLoading({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'loading.hide',
      handler: handler,
    );
  }

  /// 显示底部表单
  static Capability showBottomSheet({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'bottomSheet.show',
      requiredPermissions: [],
      handler: handler,
    );
  }

  /// 显示选择器
  static Capability showPicker({
    required Future<Map<String, dynamic>> Function(Map<String, dynamic>)
        handler,
  }) {
    return Capability(
      id: 'picker.show',
      requiredPermissions: [],
      handler: handler,
    );
  }
}
