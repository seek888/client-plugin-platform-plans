# BottomSheet 和 Dialog.Custom 能力文档

本文档描述 `bottomSheet.show` 和 `dialog.custom` 两个宿主能力的使用方法。

## bottomSheet.show

从底部弹出模态表单，支持 STAC Schema 渲染内容。

### 能力 ID
`bottomSheet.show`

### 参数

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| schema | STACSchema | 是 | STAC Schema 定义的表单内容 |
| title | String | 否 | 底部表单标题 |
| data | Map<String, dynamic> | 否 | 初始数据 |

### 返回值

```typescript
{
  submitted: boolean,  // 是否提交（true）或取消（false）
  data: Map<String, dynamic>  // 提交的表单数据
}
```

### 示例

```dart
final result = await hostBridge.handleInvoke(
  pluginId: 'your_plugin_id',
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
          'props': {
            'label': '标题',
            'hint': '请输入事件标题',
          },
        },
        {
          'type': 'textarea',
          'id': 'description',
          'props': {
            'label': '描述',
            'hint': '请输入事件描述',
            'maxLines': 3,
          },
        },
        {
          'type': 'dropdown',
          'id': 'priority',
          'props': {
            'label': '优先级',
            'options': [
              {'label': '高', 'value': 'high'},
              {'label': '中', 'value': 'medium'},
              {'label': '低', 'value': 'low'},
            ],
          },
        },
      ],
    },
    'data': {
      'priority': 'medium',  // 初始值
    },
  },
);

// 处理结果
if (result['data']['submitted']) {
  final formData = result['data']['data'];
  print('标题: ${formData['title']}');
  print('描述: ${formData['description']}');
  print('优先级: ${formData['priority']}');
}
```

### 特性

- **可滚动内容**：底部表单内容区域支持滚动，适合长表单
- **可拖动调整高度**：使用 DraggableScrollableSheet，用户可以拖动调整高度
- **表单验证**：自动集成表单验证，只有验证通过才能提交
- **取消/提交按钮**：默认提供取消和提交按钮

---

## dialog.custom

显示自定义对话框，支持 STAC Schema 渲染内容和自定义操作按钮。

### 能力 ID
`dialog.custom`

### 参数

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| schema | STACSchema | 是 | STAC Schema 定义的对话框内容 |
| title | String | 否 | 对话框标题 |
| data | Map<String, dynamic> | 否 | 初始数据 |
| actions | List<DialogAction> | 否 | 自定义操作按钮列表（为空则使用默认取消/确定按钮） |

#### DialogAction 结构

| 字段名 | 类型 | 说明 |
|--------|------|------|
| id | String | 操作 ID，返回时用于标识用户选择 |
| text | String | 按钮文本 |
| type | String | 按钮类型：`primary`（主要按钮）、`cancel`（取消按钮）、`default`（普通按钮） |

### 返回值

```typescript
{
  confirmed: boolean,  // 是否确认（true）或取消（false）
  action: String?,  // 用户选择的操作 ID
  data: Map<String, dynamic>  // 表单数据
}
```

### 示例 1：简单确认对话框

```dart
final result = await hostBridge.handleInvoke(
  pluginId: 'your_plugin_id',
  method: 'dialog.custom',
  params: {
    'title': '确认删除',
    'schema': {
      'schemaVersion': '1.0',
      'type': 'page',
      'children': [
        {
          'type': 'text',
          'props': {
            'text': '确定要删除这个事件吗？此操作无法撤销。',
          },
          'style': {
            'fontSize': 16.0,
          },
        },
      ],
    },
    'actions': [
      {
        'id': 'cancel',
        'text': '取消',
        'type': 'cancel',
      },
      {
        'id': 'delete',
        'text': '删除',
        'type': 'primary',
      },
    ],
  },
);

// 处理结果
if (result['data']['confirmed']) {
  if (result['data']['action'] == 'delete') {
    // 执行删除操作
  }
}
```

