import 'package:flutter/material.dart';
import 'package:host_bridge/host_bridge.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'BottomSheet & Dialog Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late final HostBridge _hostBridge;
  String _result = '暂无结果';

  @override
  void initState() {
    super.initState();
    _hostBridge = HostBridge(navigatorKey: _navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomSheet & Dialog 测试')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _testBottomSheet,
              child: const Text('测试 BottomSheet'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _testCustomDialog,
              child: const Text('测试 Custom Dialog'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _testComplexForm,
              child: const Text('测试复杂表单 (BottomSheet)'),
            ),
            const SizedBox(height: 32),
            const Text('结果:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(child: Text(_result)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _testBottomSheet() async {
    try {
      final result = await _hostBridge.handleInvoke(
        pluginId: 'demo_plugin',
        method: 'bottomSheet.show',
        params: {
          'title': '创建事件',
          'schema': {
            'schemaVersion': '1.0',
            'type': 'page',
            'children': [
              {
                'type': 'textFormField',
                'id': 'title',
                'props': {'label': '标题', 'hint': '请输入事件标题'},
              },
              {
                'type': 'textarea',
                'id': 'description',
                'props': {'label': '描述', 'hint': '请输入事件描述', 'maxLines': 3},
              },
            ],
          },
        },
      );
      setState(() {
        _result = 'BottomSheet 结果:\n${_formatResult(result)}';
      });
    } catch (e) {
      setState(() {
        _result = '错误: $e';
      });
    }
  }

  Future<void> _testCustomDialog() async {
    try {
      final result = await _hostBridge.handleInvoke(
        pluginId: 'demo_plugin',
        method: 'dialog.custom',
        params: {
          'title': '确认操作',
          'schema': {
            'schemaVersion': '1.0',
            'type': 'page',
            'children': [
              {
                'type': 'text',
                'props': {'text': '确定要执行这个操作吗？'},
                'style': {'fontSize': 16.0},
              },
              {
                'type': 'sizedBox',
                'props': {'height': 16.0},
              },
              {
                'type': 'text',
                'props': {'text': '此操作无法撤销。'},
                'style': {'fontSize': 14.0, 'color': '#999999'},
              },
            ],
          },
          'actions': [
            {'id': 'cancel', 'text': '取消', 'type': 'cancel'},
            {'id': 'confirm', 'text': '确定', 'type': 'primary'},
          ],
        },
      );
      setState(() {
        _result = 'Dialog 结果:\n${_formatResult(result)}';
      });
    } catch (e) {
      setState(() {
        _result = '错误: $e';
      });
    }
  }

  Future<void> _testComplexForm() async {
    try {
      final result = await _hostBridge.handleInvoke(
        pluginId: 'demo_plugin',
        method: 'bottomSheet.show',
        params: {
          'title': '用户信息表单',
          'schema': {
            'schemaVersion': '1.0',
            'type': 'page',
            'children': [
              {
                'type': 'textFormField',
                'id': 'name',
                'props': {'label': '姓名', 'hint': '请输入姓名'},
              },
              {
                'type': 'textFormField',
                'id': 'email',
                'props': {
                  'label': '邮箱',
                  'hint': '请输入邮箱',
                  'keyboardType': 'email',
                },
              },
              {
                'type': 'dropdown',
                'id': 'department',
                'props': {
                  'label': '部门',
                  'options': [
                    {'label': '研发部', 'value': 'dev'},
                    {'label': '产品部', 'value': 'product'},
                    {'label': '设计部', 'value': 'design'},
                  ],
                },
              },
              {
                'type': 'checkbox',
                'id': 'agree',
                'props': {'label': '同意用户协议'},
              },
            ],
          },
        },
      );
      setState(() {
        _result = '复杂表单结果:\n${_formatResult(result)}';
      });
    } catch (e) {
      setState(() {
        _result = '错误: $e';
      });
    }
  }

  String _formatResult(Map<String, dynamic> result) {
    final buffer = StringBuffer();
    result.forEach((key, value) {
      buffer.writeln('$key: $value');
    });
    return buffer.toString();
  }
}
