# STAC 组件库文档

## 概述

STAC (Schema-based Type-safe Adaptive Components) 是插件平台的声明式 UI 框架。插件通过 JSON Schema 描述界面，由宿主 Flutter 应用渲染为原生组件。

### 设计理念

- **声明式**：UI 通过 JSON Schema 描述，而非命令式代码
- **类型安全**：所有组件属性都有明确的类型定义
- **跨平台**：同一份 Schema 在 iOS/Android 上渲染为原生组件
- **安全隔离**：JS 插件无法直接访问 DOM 或原生 UI API

### 与传统 UI 框架的区别

| 特性 | STAC | 传统 Web UI |
|------|------|------------|
| 渲染方式 | 原生 Flutter Widget | WebView DOM |
| 性能 | 接近原生 | 受限于 WebView |
| 安全性 | 沙箱隔离，无 DOM 访问 | 可能存在 XSS 风险 |
| 样式 | Flutter 样式系统 | CSS |
| 事件处理 | 回调到 JS Runtime | DOM 事件 |

---

## STAC Schema 结构

### STACSchema 根节点

表示一个完整的 STAC 页面或组件。

```json
{
  "schemaVersion": "1.0",
  "type": "page",
  "title": "页面标题",
  "layout": { ... },
  "dataSources": { ... },
  "style": { ... },
  "events": { ... },
  "children": [ ... ]
}
```

**字段说明**：

- `schemaVersion` (必填): Schema 版本，当前为 `"1.0"`
- `type` (必填): 类型，如 `"page"`, `"card"`, `"dialog"`
- `title` (可选): 标题
- `layout` (可选): 布局配置
- `dataSources` (可选): 数据源配置
- `style` (可选): 全局样式
- `events` (可选): 事件配置
- `children` (必填): 子组件列表

---

### STACNode 节点

表示 STAC 中的单个组件。

```json
{
  "type": "button",
  "id": "submit-btn",
  "props": {
    "text": "提交"
  },
  "children": [],
  "events": {
    "onTap": "handleSubmit"
  },
  "style": { ... },
  "binding": { ... },
  "validation": [ ... ],
  "condition": { ... }
}
```

**字段说明**：

- `type` (必填): 组件类型
- `id` (可选): 组件 ID，用于事件回调
- `props` (必填): 组件属性
- `children` (可选): 子组件列表
- `events` (可选): 事件处理
- `style` (可选): 样式配置
- `binding` (可选): 数据绑定
- `validation` (可选): 表单校验
- `condition` (可选): 条件渲染

---

### STACLayout 布局配置

```json
{
  "type": "column",
  "mainAxisAlignment": "center",
  "crossAxisAlignment": "stretch",
  "spacing": 16.0,
  "padding": "16,24,16,24",
  "scrollable": true
}
```

**字段说明**：

- `type`: 布局类型 (`column`, `row`, `grid`, `stack`)
- `mainAxisAlignment`: 主轴对齐 (`start`, `center`, `end`, `spaceBetween`, `spaceAround`)
- `crossAxisAlignment`: 交叉轴对齐 (`start`, `center`, `end`, `stretch`)
- `spacing`: 主轴间距（像素）
- `runSpacing`: 交叉轴间距（grid 布局）
- `padding`: 内边距 (格式: "top,right,bottom,left")
- `crossAxisCount`: 列数（grid 布局）
- `aspectRatio`: 宽高比（grid 布局）
- `scrollable`: 是否可滚动

---

### STACStyle 样式配置

```json
{
  "backgroundColor": "#FFFFFF",
  "color": "#333333",
  "fontSize": 16.0,
  "fontWeight": "bold",
  "padding": "8,12,8,12",
  "margin": "0,0,16,0",
  "width": 200.0,
  "height": 48.0,
  "borderRadius": 8.0,
  "border": "1,#E0E0E0",
  "textAlign": "center"
}
```

**字段说明**：

- `backgroundColor`: 背景色（十六进制）
- `color`: 前景色/文字色
- `fontSize`: 字体大小
- `fontWeight`: 字体粗细 (`normal`, `bold`, `w100`-`w900`)
- `padding`: 内边距 (格式: "top,right,bottom,left")
- `margin`: 外边距 (格式: "top,right,bottom,left")
- `width` / `height`: 宽度/高度
- `borderRadius`: 圆角半径
- `border`: 边框 (格式: "width,color")
- `boxShadow`: 阴影
- `textAlign`: 文本对齐 (`left`, `center`, `right`)
- `textDecoration`: 装饰线 (`none`, `underline`)
- `maxLines`: 最大行数
- `overflow`: 溢出处理 (`clip`, `ellipsis`, `fade`)

