// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stac_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

STACSchema _$STACSchemaFromJson(Map<String, dynamic> json) {
  return _STACSchema.fromJson(json);
}

/// @nodoc
mixin _$STACSchema {
  /// Schema 版本
  String get schemaVersion => throw _privateConstructorUsedError;

  /// 类型：page/card/dialog 等
  String get type => throw _privateConstructorUsedError;

  /// 标题
  String? get title => throw _privateConstructorUsedError;

  /// 布局配置
  STACLayout? get layout => throw _privateConstructorUsedError;

  /// 数据源配置
  Map<String, STACDataSource>? get dataSources =>
      throw _privateConstructorUsedError;

  /// 样式配置
  STACStyle? get style => throw _privateConstructorUsedError;

  /// 事件配置
  Map<String, String>? get events => throw _privateConstructorUsedError;

  /// 子组件列表
  List<STACNode> get children => throw _privateConstructorUsedError;

  /// Serializes this STACSchema to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of STACSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $STACSchemaCopyWith<STACSchema> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $STACSchemaCopyWith<$Res> {
  factory $STACSchemaCopyWith(
          STACSchema value, $Res Function(STACSchema) then) =
      _$STACSchemaCopyWithImpl<$Res, STACSchema>;
  @useResult
  $Res call(
      {String schemaVersion,
      String type,
      String? title,
      STACLayout? layout,
      Map<String, STACDataSource>? dataSources,
      STACStyle? style,
      Map<String, String>? events,
      List<STACNode> children});

  $STACLayoutCopyWith<$Res>? get layout;
  $STACStyleCopyWith<$Res>? get style;
}