### 示例 2：包含表单的对话框

```dart
final result = await hostBridge.handleInvoke(
  pluginId: 'your_plugin_id',
  method: 'dialog.custom',
  params: {
    'title': '快速创建',
    'schema': {
      'schemaVersion': '1.0',
      'type': 'page',
      'children': [
        {
          'type': 'textFormField',
          'id': 'name',
          'props': {
            'label': '名称',
            'hint': '请输入名称',
          },
        },
        {
          'type': 'checkbox',
          'id': 'notify',
          'props': {
            'label': '创建后通知我',
          },
        },
      ],
    },
  },
);

// 处理结果
if (result['data']['confirmed']) {
  final formData = result['data']['data'];
  print('名称: ${formData['name']}');
  print('通知: ${formData['notify']}');
}
```

### 示例 3：多按钮选择对话框

```dart
final result = await hostBridge.handleInvoke(
  pluginId: 'your_plugin_id',
  method: 'dialog.custom',
  params: {
    'title': '保存方式',
    'schema': {
      'schemaVersion': '1.0',
      'type': 'page',
      'children': [
        {
          'type': 'text',
          'props': {
            'text': '请选择保存方式',
          },
        },
      ],
    },
    'actions': [
      {
        'id': 'cancel',
        'text': '取消',
        'type': 'cancel',
      },
      {
        'id': 'save_draft',
        'text': '保存草稿',
        'type': 'default',
      },
      {
        'id': 'publish',
        'text': '发布',
        'type': 'primary',
      },
    ],
  },
);

// 处理结果
if (result['data']['confirmed']) {
  switch (result['data']['action']) {
    case 'save_draft':
      // 保存为草稿
      break;
    case 'publish':
      // 发布
      break;
  }
}
```

### 特性

- **自定义内容**：使用 STAC Schema 自由定义对话框内容
- **灵活的按钮配置**：支持自定义多个操作按钮
- **表单支持**：可以在对话框中使用表单组件
- **默认按钮**：如果不指定 actions，会自动提供取消/确定按钮

---

## 使用场景

### bottomSheet.show 适用场景

- 创建/编辑表单（如创建事件、编辑任务）
- 较长的表单需要滚动
- 需要占据较大屏幕空间的输入场景
- 移动端友好的表单交互

### dialog.custom 适用场景

- 确认操作（删除、提交等）
- 快速输入（只有 1-2 个字段）
- 信息展示 + 操作选择
- 需要用户做出选择的场景

---

## 技术实现说明

### STAC Schema 渲染

两个能力都使用 `STACRenderer.render()` 来渲染内容，支持所有 STAC 组件类型：

- **表单组件**：textFormField, textarea, dropdown, checkbox, radio, switch, slider
- **布局组件**：container, column, row, stack
- **基础组件**：text, image, icon, divider, button
- **列表组件**：listView, gridView, card

### 表单管理

- 使用 `STACFormKey` 管理表单状态
- 自动收集表单字段值
- 支持表单验证（通过 `formKey.validate()`）
- 表单数据通过 `formKey.getValues()` 获取

### UI 设计

- **bottomSheet**：圆角顶部、标题栏、可滚动内容区、固定底部按钮
- **dialog**：居中显示、最大宽度 500px、最大高度 600px、可选标题栏

---

## 注意事项

1. **Schema 必须提供**：两个能力都要求 `schema` 参数，否则会抛出 `ArgumentError`
2. **Context 依赖**：需要 HostBridge 初始化时传入 `navigatorKey`
3. **表单验证**：如果表单验证失败，不会关闭弹窗
4. **取消操作**：用户点击取消或关闭按钮时，返回 `submitted: false` 或 `confirmed: false`
5. **异步调用**：两个能力都是异步的，需要 await 等待用户操作完成

---

## 完整示例

参考 `host_bridge/example/lib/main.dart` 获取完整的可运行示例。
