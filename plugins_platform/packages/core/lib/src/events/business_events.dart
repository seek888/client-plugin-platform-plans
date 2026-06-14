/// 业务事件常量
///
/// 定义所有业务相关的系统事件
class BusinessEvents {
  // ===== 审批事件 =====

  /// 审批创建
  static const String onApprovalCreated = 'onApprovalCreated';

  /// 审批状态变更
  static const String onApprovalStatusChanged = 'onApprovalStatusChanged';

  /// 审批被撤回
  static const String onApprovalWithdrawn = 'onApprovalWithdrawn';

  /// 审批被转发
  static const String onApprovalForwarded = 'onApprovalForwarded';

  /// 审批超时
  static const String onApprovalTimeout = 'onApprovalTimeout';

  // ===== IM 事件 =====

  /// 收到新消息
  static const String onMessageReceived = 'onMessageReceived';

  /// 消息已读回执
  static const String onMessageRead = 'onMessageRead';

  /// 聊天更新
  static const String onChatUpdated = 'onChatUpdated';

  /// 正在输入
  static const String onTyping = 'onTyping';

  // ===== 通讯录事件 =====

  /// 联系人更新
  static const String onContactUpdated = 'onContactUpdated';

  /// 联系人在线状态变化
  static const String onContactPresenceChanged = 'onContactPresenceChanged';

  /// 部门变更
  static const String onDepartmentChanged = 'onDepartmentChanged';

  /// 组织架构更新
  static const String onOrganizationUpdated = 'onOrganizationUpdated';

  // ===== 文件事件 =====

  /// 文件上传完成
  static const String onFileUploaded = 'onFileUploaded';

  /// 文件下载完成
  static const String onFileDownloaded = 'onFileDownloaded';

  /// 文件分享
  static const String onFileShared = 'onFileShared';

  /// 文件删除
  static const String onFileDeleted = 'onFileDeleted';

  // ===== 会议事件 =====

  /// 会议创建
  static const String onMeetingCreated = 'onMeetingCreated';

  /// 会议开始
  static const String onMeetingStarted = 'onMeetingStarted';

  /// 会议结束
  static const String onMeetingEnded = 'onMeetingEnded';

  /// 会议邀请
  static const String onMeetingInvited = 'onMeetingInvited';

  // ===== 日程事件 =====

  /// 日程创建
  static const String onEventCreated = 'onEventCreated';

  /// 日程更新
  static const String onEventUpdated = 'onEventUpdated';

  /// 日程提醒
  static const String onEventReminder = 'onEventReminder';

  // ===== 任务事件 =====

  /// 任务创建
  static const String onTaskCreated = 'onTaskCreated';

  /// 任务状态变更
  static const String onTaskStatusChanged = 'onTaskStatusChanged';

  /// 任务分配
  static const String onTaskAssigned = 'onTaskAssigned';

  /// 任务截止提醒
  static const String onTaskDue = 'onTaskDue';

  // ===== 客户/CRM 事件 =====

  /// 客户创建
  static const String onCustomerCreated = 'onCustomerCreated';

  /// 客户更新
  static const String onCustomerUpdated = 'onCustomerUpdated';

  /// 商机变更
  static const String onDealChanged = 'onDealChanged';

  /// 跟进记录
  static const String onActivityLogged = 'onActivityLogged';
}

/// 系统事件常量
class SystemEvents {
  /// 收到推送消息
  static const String onPushMessage = 'onPushMessage';
}

/// 事件优先级
enum EventPriority {
  /// 低优先级（后台日志类）
  low,

  /// 普通优先级（一般业务事件）
  normal,

  /// 高优先级（需要及时处理）
  high,

  /// 紧急（立即处理）
  urgent,
}

/// 事件过滤器配置
class EventFilterConfig {
  /// 事件名
  final String eventName;

  /// 过滤条件
  final Map<String, dynamic> filter;

  /// 是否只匹配特定值
  final String? matchValue;

  const EventFilterConfig({
    required this.eventName,
    this.filter = const {},
    this.matchValue,
  });

  /// 创建推送消息过滤器
  factory EventFilterConfig.pushMessage(String type) {
    return EventFilterConfig(
      eventName: SystemEvents.onPushMessage,
      filter: {'type': type},
    );
  }

  /// 创建自定义事件过滤器
  factory EventFilterConfig.customEvent(String eventName) {
    return EventFilterConfig(
      eventName: 'onEvent:$eventName',
    );
  }
}

/// 事件限流配置
class EventRateLimitConfig {
  /// 单个插件单事件最大频率（次/秒）
  final int maxRate;

  /// 单个插件事件队列最大长度
  final int maxQueueSize;

  /// 事件超时时间（毫秒）
  final int timeoutMs;

  const EventRateLimitConfig({
    this.maxRate = 10,
    this.maxQueueSize = 100,
    this.timeoutMs = 30000,
  });

  /// 默认配置
  static const EventRateLimitConfig defaultConfig = EventRateLimitConfig();
}
