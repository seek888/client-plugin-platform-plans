/// 事件驱动插件模板
///
/// 响应系统事件和业务事件的插件示例
import 'package:plugin_sdk/plugin_sdk.dart';

class MyEventDrivenPlugin extends SimplePlugin {
  @override
  String get id => 'com.example.event_driven';

  @override
  String get name => 'Event Driven Plugin';

  @override
  String get description => 'An event-driven plugin example';

  @override
  String get version => '1.0.0';

  /// 激活事件列表
  static const List<String> activationEvents = [
    'onApprovalCreated',
    'onMessageReceived',
    'onEvent:custom.event',
  ];

  @override
  void onActivate(PluginContext context) {
    context.log('Event-driven plugin activated');

    // 订阅感兴趣的事件
    context.subscribe('onApprovalCreated', _onApprovalCreated);
    context.subscribe('onMessageReceived', _onMessageReceived);
  }

  @override
  void onDeactivate() {
    // 取消订阅
  }

  /// 处理审批创建事件
  void _onApprovalCreated(dynamic event) {
    final payload = event as Map<String, dynamic>;
    print('Approval created: ${payload['orderId']}');

    // 可以调用宿主能力发送通知
    // context.invokeHost('notification.send', {...});
  }

  /// 处理消息接收事件
  void _onMessageReceived(dynamic event) {
    final payload = event as Map<String, dynamic>;
    print('Message received from ${payload['senderId']}');
  }

  /// 处理自定义事件
  void onCustomEvent(
    Map<String, dynamic> event,
    PluginContext context,
  ) async {
    await context.invokeHost('toast.show', {
      'message': 'Custom event received: ${event['type']}',
    });
  }

  /// 渲染配置页面
  @override
  STACSchema? renderPage(Map<String, dynamic> route) {
    return STACSchema(
      schemaVersion: currentStacSchemaVersion,
      type: 'page',
      title: '事件驱动插件',
      layout: const STACLayout(
        type: 'column',
        padding: '16,16,16,16',
      ),
      children: [
        STACNode(
          type: STACComponentTypes.text,
          props: {'text': '此插件响应以下事件:'},
        ),
        ...activationEvents.map((event) => STACNode(
              type: STACComponentTypes.text,
              props: {'text': '• $event'},
              style: const STACStyle(fontSize: 14),
            )),
        STACNode(
          type: STACComponentTypes.button,
          id: 'btnTest',
          props: {'text': '触发自定义事件'},
          events: {STACEventTypes.onTap: 'handleTestEvent'},
          style: const STACStyle(marginTop: 16),
        ),
      ],
    );
  }

  /// 处理测试事件
  Future<STACUpdate?> handleTestEvent(
    Map<String, dynamic> state,
    PluginContext context,
  ) async {
    await context.publishEvent('custom.event', {
      'type': 'test',
      'timestamp': DateTime.now().toIso8601String(),
    });

    await context.invokeHost('toast.show', {
      'message': '自定义事件已发布',
    });

    return STACUpdate.none();
  }
}
