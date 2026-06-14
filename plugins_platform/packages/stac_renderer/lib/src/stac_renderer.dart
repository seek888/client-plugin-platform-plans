import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart' as official_stac;
import 'package:stac_framework/stac_framework.dart';

/// STAC 渲染器。
///
/// 对外保留平台原有的 [STACSchema] / [STACNode] API，内部使用官方
/// `stac` Flutter 包完成动态 UI 渲染。
class STACRenderer {
  static Future<void>? _initializeFuture;

  /// 初始化官方 Stac，并注册插件事件 action。
  static Future<void> initialize() {
    return _initializeFuture ??= official_stac.Stac.initialize(
      actionParsers: const [_PluginEventActionParser()],
      override: true,
    );
  }

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
  String eventName,
  Map<String, dynamic> params,
);

/// 表单 Key。
class STACFormKey {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final Map<String, dynamic> _values = {};

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
  late _STACSourceType _sourceType;

  @override
  void initState() {
    super.initState();
    _sourceJson = Map<String, dynamic>.from(widget.sourceJson);
    _sourceType = widget.sourceType;
  }

  @override
  void didUpdateWidget(covariant _STACSchemaWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sourceJson != widget.sourceJson ||
        oldWidget.sourceType != widget.sourceType) {
      _sourceJson = Map<String, dynamic>.from(widget.sourceJson);
      _sourceType = widget.sourceType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: STACRenderer.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }

        final formKey = widget.formKey;
        final child = Builder(
          builder: (context) {
            return official_stac.Stac.fromJson(_officialJson, context) ??
                const SizedBox.shrink();
          },
        );

        return _PluginEventScope(
          data: widget.data,
          formKey: formKey,
          eventHandler: _handleEvent,
          child: formKey == null ? child : Form(key: formKey.key, child: child),
        );
      },
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
        _sourceType = _STACSourceType.schema;
      });
    } else if (update.type == STACUpdateType.patch && update.patches != null) {
      final patched = _applyPatches(_sourceJson, update.patches!);
      setState(() {
        _sourceJson = patched;
      });
    }

    return update;
  }

  Map<String, dynamic> get _officialJson {
    return switch (_sourceType) {
      _STACSourceType.schema => _schemaMapToOfficialStacJson(_sourceJson),
      _STACSourceType.node => _nodeMapToOfficialStacJson(_sourceJson),
    };
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

  static _PluginEventScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_PluginEventScope>();
  }

  @override
  bool updateShouldNotify(_PluginEventScope oldWidget) {
    return data != oldWidget.data ||
        formKey != oldWidget.formKey ||
        eventHandler != oldWidget.eventHandler;
  }
}

class _PluginEventAction {
  const _PluginEventAction({
    required this.eventName,
    required this.params,
  });

  final String eventName;
  final Map<String, dynamic> params;
}

class _PluginEventActionParser extends StacActionParser<_PluginEventAction> {
  const _PluginEventActionParser();

  @override
  String get actionType => 'pluginEvent';

  @override
  _PluginEventAction getModel(Map<String, dynamic> json) {
    final params = Map<String, dynamic>.from(
      json['params'] as Map? ?? const {},
    );
    return _PluginEventAction(
      eventName: json['eventName'] as String? ?? params['handler'] as String,
      params: params,
    );
  }

  @override
  FutureOr<dynamic> onCall(BuildContext context, _PluginEventAction model) {
    final scope = _PluginEventScope.maybeOf(context);
    if (scope == null) return null;

    return scope.eventHandler(model.eventName, {
      ...model.params,
      'currentData': scope.data,
      'form': scope.formKey?.getValues() ?? const <String, dynamic>{},
    });
  }
}

Map<String, dynamic> _schemaMapToOfficialStacJson(Map<String, dynamic> schema) {
  final type = schema['type'] as String?;
  final title = schema['title'] as String?;
  final children = _childrenToOfficialStacJson(schema['children']);
  final layout = schema['layout'] as Map?;

  final content = layout == null
      ? _column(children)
      : _layoutToOfficialStacJson(
          Map<String, dynamic>.from(layout),
          children,
        );

  final body = _applyStyle(content, schema['style'] as Map?);

  switch (type) {
    case 'page':
      return {
        'type': 'scaffold',
        if (title != null)
          'appBar': {
            'type': 'appBar',
            'title': {'type': 'text', 'data': title},
          },
        'body': body,
      };
    case 'dialog':
      return {
        'type': 'alertDialog',
        if (title != null) 'title': {'type': 'text', 'data': title},
        'content': body,
      };
    case 'card':
      return {
        'type': 'card',
        'child': _padding(16, body),
      };
    default:
      return body;
  }
}

