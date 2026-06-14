/// 表单插件模板
///
/// 专用于表单处理的插件示例
import 'package:plugin_sdk/plugin_sdk.dart';

class MyFormPlugin extends FormPlugin {
  @override
  String get id => 'com.example.form';

  @override
  String get name => 'Form Plugin';

  @override
  String get description => 'A form plugin example';

  @override
  String get version => '1.0.0';

  @override
  List<FormFieldDefinition> get fields => [
    FormFieldDefinition(
      id: 'name',
      type: STACComponentTypes.textFormField,
      label: '姓名',
      required: true,
    ),
    FormFieldDefinition(
      id: 'email',
      type: STACComponentTypes.textFormField,
      label: '邮箱',
      required: true,
      validations: [
        STACValidation(type: 'required', message: '请输入邮箱'),
        STACValidation(type: 'pattern', value: r'^\w+@\w+', message: '邮箱格式不正确'),
      ],
    ),
    FormFieldDefinition(
      id: 'comment',
      type: STACComponentTypes.textarea,
      label: '备注',
    ),
  ];

  @override
  Future<Map<String, dynamic>> handleSubmit(Map<String, dynamic> data) async {
    // 处理表单提交
    return {'success': true, 'data': data};
  }

  @override
  Map<String, String>? validate(Map<String, dynamic> data) {
    final errors = <String, String>{};

    // 自定义校验逻辑
    final name = data['name'] as String?;
    if (name != null && name.length < 2) {
      errors['name'] = '姓名至少2个字符';
    }

    return errors.isEmpty ? null : errors;
  }

  @override
  STACSchema? renderPage(Map<String, dynamic> route) {
    return STACSchema(
      schemaVersion: currentStacSchemaVersion,
      type: 'page',
      title: '表单插件',
      layout: const STACLayout(
        type: 'column',
        padding: '16,16,16,16',
      ),
      children: [
        STACNode(
          type: STACComponentTypes.text,
          props: {'text': '请填写以下信息'},
          style: const STACStyle(fontSize: 16),
        ),
        ...fields.map((field) => STACNode(
              type: field.type,
              id: field.id,
              props: {
                'label': field.label,
                if (field.required) 'required': true,
                ...field.props,
              },
              validation: field.validations,
            )),
        STACNode(
          type: STACComponentTypes.button,
          id: 'btnSubmit',
          props: {'text': '提交'},
          events: {STACEventTypes.onTap: 'handleSubmit'},
          style: const STACStyle(marginTop: 16),
        ),
      ],
    );
  }

  /// 处理表单提交
  Future<STACUpdate?> handleSubmit(
    Map<String, dynamic> state,
    PluginContext context,
  ) async {
    final formData = state['form'] as Map<String, dynamic>?;

    if (formData != null) {
      final result = await handleSubmit(formData);

      await context.invokeHost('toast.show', {
        'message': result['success'] ? '提交成功！' : '提交失败',
      });

      if (result['success']) {
        return STACUpdate.patch([
          replace('/children/0/props/text', '提交成功！'),
        ]);
      }
    }

    return STACUpdate.none();
  }
}
