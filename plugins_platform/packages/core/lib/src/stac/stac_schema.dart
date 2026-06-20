import 'package:freezed_annotation/freezed_annotation.dart';

part 'stac_schema.freezed.dart';
part 'stac_schema.g.dart';

/// STAC Schema 版本
const String currentStacSchemaVersion = '1.0';

/// STAC 根节点
///
/// 表示一个完整的 STAC 页面或组件
@freezed
class STACSchema with _$STACSchema {
  const factory STACSchema({
    /// Schema 版本
    required String schemaVersion,

    /// 类型：page/card/dialog 等
    required String type,

    /// 标题
    String? title,

    /// 布局配置
    STACLayout? layout,

    /// 数据源配置
    Map<String, STACDataSource>? dataSources,

    /// 样式配置
    STACStyle? style,

    /// 事件配置
    Map<String, String>? events,

    /// 子组件列表
    @Default([]) List<STACNode> children,
  }) = _STACSchema;

  factory STACSchema.fromJson(Map<String, dynamic> json) =>
      _$STACSchemaFromJson(json);
}

/// STAC 节点
///
/// 表示 STAC 中的单个组件
@freezed
class STACNode with _$STACNode {
  const factory STACNode({
    /// 组件类型：text/button/image/form/list 等
    required String type,

    /// 组件 ID（用于事件回调）
    String? id,

    /// 组件属性
    @Default(<String, dynamic>{}) Map<String, dynamic> props,

    /// 子组件
    @Default([]) List<STACNode> children,

    /// 事件处理
    @Default(<String, String>{}) Map<String, String> events,

    /// 样式
    STACStyle? style,

    /// 数据绑定
    STACDataBinding? binding,

    /// 表单校验
    List<STACValidation>? validation,

    /// 条件渲染
    STACCondition? condition,
  }) = _STACNode;

  factory STACNode.fromJson(Map<String, dynamic> json) =>
      _$STACNodeFromJson(json);
}

/// 布局配置
@freezed
class STACLayout with _$STACLayout {
  const factory STACLayout({
    /// 布局类型：column/row/grid/stack 等
    required String type,

    /// 主轴对齐
    String? mainAxisAlignment,

    /// 交叉轴对齐
    String? crossAxisAlignment,

    /// 主轴间距
    double? spacing,

    /// 交叉轴间距（runSpacing）
    double? runSpacing,

    /// 内边距
    String? padding,

    /// 列数（grid 布局）
    int? crossAxisCount,

    /// 宽高比（grid 布局）
    double? aspectRatio,

    /// 是否可滚动
    @Default(false) bool scrollable,
  }) = _STACLayout;

  factory STACLayout.fromJson(Map<String, dynamic> json) =>
      _$STACLayoutFromJson(json);
}

/// 样式配置
@freezed
class STACStyle with _$STACStyle {
  const factory STACStyle({
    /// 背景色
    String? backgroundColor,

    /// 前景色
    String? color,

    /// 字体大小
    double? fontSize,

    /// 字体粗细
    String? fontWeight,

    /// 内边距
    String? padding,

    /// 外边距
    String? margin,

    /// 宽度
    double? width,

    /// 高度
    double? height,

    /// 圆角
    double? borderRadius,

    /// 边框
    String? border,

    /// 阴影
    String? boxShadow,

    /// 对齐
    String? textAlign,

    /// 装饰线
    String? textDecoration,

    /// 最大行数
    int? maxLines,

    /// 溢出处理
    String? overflow,
  }) = _STACStyle;

  factory STACStyle.fromJson(Map<String, dynamic> json) =>
      _$STACStyleFromJson(json);
}

/// 数据源配置
@freezed
class STACDataSource with _$STACDataSource {
  const factory STACDataSource({
    /// 数据源类型：capability/api/local
    required String sourceType,

    /// 能力 ID 或 API URL
    String? capability,

    /// 请求参数（支持模板变量）
    @Default(<String, dynamic>{}) Map<String, dynamic> params,

    /// 数据转换（简单的字段映射）
    Map<String, String>? transform,

    /// 默认值
    dynamic defaultValue,
  }) = _STACDataSource;

  factory STACDataSource.fromJson(Map<String, dynamic> json) =>
      _$STACDataSourceFromJson(json);
}

/// 数据绑定配置
@freezed
class STACDataBinding with _$STACDataBinding {
  const factory STACDataBinding({
    /// 绑定的数据源路径
    String? source,

    /// 绑定字段
    String? field,

    /// 绑定类型：value/text/src/href 等
    String? bindType,

    /// 格式化
    String? format,

    /// 默认值
    dynamic defaultValue,
  }) = _STACDataBinding;

  factory STACDataBinding.fromJson(Map<String, dynamic> json) =>
      _$STACDataBindingFromJson(json);
}

/// 表单校验规则
@freezed
class STACValidation with _$STACValidation {
  const factory STACValidation({
    /// 校验类型：required/pattern/minLength/maxLength/min/max
    required String type,

    /// 错误提示
    String? message,

    /// 校验值（用于 pattern/min/max 等）
    dynamic value,

    /// 自定义校验函数名
    String? custom,
  }) = _STACValidation;

  factory STACValidation.fromJson(Map<String, dynamic> json) =>
      _$STACValidationFromJson(json);
}

/// 条件渲染配置
@freezed
class STACCondition with _$STACCondition {
  const factory STACCondition({
    /// 条件类型：eq/ne/gt/lt/contains/exists
    required String type,

    /// 左值（字段路径）
    required String left,

    /// 右值（常量或字段路径）
    required dynamic right,

    /// 是否取反
    @Default(false) bool not,
  }) = _STACCondition;

  factory STACCondition.fromJson(Map<String, dynamic> json) =>
      _$STACConditionFromJson(json);
}

/// STAC 组件类型常量
class STACComponentTypes {
  // 布局组件
  static const String container = 'container';
  static const String column = 'column';
  static const String row = 'row';
  static const String stack = 'stack';
  static const String expanded = 'expanded';
  static const String sizedBox = 'sizedBox';

  // 基础组件
  static const String text = 'text';
  static const String image = 'image';
  static const String icon = 'icon';
  static const String divider = 'divider';

  // 表单组件
  static const String textFormField = 'textFormField';
  static const String textarea = 'textarea';
  static const String dropdown = 'dropdown';
  static const String checkbox = 'checkbox';
  static const String checkboxGroup = 'checkboxGroup';
  static const String radio = 'radio';
  static const String radioGroup = 'radioGroup';
  static const String switch_ = 'switch';
  static const String slider = 'slider';

  // 交互组件
  static const String button = 'button';
  static const String iconButton = 'iconButton';
  static const String fab = 'fab';

  // 列表组件
  static const String listView = 'listView';
  static const String gridView = 'gridView';
  static const String listItem = 'listItem';
  static const String card = 'card';

  // 容器组件
  static const String scaffold = 'scaffold';
  static const String appBar = 'appBar';
  static const String drawer = 'drawer';
  static const String bottomSheet = 'bottomSheet';

  // 对话框组件
  static const String dialog = 'dialog';
  static const String alertDialog = 'alertDialog';
  static const String confirmDialog = 'confirmDialog';
}

/// STAC 事件类型常量
class STACEventTypes {
  static const String onTap = 'onTap';
  static const String onLongPress = 'onLongPress';
  static const String onChanged = 'onChanged';
  static const String onSubmit = 'onSubmit';
  static const String onLoad = 'onLoad';
  static const String onError = 'onError';
  static const String onRefresh = 'onRefresh';
  static const String onScroll = 'onScroll';
  static const String onSwipe = 'onSwipe';
}