List<Map<String, dynamic>> _childrenToOfficialStacJson(dynamic value) {
  final children = value is List ? value : const [];
  return children
      .whereType<Map>()
      .map(
          (node) => _nodeMapToOfficialStacJson(Map<String, dynamic>.from(node)))
      .toList();
}

Map<String, dynamic> _nodeMapToOfficialStacJson(Map<String, dynamic> node) {
  final type = node['type'] as String? ?? 'unknown';
  final props = Map<String, dynamic>.from(node['props'] as Map? ?? const {});
  final children = _childrenToOfficialStacJson(node['children']);
  final style = node['style'] as Map?;

  Map<String, dynamic> result;
  switch (type) {
    case STACComponentTypes.container:
      result = {
        'type': 'container',
        'child': _column(children),
      };
      break;
    case STACComponentTypes.column:
      result = _column(children);
      break;
    case STACComponentTypes.row:
      result = {'type': 'row', 'children': children};
      break;
    case STACComponentTypes.stack:
      result = {'type': 'stack', 'children': children};
      break;
    case STACComponentTypes.expanded:
      result = {
        'type': 'expanded',
        'child': children.isNotEmpty ? children.first : _empty(),
      };
      break;
    case STACComponentTypes.sizedBox:
      result = {
        'type': 'sizedBox',
        if (props['width'] != null) 'width': props['width'],
        if (props['height'] != null) 'height': props['height'],
      };
      break;
    case STACComponentTypes.text:
      result = {
        'type': 'text',
        'data': props['text']?.toString() ?? '',
        ..._textStyle(style),
      };
      break;
    case STACComponentTypes.image:
      result = {
        'type': 'image',
        'src': props['src']?.toString() ?? '',
        if (props['width'] != null) 'width': props['width'],
        if (props['height'] != null) 'height': props['height'],
        if (props['fit'] != null) 'fit': props['fit'],
      };
      break;
    case STACComponentTypes.icon:
      result = {
        'type': 'icon',
        'icon': _iconName(props['icon']),
        if (props['size'] != null) 'size': props['size'],
        if (props['color'] != null) 'color': props['color'],
      };
      break;
    case STACComponentTypes.divider:
      result = {'type': 'divider'};
      break;
    case STACComponentTypes.textFormField:
    case STACComponentTypes.textarea:
      result = _textFormField(node, props);
      break;
    case STACComponentTypes.button:
      result = {
        'type': 'elevatedButton',
        'onPressed': _eventAction(node, STACEventTypes.onTap),
        'child': {
          'type': 'text',
          'data': props['text']?.toString() ?? 'Button'
        },
      };
      break;
    case STACComponentTypes.iconButton:
      result = {
        'type': 'iconButton',
        'onPressed': _eventAction(node, STACEventTypes.onTap),
        'icon': {'type': 'icon', 'icon': _iconName(props['icon'])},
      };
      break;
    case STACComponentTypes.fab:
      result = {
        'type': 'floatingActionButton',
        'onPressed': _eventAction(node, STACEventTypes.onTap),
        'child': {'type': 'icon', 'icon': _iconName(props['icon'] ?? 'add')},
      };
      break;
    case STACComponentTypes.listView:
      result = {
        'type': 'listView',
        'shrinkWrap': true,
        'children': children,
      };
      break;
    case STACComponentTypes.gridView:
      result = {
        'type': 'gridView',
        'shrinkWrap': true,
        'crossAxisCount': props['crossAxisCount'] ?? 2,
        'mainAxisSpacing': props['spacing'] ?? props['mainAxisSpacing'] ?? 8,
        'crossAxisSpacing': props['spacing'] ?? props['crossAxisSpacing'] ?? 8,
        'childAspectRatio': props['childAspectRatio'] ?? 1,
        'children': children,
      };
      break;
    case STACComponentTypes.card:
      result = {
        'type': 'card',
        'child': _padding(16, _column(children)),
      };
      break;
    case STACComponentTypes.scaffold:
      result = {
        'type': 'scaffold',
        'body': _column(children),
      };
      break;
    case STACComponentTypes.appBar:
      result = {
        'type': 'appBar',
        'title': {'type': 'text', 'data': props['title']?.toString() ?? ''},
      };
      break;
    default:
      result = {'type': 'sizedBox'};
  }

  result = _applyStyle(result, style);

  if (_hasTapEvent(node) &&
      type != STACComponentTypes.button &&
      type != STACComponentTypes.iconButton &&
      type != STACComponentTypes.fab) {
    result = {
      'type': 'gestureDetector',
      'onTap': _eventAction(node, STACEventTypes.onTap),
      'child': result,
    };
  }

  return result;
}

