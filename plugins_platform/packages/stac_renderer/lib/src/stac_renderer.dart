import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// STAC 渲染器。
///
/// 对外保留平台原有的 [STACSchema] / [STACNode] API，内部直接生成
/// Flutter Widget，不再依赖官方 STAC 解析链路。
class STACRenderer {
  static Future<void> initialize() async {}

  /// 渲染 Schema 为 Widget。
  static Widget render(
    STACSchema schema, {
    Map<String, dynamic>? data,
    STACEventHandler? eventHandler,
    STACFormKey? formKey,
  }) {
    return _STACSchemaWidget(
      sourceJson: _deepJsonMap(schema.toJson()),
      sourceType: _STACSourceType.schema,
      data: data ?? const {},
      eventHandler: eventHandler,
      formKey: formKey,
    );
  }

  /// 渲染单个节点。
  static Widget renderNode(
    STACNode node, {
    Map<String, dynamic>? data,
    STACEventHandler? eventHandler,
    STACFormKey? formKey,
  }) {
    return _STACSchemaWidget(
      sourceJson: _deepJsonMap(node.toJson()),
      sourceType: _STACSourceType.node,
      data: data ?? const {},
      eventHandler: eventHandler,
      formKey: formKey,
    );
  }
}

Map<String, dynamic> _deepJsonMap(Map<String, dynamic> value) {
  return Map<String, dynamic>.from(jsonDecode(jsonEncode(value)) as Map);
}

/// 事件处理器签名。
typedef STACEventHandler = Future<STACUpdate?> Function(
    String eventName, Map<String, dynamic> params);

/// 表单 Key。
class STACFormKey {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final Map<String, dynamic> _values = {};

  /// 获取表单字段的当前值。
  dynamic getValue(String id) => _values[id];

  /// 设置表单值。
  void setValue(String id, dynamic value) {
    _values[id] = value;
  }

  /// 获取表单值。
  Map<String, dynamic> getValues() {
    key.currentState?.save();
    return Map<String, dynamic>.unmodifiable(_values);
  }

  /// 验证表单。
  bool validate() {
    final state = key.currentState;
    return state?.validate() ?? false;
  }
}

enum _STACSourceType { schema, node }

class _STACSchemaWidget extends StatefulWidget {
  const _STACSchemaWidget({
    required this.sourceJson,
    required this.sourceType,
    required this.data,
    this.eventHandler,
    this.formKey,
  });

  final Map<String, dynamic> sourceJson;
  final _STACSourceType sourceType;
  final Map<String, dynamic> data;
  final STACEventHandler? eventHandler;
  final STACFormKey? formKey;

  @override
  State<_STACSchemaWidget> createState() => _STACSchemaWidgetState();
}

class _STACSchemaWidgetState extends State<_STACSchemaWidget> {
  late Map<String, dynamic> _sourceJson;

  @override
  void initState() {
    super.initState();
    _sourceJson = Map<String, dynamic>.from(widget.sourceJson);
  }

  @override
  void didUpdateWidget(covariant _STACSchemaWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sourceJson != widget.sourceJson ||
        oldWidget.sourceType != widget.sourceType) {
      _sourceJson = Map<String, dynamic>.from(widget.sourceJson);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = widget.formKey;
    final child = _buildNode(
      context,
      _sourceJson,
      data: widget.data,
      onEvent: _handleEvent,
      formKey: formKey,
    );

    return _PluginEventScope(
      data: widget.data,
      formKey: formKey,
      eventHandler: _handleEvent,
      child: formKey == null ? child : Form(key: formKey.key, child: child),
    );
  }

  Future<STACUpdate?> _handleEvent(
    String eventName,
    Map<String, dynamic> params,
  ) async {
    final update = await widget.eventHandler?.call(eventName, params);
    if (!mounted || update == null) return update;

    if (update.type == STACUpdateType.full && update.schema != null) {
      setState(() {
        _sourceJson = Map<String, dynamic>.from(update.schema!);
      });
    } else if (update.type == STACUpdateType.patch && update.patches != null) {
      final patched = _applyPatches(_sourceJson, update.patches!);
      setState(() {
        _sourceJson = patched;
      });
    }

    return update;
  }
}

class _PluginEventScope extends InheritedWidget {
  const _PluginEventScope({
    required this.data,
    required this.formKey,
    required this.eventHandler,
    required super.child,
  });

  final Map<String, dynamic> data;
  final STACFormKey? formKey;
  final STACEventHandler eventHandler;

  @override
  bool updateShouldNotify(_PluginEventScope oldWidget) {
    return data != oldWidget.data ||
        formKey != oldWidget.formKey ||
        eventHandler != oldWidget.eventHandler;
  }
}

