// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stac_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$STACSchemaImpl _$$STACSchemaImplFromJson(Map<String, dynamic> json) =>
    _$STACSchemaImpl(
      schemaVersion: json['schemaVersion'] as String,
      type: json['type'] as String,
      title: json['title'] as String?,
      layout: json['layout'] == null
          ? null
          : STACLayout.fromJson(json['layout'] as Map<String, dynamic>),
      dataSources: (json['dataSources'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, STACDataSource.fromJson(e as Map<String, dynamic>)),
      ),
      style: json['style'] == null
          ? null
          : STACStyle.fromJson(json['style'] as Map<String, dynamic>),
      events: (json['events'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => STACNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$STACSchemaImplToJson(_$STACSchemaImpl instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'type': instance.type,
      'title': instance.title,
      'layout': instance.layout,
      'dataSources': instance.dataSources,
      'style': instance.style,
      'events': instance.events,
      'children': instance.children,
    };

_$STACNodeImpl _$$STACNodeImplFromJson(Map<String, dynamic> json) =>
    _$STACNodeImpl(
      type: json['type'] as String,
      id: json['id'] as String?,
      props:
          json['props'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => STACNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      events: (json['events'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      style: json['style'] == null
          ? null
          : STACStyle.fromJson(json['style'] as Map<String, dynamic>),
      binding: json['binding'] == null
          ? null
          : STACDataBinding.fromJson(json['binding'] as Map<String, dynamic>),
      validation: (json['validation'] as List<dynamic>?)
          ?.map((e) => STACValidation.fromJson(e as Map<String, dynamic>))
          .toList(),
      condition: json['condition'] == null
          ? null
          : STACCondition.fromJson(json['condition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$STACNodeImplToJson(_$STACNodeImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'props': instance.props,
      'children': instance.children,
      'events': instance.events,
      'style': instance.style,
      'binding': instance.binding,
      'validation': instance.validation,
      'condition': instance.condition,
    };

_$STACLayoutImpl _$$STACLayoutImplFromJson(Map<String, dynamic> json) =>
    _$STACLayoutImpl(
      type: json['type'] as String,
      mainAxisAlignment: json['mainAxisAlignment'] as String?,
      crossAxisAlignment: json['crossAxisAlignment'] as String?,
      spacing: (json['spacing'] as num?)?.toDouble(),
      runSpacing: (json['runSpacing'] as num?)?.toDouble(),
      padding: json['padding'] as String?,
      crossAxisCount: (json['crossAxisCount'] as num?)?.toInt(),
      aspectRatio: (json['aspectRatio'] as num?)?.toDouble(),
      scrollable: json['scrollable'] as bool? ?? false,
    );

Map<String, dynamic> _$$STACLayoutImplToJson(_$STACLayoutImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'mainAxisAlignment': instance.mainAxisAlignment,
      'crossAxisAlignment': instance.crossAxisAlignment,
      'spacing': instance.spacing,
      'runSpacing': instance.runSpacing,
      'padding': instance.padding,
      'crossAxisCount': instance.crossAxisCount,
      'aspectRatio': instance.aspectRatio,
      'scrollable': instance.scrollable,
    };

_$STACStyleImpl _$$STACStyleImplFromJson(Map<String, dynamic> json) =>
    _$STACStyleImpl(
      backgroundColor: json['backgroundColor'] as String?,
      color: json['color'] as String?,
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      fontWeight: json['fontWeight'] as String?,
      padding: json['padding'] as String?,
      margin: json['margin'] as String?,
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      borderRadius: (json['borderRadius'] as num?)?.toDouble(),
      border: json['border'] as String?,
      boxShadow: json['boxShadow'] as String?,
      textAlign: json['textAlign'] as String?,
      textDecoration: json['textDecoration'] as String?,
      maxLines: (json['maxLines'] as num?)?.toInt(),
      overflow: json['overflow'] as String?,
    );

Map<String, dynamic> _$$STACStyleImplToJson(_$STACStyleImpl instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'color': instance.color,
      'fontSize': instance.fontSize,
      'fontWeight': instance.fontWeight,
      'padding': instance.padding,
      'margin': instance.margin,
      'width': instance.width,
      'height': instance.height,
      'borderRadius': instance.borderRadius,
      'border': instance.border,
      'boxShadow': instance.boxShadow,
      'textAlign': instance.textAlign,
      'textDecoration': instance.textDecoration,
      'maxLines': instance.maxLines,
      'overflow': instance.overflow,
    };

_$STACDataSourceImpl _$$STACDataSourceImplFromJson(Map<String, dynamic> json) =>
    _$STACDataSourceImpl(
      sourceType: json['sourceType'] as String,
      capability: json['capability'] as String?,
      params:
          json['params'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      transform: (json['transform'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      defaultValue: json['defaultValue'],
    );

Map<String, dynamic> _$$STACDataSourceImplToJson(
        _$STACDataSourceImpl instance) =>
    <String, dynamic>{
      'sourceType': instance.sourceType,
      'capability': instance.capability,
      'params': instance.params,
      'transform': instance.transform,
      'defaultValue': instance.defaultValue,
    };

_$STACDataBindingImpl _$$STACDataBindingImplFromJson(
        Map<String, dynamic> json) =>
    _$STACDataBindingImpl(
      source: json['source'] as String?,
      field: json['field'] as String?,
      bindType: json['bindType'] as String?,
      format: json['format'] as String?,
      defaultValue: json['defaultValue'],
    );

Map<String, dynamic> _$$STACDataBindingImplToJson(
        _$STACDataBindingImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'field': instance.field,
      'bindType': instance.bindType,
      'format': instance.format,
      'defaultValue': instance.defaultValue,
    };

_$STACValidationImpl _$$STACValidationImplFromJson(Map<String, dynamic> json) =>
    _$STACValidationImpl(
      type: json['type'] as String,
      message: json['message'] as String?,
      value: json['value'],
      custom: json['custom'] as String?,
    );

Map<String, dynamic> _$$STACValidationImplToJson(
        _$STACValidationImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'value': instance.value,
      'custom': instance.custom,
    };

_$STACConditionImpl _$$STACConditionImplFromJson(Map<String, dynamic> json) =>
    _$STACConditionImpl(
      type: json['type'] as String,
      left: json['left'] as String,
      right: json['right'],
      not: json['not'] as bool? ?? false,
    );

Map<String, dynamic> _$$STACConditionImplToJson(_$STACConditionImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'left': instance.left,
      'right': instance.right,
      'not': instance.not,
    };