/// @nodoc
class _$STACSchemaCopyWithImpl<$Res, $Val extends STACSchema>
    implements $STACSchemaCopyWith<$Res> {
  _$STACSchemaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of STACSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemaVersion = null,
    Object? type = null,
    Object? title = freezed,
    Object? layout = freezed,
    Object? dataSources = freezed,
    Object? style = freezed,
    Object? events = freezed,
    Object? children = null,
  }) {
    return _then(_value.copyWith(
      schemaVersion: null == schemaVersion
          ? _value.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      layout: freezed == layout
          ? _value.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as STACLayout?,
      dataSources: freezed == dataSources
          ? _value.dataSources
          : dataSources // ignore: cast_nullable_to_non_nullable
              as Map<String, STACDataSource>?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as STACStyle?,
      events: freezed == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<STACNode>,
    ) as $Val);
  }

  /// Create a copy of STACSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $STACLayoutCopyWith<$Res>? get layout {
    if (_value.layout == null) {
      return null;
    }

    return $STACLayoutCopyWith<$Res>(_value.layout!, (value) {
      return _then(_value.copyWith(layout: value) as $Val);
    });
  }

  /// Create a copy of STACSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $STACStyleCopyWith<$Res>? get style {
    if (_value.style == null) {
      return null;
    }

    return $STACStyleCopyWith<$Res>(_value.style!, (value) {
      return _then(_value.copyWith(style: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$STACSchemaImplCopyWith<$Res>
    implements $STACSchemaCopyWith<$Res> {
  factory _$$STACSchemaImplCopyWith(
          _$STACSchemaImpl value, $Res Function(_$STACSchemaImpl) then) =
      __$$STACSchemaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String schemaVersion,
      String type,
      String? title,
      STACLayout? layout,
      Map<String, STACDataSource>? dataSources,
      STACStyle? style,
      Map<String, String>? events,
      List<STACNode> children});

  @override
  $STACLayoutCopyWith<$Res>? get layout;
  @override
  $STACStyleCopyWith<$Res>? get style;
}

/// @nodoc
class __$$STACSchemaImplCopyWithImpl<$Res>
    extends _$STACSchemaCopyWithImpl<$Res, _$STACSchemaImpl>
    implements _$$STACSchemaImplCopyWith<$Res> {
  __$$STACSchemaImplCopyWithImpl(
      _$STACSchemaImpl _value, $Res Function(_$STACSchemaImpl) _then)
      : super(_value, _then);

  /// Create a copy of STACSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemaVersion = null,
    Object? type = null,
    Object? title = freezed,
    Object? layout = freezed,
    Object? dataSources = freezed,
    Object? style = freezed,
    Object? events = freezed,
    Object? children = null,
  }) {
    return _then(_$STACSchemaImpl(
      schemaVersion: null == schemaVersion
          ? _value.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      layout: freezed == layout
          ? _value.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as STACLayout?,
      dataSources: freezed == dataSources
          ? _value._dataSources
          : dataSources // ignore: cast_nullable_to_non_nullable
              as Map<String, STACDataSource>?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as STACStyle?,
      events: freezed == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<STACNode>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$STACSchemaImpl implements _STACSchema {
  const _$STACSchemaImpl(
      {required this.schemaVersion,
      required this.type,
      this.title,
      this.layout,
      final Map<String, STACDataSource>? dataSources,
      this.style,
      final Map<String, String>? events,
      final List<STACNode> children = const []})
      : _dataSources = dataSources,
        _events = events,
        _children = children;

  factory _$STACSchemaImpl.fromJson(Map<String, dynamic> json) =>
      _$$STACSchemaImplFromJson(json);

  /// Schema 版本
  @override
  final String schemaVersion;

  /// 类型：page/card/dialog 等
  @override
  final String type;

  /// 标题
  @override
  final String? title;

  /// 布局配置
  @override
  final STACLayout? layout;

  /// 数据源配置
  final Map<String, STACDataSource>? _dataSources;

  /// 数据源配置
  @override
  Map<String, STACDataSource>? get dataSources {
    final value = _dataSources;
    if (value == null) return null;
    if (_dataSources is EqualUnmodifiableMapView) return _dataSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// 样式配置
  @override
  final STACStyle? style;

  /// 事件配置
  final Map<String, String>? _events;

  /// 事件配置
  @override
  Map<String, String>? get events {
    final value = _events;
    if (value == null) return null;
    if (_events is EqualUnmodifiableMapView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// 子组件列表
  final List<STACNode> _children;

  /// 子组件列表
  @override
  @JsonKey()
  List<STACNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'STACSchema(schemaVersion: $schemaVersion, type: $type, title: $title, layout: $layout, dataSources: $dataSources, style: $style, events: $events, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$STACSchemaImpl &&
            (identical(other.schemaVersion, schemaVersion) ||
                other.schemaVersion == schemaVersion) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.layout, layout) || other.layout == layout) &&
            const DeepCollectionEquality()
                .equals(other._dataSources, _dataSources) &&
            (identical(other.style, style) || other.style == style) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      schemaVersion,
      type,
      title,
      layout,
      const DeepCollectionEquality().hash(_dataSources),
      style,
      const DeepCollectionEquality().hash(_events),
      const DeepCollectionEquality().hash(_children));

  /// Create a copy of STACSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$STACSchemaImplCopyWith<_$STACSchemaImpl> get copyWith =>
      __$$STACSchemaImplCopyWithImpl<_$STACSchemaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$STACSchemaImplToJson(
      this,
    );
  }
}

abstract class _STACSchema implements STACSchema {
  const factory _STACSchema(
      {required final String schemaVersion,
      required final String type,
      final String? title,
      final STACLayout? layout,
      final Map<String, STACDataSource>? dataSources,
      final STACStyle? style,
      final Map<String, String>? events,
      final List<STACNode> children}) = _$STACSchemaImpl;

  factory _STACSchema.fromJson(Map<String, dynamic> json) =
      _$STACSchemaImpl.fromJson;

  /// Schema 版本
  @override
  String get schemaVersion;

  /// 类型：page/card/dialog 等
  @override
  String get type;

  /// 标题
  @override
  String? get title;

  /// 布局配置
  @override
  STACLayout? get layout;

  /// 数据源配置
  @override
  Map<String, STACDataSource>? get dataSources;

  /// 样式配置
  @override
  STACStyle? get style;

  /// 事件配置
  @override
  Map<String, String>? get events;

  /// 子组件列表
  @override
  List<STACNode> get children;

  /// Create a copy of STACSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$STACSchemaImplCopyWith<_$STACSchemaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

STACNode _$STACNodeFromJson(Map<String, dynamic> json) {
  return _STACNode.fromJson(json);
}

/// @nodoc
mixin _$STACNode {
  /// 组件类型：text/button/image/form/list 等
  String get type => throw _privateConstructorUsedError;

  /// 组件 ID（用于事件回调）
  String? get id => throw _privateConstructorUsedError;

  /// 组件属性
  Map<String, dynamic> get props => throw _privateConstructorUsedError;

  /// 子组件
  List<STACNode> get children => throw _privateConstructorUsedError;

  /// 事件处理
  Map<String, String> get events => throw _privateConstructorUsedError;

  /// 样式
  STACStyle? get style => throw _privateConstructorUsedError;

  /// 数据绑定
  STACDataBinding? get binding => throw _privateConstructorUsedError;

  /// 表单校验
  List<STACValidation>? get validation => throw _privateConstructorUsedError;

  /// 条件渲染
  STACCondition? get condition => throw _privateConstructorUsedError;

  /// Serializes this STACNode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of STACNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $STACNodeCopyWith<STACNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $STACNodeCopyWith<$Res> {
  factory $STACNodeCopyWith(STACNode value, $Res Function(STACNode) then) =
      _$STACNodeCopyWithImpl<$Res, STACNode>;
  @useResult
  $Res call(
      {String type,
      String? id,
      Map<String, dynamic> props,
      List<STACNode> children,
      Map<String, String> events,
      STACStyle? style,
      STACDataBinding? binding,
      List<STACValidation>? validation,
      STACCondition? condition});

  $STACStyleCopyWith<$Res>? get style;
  $STACDataBindingCopyWith<$Res>? get binding;
  $STACConditionCopyWith<$Res>? get condition;
}

/// @nodoc
class _$STACNodeCopyWithImpl<$Res, $Val extends STACNode>
    implements $STACNodeCopyWith<$Res> {
  _$STACNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of STACNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = freezed,
    Object? props = null,
    Object? children = null,
    Object? events = null,
    Object? style = freezed,
    Object? binding = freezed,
    Object? validation = freezed,
    Object? condition = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      props: null == props
          ? _value.props
          : props // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<STACNode>,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as STACStyle?,
      binding: freezed == binding
          ? _value.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as STACDataBinding?,
      validation: freezed == validation
          ? _value.validation
          : validation // ignore: cast_nullable_to_non_nullable
              as List<STACValidation>?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as STACCondition?,
    ) as $Val);
  }

  /// Create a copy of STACNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $STACStyleCopyWith<$Res>? get style {
    if (_value.style == null) {
      return null;
    }

    return $STACStyleCopyWith<$Res>(_value.style!, (value) {
      return _then(_value.copyWith(style: value) as $Val);
    });
  }

  /// Create a copy of STACNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $STACDataBindingCopyWith<$Res>? get binding {
    if (_value.binding == null) {
      return null;
    }

    return $STACDataBindingCopyWith<$Res>(_value.binding!, (value) {
      return _then(_value.copyWith(binding: value) as $Val);
    });
  }

  /// Create a copy of STACNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $STACConditionCopyWith<$Res>? get condition {
    if (_value.condition == null) {
      return null;
    }

    return $STACConditionCopyWith<$Res>(_value.condition!, (value) {
      return _then(_value.copyWith(condition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$STACNodeImplCopyWith<$Res>
    implements $STACNodeCopyWith<$Res> {
  factory _$$STACNodeImplCopyWith(
          _$STACNodeImpl value, $Res Function(_$STACNodeImpl) then) =
      __$$STACNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String? id,
      Map<String, dynamic> props,
      List<STACNode> children,
      Map<String, String> events,
      STACStyle? style,
      STACDataBinding? binding,
      List<STACValidation>? validation,
      STACCondition? condition});

  @override
  $STACStyleCopyWith<$Res>? get style;
  @override
  $STACDataBindingCopyWith<$Res>? get binding;
  @override
  $STACConditionCopyWith<$Res>? get condition;
}

/// @nodoc
class __$$STACNodeImplCopyWithImpl<$Res>
    extends _$STACNodeCopyWithImpl<$Res, _$STACNodeImpl>
    implements _$$STACNodeImplCopyWith<$Res> {
  __$$STACNodeImplCopyWithImpl(
      _$STACNodeImpl _value, $Res Function(_$STACNodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of STACNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = freezed,
    Object? props = null,
    Object? children = null,
    Object? events = null,
    Object? style = freezed,
    Object? binding = freezed,
    Object? validation = freezed,
    Object? condition = freezed,
  }) {
    return _then(_$STACNodeImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      props: null == props
          ? _value._props
          : props // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<STACNode>,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as STACStyle?,
      binding: freezed == binding
          ? _value.binding
          : binding // ignore: cast_nullable_to_non_nullable
              as STACDataBinding?,
      validation: freezed == validation
          ? _value._validation
          : validation // ignore: cast_nullable_to_non_nullable
              as List<STACValidation>?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as STACCondition?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$STACNodeImpl implements _STACNode {
  const _$STACNodeImpl(
      {required this.type,
      this.id,
      final Map<String, dynamic> props = const <String, dynamic>{},
      final List<STACNode> children = const [],
      final Map<String, String> events = const <String, String>{},
      this.style,
      this.binding,
      final List<STACValidation>? validation,
      this.condition})
      : _props = props,
        _children = children,
        _events = events,
        _validation = validation;

  factory _$STACNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$STACNodeImplFromJson(json);

  /// 组件类型：text/button/image/form/list 等
  @override
  final String type;

  /// 组件 ID（用于事件回调）
  @override
  final String? id;

  /// 组件属性
  final Map<String, dynamic> _props;

  /// 组件属性
  @override
  @JsonKey()
  Map<String, dynamic> get props {
    if (_props is EqualUnmodifiableMapView) return _props;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_props);
  }

  /// 子组件
  final List<STACNode> _children;

  /// 子组件
  @override
  @JsonKey()
  List<STACNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  /// 事件处理
  final Map<String, String> _events;

  /// 事件处理
  @override
  @JsonKey()
  Map<String, String> get events {
    if (_events is EqualUnmodifiableMapView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_events);
  }

  /// 样式
  @override
  final STACStyle? style;

  /// 数据绑定
  @override
  final STACDataBinding? binding;

  /// 表单校验
  final List<STACValidation>? _validation;

  /// 表单校验
  @override
  List<STACValidation>? get validation {
    final value = _validation;
    if (value == null) return null;
    if (_validation is EqualUnmodifiableListView) return _validation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// 条件渲染
  @override
  final STACCondition? condition;

  @override
  String toString() {
    return 'STACNode(type: $type, id: $id, props: $props, children: $children, events: $events, style: $style, binding: $binding, validation: $validation, condition: $condition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$STACNodeImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._props, _props) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.binding, binding) || other.binding == binding) &&
            const DeepCollectionEquality()
                .equals(other._validation, _validation) &&
            (identical(other.condition, condition) ||
                other.condition == condition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      id,
      const DeepCollectionEquality().hash(_props),
      const DeepCollectionEquality().hash(_children),
      const DeepCollectionEquality().hash(_events),
      style,
      binding,
      const DeepCollectionEquality().hash(_validation),
      condition);

  /// Create a copy of STACNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$STACNodeImplCopyWith<_$STACNodeImpl> get copyWith =>
      __$$STACNodeImplCopyWithImpl<_$STACNodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$STACNodeImplToJson(
      this,
    );
  }
}

abstract class _STACNode implements STACNode {
  const factory _STACNode(
      {required final String type,
      final String? id,
      final Map<String, dynamic> props,
      final List<STACNode> children,
      final Map<String, String> events,
      final STACStyle? style,
      final STACDataBinding? binding,
      final List<STACValidation>? validation,
      final STACCondition? condition}) = _$STACNodeImpl;

  factory _STACNode.fromJson(Map<String, dynamic> json) =
      _$STACNodeImpl.fromJson;

  /// 组件类型：text/button/image/form/list 等
  @override
  String get type;

  /// 组件 ID（用于事件回调）
  @override
  String? get id;

  /// 组件属性
  @override
  Map<String, dynamic> get props;

  /// 子组件
  @override
  List<STACNode> get children;

  /// 事件处理
  @override
  Map<String, String> get events;

  /// 样式
  @override
  STACStyle? get style;

  /// 数据绑定
  @override
  STACDataBinding? get binding;

  /// 表单校验
  @override
  List<STACValidation>? get validation;

  /// 条件渲染
  @override
  STACCondition? get condition;

  /// Create a copy of STACNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$STACNodeImplCopyWith<_$STACNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

STACLayout _$STACLayoutFromJson(Map<String, dynamic> json) {
  return _STACLayout.fromJson(json);
}

/// @nodoc
mixin _$STACLayout {
  /// 布局类型：column/row/grid/stack 等
  String get type => throw _privateConstructorUsedError;

  /// 主轴对齐
  String? get mainAxisAlignment => throw _privateConstructorUsedError;

  /// 交叉轴对齐
  String? get crossAxisAlignment => throw _privateConstructorUsedError;

  /// 主轴间距
  double? get spacing => throw _privateConstructorUsedError;

  /// 交叉轴间距（runSpacing）
  double? get runSpacing => throw _privateConstructorUsedError;

  /// 内边距
  String? get padding => throw _privateConstructorUsedError;

  /// 列数（grid 布局）
  int? get crossAxisCount => throw _privateConstructorUsedError;

  /// 宽高比（grid 布局）
  double? get aspectRatio => throw _privateConstructorUsedError;

  /// 是否可滚动
  bool get scrollable => throw _privateConstructorUsedError;

  /// Serializes this STACLayout to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of STACLayout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $STACLayoutCopyWith<STACLayout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $STACLayoutCopyWith<$Res> {
  factory $STACLayoutCopyWith(
          STACLayout value, $Res Function(STACLayout) then) =
      _$STACLayoutCopyWithImpl<$Res, STACLayout>;
  @useResult
  $Res call(
      {String type,
      String? mainAxisAlignment,
      String? crossAxisAlignment,
      double? spacing,
      double? runSpacing,
      String? padding,
      int? crossAxisCount,
      double? aspectRatio,
      bool scrollable});
}

/// @nodoc
class _$STACLayoutCopyWithImpl<$Res, $Val extends STACLayout>
    implements $STACLayoutCopyWith<$Res> {
  _$STACLayoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of STACLayout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? spacing = freezed,
    Object? runSpacing = freezed,
    Object? padding = freezed,
    Object? crossAxisCount = freezed,
    Object? aspectRatio = freezed,
    Object? scrollable = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      mainAxisAlignment: freezed == mainAxisAlignment
          ? _value.mainAxisAlignment
          : mainAxisAlignment // ignore: cast_nullable_to_non_nullable
              as String?,
      crossAxisAlignment: freezed == crossAxisAlignment
          ? _value.crossAxisAlignment
          : crossAxisAlignment // ignore: cast_nullable_to_non_nullable
              as String?,
      spacing: freezed == spacing
          ? _value.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as double?,
      runSpacing: freezed == runSpacing
          ? _value.runSpacing
          : runSpacing // ignore: cast_nullable_to_non_nullable
              as double?,
      padding: freezed == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
      crossAxisCount: freezed == crossAxisCount
          ? _value.crossAxisCount
          : crossAxisCount // ignore: cast_nullable_to_non_nullable
              as int?,
      aspectRatio: freezed == aspectRatio
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      scrollable: null == scrollable
          ? _value.scrollable
          : scrollable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$STACLayoutImplCopyWith<$Res>
    implements $STACLayoutCopyWith<$Res> {
  factory _$$STACLayoutImplCopyWith(
          _$STACLayoutImpl value, $Res Function(_$STACLayoutImpl) then) =
      __$$STACLayoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String? mainAxisAlignment,
      String? crossAxisAlignment,
      double? spacing,
      double? runSpacing,
      String? padding,
      int? crossAxisCount,
      double? aspectRatio,
      bool scrollable});
}

/// @nodoc
class __$$STACLayoutImplCopyWithImpl<$Res>
    extends _$STACLayoutCopyWithImpl<$Res, _$STACLayoutImpl>
    implements _$$STACLayoutImplCopyWith<$Res> {
  __$$STACLayoutImplCopyWithImpl(
      _$STACLayoutImpl _value, $Res Function(_$STACLayoutImpl) _then)
      : super(_value, _then);

  /// Create a copy of STACLayout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? spacing = freezed,
    Object? runSpacing = freezed,
    Object? padding = freezed,
    Object? crossAxisCount = freezed,
    Object? aspectRatio = freezed,
    Object? scrollable = null,
  }) {
    return _then(_$STACLayoutImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      mainAxisAlignment: freezed == mainAxisAlignment
          ? _value.mainAxisAlignment
          : mainAxisAlignment // ignore: cast_nullable_to_non_nullable
              as String?,
      crossAxisAlignment: freezed == crossAxisAlignment
          ? _value.crossAxisAlignment
          : crossAxisAlignment // ignore: cast_nullable_to_non_nullable
              as String?,
      spacing: freezed == spacing
          ? _value.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as double?,
      runSpacing: freezed == runSpacing
          ? _value.runSpacing
          : runSpacing // ignore: cast_nullable_to_non_nullable
              as double?,
      padding: freezed == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
      crossAxisCount: freezed == crossAxisCount
          ? _value.crossAxisCount
          : crossAxisCount // ignore: cast_nullable_to_non_nullable
              as int?,
      aspectRatio: freezed == aspectRatio
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      scrollable: null == scrollable
          ? _value.scrollable
          : scrollable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$STACLayoutImpl implements _STACLayout {
  const _$STACLayoutImpl(
      {required this.type,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.spacing,
      this.runSpacing,
      this.padding,
      this.crossAxisCount,
      this.aspectRatio,
      this.scrollable = false});

  factory _$STACLayoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$STACLayoutImplFromJson(json);

  /// 布局类型：column/row/grid/stack 等
  @override
  final String type;

  /// 主轴对齐
  @override
  final String? mainAxisAlignment;

  /// 交叉轴对齐
  @override
  final String? crossAxisAlignment;

  /// 主轴间距
  @override
  final double? spacing;

  /// 交叉轴间距（runSpacing）
  @override
  final double? runSpacing;

  /// 内边距
  @override
  final String? padding;

  /// 列数（grid 布局）
  @override
  final int? crossAxisCount;

  /// 宽高比（grid 布局）
  @override
  final double? aspectRatio;

  /// 是否可滚动
  @override
  @JsonKey()
  final bool scrollable;

  @override
  String toString() {
    return 'STACLayout(type: $type, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, spacing: $spacing, runSpacing: $runSpacing, padding: $padding, crossAxisCount: $crossAxisCount, aspectRatio: $aspectRatio, scrollable: $scrollable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$STACLayoutImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.mainAxisAlignment, mainAxisAlignment) ||
                other.mainAxisAlignment == mainAxisAlignment) &&
            (identical(other.crossAxisAlignment, crossAxisAlignment) ||
                other.crossAxisAlignment == crossAxisAlignment) &&
            (identical(other.spacing, spacing) || other.spacing == spacing) &&
            (identical(other.runSpacing, runSpacing) ||
                other.runSpacing == runSpacing) &&
            (identical(other.padding, padding) || other.padding == padding) &&
            (identical(other.crossAxisCount, crossAxisCount) ||
                other.crossAxisCount == crossAxisCount) &&
            (identical(other.aspectRatio, aspectRatio) ||
                other.aspectRatio == aspectRatio) &&
            (identical(other.scrollable, scrollable) ||
                other.scrollable == scrollable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      mainAxisAlignment,
      crossAxisAlignment,
      spacing,
      runSpacing,
      padding,
      crossAxisCount,
      aspectRatio,
      scrollable);

  /// Create a copy of STACLayout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$STACLayoutImplCopyWith<_$STACLayoutImpl> get copyWith =>
      __$$STACLayoutImplCopyWithImpl<_$STACLayoutImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$STACLayoutImplToJson(
      this,
    );
  }
}

abstract class _STACLayout implements STACLayout {
  const factory _STACLayout(
      {required final String type,
      final String? mainAxisAlignment,
      final String? crossAxisAlignment,
      final double? spacing,
      final double? runSpacing,
      final String? padding,
      final int? crossAxisCount,
      final double? aspectRatio,
      final bool scrollable}) = _$STACLayoutImpl;

  factory _STACLayout.fromJson(Map<String, dynamic> json) =
      _$STACLayoutImpl.fromJson;

  /// 布局类型：column/row/grid/stack 等
  @override
  String get type;

  /// 主轴对齐
  @override
  String? get mainAxisAlignment;

  /// 交叉轴对齐
  @override
  String? get crossAxisAlignment;

  /// 主轴间距
  @override
  double? get spacing;

  /// 交叉轴间距（runSpacing）
  @override
  double? get runSpacing;

  /// 内边距
  @override
  String? get padding;

  /// 列数（grid 布局）
  @override
  int? get crossAxisCount;

  /// 宽高比（grid 布局）
  @override
  double? get aspectRatio;

  /// 是否可滚动
  @override
  bool get scrollable;

  /// Create a copy of STACLayout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$STACLayoutImplCopyWith<_$STACLayoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

STACStyle _$STACStyleFromJson(Map<String, dynamic> json) {
  return _STACStyle.fromJson(json);
}

/// @nodoc
mixin _$STACStyle {
  /// 背景色
  String? get backgroundColor => throw _privateConstructorUsedError;

  /// 前景色
  String? get color => throw _privateConstructorUsedError;

  /// 字体大小
  double? get fontSize => throw _privateConstructorUsedError;

  /// 字体粗细
  String? get fontWeight => throw _privateConstructorUsedError;

  /// 内边距
  String? get padding => throw _privateConstructorUsedError;

  /// 外边距
  String? get margin => throw _privateConstructorUsedError;

  /// 宽度
  double? get width => throw _privateConstructorUsedError;

  /// 高度
  double? get height => throw _privateConstructorUsedError;

  /// 圆角
  double? get borderRadius => throw _privateConstructorUsedError;

  /// 边框
  String? get border => throw _privateConstructorUsedError;

  /// 阴影
  String? get boxShadow => throw _privateConstructorUsedError;

  /// 对齐
  String? get textAlign => throw _privateConstructorUsedError;

  /// 装饰线
  String? get textDecoration => throw _privateConstructorUsedError;

  /// 最大行数
  int? get maxLines => throw _privateConstructorUsedError;

  /// 溢出处理
  String? get overflow => throw _privateConstructorUsedError;

  /// Serializes this STACStyle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of STACStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $STACStyleCopyWith<STACStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $STACStyleCopyWith<$Res> {
  factory $STACStyleCopyWith(STACStyle value, $Res Function(STACStyle) then) =
      _$STACStyleCopyWithImpl<$Res, STACStyle>;
  @useResult
  $Res call(
      {String? backgroundColor,
      String? color,
      double? fontSize,
      String? fontWeight,
      String? padding,
      String? margin,
      double? width,
      double? height,
      double? borderRadius,
      String? border,
      String? boxShadow,
      String? textAlign,
      String? textDecoration,
      int? maxLines,
      String? overflow});
}

/// @nodoc
class _$STACStyleCopyWithImpl<$Res, $Val extends STACStyle>
    implements $STACStyleCopyWith<$Res> {
  _$STACStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of STACStyle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? color = freezed,
    Object? fontSize = freezed,
    Object? fontWeight = freezed,
    Object? padding = freezed,
    Object? margin = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? borderRadius = freezed,
    Object? border = freezed,
    Object? boxShadow = freezed,
    Object? textAlign = freezed,
    Object? textDecoration = freezed,
    Object? maxLines = freezed,
    Object? overflow = freezed,
  }) {
    return _then(_value.copyWith(
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      fontSize: freezed == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double?,
      fontWeight: freezed == fontWeight
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as String?,
      padding: freezed == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
      margin: freezed == margin
          ? _value.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      borderRadius: freezed == borderRadius
          ? _value.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as double?,
      border: freezed == border
          ? _value.border
          : border // ignore: cast_nullable_to_non_nullable
              as String?,
      boxShadow: freezed == boxShadow
          ? _value.boxShadow
          : boxShadow // ignore: cast_nullable_to_non_nullable
              as String?,
      textAlign: freezed == textAlign
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as String?,
      textDecoration: freezed == textDecoration
          ? _value.textDecoration
          : textDecoration // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLines: freezed == maxLines
          ? _value.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      overflow: freezed == overflow
          ? _value.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$STACStyleImplCopyWith<$Res>
    implements $STACStyleCopyWith<$Res> {
  factory _$$STACStyleImplCopyWith(
          _$STACStyleImpl value, $Res Function(_$STACStyleImpl) then) =
      __$$STACStyleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? backgroundColor,
      String? color,
      double? fontSize,
      String? fontWeight,
      String? padding,
      String? margin,
      double? width,
      double? height,
      double? borderRadius,
      String? border,
      String? boxShadow,
      String? textAlign,
      String? textDecoration,
      int? maxLines,
      String? overflow});
}

/// @nodoc
class __$$STACStyleImplCopyWithImpl<$Res>
    extends _$STACStyleCopyWithImpl<$Res, _$STACStyleImpl>
    implements _$$STACStyleImplCopyWith<$Res> {
  __$$STACStyleImplCopyWithImpl(
      _$STACStyleImpl _value, $Res Function(_$STACStyleImpl) _then)
      : super(_value, _then);

  /// Create a copy of STACStyle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? color = freezed,
    Object? fontSize = freezed,
    Object? fontWeight = freezed,
    Object? padding = freezed,
    Object? margin = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? borderRadius = freezed,
    Object? border = freezed,
    Object? boxShadow = freezed,
    Object? textAlign = freezed,
    Object? textDecoration = freezed,
    Object? maxLines = freezed,
    Object? overflow = freezed,
  }) {
    return _then(_$STACStyleImpl(
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      fontSize: freezed == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double?,
      fontWeight: freezed == fontWeight
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as String?,
      padding: freezed == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as String?,
      margin: freezed == margin
          ? _value.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      borderRadius: freezed == borderRadius
          ? _value.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as double?,
      border: freezed == border
          ? _value.border
          : border // ignore: cast_nullable_to_non_nullable
              as String?,
      boxShadow: freezed == boxShadow
          ? _value.boxShadow
          : boxShadow // ignore: cast_nullable_to_non_nullable
              as String?,
      textAlign: freezed == textAlign
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as String?,
      textDecoration: freezed == textDecoration
          ? _value.textDecoration
          : textDecoration // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLines: freezed == maxLines
          ? _value.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      overflow: freezed == overflow
          ? _value.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$STACStyleImpl implements _STACStyle {
  const _$STACStyleImpl(
      {this.backgroundColor,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.padding,
      this.margin,
      this.width,
      this.height,
      this.borderRadius,
      this.border,
      this.boxShadow,
      this.textAlign,
      this.textDecoration,
      this.maxLines,
      this.overflow});

  factory _$STACStyleImpl.fromJson(Map<String, dynamic> json) =>
      _$$STACStyleImplFromJson(json);

  /// 背景色
  @override
  final String? backgroundColor;

  /// 前景色
  @override
  final String? color;

  /// 字体大小
  @override
  final double? fontSize;

  /// 字体粗细
  @override
  final String? fontWeight;

  /// 内边距
  @override
  final String? padding;

  /// 外边距
  @override
  final String? margin;

  /// 宽度
  @override
  final double? width;

  /// 高度
  @override
  final double? height;

  /// 圆角
  @override
  final double? borderRadius;

  /// 边框
  @override
  final String? border;

  /// 阴影
  @override
  final String? boxShadow;

  /// 对齐
  @override
  final String? textAlign;

  /// 装饰线
  @override
  final String? textDecoration;

  /// 最大行数
  @override
  final int? maxLines;

  /// 溢出处理
  @override
  final String? overflow;

  @override
  String toString() {
    return 'STACStyle(backgroundColor: $backgroundColor, color: $color, fontSize: $fontSize, fontWeight: $fontWeight, padding: $padding, margin: $margin, width: $width, height: $height, borderRadius: $borderRadius, border: $border, boxShadow: $boxShadow, textAlign: $textAlign, textDecoration: $textDecoration, maxLines: $maxLines, overflow: $overflow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$STACStyleImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontWeight, fontWeight) ||
                other.fontWeight == fontWeight) &&
            (identical(other.padding, padding) || other.padding == padding) &&
            (identical(other.margin, margin) || other.margin == margin) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.borderRadius, borderRadius) ||
                other.borderRadius == borderRadius) &&
            (identical(other.border, border) || other.border == border) &&
            (identical(other.boxShadow, boxShadow) ||
                other.boxShadow == boxShadow) &&
            (identical(other.textAlign, textAlign) ||
                other.textAlign == textAlign) &&
            (identical(other.textDecoration, textDecoration) ||
                other.textDecoration == textDecoration) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.overflow, overflow) ||
                other.overflow == overflow));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      backgroundColor,
      color,
      fontSize,
      fontWeight,
      padding,
      margin,
      width,
      height,
      borderRadius,
      border,
      boxShadow,
      textAlign,
      textDecoration,
      maxLines,
      overflow);

  /// Create a copy of STACStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$STACStyleImplCopyWith<_$STACStyleImpl> get copyWith =>
      __$$STACStyleImplCopyWithImpl<_$STACStyleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$STACStyleImplToJson(
      this,
    );
  }
}

abstract class _STACStyle implements STACStyle {
  const factory _STACStyle(
      {final String? backgroundColor,
      final String? color,
      final double? fontSize,
      final String? fontWeight,
      final String? padding,
      final String? margin,
      final double? width,
      final double? height,
      final double? borderRadius,
      final String? border,
      final String? boxShadow,
      final String? textAlign,
      final String? textDecoration,
      final int? maxLines,
      final String? overflow}) = _$STACStyleImpl;

  factory _STACStyle.fromJson(Map<String, dynamic> json) =
      _$STACStyleImpl.fromJson;

  /// 背景色
  @override
  String? get backgroundColor;

  /// 前景色
  @override
  String? get color;

  /// 字体大小
  @override
  double? get fontSize;

  /// 字体粗细
  @override
  String? get fontWeight;

  /// 内边距
  @override
  String? get padding;

  /// 外边距
  @override
  String? get margin;

  /// 宽度
  @override
  double? get width;

  /// 高度
  @override
  double? get height;

  /// 圆角
  @override
  double? get borderRadius;

  /// 边框
  @override
  String? get border;

  /// 阴影
  @override
  String? get boxShadow;

  /// 对齐
  @override
  String? get textAlign;

  /// 装饰线
  @override
  String? get textDecoration;

  /// 最大行数
  @override
  int? get maxLines;

  /// 溢出处理
  @override
  String? get overflow;

  /// Create a copy of STACStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$STACStyleImplCopyWith<_$STACStyleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

STACDataSource _$STACDataSourceFromJson(Map<String, dynamic> json) {
  return _STACDataSource.fromJson(json);
}

/// @nodoc
mixin _$STACDataSource {
  /// 数据源类型：capability/api/local
  String get sourceType => throw _privateConstructorUsedError;

  /// 能力 ID 或 API URL
  String? get capability => throw _privateConstructorUsedError;

  /// 请求参数（支持模板变量）
  Map<String, dynamic> get params => throw _privateConstructorUsedError;

  /// 数据转换（简单的字段映射）
  Map<String, String>? get transform => throw _privateConstructorUsedError;

  /// 默认值
  dynamic get defaultValue => throw _privateConstructorUsedError;

  /// Serializes this STACDataSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of STACDataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $STACDataSourceCopyWith<STACDataSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $STACDataSourceCopyWith<$Res> {
  factory $STACDataSourceCopyWith(
          STACDataSource value, $Res Function(STACDataSource) then) =
      _$STACDataSourceCopyWithImpl<$Res, STACDataSource>;
  @useResult
  $Res call(
      {String sourceType,
      String? capability,
      Map<String, dynamic> params,
      Map<String, String>? transform,
      dynamic defaultValue});
}

/// @nodoc
class _$STACDataSourceCopyWithImpl<$Res, $Val extends STACDataSource>
    implements $STACDataSourceCopyWith<$Res> {
  _$STACDataSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of STACDataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceType = null,
    Object? capability = freezed,
    Object? params = null,
    Object? transform = freezed,
    Object? defaultValue = freezed,
  }) {
    return _then(_value.copyWith(
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      capability: freezed == capability
          ? _value.capability
          : capability // ignore: cast_nullable_to_non_nullable
              as String?,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      transform: freezed == transform
          ? _value.transform
          : transform // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$STACDataSourceImplCopyWith<$Res>
    implements $STACDataSourceCopyWith<$Res> {
  factory _$$STACDataSourceImplCopyWith(_$STACDataSourceImpl value,
          $Res Function(_$STACDataSourceImpl) then) =
      __$$STACDataSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sourceType,
      String? capability,
      Map<String, dynamic> params,
      Map<String, String>? transform,
      dynamic defaultValue});
}

/// @nodoc
class __$$STACDataSourceImplCopyWithImpl<$Res>
    extends _$STACDataSourceCopyWithImpl<$Res, _$STACDataSourceImpl>
    implements _$$STACDataSourceImplCopyWith<$Res> {
  __$$STACDataSourceImplCopyWithImpl(
      _$STACDataSourceImpl _value, $Res Function(_$STACDataSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of STACDataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceType = null,
    Object? capability = freezed,
    Object? params = null,
    Object? transform = freezed,
    Object? defaultValue = freezed,
  }) {
    return _then(_$STACDataSourceImpl(
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      capability: freezed == capability
          ? _value.capability
          : capability // ignore: cast_nullable_to_non_nullable
              as String?,
      params: null == params
          ? _value._params
          : params // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      transform: freezed == transform
          ? _value._transform
          : transform // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$STACDataSourceImpl implements _STACDataSource {
  const _$STACDataSourceImpl(
      {required this.sourceType,
      this.capability,
      final Map<String, dynamic> params = const <String, dynamic>{},
      final Map<String, String>? transform,
      this.defaultValue})
      : _params = params,
        _transform = transform;

  factory _$STACDataSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$STACDataSourceImplFromJson(json);

  /// 数据源类型：capability/api/local
  @override
  final String sourceType;

  /// 能力 ID 或 API URL
  @override
  final String? capability;

  /// 请求参数（支持模板变量）
  final Map<String, dynamic> _params;

  /// 请求参数（支持模板变量）
  @override
  @JsonKey()
  Map<String, dynamic> get params {
    if (_params is EqualUnmodifiableMapView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_params);
  }

  /// 数据转换（简单的字段映射）
  final Map<String, String>? _transform;

  /// 数据转换（简单的字段映射）
  @override
  Map<String, String>? get transform {
    final value = _transform;
    if (value == null) return null;
    if (_transform is EqualUnmodifiableMapView) return _transform;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// 默认值
  @override
  final dynamic defaultValue;

  @override
  String toString() {
    return 'STACDataSource(sourceType: $sourceType, capability: $capability, params: $params, transform: $transform, defaultValue: $defaultValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$STACDataSourceImpl &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.capability, capability) ||
                other.capability == capability) &&
            const DeepCollectionEquality().equals(other._params, _params) &&
            const DeepCollectionEquality()
                .equals(other._transform, _transform) &&
            const DeepCollectionEquality()
                .equals(other.defaultValue, defaultValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sourceType,
      capability,
      const DeepCollectionEquality().hash(_params),
      const DeepCollectionEquality().hash(_transform),
      const DeepCollectionEquality().hash(defaultValue));

  /// Create a copy of STACDataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$STACDataSourceImplCopyWith<_$STACDataSourceImpl> get copyWith =>
      __$$STACDataSourceImplCopyWithImpl<_$STACDataSourceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$STACDataSourceImplToJson(
      this,
    );
  }
}

abstract class _STACDataSource implements STACDataSource {
  const factory _STACDataSource(
      {required final String sourceType,
      final String? capability,
      final Map<String, dynamic> params,
      final Map<String, String>? transform,
      final dynamic defaultValue}) = _$STACDataSourceImpl;

  factory _STACDataSource.fromJson(Map<String, dynamic> json) =
      _$STACDataSourceImpl.fromJson;

  /// 数据源类型：capability/api/local
  @override
  String get sourceType;

  /// 能力 ID 或 API URL
  @override
  String? get capability;

  /// 请求参数（支持模板变量）
  @override
  Map<String, dynamic> get params;

  /// 数据转换（简单的字段映射）
  @override
  Map<String, String>? get transform;

  /// 默认值
  @override
  dynamic get defaultValue;

  /// Create a copy of STACDataSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$STACDataSourceImplCopyWith<_$STACDataSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

STACDataBinding _$STACDataBindingFromJson(Map<String, dynamic> json) {
  return _STACDataBinding.fromJson(json);
}

/// @nodoc
mixin _$STACDataBinding {
  /// 绑定的数据源路径
  String? get source => throw _privateConstructorUsedError;

  /// 绑定字段
  String? get field => throw _privateConstructorUsedError;

  /// 绑定类型：value/text/src/href 等
  String? get bindType => throw _privateConstructorUsedError;

  /// 格式化
  String? get format => throw _privateConstructorUsedError;

  /// 默认值
  dynamic get defaultValue => throw _privateConstructorUsedError;

  /// Serializes this STACDataBinding to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of STACDataBinding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $STACDataBindingCopyWith<STACDataBinding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $STACDataBindingCopyWith<$Res> {
  factory $STACDataBindingCopyWith(
          STACDataBinding value, $Res Function(STACDataBinding) then) =
      _$STACDataBindingCopyWithImpl<$Res, STACDataBinding>;
  @useResult
  $Res call(
      {String? source,
      String? field,
      String? bindType,
      String? format,
      dynamic defaultValue});
}

/// @nodoc
class _$STACDataBindingCopyWithImpl<$Res, $Val extends STACDataBinding>
    implements $STACDataBindingCopyWith<$Res> {
  _$STACDataBindingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of STACDataBinding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? field = freezed,
    Object? bindType = freezed,
    Object? format = freezed,
    Object? defaultValue = freezed,
  }) {
    return _then(_value.copyWith(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      field: freezed == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String?,
      bindType: freezed == bindType
          ? _value.bindType
          : bindType // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$STACDataBindingImplCopyWith<$Res>
    implements $STACDataBindingCopyWith<$Res> {
  factory _$$STACDataBindingImplCopyWith(_$STACDataBindingImpl value,
          $Res Function(_$STACDataBindingImpl) then) =
      __$$STACDataBindingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? source,
      String? field,
      String? bindType,
      String? format,
      dynamic defaultValue});
}

/// @nodoc
class __$$STACDataBindingImplCopyWithImpl<$Res>
    extends _$STACDataBindingCopyWithImpl<$Res, _$STACDataBindingImpl>
    implements _$$STACDataBindingImplCopyWith<$Res> {
  __$$STACDataBindingImplCopyWithImpl(
      _$STACDataBindingImpl _value, $Res Function(_$STACDataBindingImpl) _then)
      : super(_value, _then);

  /// Create a copy of STACDataBinding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? field = freezed,
    Object? bindType = freezed,
    Object? format = freezed,
    Object? defaultValue = freezed,
  }) {
    return _then(_$STACDataBindingImpl(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      field: freezed == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String?,
      bindType: freezed == bindType
          ? _value.bindType
          : bindType // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$STACDataBindingImpl implements _STACDataBinding {
  const _$STACDataBindingImpl(
      {this.source, this.field, this.bindType, this.format, this.defaultValue});

  factory _$STACDataBindingImpl.fromJson(Map<String, dynamic> json) =>
      _$$STACDataBindingImplFromJson(json);

  /// 绑定的数据源路径
  @override
  final String? source;

  /// 绑定字段
  @override
  final String? field;

  /// 绑定类型：value/text/src/href 等
  @override
  final String? bindType;

  /// 格式化
  @override
  final String? format;

  /// 默认值
  @override
  final dynamic defaultValue;

  @override
  String toString() {
    return 'STACDataBinding(source: $source, field: $field, bindType: $bindType, format: $format, defaultValue: $defaultValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$STACDataBindingImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.bindType, bindType) ||
                other.bindType == bindType) &&
            (identical(other.format, format) || other.format == format) &&
            const DeepCollectionEquality()
                .equals(other.defaultValue, defaultValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, source, field, bindType, format,
      const DeepCollectionEquality().hash(defaultValue));

  /// Create a copy of STACDataBinding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$STACDataBindingImplCopyWith<_$STACDataBindingImpl> get copyWith =>
      __$$STACDataBindingImplCopyWithImpl<_$STACDataBindingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$STACDataBindingImplToJson(
      this,
    );
  }
}

abstract class _STACDataBinding implements STACDataBinding {
  const factory _STACDataBinding(
      {final String? source,
      final String? field,
      final String? bindType,
      final String? format,
      final dynamic defaultValue}) = _$STACDataBindingImpl;

  factory _STACDataBinding.fromJson(Map<String, dynamic> json) =
      _$STACDataBindingImpl.fromJson;

  /// 绑定的数据源路径
  @override
  String? get source;

  /// 绑定字段
  @override
  String? get field;

  /// 绑定类型：value/text/src/href 等
  @override
  String? get bindType;

  /// 格式化
  @override
  String? get format;

  /// 默认值
  @override
  dynamic get defaultValue;

  /// Create a copy of STACDataBinding
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$STACDataBindingImplCopyWith<_$STACDataBindingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

STACValidation _$STACValidationFromJson(Map<String, dynamic> json) {
  return _STACValidation.fromJson(json);
}

/// @nodoc
mixin _$STACValidation {
  /// 校验类型：required/pattern/minLength/maxLength/min/max
  String get type => throw _privateConstructorUsedError;

  /// 错误提示
  String? get message => throw _privateConstructorUsedError;

  /// 校验值（用于 pattern/min/max 等）
  dynamic get value => throw _privateConstructorUsedError;

  /// 自定义校验函数名
  String? get custom => throw _privateConstructorUsedError;

  /// Serializes this STACValidation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of STACValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $STACValidationCopyWith<STACValidation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $STACValidationCopyWith<$Res> {
  factory $STACValidationCopyWith(
          STACValidation value, $Res Function(STACValidation) then) =
      _$STACValidationCopyWithImpl<$Res, STACValidation>;
  @useResult
  $Res call({String type, String? message, dynamic value, String? custom});
}

/// @nodoc
class _$STACValidationCopyWithImpl<$Res, $Val extends STACValidation>
    implements $STACValidationCopyWith<$Res> {
  _$STACValidationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of STACValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = freezed,
    Object? value = freezed,
    Object? custom = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      custom: freezed == custom
          ? _value.custom
          : custom // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$STACValidationImplCopyWith<$Res>
    implements $STACValidationCopyWith<$Res> {
  factory _$$STACValidationImplCopyWith(_$STACValidationImpl value,
          $Res Function(_$STACValidationImpl) then) =
      __$$STACValidationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String? message, dynamic value, String? custom});
}

/// @nodoc
class __$$STACValidationImplCopyWithImpl<$Res>
    extends _$STACValidationCopyWithImpl<$Res, _$STACValidationImpl>
    implements _$$STACValidationImplCopyWith<$Res> {
  __$$STACValidationImplCopyWithImpl(
      _$STACValidationImpl _value, $Res Function(_$STACValidationImpl) _then)
      : super(_value, _then);

  /// Create a copy of STACValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = freezed,
    Object? value = freezed,
    Object? custom = freezed,
  }) {
    return _then(_$STACValidationImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      custom: freezed == custom
          ? _value.custom
          : custom // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$STACValidationImpl implements _STACValidation {
  const _$STACValidationImpl(
      {required this.type, this.message, this.value, this.custom});

  factory _$STACValidationImpl.fromJson(Map<String, dynamic> json) =>
      _$$STACValidationImplFromJson(json);

  /// 校验类型：required/pattern/minLength/maxLength/min/max
  @override
  final String type;

  /// 错误提示
  @override
  final String? message;

  /// 校验值（用于 pattern/min/max 等）
  @override
  final dynamic value;

  /// 自定义校验函数名
  @override
  final String? custom;

  @override
  String toString() {
    return 'STACValidation(type: $type, message: $message, value: $value, custom: $custom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$STACValidationImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.custom, custom) || other.custom == custom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, message,
      const DeepCollectionEquality().hash(value), custom);

  /// Create a copy of STACValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$STACValidationImplCopyWith<_$STACValidationImpl> get copyWith =>
      __$$STACValidationImplCopyWithImpl<_$STACValidationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$STACValidationImplToJson(
      this,
    );
  }
}

abstract class _STACValidation implements STACValidation {
  const factory _STACValidation(
      {required final String type,
      final String? message,
      final dynamic value,
      final String? custom}) = _$STACValidationImpl;

  factory _STACValidation.fromJson(Map<String, dynamic> json) =
      _$STACValidationImpl.fromJson;

  /// 校验类型：required/pattern/minLength/maxLength/min/max
  @override
  String get type;

  /// 错误提示
  @override
  String? get message;

  /// 校验值（用于 pattern/min/max 等）
  @override
  dynamic get value;

  /// 自定义校验函数名
  @override
  String? get custom;

  /// Create a copy of STACValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$STACValidationImplCopyWith<_$STACValidationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

STACCondition _$STACConditionFromJson(Map<String, dynamic> json) {
  return _STACCondition.fromJson(json);
}

/// @nodoc
mixin _$STACCondition {
  /// 条件类型：eq/ne/gt/lt/contains/exists
  String get type => throw _privateConstructorUsedError;

  /// 左值（字段路径）
  String get left => throw _privateConstructorUsedError;

  /// 右值（常量或字段路径）
  dynamic get right => throw _privateConstructorUsedError;

  /// 是否取反
  bool get not => throw _privateConstructorUsedError;

  /// Serializes this STACCondition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of STACCondition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $STACConditionCopyWith<STACCondition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $STACConditionCopyWith<$Res> {
  factory $STACConditionCopyWith(
          STACCondition value, $Res Function(STACCondition) then) =
      _$STACConditionCopyWithImpl<$Res, STACCondition>;
  @useResult
  $Res call({String type, String left, dynamic right, bool not});
}

/// @nodoc
class _$STACConditionCopyWithImpl<$Res, $Val extends STACCondition>
    implements $STACConditionCopyWith<$Res> {
  _$STACConditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of STACCondition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? left = null,
    Object? right = freezed,
    Object? not = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      left: null == left
          ? _value.left
          : left // ignore: cast_nullable_to_non_nullable
              as String,
      right: freezed == right
          ? _value.right
          : right // ignore: cast_nullable_to_non_nullable
              as dynamic,
      not: null == not
          ? _value.not
          : not // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$STACConditionImplCopyWith<$Res>
    implements $STACConditionCopyWith<$Res> {
  factory _$$STACConditionImplCopyWith(
          _$STACConditionImpl value, $Res Function(_$STACConditionImpl) then) =
      __$$STACConditionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String left, dynamic right, bool not});
}

/// @nodoc
class __$$STACConditionImplCopyWithImpl<$Res>
    extends _$STACConditionCopyWithImpl<$Res, _$STACConditionImpl>
    implements _$$STACConditionImplCopyWith<$Res> {
  __$$STACConditionImplCopyWithImpl(
      _$STACConditionImpl _value, $Res Function(_$STACConditionImpl) _then)
      : super(_value, _then);

  /// Create a copy of STACCondition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? left = null,
    Object? right = freezed,
    Object? not = null,
  }) {
    return _then(_$STACConditionImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      left: null == left
          ? _value.left
          : left // ignore: cast_nullable_to_non_nullable
              as String,
      right: freezed == right
          ? _value.right
          : right // ignore: cast_nullable_to_non_nullable
              as dynamic,
      not: null == not
          ? _value.not
          : not // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$STACConditionImpl implements _STACCondition {
  const _$STACConditionImpl(
      {required this.type,
      required this.left,
      required this.right,
      this.not = false});

  factory _$STACConditionImpl.fromJson(Map<String, dynamic> json) =>
      _$$STACConditionImplFromJson(json);

  /// 条件类型：eq/ne/gt/lt/contains/exists
  @override
  final String type;

  /// 左值（字段路径）
  @override
  final String left;

  /// 右值（常量或字段路径）
  @override
  final dynamic right;

  /// 是否取反
  @override
  @JsonKey()
  final bool not;

  @override
  String toString() {
    return 'STACCondition(type: $type, left: $left, right: $right, not: $not)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$STACConditionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.left, left) || other.left == left) &&
            const DeepCollectionEquality().equals(other.right, right) &&
            (identical(other.not, not) || other.not == not));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, left, const DeepCollectionEquality().hash(right), not);

  /// Create a copy of STACCondition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$STACConditionImplCopyWith<_$STACConditionImpl> get copyWith =>
      __$$STACConditionImplCopyWithImpl<_$STACConditionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$STACConditionImplToJson(
      this,
    );
  }
}

abstract class _STACCondition implements STACCondition {
  const factory _STACCondition(
      {required final String type,
      required final String left,
      required final dynamic right,
      final bool not}) = _$STACConditionImpl;

  factory _STACCondition.fromJson(Map<String, dynamic> json) =
      _$STACConditionImpl.fromJson;

  /// 条件类型：eq/ne/gt/lt/contains/exists
  @override
  String get type;

  /// 左值（字段路径）
  @override
  String get left;

  /// 右值（常量或字段路径）
  @override
  dynamic get right;

  /// 是否取反
  @override
  bool get not;

  /// Create a copy of STACCondition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$STACConditionImplCopyWith<_$STACConditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