Widget _buildNode(
  BuildContext context,
  Map<String, dynamic> node, {
  required Map<String, dynamic> data,
  required STACEventHandler? onEvent,
  required STACFormKey? formKey,
}) {
  final type = node['type'] as String? ?? 'unknown';
  final props = Map<String, dynamic>.from(node['props'] as Map? ?? const {});
  final children = _buildChildren(
    context,
    node['children'],
    data: data,
    onEvent: onEvent,
    formKey: formKey,
  );
  final style = Map<String, dynamic>.from(node['style'] as Map? ?? const {});
  final body = _buildNodeCore(
    context,
    type,
    node,
    props,
    children,
    data: data,
    onEvent: onEvent,
    formKey: formKey,
  );

  final styled = _applyNodeStyle(body, style);
  if (_shouldWrapTap(type, node)) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _buildTapHandler(
        context,
        node,
        eventName: STACEventTypes.onTap,
        onEvent: onEvent,
        data: data,
        formKey: formKey,
      ),
      child: styled,
    );
  }

  return styled;
}

List<Widget> _buildChildren(
  BuildContext context,
  dynamic value, {
  required Map<String, dynamic> data,
  required STACEventHandler? onEvent,
  required STACFormKey? formKey,
}) {
  final children = value is List ? value : const [];
  return children
      .whereType<Map>()
      .map(
        (node) => _buildNode(
          context,
          Map<String, dynamic>.from(node),
          data: data,
          onEvent: onEvent,
          formKey: formKey,
        ),
      )
      .toList(growable: false);
}

Widget _buildNodeCore(
  BuildContext context,
  String type,
  Map<String, dynamic> node,
  Map<String, dynamic> props,
  List<Widget> children, {
  required Map<String, dynamic> data,
  required STACEventHandler? onEvent,
  required STACFormKey? formKey,
}) {
  switch (type) {
    case 'page':
      return _buildPage(node, children);
    case 'dialog':
      return AlertDialog(
        title: node['title'] == null ? null : Text(node['title'].toString()),
        content: _buildLayout(node['layout'] as Map?, children),
      );
    case STACComponentTypes.container:
      return _buildContainer(children, props);
    case STACComponentTypes.scaffold:
      return Scaffold(
        appBar: props['title'] == null
            ? null
            : AppBar(title: Text(props['title'].toString())),
        body: _vertical(children),
      );
    case STACComponentTypes.appBar:
      return AppBar(title: Text(props['title']?.toString() ?? ''));
    case STACComponentTypes.column:
      return _buildColumn(children, props);
    case STACComponentTypes.row:
      return _buildRow(children, props);
    case STACComponentTypes.stack:
      return Stack(children: children);
    case STACComponentTypes.expanded:
      return Expanded(
        child: children.isNotEmpty ? children.first : const SizedBox.shrink(),
      );
    case STACComponentTypes.sizedBox:
      return SizedBox(
        width: _toDouble(props['width']),
        height: _toDouble(props['height']),
      );
    case STACComponentTypes.text:
      return _buildText(props, node['style'] as Map?);
    case STACComponentTypes.image:
      return _buildImage(props);
    case STACComponentTypes.icon:
      return Icon(
        _iconData(props['icon']),
        size: _toDouble(props['size']),
        color: _parseColor(props['color']),
      );
    case STACComponentTypes.divider:
      return const Divider(height: 1);
    case STACComponentTypes.textFormField:
    case STACComponentTypes.textarea:
      return _buildTextFormField(node, props, formKey);
    case STACComponentTypes.dropdown:
      return _FormDropdownField(node: node, props: props, formKey: formKey);
    case STACComponentTypes.checkbox:
      return _FormCheckboxField(node: node, props: props, formKey: formKey);
    case STACComponentTypes.checkboxGroup:
      return _FormCheckboxGroupField(
        node: node,
        props: props,
        formKey: formKey,
      );
    case STACComponentTypes.radio:
      return _FormRadioField(node: node, props: props, formKey: formKey);
    case STACComponentTypes.radioGroup:
      return _FormRadioGroupField(node: node, props: props, formKey: formKey);
    case STACComponentTypes.switch_:
      return _FormSwitchField(node: node, props: props, formKey: formKey);
    case STACComponentTypes.slider:
      return _FormSliderField(node: node, props: props, formKey: formKey);
    case STACComponentTypes.button:
      return ElevatedButton(
        onPressed: _buildTapHandler(
          context,
          node,
          eventName: STACEventTypes.onTap,
          onEvent: onEvent,
          data: data,
          formKey: formKey,
        ),
        child: Text(props['text']?.toString() ?? 'Button'),
      );
    case STACComponentTypes.iconButton:
      return IconButton(
        onPressed: _buildTapHandler(
          context,
          node,
          eventName: STACEventTypes.onTap,
          onEvent: onEvent,
          data: data,
          formKey: formKey,
        ),
        icon: Icon(_iconData(props['icon'])),
      );
    case STACComponentTypes.fab:
      return FloatingActionButton(
        onPressed: _buildTapHandler(
          context,
          node,
          eventName: STACEventTypes.onTap,
          onEvent: onEvent,
          data: data,
          formKey: formKey,
        ),
        child: Icon(_iconData(props['icon'] ?? 'add')),
      );
    case STACComponentTypes.listView:
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: children,
      );
    case STACComponentTypes.gridView:
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: _toInt(props['crossAxisCount']) ?? 2,
        mainAxisSpacing: _toDouble(props['spacing']) ??
            _toDouble(props['mainAxisSpacing']) ??
            8,
        crossAxisSpacing: _toDouble(props['spacing']) ??
            _toDouble(props['crossAxisSpacing']) ??
            8,
        childAspectRatio: _toDouble(props['childAspectRatio']) ?? 1,
        children: children,
      );
    case STACComponentTypes.card:
      return Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _vertical(children),
        ),
      );
    default:
      return const SizedBox.shrink();
  }
}