Map<String, dynamic> _layoutToOfficialStacJson(
  Map<String, dynamic> layout,
  List<Map<String, dynamic>> children,
) {
  final padding = _edgeInsets(layout['padding']);
  Map<String, dynamic> result;

  switch (layout['type'] as String?) {
    case 'row':
      result = {
        'type': 'row',
        if (layout['mainAxisAlignment'] != null)
          'mainAxisAlignment': layout['mainAxisAlignment'],
        if (layout['crossAxisAlignment'] != null)
          'crossAxisAlignment': layout['crossAxisAlignment'],
        if (layout['spacing'] != null) 'spacing': layout['spacing'],
        'children': children,
      };
      break;
    case 'grid':
      result = {
        'type': 'gridView',
        'shrinkWrap': true,
        'crossAxisCount': layout['crossAxisCount'] ?? 2,
        'mainAxisSpacing': layout['spacing'] ?? 8,
        'crossAxisSpacing': layout['runSpacing'] ?? layout['spacing'] ?? 8,
        'childAspectRatio': layout['aspectRatio'] ?? 1,
        'children': children,
      };
      break;
    case 'stack':
      result = {'type': 'stack', 'children': children};
      break;
    case 'column':
    default:
      result = {
        'type': 'column',
        if (layout['mainAxisAlignment'] != null)
          'mainAxisAlignment': layout['mainAxisAlignment'],
        if (layout['crossAxisAlignment'] != null)
          'crossAxisAlignment': layout['crossAxisAlignment'],
        if (layout['spacing'] != null) 'spacing': layout['spacing'],
        'children': children,
      };
  }

  if (padding != null) {
    result = {'type': 'padding', 'padding': padding, 'child': result};
  }

  if (layout['scrollable'] == true) {
    result = {'type': 'singleChildScrollView', 'child': result};
  }

  return result;
}

Map<String, dynamic> _textFormField(
  Map<String, dynamic> node,
  Map<String, dynamic> props,
) {
  final id = node['id'] as String?;
  return {
    'type': 'textFormField',
    if (id != null) 'id': id,
    'decoration': {
      if (props['label'] != null) 'labelText': props['label'],
      if (props['hint'] != null) 'hintText': props['hint'],
    },
    if (props['obscure'] != null) 'obscureText': props['obscure'],
    if (props['enabled'] != null) 'enabled': props['enabled'],
    if (props['maxLines'] != null) 'maxLines': props['maxLines'],
    if (props['minLines'] != null) 'minLines': props['minLines'],
    if (props['keyboardType'] != null)
      'keyboardType': _keyboardType(props['keyboardType']),
  };
}

Map<String, dynamic> _applyStyle(
  Map<String, dynamic> widget,
  Map<dynamic, dynamic>? style,
) {
  if (style == null || style.isEmpty) return widget;

  var result = widget;
  final padding = _edgeInsets(style['padding']);
  if (padding != null) {
    result = {'type': 'padding', 'padding': padding, 'child': result};
  }

  final width = style['width'];
  final height = style['height'];
  if (width != null || height != null) {
    result = {
      'type': 'sizedBox',
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      'child': result,
    };
  }

  final margin = _edgeInsets(style['margin']);
  final backgroundColor = style['backgroundColor'];
  final borderRadius = style['borderRadius'];
  if (margin != null || backgroundColor != null || borderRadius != null) {
    result = {
      'type': 'container',
      if (margin != null) 'margin': margin,
      if (backgroundColor != null && borderRadius == null)
        'color': backgroundColor,
      if (borderRadius != null)
        'decoration': {
          'color': backgroundColor,
          'borderRadius': borderRadius,
        },
      'child': result,
    };
  }

  return result;
}

