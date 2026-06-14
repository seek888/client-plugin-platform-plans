/// 基础插件模板
///
/// 最简单的插件示例
import 'package:plugin_sdk/plugin_sdk.dart';

class MyBasicPlugin extends SimplePlugin {
  @override
  String get id => 'com.example.basic';

  @override
  String get name => 'Basic Plugin';

  @override
  String get description => 'A basic plugin example';

  @override
  String get version => '1.0.0';

  @override
  void onActivate(PluginContext context) {
    context.log('Basic plugin activated!');
  }

  @override
  void onDeactivate() {
    // 清理资源
  }

  @override
  STACSchema? renderPage(Map<String, dynamic> route) {
    return STACSchema(
      schemaVersion: currentStacSchemaVersion,
      type: 'page',
      title: 'Basic Plugin',
      layout: const STACLayout(
        type: 'column',
        padding: '16,16,16,16',
      ),
      children: [
        STACNode(
          type: STACComponentTypes.text,
          props: {'text': 'Hello from Basic Plugin!'},
          style: const STACStyle(fontSize: 18),
        ),
        STACNode(
          type: STACComponentTypes.button,
          id: 'btnClick',
          props: {'text': 'Click Me'},
          events: {STACEventTypes.onTap: 'handleClick'},
        ),
      ],
    );
  }

  /// 处理按钮点击
  Future<STACUpdate?> handleClick(
    Map<String, dynamic> state,
    PluginContext context,
  ) async {
    await context.invokeHost('toast.show', {
      'message': 'Button clicked!',
    });
    return STACUpdate.none();
  }
}