Widget _buildPage(Map<String, dynamic> schema, List<Widget> children) {
  final title = schema['title']?.toString();
  return Scaffold(
    appBar: title == null ? null : AppBar(title: Text(title)),
    body: _buildLayout(schema['layout'] as Map?, children),
  );
}

Widget _buildLayout(Map<dynamic, dynamic>? layout, List<Widget> children) {
  if (layout == null) return _vertical(children);

  final props = Map<String, dynamic>.from(layout);
  Widget result;
  switch (props['type']?.toString()) {
    case 'row':
      result = _buildRow(children, props);
      break;
    case 'grid':
      result = GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: _toInt(props['crossAxisCount']) ?? 2,
        mainAxisSpacing: _toDouble(props['spacing']) ?? 8,
        crossAxisSpacing:
            _toDouble(props['runSpacing']) ?? _toDouble(props['spacing']) ?? 8,
        childAspectRatio: _toDouble(props['aspectRatio']) ?? 1,
        children: children,
      );
      break;
    case 'stack':
      result = Stack(children: children);
      break;
    case 'column':
    default:
      result = _buildColumn(children, props);
      break;
  }

  final padding = _edgeInsets(props['padding']);
  if (padding != null) {
    result = Padding(padding: padding, child: result);
  }

  if (props['scrollable'] == true) {
    result = SingleChildScrollView(child: result);
  }

  return result;
}

Widget _buildContainer(List<Widget> children, Map<String, dynamic> props) {
  final child = children.isEmpty
      ? const SizedBox.shrink()
      : children.length == 1
          ? children.first
          : _vertical(children);

  return Container(
    width: _toDouble(props['width']),
    height: _toDouble(props['height']),
    alignment: _alignment(props['alignment']),
    padding: _edgeInsets(props['padding']),
    margin: _edgeInsets(props['margin']),
    decoration: _boxDecoration(props),
    child: child,
  );
}

Widget _buildColumn(List<Widget> children, Map<String, dynamic> props) {
  return Column(
    mainAxisAlignment: _mainAxisAlignment(props['mainAxisAlignment']),
    crossAxisAlignment: _crossAxisAlignment(props['crossAxisAlignment']) ??
        CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: _withSpacing(children, _toDouble(props['spacing'])),
  );
}

Widget _buildRow(List<Widget> children, Map<String, dynamic> props) {
  return Row(
    mainAxisAlignment: _mainAxisAlignment(props['mainAxisAlignment']),
    crossAxisAlignment: _crossAxisAlignment(props['crossAxisAlignment']) ??
        CrossAxisAlignment.center,
    children: _withSpacing(
      children,
      _toDouble(props['spacing']),
      horizontal: true,
    ),
  );
}

Widget _buildText(Map<String, dynamic> props, Map<dynamic, dynamic>? style) {
  final text = props['text']?.toString() ?? '';
  final textStyle = TextStyle(
    fontSize: _toDouble(style?['fontSize']),
    color: _parseColor(style?['color']),
    fontWeight: _fontWeight(style?['fontWeight']),
    decoration: _textDecoration(style?['textDecoration']),
  );

  return Text(
    text,
    textAlign: _textAlign(style?['textAlign']),
    maxLines: _toInt(style?['maxLines']),
    overflow: _overflow(style?['overflow']),
    style: textStyle,
  );
}

