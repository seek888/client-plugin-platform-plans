/// 全功能插件模板
///
/// 展示所有插件功能的完整示例
import 'package:plugin_sdk/plugin_sdk.dart';

class MyFullFeaturedPlugin extends StatefulPlugin {
  @override
  String get id => 'com.example.full_featured';

  @override
  String get name => 'Full Featured Plugin';

  @override
  String get description => 'A full-featured plugin example';

  @override
  String get version => '1.0.0';

  @override
  void onActivate(PluginContext context) {
    // 初始化状态
    setState({
      'counter': 0,
      'lastUpdated': DateTime.now().toIso8601String(),
    });

    context.log('Full-featured plugin activated');
  }

  @override
  void onDeactivate() {
    // 清理资源
  }

  @override
  STACSchema? renderPage(Map<String, dynamic> route) {
    final counter = getState<int>('counter') ?? 0;

    return STACSchema(
      schemaVersion: currentStacSchemaVersion,
      type: 'page',
      title: '全功能插件',
      layout: const STACLayout(
        type: 'column',
        padding: '16,16,16,16',
        scrollable: true,
      ),
      dataSources: {
        'currentTime': STACDataSource(
          sourceType: 'capability',
          capability: 'system.time.get',
          defaultValue: DateTime.now().toIso8601String(),
        ),
      },
      children: [
        // 状态展示
        STACNode(
          type: STACComponentTypes.card,
          children: [
            STACNode(
              type: STACComponentTypes.text,
              props: {'text': '计数器: $counter'},
              style: const STACStyle(fontSize: 24, fontWeight: 'bold'),
            ),
            STACNode(
              type: STACComponentTypes.row,
              children: [
                STACNode(
                  type: STACComponentTypes.button,
                  id: 'btnDec',
                  props: {'text': '-'},
                  events: {STACEventTypes.onTap: 'handleDecrement'},
                ),
                STACNode(
                  type: STACComponentTypes.sizedBox,
                  props: {'width': 16},
                ),
                STACNode(
                  type: STACComponentTypes.button,
                  id: 'btnInc',
                  props: {'text': '+'},
                  events: {STACEventTypes.onTap: 'handleIncrement'},
                ),
              ],
            ),
          ],
        ),

        // 表单示例
        STACNode(
          type: STACComponentTypes.card,
          style: const STACStyle(marginTop: 16),
          children: [
            STACNode(
              type: STACComponentTypes.textFormField,
              id: 'inputName',
              props: {'label': '输入名称', 'hint': '请输入名称'},
              validation: [
                STACValidation(type: 'required', message: '请输入名称'),
              ],
            ),
            STACNode(
              type: STACComponentTypes.textarea,
              id: 'inputDesc',
              props: {'label': '描述', 'maxLines': 3},
            ),
            STACNode(
              type: STACComponentTypes.checkbox,
              id: 'checkAgree',
              props: {'label': '我同意条款', 'value': false},
            ),
            STACNode(
              type: STACComponentTypes.button,
              id: 'btnSubmit',
              props: {'text': '提交'},
              events: {STACEventTypes.onTap: 'handleSubmit'},
              style: const STACStyle(marginTop: 8),
            ),
          ],
        ),

        // 列表示例
        STACNode(
          type: STACComponentTypes.card,
          style: const STACStyle(marginTop: 16),
          children: [
            STACNode(
              type: STACComponentTypes.text,
              props: {'text': '项目列表'},
              style: const STACStyle(fontSize: 18, fontWeight: 'bold'),
            ),
            STACNode(
              type: STACComponentTypes.listView,
              children: [
                STACNode(
                  type: STACComponentTypes.listItem,
                  children: [
                    STACNode(
                      type: STACComponentTypes.text,
                      props: {'text': '项目 1'},
                    ),
                    STACNode(
                      type: STACComponentTypes.button,
                      id: 'btnItem1',
                      props: {'text': '查看'},
                      events: {STACEventTypes.onTap: 'handleItemClick'},
                    ),
                  ],
                ),
                STACNode(
                  type: STACComponentTypes.listItem,
                  children: [
                    STACNode(
                      type: STACComponentTypes.text,
                      props: {'text': '项目 2'},
                    ),
                    STACNode(
                      type: STACComponentTypes.button,
                      id: 'btnItem2',
                      props: {'text': '查看'},
                      events: {STACEventTypes.onTap: 'handleItemClick'},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // 操作按钮
        STACNode(
          type: STACComponentTypes.card,
          style: const STACStyle(marginTop: 16),
          children: [
            STACNode(
              type: STACComponentTypes.button,
              id: 'btnRefresh',
              props: {'text': '刷新数据'},
              events: {STACEventTypes.onTap: 'handleRefresh'},
            ),
            STACNode(
              type: STACComponentTypes.button,
              id: 'btnReset',
              props: {'text': '重置状态'},
              events: {STACEventTypes.onTap: 'handleReset'},
            ),
          ],
        ),
      ],
    );
  }

  /// 增加计数
  Future<STACUpdate?> handleIncrement(
    Map<String, dynamic> state,
    PluginContext context,
  ) async {
    final counter = (getState<int>('counter') ?? 0) + 1;
    setState({'counter': counter});

    return STACUpdate.patch([
      replace('/children/0/children/0/props/text', '计数器: $counter'),
    ]);
  }

  /// 减少计数
  Future<STACUpdate?> handleDecrement(
    Map<String, dynamic> state,
    PluginContext context,
  ) async {
    final counter = (getState<int>('counter') ?? 0) - 1;
    setState({'counter': counter});

    return STACUpdate.patch([
      replace('/children/0/children/0/props/text', '计数器: $counter'),
    ]);
  }

  /// 提交表单
  Future<STACUpdate?> handleSubmit(
    Map<String, dynamic> state,
    PluginContext context,
  ) async {
    final formData = state['form'] as Map<String, dynamic>?;

    if (formData != null) {
      await context.invokeHost('toast.show', {
        'message': '表单提交成功！',
      });

      return STACUpdate.none();
    } else {
      await context.invokeHost('dialog.alert', {
        'title': '提示',
        'message': '请填写表单',
      });

      return STACUpdate.none();
    }
  }

  /// 处理项目点击
  Future<STACUpdate?> handleItemClick(
    Map<String, dynamic> state,
    PluginContext context,
  ) async {
    final nodeId = state['nodeId'] as String?;

    await context.invokeHost('toast.show', {
      'message': '点击了 $nodeId',
    });

    return STACUpdate.none();
  }

  /// 刷新数据
  Future<STACUpdate?> handleRefresh(
    Map<String, dynamic> state,
    PluginContext context,
  ) async {
    setState({'lastUpdated': DateTime.now().toIso8601String()});

    await context.invokeHost('toast.show', {
      'message': '数据已刷新',
    });

    return STACUpdate.full(
      renderPage({'route': 'refresh'}).toJson(),
    );
  }

  /// 重置状态
  Future<STACUpdate?> handleReset(
    Map<String, dynamic> state,
    PluginContext context,
  ) async {
    setState({
      'counter': 0,
      'lastUpdated': DateTime.now().toIso8601String(),
    });

    await context.invokeHost('toast.show', {
      'message': '状态已重置',
    });

    return STACUpdate.full(
      renderPage({'route': 'reset'}).toJson(),
    );
  }

  /// 渲染卡片
  @override
  STACSchema? renderCard(Map<String, dynamic> context) {
    final counter = getState<int>('counter') ?? 0;

    return STACSchema(
      schemaVersion: currentStacSchemaVersion,
      type: 'card',
      children: [
        STACNode(
          type: STACComponentTypes.text,
          props: {'text': '计数: $counter'},
          style: const STACStyle(fontSize: 20),
        ),
        STACNode(
          type: STACComponentTypes.button,
          id: 'btnCardInc',
          props: {'text': '+'},
          events: {STACEventTypes.onTap: 'handleIncrement'},
        ),
      ],
    );
  }
}