---

### STACDataSource 数据源配置

```json
{
  "sourceType": "capability",
  "capability": "org.contacts.search",
  "params": {
    "keyword": "{{searchKeyword}}"
  },
  "transform": {
    "name": "$.data.items[*].name"
  },
  "defaultValue": []
}
```

**字段说明**：

- `sourceType`: 数据源类型 (`capability`, `api`, `local`)
- `capability`: 能力 ID（当 `sourceType` 为 `capability` 时）
- `params`: 请求参数（支持模板变量 `{{variableName}}`）
- `transform`: 数据转换（字段映射）
- `defaultValue`: 默认值

---

### STACDataBinding 数据绑定

```json
{
  "source": "contacts",
  "field": "name",
  "bindType": "text",
  "format": "{{value}}",
  "defaultValue": "未命名"
}
```

**字段说明**：

- `source`: 绑定的数据源路径
- `field`: 绑定字段
- `bindType`: 绑定类型 (`value`, `text`, `src`, `href`)
- `format`: 格式化字符串
- `defaultValue`: 默认值

---

### STACValidation 表单校验

```json
{
  "type": "required",
  "message": "此字段为必填项"
}
```

```json
{
  "type": "pattern",
  "value": "^[a-zA-Z0-9]+$",
  "message": "只能包含字母和数字"
}
```

**校验类型**：

- `required`: 必填
- `pattern`: 正则表达式
- `minLength`: 最小长度
- `maxLength`: 最大长度
- `min`: 最小值（数字）
- `max`: 最大值（数字）
- `custom`: 自定义校验函数名

---

### STACCondition 条件渲染

```json
{
  "type": "eq",
  "left": "{{userRole}}",
  "right": "admin",
  "not": false
}
```

**条件类型**：

- `eq`: 等于
- `ne`: 不等于
- `gt`: 大于
- `lt`: 小于
- `contains`: 包含
- `exists`: 存在

---

## 组件类型完整列表

### 布局组件

#### container

容器组件，用于包裹其他组件。

**Props**:

```json
{
  "padding": "16,16,16,16",
  "margin": "0,0,16,0",
  "decoration": {
    "color": "#FFFFFF",
    "borderRadius": 8.0,
    "border": "1,#E0E0E0"
  }
}
```

**示例**:

```json
{
  "type": "container",
  "props": {
    "padding": "16,16,16,16"
  },
  "style": {
    "backgroundColor": "#F5F5F5",
    "borderRadius": 8.0
  },
  "children": [
    {
      "type": "text",
      "props": { "text": "这是一个容器" }
    }
  ]
}
```

---

#### column

垂直布局组件。

**Props**:

```json
{
  "mainAxisAlignment": "start",
  "crossAxisAlignment": "center",
  "spacing": 8.0
}
```

**示例**:

```json
{
  "type": "column",
  "props": {
    "mainAxisAlignment": "center",
    "crossAxisAlignment": "stretch",
    "spacing": 16.0
  },
  "children": [
    {
      "type": "text",
      "props": { "text": "标题" }
    },
    {
      "type": "text",
      "props": { "text": "内容" }
    }
  ]
}
```

---

#### row

水平布局组件。

**Props**:

```json
{
  "mainAxisAlignment": "spaceBetween",
  "crossAxisAlignment": "center",
  "spacing": 8.0
}
```

**示例**:

```json
{
  "type": "row",
  "props": {
    "mainAxisAlignment": "spaceBetween"
  },
  "children": [
    {
      "type": "text",
      "props": { "text": "左侧" }
    },
    {
      "type": "text",
      "props": { "text": "右侧" }
    }
  ]
}
```

---

#### stack

层叠布局组件。

**Props**:

```json
{
  "alignment": "center"
}
```

**示例**:

```json
{
  "type": "stack",
  "props": {
    "alignment": "center"
  },
  "children": [
    {
      "type": "image",
      "props": { "src": "background.png" }
    },
    {
      "type": "text",
      "props": { "text": "叠加文字" },
      "style": { "color": "#FFFFFF" }
    }
  ]
}
```

---

#### expanded

可扩展组件（在 row/column 中占据剩余空间）。

**Props**:

```json
{
  "flex": 1
}
```

---

#### sizedBox

固定尺寸盒子。

**Props**:

```json
{
  "width": 100.0,
  "height": 50.0
}
```

---

### 基础组件

#### text

文本组件。

**Props**:

```json
{
  "text": "显示的文本",
  "style": {
    "fontSize": 16.0,
    "color": "#333333",
    "fontWeight": "normal",
    "textAlign": "left"
  }
}
```

**示例**:

```json
{
  "type": "text",
  "props": {
    "text": "欢迎使用插件平台"
  },
  "style": {
    "fontSize": 20.0,
    "fontWeight": "bold",
    "color": "#1976D2"
  }
}
```

---

#### image

图片组件。

**Props**:

```json
{
  "src": "https://example.com/image.png",
  "width": 200.0,
  "height": 150.0,
  "fit": "cover"
}
```

**fit 取值**:

- `fill`: 填充
- `contain`: 包含
- `cover`: 覆盖
- `fitWidth`: 适应宽度
- `fitHeight`: 适应高度

---

#### icon

图标组件。

**Props**:

```json
{
  "icon": "check_circle",
  "size": 24.0,
  "color": "#4CAF50"
}
```

**常用图标名**:

- `check_circle`, `error`, `info`, `warning`
- `home`, `person`, `settings`, `search`
- `add`, `remove`, `edit`, `delete`
- `arrow_back`, `arrow_forward`, `arrow_upward`, `arrow_downward`

---

#### divider

分割线组件。

**Props**:

```json
{
  "height": 1.0,
  "color": "#E0E0E0",
  "indent": 16.0,
  "endIndent": 16.0
}
```

---

### 表单组件

#### textFormField

文本输入框。

**Props**:

```json
{
  "label": "用户名",
  "placeholder": "请输入用户名",
  "initialValue": "",
  "maxLength": 50,
  "obscureText": false,
  "keyboardType": "text"
}
```

**keyboardType 取值**:

- `text`: 普通文本
- `number`: 数字
- `email`: 邮箱
- `phone`: 电话
- `url`: URL

**事件**:

- `onChanged`: 文本改变时触发
- `onSubmit`: 提交时触发

**示例**:

```json
{
  "type": "textFormField",
  "id": "username-input",
  "props": {
    "label": "用户名",
    "placeholder": "请输入用户名"
  },
  "events": {
    "onChanged": "handleUsernameChange"
  },
  "validation": [
    {
      "type": "required",
      "message": "用户名不能为空"
    },
    {
      "type": "minLength",
      "value": 3,
      "message": "用户名至少 3 个字符"
    }
  ]
}
```

---

#### textarea

多行文本输入框。

**Props**:

```json
{
  "label": "备注",
  "placeholder": "请输入备注",
  "maxLines": 5,
  "minLines": 3
}
```

---

#### dropdown

下拉选择器。

**Props**:

```json
{
  "label": "选择部门",
  "value": "dept_1",
  "items": [
    { "value": "dept_1", "label": "产品部" },
    { "value": "dept_2", "label": "研发部" }
  ]
}
```

**事件**:

- `onChanged`: 选择改变时触发

---

#### checkbox

复选框。

**Props**:

```json
{
  "label": "我同意服务条款",
  "value": false
}
```

**事件**:

- `onChanged`: 选中状态改变时触发

---

#### radio

单选按钮。

**Props**:

```json
{
  "groupValue": "option1",
  "value": "option1",
  "label": "选项 1"
}
```

---

#### switch

开关组件。

**Props**:

```json
{
  "value": false,
  "label": "启用通知"
}
```

---

#### slider

滑块组件。

**Props**:

```json
{
  "value": 50.0,
  "min": 0.0,
  "max": 100.0,
  "divisions": 10,
  "label": "音量"
}
```

---

### 交互组件

#### button

按钮组件。

**Props**:

```json
{
  "text": "确定",
  "type": "elevated",
  "disabled": false
}
```

**type 取值**:

- `elevated`: 凸起按钮（默认）
- `filled`: 填充按钮
- `outlined`: 边框按钮
- `text`: 文本按钮

**事件**:

- `onTap`: 点击时触发

**示例**:

```json
{
  "type": "button",
  "id": "submit-btn",
  "props": {
    "text": "提交",
    "type": "elevated"
  },
  "events": {
    "onTap": "handleSubmit"
  },
  "style": {
    "backgroundColor": "#1976D2",
    "color": "#FFFFFF"
  }
}
```

---

#### iconButton

图标按钮。

**Props**:

```json
{
  "icon": "search",
  "tooltip": "搜索"
}
```