Widget _buildImage(Map<String, dynamic> props) {
  final src = props['src']?.toString();
  if (src == null || src.isEmpty) {
    return const SizedBox.shrink();
  }
  final image = src.startsWith('http') ? Image.network(src) : Image.asset(src);
  return SizedBox(
    width: _toDouble(props['width']),
    height: _toDouble(props['height']),
    child: FittedBox(fit: _boxFit(props['fit']) ?? BoxFit.cover, child: image),
  );
}

Widget _buildTextFormField(
  Map<String, dynamic> node,
  Map<String, dynamic> props,
  STACFormKey? formKey,
) {
  final id = node['id']?.toString();
  final initialValue = props['initialValue'] ?? props['value'];
  if (id != null && initialValue != null && formKey?.getValue(id) == null) {
    formKey?.setValue(id, initialValue);
  }
  return TextFormField(
    key: ValueKey('${id ?? ''}:${initialValue ?? ''}'),
    initialValue: initialValue?.toString(),
    decoration: InputDecoration(
      labelText: props['label']?.toString(),
      hintText: props['hint']?.toString(),
    ),
    obscureText: props['obscure'] == true,
    enabled: props['enabled'] != false,
    maxLines: _toInt(props['maxLines']) ??
        (_isTextarea(node['type']?.toString()) ? 4 : 1),
    minLines: _toInt(props['minLines']),
    keyboardType: _keyboardType(props['keyboardType']),
    onChanged: id == null
        ? null
        : (value) {
            formKey?.setValue(id, value);
          },
    onSaved: id == null
        ? null
        : (value) {
            formKey?.setValue(id, value);
          },
  );
}

bool _isTextarea(String? type) => type == STACComponentTypes.textarea;

class _FormDropdownField extends StatefulWidget {
  const _FormDropdownField({
    required this.node,
    required this.props,
    required this.formKey,
  });

  final Map<String, dynamic> node;
  final Map<String, dynamic> props;
  final STACFormKey? formKey;

  @override
  State<_FormDropdownField> createState() => _FormDropdownFieldState();
}

class _FormDropdownFieldState extends State<_FormDropdownField> {
  String? _value;

  @override
  void initState() {
    super.initState();
    final id = widget.node['id']?.toString();
    final initial = _initialFormValue(
      widget.node,
      widget.props,
      widget.formKey,
    );
    _value = initial?.toString();
    if (id != null && _value != null) {
      widget.formKey?.setValue(id, _value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.node['id']?.toString();
    final options = _formOptions(widget.props['options']);

    return DropdownButtonFormField<String>(
      value: options.any((option) => option.value == _value) ? _value : null,
      decoration: InputDecoration(
        labelText: widget.props['label']?.toString(),
        hintText: widget.props['hint']?.toString(),
      ),
      items: options
          .map(
            (option) => DropdownMenuItem<String>(
              value: option.value,
              child: Text(option.label),
            ),
          )
          .toList(growable: false),
      onChanged: widget.props['enabled'] == false
          ? null
          : (value) {
              setState(() => _value = value);
              if (id != null) {
                widget.formKey?.setValue(id, value);
              }
            },
    );
  }
}

class _FormCheckboxField extends StatefulWidget {
  const _FormCheckboxField({
    required this.node,
    required this.props,
    required this.formKey,
  });

  final Map<String, dynamic> node;
  final Map<String, dynamic> props;
  final STACFormKey? formKey;

  @override
  State<_FormCheckboxField> createState() => _FormCheckboxFieldState();
}

class _FormCheckboxFieldState extends State<_FormCheckboxField> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    final id = widget.node['id']?.toString();
    _value = _toBool(
      _initialFormValue(widget.node, widget.props, widget.formKey),
    );
    if (id != null) {
      widget.formKey?.setValue(id, _value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.node['id']?.toString();
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.props['label']?.toString() ?? ''),
      subtitle: widget.props['hint'] == null
          ? null
          : Text(widget.props['hint'].toString()),
      value: _value,
      onChanged: widget.props['enabled'] == false
          ? null
          : (value) {
              setState(() => _value = value ?? false);
              if (id != null) {
                widget.formKey?.setValue(id, _value);
              }
            },
    );
  }
}

class _FormCheckboxGroupField extends StatefulWidget {
  const _FormCheckboxGroupField({
    required this.node,
    required this.props,
    required this.formKey,
  });

  final Map<String, dynamic> node;
  final Map<String, dynamic> props;
  final STACFormKey? formKey;