Map<String, dynamic> _textStyle(Map<dynamic, dynamic>? style) {
  if (style == null) return const {};
  final fontWeight = _fontWeight(style['fontWeight']);
  final copyWithStyle = <String, dynamic>{
    if (style['color'] != null) 'color': style['color'],
    if (style['fontSize'] != null) 'fontSize': style['fontSize'],
    if (fontWeight != null) 'fontWeight': fontWeight,
  };
  return {
    if (copyWithStyle.isNotEmpty) 'copyWithStyle': copyWithStyle,
    if (style['textAlign'] != null) 'textAlign': style['textAlign'],
    if (style['maxLines'] != null) 'maxLines': style['maxLines'],
    if (style['overflow'] != null) 'overflow': style['overflow'],
  };
}

String? _fontWeight(dynamic value) {
  if (value == null) return null;
  if (value is num) return _numericFontWeight(value.toInt());

  final text = value.toString().trim();
  if (text.isEmpty) return null;

  final lower = text.toLowerCase();
  if (lower == 'normal' || lower == 'bold') return lower;

  final normalized = lower.startsWith('fontweight.')
      ? lower.substring('fontweight.'.length)
      : lower;
  if (_isSupportedFontWeight(normalized)) return normalized;

  final numeric = int.tryParse(normalized);
  return numeric == null ? text : _numericFontWeight(numeric);
}

String _numericFontWeight(int value) {
  final clamped = value.clamp(100, 900);
  final rounded = (clamped / 100).round() * 100;
  return 'w$rounded';
}

bool _isSupportedFontWeight(String value) {
  switch (value) {
    case 'w100':
    case 'w200':
    case 'w300':
    case 'w400':
    case 'w500':
    case 'w600':
    case 'w700':
    case 'w800':
    case 'w900':
      return true;
    default:
      return false;
  }
}

Map<String, dynamic>? _eventAction(
    Map<String, dynamic> node, String eventType) {
  final events = node['events'] as Map?;
  final handler = events?[eventType] as String?;
  if (handler == null) return null;

  return {
    'actionType': 'pluginEvent',
    'eventName': handler,
    'params': {
      'nodeId': node['id'],
      'eventType': eventType,
      'handler': handler,
      'props': Map<String, dynamic>.from(node['props'] as Map? ?? const {}),
    },
  };
}

bool _hasTapEvent(Map<String, dynamic> node) {
  final events = node['events'] as Map?;
  return events?[STACEventTypes.onTap] != null;
}

Map<String, dynamic> _column(List<Map<String, dynamic>> children) {
  return {'type': 'column', 'children': children};
}

Map<String, dynamic> _padding(num value, Map<String, dynamic> child) {
  return {'type': 'padding', 'padding': value, 'child': child};
}

Map<String, dynamic> _empty() {
  return {'type': 'sizedBox'};
}

dynamic _edgeInsets(dynamic value) {
  if (value == null) return null;
  if (value is num || value is Map || value is List) return value;
  if (value is String) {
    final parts = value
        .split(',')
        .map((part) => double.tryParse(part.trim()))
        .toList(growable: false);
    if (parts.length == 4 && !parts.any((part) => part == null)) {
      return parts.cast<double>();
    }
  }
  return null;
}

String _iconName(dynamic value) {
  final name = value?.toString() ?? 'help_outline';
  return name.startsWith('Icons.') ? name.substring(6) : name;
}

String _keyboardType(dynamic value) {
  switch (value?.toString()) {
    case 'email':
      return 'emailAddress';
    case 'phone':
      return 'phone';
    case 'number':
      return 'number';
    case 'url':
      return 'url';
    case 'multiline':
      return 'multiline';
    case 'text':
    default:
      return 'text';
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