---

#### fab

浮动操作按钮。

**Props**:

```json
{
  "icon": "add",
  "label": "新建"
}
```

---

### 列表组件

#### listView

列表视图组件。

**Props**:

```json
{
  "scrollDirection": "vertical",
  "itemCount": 10,
  "itemBuilder": "buildListItem"
}
```

---

#### gridView

网格视图组件。

**Props**:

```json
{
  "crossAxisCount": 2,
  "mainAxisSpacing": 16.0,
  "crossAxisSpacing": 16.0,
  "childAspectRatio": 1.0
}
```

---

#### listItem

列表项组件。

**Props**:

```json
{
  "leading": { "type": "icon", "props": { "icon": "person" } },
  "title": "张三",
  "subtitle": "产品部",
  "trailing": { "type": "icon", "props": { "icon": "arrow_forward" } }
}
```

---

#### card

卡片组件。

**Props**:

```json
{
  "elevation": 2.0,
  "margin": "8,8,8,8"
}
```

---

### 容器组件

#### scaffold

页面脚手架（包含 AppBar、Body、BottomNavigationBar 等）。

**Props**:

```json
{
  "appBar": { ... },
  "body": { ... },
  "floatingActionButton": { ... }
}
```

---

#### appBar

应用栏组件。

**Props**:

```json
{
  "title": "页面标题",
  "leading": { "type": "iconButton", "props": { "icon": "arrow_back" } },
  "actions": [
    { "type": "iconButton", "props": { "icon": "search" } }
  ]
}
```

---

#### drawer

侧边抽屉。

**Props**:

```json
{
  "child": { ... }
}
```

---

#### bottomSheet

底部表单。

**Props**:

```json
{
  "child": { ... },
  "isScrollControlled": true
}
```

---

### 对话框组件

#### dialog

对话框基础组件。

**Props**:

```json
{
  "title": "对话框标题",
  "content": { ... },
  "actions": [ ... ]
}
```

---

#### alertDialog

警告对话框。

**Props**:

```json
{
  "title": "提示",
  "content": "确定要删除吗？",
  "actions": [
    { "type": "button", "props": { "text": "取消" } },
    { "type": "button", "props": { "text": "确定" } }
  ]
}
```

---

#### confirmDialog

确认对话框。

**Props**:

```json
{
  "title": "确认操作",
  "message": "此操作不可撤销，确定继续吗？",
  "confirmText": "确定",
  "cancelText": "取消"
}
```

---

## 事件系统

STAC 支持以下事件类型：

### onTap

点击事件。

```json
{
  "type": "button",
  "events": {
    "onTap": "handleButtonClick"
  }
}
```

在 JS 中处理：

```javascript
function handleButtonClick(event) {
  console.log('按钮被点击');
}
```

---

### onLongPress

长按事件。

```json
{
  "type": "container",
  "events": {
    "onLongPress": "handleLongPress"
  }
}
```

---

### onChanged

值改变事件（用于表单组件）。

```json
{
  "type": "textFormField",
  "events": {
    "onChanged": "handleInputChange"
  }
}
```

```javascript
function handleInputChange(event) {
  const newValue = event.value;
  console.log('输入值改变:', newValue);
}
```

---

### onSubmit

提交事件（用于表单）。

```json
{
  "type": "textFormField",
  "events": {
    "onSubmit": "handleFormSubmit"
  }
}
```

---

### onLoad

加载事件（页面或组件加载时触发）。

```json
{
  "type": "page",
  "events": {
    "onLoad": "handlePageLoad"
  }
}
```

---

### onError

错误事件。

```json
{
  "type": "image",
  "events": {
    "onError": "handleImageError"
  }
}
```

---

### onRefresh

刷新事件（下拉刷新）。

```json
{
  "type": "listView",
  "events": {
    "onRefresh": "handleRefresh"
  }
}
```

---

### onScroll

滚动事件。

```json
{
  "type": "listView",
  "events": {
    "onScroll": "handleScroll"
  }
}
```

---

### onSwipe

滑动事件。

```json
{
  "type": "listItem",
  "events": {
    "onSwipe": "handleSwipe"
  }
}
```

---

## 数据绑定与动态渲染

### 数据源配置

```json
{
  "dataSources": {
    "userList": {
      "sourceType": "capability",
      "capability": "org.contacts.search",
      "params": {
        "keyword": ""
      }
    }
  }
}
```

### 数据绑定语法

```json
{
  "type": "text",
  "props": {
    "text": "{{userName}}"
  }
}
```