  @override
  State<_FormCheckboxGroupField> createState() =>
      _FormCheckboxGroupFieldState();
}

class _FormCheckboxGroupFieldState extends State<_FormCheckboxGroupField> {
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    final id = widget.node['id']?.toString();
    final initial = _initialFormValue(
      widget.node,
      widget.props,
      widget.formKey,
    );
    if (initial is List) {
      _selectedValues = initial.map((e) => e.toString()).toList();
    } else if (initial is Set) {
      _selectedValues = initial.map((e) => e.toString()).toList();
    } else if (initial is String && initial.isNotEmpty) {
      _selectedValues = [initial];
    } else {
      _selectedValues = [];
    }
    if (id != null) {
      widget.formKey?.setValue(id, _selectedValues);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.node['id']?.toString();
    final options = _formOptions(widget.props['options']);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.props['label'] != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(widget.props['label'].toString()),
          ),
        ...options.map(
          (option) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(option.label),
            value: _selectedValues.contains(option.value),
            onChanged: widget.props['enabled'] == false
                ? null
                : (checked) {
                    setState(() {
                      if (checked == true) {
                        if (!_selectedValues.contains(option.value)) {
                          _selectedValues.add(option.value);
                        }
                      } else {
                        _selectedValues.remove(option.value);
                      }
                    });
                    if (id != null) {
                      widget.formKey?.setValue(id, _selectedValues);
                    }
                  },
          ),
        ),
      ],
    );
  }
}

class _FormSwitchField extends StatefulWidget {
  const _FormSwitchField({
    required this.node,
    required this.props,
    required this.formKey,
  });

  final Map<String, dynamic> node;
  final Map<String, dynamic> props;
  final STACFormKey? formKey;

  @override
  State<_FormSwitchField> createState() => _FormSwitchFieldState();
}

class _FormSwitchFieldState extends State<_FormSwitchField> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    final id = widget.node['id']?.toString();
    _value = _toBool(
      _initialFormValue(widget.node, widget.props, widget.formKey),
    );
    if (id != null) {
      widget.formKey?.setValue(id, _value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.node['id']?.toString();
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.props['label']?.toString() ?? ''),
      subtitle: widget.props['hint'] == null
          ? null
          : Text(widget.props['hint'].toString()),
      value: _value,
      onChanged: widget.props['enabled'] == false
          ? null
          : (value) {
              setState(() => _value = value);
              if (id != null) {
                widget.formKey?.setValue(id, _value);
              }
            },
    );
  }
}

class _FormRadioField extends StatefulWidget {
  const _FormRadioField({
    required this.node,
    required this.props,
    required this.formKey,
  });

  final Map<String, dynamic> node;
  final Map<String, dynamic> props;
  final STACFormKey? formKey;

  @override
  State<_FormRadioField> createState() => _FormRadioFieldState();
}

class _FormRadioFieldState extends State<_FormRadioField> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    final id = widget.node['id']?.toString();
    final groupValue = widget.props['groupValue']?.toString();
    final thisValue = widget.props['value']?.toString();
    _value = groupValue == thisValue;
    if (id != null) {
      widget.formKey?.setValue(id, _value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.node['id']?.toString();
    final thisValue = widget.props['value']?.toString();
    return RadioListTile<String>(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.props['label']?.toString() ?? ''),
      value: thisValue ?? '',
      groupValue: _value ? thisValue : null,
      onChanged: widget.props['enabled'] == false
          ? null
          : (value) {
              setState(() => _value = value == thisValue);
              if (id != null) {
                widget.formKey?.setValue(id, value);
              }
            },
    );
  }
}

class _FormRadioGroupField extends StatefulWidget {
  const _FormRadioGroupField({
    required this.node,
    required this.props,
    required this.formKey,
  });

  final Map<String, dynamic> node;
  final Map<String, dynamic> props;
  final STACFormKey? formKey;

  @override
  State<_FormRadioGroupField> createState() => _FormRadioGroupFieldState();
}

class _FormRadioGroupFieldState extends State<_FormRadioGroupField> {
  String? _value;

  @override
  void initState() {
    super.initState();
    final id = widget.node['id']?.toString();
    final initial = _initialFormValue(
      widget.node,
      widget.props,
      widget.formKey,
    );
    _value = initial?.toString();
    if (id != null && _value != null) {
      widget.formKey?.setValue(id, _value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.node['id']?.toString();
    final options = _formOptions(widget.props['options']);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.props['label'] != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(widget.props['label'].toString()),
          ),
        ...options.map(
          (option) => RadioListTile<String>(
            contentPadding: EdgeInsets.zero,
            title: Text(option.label),
            value: option.value,
            groupValue: _value,
            onChanged: widget.props['enabled'] == false
                ? null
                : (value) {
                    setState(() => _value = value);
                    if (id != null) {
                      widget.formKey?.setValue(id, value);
                    }
                  },
          ),
        ),
      ],
    );
  }
}

