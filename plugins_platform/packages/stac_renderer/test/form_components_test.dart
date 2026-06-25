import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stac_renderer/stac_renderer.dart';

void main() {
  group('高级表单组件测试', () {
    testWidgets('dropdown 组件渲染测试', (WidgetTester tester) async {
      final schema = STACSchema.fromJson({
        'schemaVersion': '1.0',
        'type': 'page',
        'children': [
          {
            'type': 'dropdown',
            'id': 'test-dropdown',
            'props': {
              'label': '选择部门',
              'options': [
                {'value': 'dept1', 'label': '产品部'},
                {'value': 'dept2', 'label': '研发部'},
              ],
              'initialValue': 'dept1',
            },
          },
        ],
      });

      final formKey = STACFormKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: STACRenderer.render(schema, formKey: formKey)),
        ),
      );

      expect(find.text('选择部门'), findsOneWidget);
      expect(formKey.getValue('test-dropdown'), equals('dept1'));
    });

    testWidgets('switch 组件渲染测试', (WidgetTester tester) async {
      final schema = STACSchema.fromJson({
        'schemaVersion': '1.0',
        'type': 'page',
        'children': [
          {
            'type': 'switch',
            'id': 'test-switch',
            'props': {'label': '启用通知', 'initialValue': true},
          },
        ],
      });

      final formKey = STACFormKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: STACRenderer.render(schema, formKey: formKey)),
        ),
      );

      expect(find.text('启用通知'), findsOneWidget);
      expect(formKey.getValue('test-switch'), equals(true));
    });

    testWidgets('radioGroup 组件渲染测试', (WidgetTester tester) async {
      final schema = STACSchema.fromJson({
        'schemaVersion': '1.0',
        'type': 'page',
        'children': [
          {
            'type': 'radioGroup',
            'id': 'test-radio',
            'props': {
              'label': '选择性别',
              'options': [
                {'value': 'male', 'label': '男'},
                {'value': 'female', 'label': '女'},
                {'value': 'other', 'label': '其他'},
              ],
              'initialValue': 'male',
            },
          },
        ],
      });

      final formKey = STACFormKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: STACRenderer.render(schema, formKey: formKey)),
        ),
      );

      expect(find.text('选择性别'), findsOneWidget);
      expect(find.text('男'), findsOneWidget);
      expect(find.text('女'), findsOneWidget);
      expect(find.text('其他'), findsOneWidget);
      expect(formKey.getValue('test-radio'), equals('male'));
    });

    testWidgets('checkboxGroup 组件渲染测试', (WidgetTester tester) async {
      final schema = STACSchema.fromJson({
        'schemaVersion': '1.0',
        'type': 'page',
        'children': [
          {
            'type': 'checkboxGroup',
            'id': 'test-checkbox',
            'props': {
              'label': '选择兴趣爱好',
              'options': [
                {'value': 'sports', 'label': '运动'},
                {'value': 'music', 'label': '音乐'},
                {'value': 'reading', 'label': '阅读'},
              ],
              'initialValue': ['music', 'reading'],
            },
          },
        ],
      });

      final formKey = STACFormKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: STACRenderer.render(schema, formKey: formKey)),
        ),
      );

      expect(find.text('选择兴趣爱好'), findsOneWidget);
      expect(find.text('运动'), findsOneWidget);
      expect(find.text('音乐'), findsOneWidget);
      expect(find.text('阅读'), findsOneWidget);

      final value = formKey.getValue('test-checkbox');
      expect(value, isA<List>());
      expect((value as List).toSet(), equals({'music', 'reading'}));
    });

    testWidgets('所有表单组件集成测试', (WidgetTester tester) async {
      final schema = STACSchema.fromJson({
        'schemaVersion': '1.0',
        'type': 'page',
        'children': [
          {
            'type': 'column',
            'props': {'spacing': 16.0},
            'children': [
              {
                'type': 'dropdown',
                'id': 'dept',
                'props': {
                  'label': '部门',
                  'options': [
                    {'value': 'd1', 'label': '产品部'},
                    {'value': 'd2', 'label': '研发部'},
                  ],
                },
              },
              {
                'type': 'switch',
                'id': 'notify',
                'props': {'label': '通知', 'initialValue': false},
              },
              {
                'type': 'radioGroup',
                'id': 'gender',
                'props': {
                  'label': '性别',
                  'options': [
                    {'value': 'm', 'label': '男'},
                    {'value': 'f', 'label': '女'},
                  ],
                  'initialValue': 'm',
                },
              },
              {
                'type': 'checkboxGroup',
                'id': 'hobbies',
                'props': {
                  'label': '爱好',
                  'options': [
                    {'value': 's', 'label': '运动'},
                    {'value': 'm', 'label': '音乐'},
                  ],
                  'initialValue': ['s'],
                },
              },
            ],
          },
        ],
      });

      final formKey = STACFormKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: STACRenderer.render(schema, formKey: formKey)),
        ),
      );

      // 验证所有组件都能渲染
      expect(find.text('部门'), findsOneWidget);
      expect(find.text('通知'), findsOneWidget);
      expect(find.text('性别'), findsOneWidget);
      expect(find.text('爱好'), findsOneWidget);

      // 验证表单值
      final values = formKey.getValues();
      expect(values['notify'], equals(false));
      expect(values['gender'], equals('m'));
      expect(values['hobbies'], isA<List>());
    });
  });
}