### 列表数据绑定

```json
{
  "type": "listView",
  "binding": {
    "source": "userList",
    "field": "items"
  },
  "children": [
    {
      "type": "listItem",
      "props": {
        "title": "{{item.name}}",
        "subtitle": "{{item.department}}"
      }
    }
  ]
}
```

### 条件渲染

```json
{
  "type": "text",
  "props": {
    "text": "管理员专用"
  },
  "condition": {
    "type": "eq",
    "left": "{{userRole}}",
    "right": "admin"
  }
}
```

---

## 最佳实践

### 1. 组件组合模式

将复杂 UI 分解为小的、可复用的组件。

```json
{
  "type": "card",
  "children": [
    {
      "type": "row",
      "props": {
        "mainAxisAlignment": "spaceBetween"
      },
      "children": [
        {
          "type": "column",
          "children": [
            {
              "type": "text",
              "props": { "text": "{{article.title}}" },
              "style": { "fontWeight": "bold", "fontSize": 16.0 }
            },
            {
              "type": "text",
              "props": { "text": "{{article.author}}" },
              "style": { "color": "#666666", "fontSize": 12.0 }
            }
          ]
        },
        {
          "type": "image",
          "props": {
            "src": "{{article.thumbnail}}",
            "width": 80.0,
            "height": 80.0
          }
        }
      ]
    }
  ]
}
```

### 2. 性能优化建议

- **限制列表长度**：使用分页加载，避免一次渲染过多项
- **图片懒加载**：为 image 组件设置合理的 loading 策略
- **避免深层嵌套**：组件嵌套深度不超过 10 层
- **缓存数据源**：对不常变化的数据使用本地缓存

### 3. 常见错误和解决方案

**错误 1**: Schema 解析失败

```
Error: Invalid STAC schema: missing required field 'type'
```

**解决方案**: 确保每个组件都有 `type` 字段。

---

**错误 2**: 事件处理函数未定义

```
Error: Event handler 'handleSubmit' is not defined
```

**解决方案**: 在 JS Runtime 中定义对应的处理函数。

```javascript
function handleSubmit(event) {
  // 处理逻辑
}
```

---

**错误 3**: 数据绑定路径错误

```
Error: Cannot resolve binding path '{{user.name}}'
```

**解决方案**: 检查数据源是否已正确配置，路径是否正确。

---

## 完整示例

### 联系人列表页面

```json
{
  "schemaVersion": "1.0",
  "type": "page",
  "title": "联系人",
  "dataSources": {
    "contacts": {
      "sourceType": "capability",
      "capability": "org.contacts.search",
      "params": {}
    }
  },
  "children": [
    {
      "type": "scaffold",
      "props": {
        "appBar": {
          "type": "appBar",
          "props": {
            "title": "联系人",
            "actions": [
              {
                "type": "iconButton",
                "props": { "icon": "search" },
                "events": { "onTap": "handleSearch" }
              }
            ]
          }
        },
        "body": {
          "type": "listView",
          "binding": {
            "source": "contacts",
            "field": "items"
          },
          "children": [
            {
              "type": "listItem",
              "props": {
                "leading": {
                  "type": "icon",
                  "props": { "icon": "person" }
                },
                "title": "{{item.name}}",
                "subtitle": "{{item.department}}"
              },
              "events": {
                "onTap": "handleContactTap"
              }
            }
          ]
        }
      }
    }
  ],
  "events": {
    "onLoad": "loadContacts"
  }
}
```

对应的 JS 代码：

```javascript
// 页面加载时调用
async function loadContacts() {
  // 数据源会自动加载，无需手动调用
  console.log('联系人页面已加载');
}

// 搜索按钮点击
function handleSearch() {
  // 打开搜索页面或显示搜索框
  host.invoke('navigation.open', {
    route: '/contacts/search'
  });
}

// 联系人项点击
function handleContactTap(event) {
  const contact = event.item;
  host.invoke('navigation.open', {
    route: '/contacts/detail',
    arguments: {
      contactId: contact.id
    }
  });
}
```

---

## 附录

### Schema 版本历史

- **1.0.0** (当前版本) - 初始版本，包含所有核心组件

### 支持的平台

- iOS 13.0+
- Android 5.0+ (API Level 21+)

### 相关文档

- [能力桥接 API 文档](./capabilities.md)
- [插件 Manifest 配置文档](./manifest.md)
- [JS 运行时 API 文档](./js-runtime.md)