class _FormSliderField extends StatefulWidget {
  const _FormSliderField({
    required this.node,
    required this.props,
    required this.formKey,
  });

  final Map<String, dynamic> node;
  final Map<String, dynamic> props;
  final STACFormKey? formKey;

  @override
  State<_FormSliderField> createState() => _FormSliderFieldState();
}

class _FormSliderFieldState extends State<_FormSliderField> {
  late double _value;

  @override
  void initState() {
    super.initState();
    final id = widget.node['id']?.toString();
    _value = _toDouble(
          _initialFormValue(widget.node, widget.props, widget.formKey),
        ) ??
        _toDouble(widget.props['min']) ??
        0;
    if (id != null) {
      widget.formKey?.setValue(id, _value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.node['id']?.toString();
    final min = _toDouble(widget.props['min']) ?? 0;
    final max = _toDouble(widget.props['max']) ?? 100;
    final divisions = _toInt(widget.props['divisions']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.props['label'] != null)
          Text('${widget.props['label']}: ${_value.round()}'),
        Slider(
          value: _value.clamp(min, max),
          min: min,
          max: max,
          divisions: divisions,
          label: _value.round().toString(),
          onChanged: widget.props['enabled'] == false
              ? null
              : (value) {
                  setState(() => _value = value);
                  if (id != null) {
                    widget.formKey?.setValue(id, value);
                  }
                },
        ),
      ],
    );
  }
}

class _FormOption {
  const _FormOption({required this.label, required this.value});

  final String label;
  final String value;
}

List<_FormOption> _formOptions(dynamic value) {
  if (value is! List) return const [];
  return value.map((item) {
    if (item is Map) {
      final map = Map<String, dynamic>.from(item);
      final rawValue = map['value'] ?? map['id'] ?? map['label'];
      return _FormOption(
        label: (map['label'] ?? rawValue ?? '').toString(),
        value: (rawValue ?? '').toString(),
      );
    }
    return _FormOption(label: item.toString(), value: item.toString());
  }).toList(growable: false);
}

dynamic _initialFormValue(
  Map<String, dynamic> node,
  Map<String, dynamic> props,
  STACFormKey? formKey,
) {
  final id = node['id']?.toString();
  if (id != null && formKey?.getValue(id) != null) {
    return formKey?.getValue(id);
  }
  return props['initialValue'] ?? props['value'];
}

bool _toBool(dynamic value) {
  if (value is bool) return value;
  final text = value?.toString().toLowerCase();
  return text == 'true' || text == '1' || text == 'yes';
}

bool _shouldWrapTap(String type, Map<String, dynamic> node) {
  if (_eventHandlerName(node, STACEventTypes.onTap) == null) return false;
  return type != STACComponentTypes.button &&
      type != STACComponentTypes.iconButton &&
      type != STACComponentTypes.fab;
}

VoidCallback? _buildTapHandler(
  BuildContext context,
  Map<String, dynamic> node, {
  required String eventName,
  required STACEventHandler? onEvent,
  required Map<String, dynamic> data,
  required STACFormKey? formKey,
}) {
  final handler = _eventHandlerName(node, eventName);
  if (handler == null) return null;

  return () {
    unawaited(
      onEvent?.call(handler, {
        'nodeId': node['id'],
        'eventType': eventName,
        'handler': handler,
        'props': Map<String, dynamic>.from(node['props'] as Map? ?? const {}),
        'currentData': data,
        'form': formKey?.getValues() ?? const <String, dynamic>{},
      }),
    );
  };
}

String? _eventHandlerName(Map<String, dynamic> node, String eventName) {
  final events = Map<String, dynamic>.from(node['events'] as Map? ?? const {});
  final handler = events[eventName];
  return handler?.toString();
}

List<Widget> _withSpacing(
  List<Widget> children,
  double? spacing, {
  bool horizontal = false,
}) {
  if (spacing == null || children.length < 2) return children;
  final gap = SizedBox(
    width: horizontal ? spacing : 0,
    height: horizontal ? 0 : spacing,
  );
  return children
      .expandIndexed(
        (index, child) => index == children.length - 1 ? [child] : [child, gap],
      )
      .toList(growable: false);
}

Widget _vertical(List<Widget> children) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: children,
  );
}

Widget _applyNodeStyle(Widget child, Map<String, dynamic> style) {
  final padding = _edgeInsets(style['padding']);
  final margin = _edgeInsets(style['margin']);
  final width = _toDouble(style['width']);
  final height = _toDouble(style['height']);
  final bg = _parseColor(style['backgroundColor']);
  final borderRadius = _toDouble(style['borderRadius']);

  Widget result = child;

  if (padding != null) {
    result = Padding(padding: padding, child: result);
  }

  if (width != null || height != null) {
    result = SizedBox(width: width, height: height, child: result);
  }

  if (margin != null || bg != null || borderRadius != null) {
    result = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: bg,
        borderRadius:
            borderRadius == null ? null : BorderRadius.circular(borderRadius),
      ),
      child: result,
    );
  }

  if (style['onTap'] != null) {
    result = GestureDetector(
      onTap: style['onTap'] as VoidCallback?,
      child: result,
    );
  }

  return result;
}

BoxDecoration? _boxDecoration(Map<String, dynamic> props) {
  final color =
      _parseColor(props['backgroundColor']) ?? _parseColor(props['color']);
  final borderRadius = _toDouble(props['borderRadius']);
  final border = _border(props['border']);
  final boxShadow = _boxShadow(props['boxShadow']);
  if (color == null &&
      borderRadius == null &&
      border == null &&
      boxShadow == null) {
    return null;
  }
  return BoxDecoration(
    color: color,
    borderRadius:
        borderRadius == null ? null : BorderRadius.circular(borderRadius),
    border: border,
    boxShadow: boxShadow,
  );
}

Border? _border(dynamic value) {
  if (value == null) return null;
  if (value is Border) return value;
  return null;
}

List<BoxShadow>? _boxShadow(dynamic value) {
  if (value == null) return null;
  if (value is List<BoxShadow>) return value;
  return null;
}

AlignmentGeometry? _alignment(dynamic value) {
  switch (value?.toString()) {
    case 'center':
      return Alignment.center;
    case 'topCenter':
      return Alignment.topCenter;
    case 'bottomCenter':
      return Alignment.bottomCenter;
    case 'centerLeft':
      return Alignment.centerLeft;
    case 'centerRight':
      return Alignment.centerRight;
    default:
      return null;
  }
}

MainAxisAlignment _mainAxisAlignment(dynamic value) {
  switch (value?.toString()) {
    case 'center':
      return MainAxisAlignment.center;
    case 'end':
      return MainAxisAlignment.end;
    case 'spaceBetween':
      return MainAxisAlignment.spaceBetween;
    case 'spaceAround':
      return MainAxisAlignment.spaceAround;
    case 'spaceEvenly':
      return MainAxisAlignment.spaceEvenly;
    case 'start':
    default:
      return MainAxisAlignment.start;
  }
}

CrossAxisAlignment? _crossAxisAlignment(dynamic value) {
  switch (value?.toString()) {
    case 'start':
      return CrossAxisAlignment.start;
    case 'end':
      return CrossAxisAlignment.end;
    case 'stretch':
      return CrossAxisAlignment.stretch;
    case 'center':
      return CrossAxisAlignment.center;
    default:
      return null;
  }
}

TextAlign _textAlign(dynamic value) {
  switch (value?.toString()) {
    case 'center':
      return TextAlign.center;
    case 'end':
      return TextAlign.end;
    case 'right':
      return TextAlign.right;
    case 'justify':
      return TextAlign.justify;
    case 'left':
    default:
      return TextAlign.left;
  }
}

TextOverflow? _overflow(dynamic value) {
  switch (value?.toString()) {
    case 'clip':
      return TextOverflow.clip;
    case 'fade':
      return TextOverflow.fade;
    case 'ellipsis':
      return TextOverflow.ellipsis;
    case 'visible':
      return TextOverflow.visible;
    default:
      return null;
  }
}

TextDecoration? _textDecoration(dynamic value) {
  switch (value?.toString()) {
    case 'underline':
      return TextDecoration.underline;
    case 'lineThrough':
      return TextDecoration.lineThrough;
    case 'overline':
      return TextDecoration.overline;
    default:
      return null;
  }
}

FontWeight? _fontWeight(dynamic value) {
  final text = value?.toString().toLowerCase();
  switch (text) {
    case '100':
    case 'w100':
      return FontWeight.w100;
    case '200':
    case 'w200':
      return FontWeight.w200;
    case '300':
    case 'w300':
      return FontWeight.w300;
    case '400':
    case 'normal':
    case 'w400':
      return FontWeight.w400;
    case '500':
    case 'w500':
      return FontWeight.w500;
    case '600':
    case 'w600':
      return FontWeight.w600;
    case '700':
    case 'bold':
    case 'w700':
      return FontWeight.w700;
    case '800':
    case 'w800':
      return FontWeight.w800;
    case '900':
    case 'w900':
      return FontWeight.w900;
    default:
      return null;
  }
}

Color? _parseColor(dynamic value) {
  if (value == null) return null;
  if (value is int) return Color(value);
  final text = value.toString().trim();
  if (text.isEmpty) return null;
  if (text.startsWith('#')) {
    final hex = text.substring(1);
    final normalized = hex.length == 6 ? 'FF$hex' : hex;
    return Color(int.parse(normalized, radix: 16));
  }
  return null;
}

double? _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value?.toString() ?? '');
}

int? _toInt(dynamic value) {
  if (value is int) return value;
  if (value is double) return value.toInt();
  return int.tryParse(value?.toString() ?? '');
}

EdgeInsetsGeometry? _edgeInsets(dynamic value) {
  if (value == null) return null;
  if (value is EdgeInsetsGeometry) return value;
  if (value is List && value.length == 4) {
    final parts = value.map((e) => _toDouble(e) ?? 0).toList(growable: false);
    return EdgeInsets.fromLTRB(parts[0], parts[1], parts[2], parts[3]);
  }
  if (value is String) {
    final parts = value
        .split(',')
        .map((part) => double.tryParse(part.trim()))
        .toList(growable: false);
    if (parts.length == 4 && !parts.any((part) => part == null)) {
      return EdgeInsets.fromLTRB(parts[0]!, parts[1]!, parts[2]!, parts[3]!);
    }
  }
  return null;
}

IconData _iconData(dynamic value) {
  switch (value?.toString()) {
    case 'Icons.today':
      return Icons.today;
    case 'Icons.event':
      return Icons.event;
    case 'Icons.chevron_left':
      return Icons.chevron_left;
    case 'Icons.chevron_right':
      return Icons.chevron_right;
    case 'Icons.add':
      return Icons.add;
    case 'Icons.check':
      return Icons.check;
    case 'Icons.info':
      return Icons.info;
    case 'Icons.calendar_month':
      return Icons.calendar_month;
    default:
      return Icons.help_outline;
  }
}

BoxFit? _boxFit(dynamic value) {
  switch (value?.toString()) {
    case 'contain':
      return BoxFit.contain;
    case 'cover':
      return BoxFit.cover;
    case 'fill':
      return BoxFit.fill;
    case 'fitWidth':
      return BoxFit.fitWidth;
    case 'fitHeight':
      return BoxFit.fitHeight;
    default:
      return null;
  }
}

TextInputType? _keyboardType(dynamic value) {
  switch (value?.toString()) {
    case 'email':
    case 'emailAddress':
      return TextInputType.emailAddress;
    case 'phone':
      return TextInputType.phone;
    case 'number':
      return TextInputType.number;
    case 'url':
      return TextInputType.url;
    case 'multiline':
      return TextInputType.multiline;
    case 'text':
      return TextInputType.text;
    default:
      return null;
  }
}

Map<String, dynamic> _applyPatches(
  Map<String, dynamic> schema,
  List<STACPatchOp> patches,
) {
  final result = Map<String, dynamic>.from(schema);
  for (final patch in patches) {
    if (patch.op == 'replace' || patch.op == 'add') {
      _setJsonPointer(result, patch.path, patch.value);
    } else if (patch.op == 'remove') {
      _removeJsonPointer(result, patch.path);
    }
  }
  return result;
}

void _setJsonPointer(Map<String, dynamic> root, String path, dynamic value) {
  final parts = _jsonPointerParts(path);
  if (parts.isEmpty) return;

  dynamic current = root;
  for (final part in parts.take(parts.length - 1)) {
    current = current is List ? current[int.parse(part)] : current[part];
  }

  final last = parts.last;
  if (current is List) {
    current[int.parse(last)] = value;
  } else if (current is Map) {
    current[last] = value;
  }
}

void _removeJsonPointer(Map<String, dynamic> root, String path) {
  final parts = _jsonPointerParts(path);
  if (parts.isEmpty) return;

  dynamic current = root;
  for (final part in parts.take(parts.length - 1)) {
    current = current is List ? current[int.parse(part)] : current[part];
  }

  final last = parts.last;
  if (current is List) {
    current.removeAt(int.parse(last));
  } else if (current is Map) {
    current.remove(last);
  }
}

List<String> _jsonPointerParts(String path) {
  if (path.isEmpty || path == '/') return const [];
  return path
      .split('/')
      .skip(1)
      .map((part) => part.replaceAll('~1', '/').replaceAll('~0', '~'))
      .toList(growable: false);
}
