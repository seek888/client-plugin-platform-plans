---
description: "基于自然语言描述生成 STAC UI Schema，提供组件选择、布局生成、样式一致性检查"
globs: ["**/plugins/**/src/ui/**/*.js", "**/plugins/**/src/ui/tokens.js"]
alwaysApply: false
---

# STAC UI Development Skill

基于自然语言描述生成 STAC UI Schema，自动选择合适的组件、生成布局、确保样式一致性。

## 触发关键词
- create ui
- generate ui
- stac schema
- design ui
- build interface
- 生成界面
- 创建 UI
- 设计页面

---

## STAC 组件库

### 布局组件

#### column (垂直布局)
```javascript
{
  type: 'column',
  props: {
    crossAxisAlignment: 'start',  // 'start' | 'center' | 'end' | 'stretch'
    mainAxisAlignment: 'start',   // 'start' | 'center' | 'end' | 'spaceBetween'
    spacing: 12                    // 子元素间距
  },
  style: {
    padding: '16,16,16,16',        // 上,右,下,左
    scrollable: true               // 是否可滚动
  },
  children: []
}
```

#### row (水平布局)
```javascript
{
  type: 'row',
  props: {
    crossAxisAlignment: 'center',
    mainAxisAlignment: 'start',
    spacing: 8
  },
  children: []
}
```

#### container (容器)
```javascript
{
  type: 'container',
  style: {
    width: 200,
    height: 100,
    padding: '12,12,12,12',
    margin: '8,8,8,8',
    backgroundColor: '#FFFFFF',
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#E5E7EB'
  },
  children: []
}
```

#### card (卡片)
```javascript
{
  type: 'card',
  style: {
    padding: '16,16,16,16',
    margin: '8,8,8,8',
    elevation: 2,              // 阴影高度 0-24
    backgroundColor: '#FFFFFF'
  },
  children: []
}
```

#### stack (堆叠布局)
```javascript
{
  type: 'stack',
  props: {
    alignment: 'center'        // 对齐方式
  },
  children: []
}
```

#### expanded (弹性空间)
```javascript
{
  type: 'expanded',
  props: {
    flex: 1                    // 弹性系数
  },
  children: []
}
```

#### sizedBox (固定尺寸空白)
```javascript
{
  type: 'sizedBox',
  props: {
    width: 16,
    height: 16
  }
}
```

---

### 基础组件

#### text (文本)
```javascript
{
  type: 'text',
  props: {
    text: '显示内容',
    style: 'bodyMedium',       // Flutter TextStyle 预设
    maxLines: 2,
    overflow: 'ellipsis'       // 'clip' | 'ellipsis' | 'fade'
  },
  style: {
    fontSize: 16,
    color: '#111827',
    fontWeight: '400',         // '300' | '400' | '500' | '600' | '700'
    fontStyle: 'normal',       // 'normal' | 'italic'
    letterSpacing: 0.5,
    height: 1.5,               // 行高倍数
    textAlign: 'left'          // 'left' | 'center' | 'right'
  }
}
```

常用 Flutter TextStyle 预设：
- `displayLarge` (57px)
- `displayMedium` (45px)
- `displaySmall` (36px)
- `headlineLarge` (32px)
- `headlineMedium` (28px)
- `headlineSmall` (24px)
- `titleLarge` (22px)
- `titleMedium` (16px, 500 weight)
- `titleSmall` (14px, 500 weight)
- `bodyLarge` (16px)
- `bodyMedium` (14px)
- `bodySmall` (12px)
- `labelLarge` (14px, 500 weight)
- `labelMedium` (12px, 500 weight)
- `labelSmall` (11px, 500 weight)

#### image (图片)
```javascript
{
  type: 'image',
  props: {
    src: 'https://example.com/image.png',
    width: 200,
    height: 150,
    fit: 'cover'               // 'contain' | 'cover' | 'fill' | 'fitWidth' | 'fitHeight'
  },
  style: {
    borderRadius: 8
  }
}
```

#### icon (图标)
```javascript
{
  type: 'icon',
  props: {
    icon: 'check',             // Material Icons 名称
    size: 24,
    color: '#2563EB'
  }
}
```

#### divider (分割线)
```javascript
{
  type: 'divider',
  style: {
    height: 1,
    color: '#E5E7EB',
    margin: '12,0,12,0'
  }
}
```

---

### 表单组件

#### textFormField (单行输入框)
```javascript
{
  type: 'textFormField',
  id: 'email',                 // 表单字段 ID
  props: {
    label: '邮箱地址',
    hint: '请输入邮箱',
    initialValue: '',
    keyboardType: 'email',     // 'text' | 'email' | 'number' | 'phone' | 'url'
    obscureText: false,        // 是否密码模式
    maxLength: 50,
    enabled: true,
    autofocus: false
  },
  validation: [
    {
      type: 'required',
      message: '邮箱不能为空'
    },
    {
      type: 'email',
      message: '邮箱格式不正确'
    }
  ]
}
```

#### textarea (多行输入框)
```javascript
{
  type: 'textarea',
  id: 'description',
  props: {
    label: '描述',
    hint: '请输入描述信息',
    initialValue: '',
    maxLines: 4,
    minLines: 2,
    maxLength: 500
  },
  validation: [
    {
      type: 'maxLength',
      value: 500,
      message: '描述不能超过500字'
    }
  ]
}
```

#### dropdown (下拉选择)
```javascript
{
  type: 'dropdown',
  id: 'category',
  props: {
    label: '分类',
    hint: '请选择分类',
    value: 'option1',
    items: [
      { label: '选项1', value: 'option1' },
      { label: '选项2', value: 'option2' },
      { label: '选项3', value: 'option3' }
    ]
  }
}
```

#### checkbox (复选框)
```javascript
{
  type: 'checkbox',
  id: 'agree',
  props: {
    label: '同意用户协议',
    value: false
  }
}
```

#### switch (开关)
```javascript
{
  type: 'switch',
  id: 'notifications',
  props: {
    label: '推送通知',
    value: true
  }
}
```

#### slider (滑块)
```javascript
{
  type: 'slider',
  id: 'volume',
  props: {
    label: '音量',
    value: 50,
    min: 0,
    max: 100,
    divisions: 10            // 分割数
  }
}
```

---

### 交互组件

#### button (按钮)
```javascript
{
  type: 'button',
  props: {
    text: '提交',
    type: 'elevated',        // 'elevated' | 'filled' | 'outlined' | 'text'
    enabled: true,
    loading: false           // 加载状态
  },
  events: {
    onTap: 'handleSubmit'    // 事件处理函数名
  },
  style: {
    backgroundColor: '#2563EB',
    foregroundColor: '#FFFFFF',
    padding: '12,24,12,24',
    borderRadius: 8
  }
}
```

按钮类型样式：
- `elevated`: 带阴影的凸起按钮
- `filled`: 填充背景按钮（主按钮）
- `outlined`: 边框按钮
- `text`: 文本按钮（无背景）

#### iconButton (图标按钮)
```javascript
{
  type: 'iconButton',
  props: {
    icon: 'add',
    iconSize: 24,
    tooltip: '添加'
  },
  events: {
    onTap: 'handleAdd'
  },
  style: {
    color: '#2563EB'
  }
}
```

#### fab (浮动操作按钮)
```javascript
{
  type: 'fab',
  props: {
    icon: 'add',
    label: '新建',           // 可选文本
    mini: false              // 是否小尺寸
  },
  events: {
    onTap: 'handleCreate'
  }
}
```

---

### 列表组件

#### listView (列表)
```javascript
{
  type: 'listView',
  props: {
    scrollable: true,
    spacing: 8
  },
  children: []
}
```

#### gridView (网格)
```javascript
{
  type: 'gridView',
  props: {
    crossAxisCount: 3,       // 列数
    spacing: 8,              // 间距
    childAspectRatio: 1.0,   // 子元素宽高比
    scrollable: true
  },
  children: []
}
```

#### listItem (列表项)
```javascript
{
  type: 'listItem',
  props: {
    title: '标题',
    subtitle: '副标题',
    leading: {               // 左侧图标/头像
      type: 'icon',
      icon: 'person',
      color: '#6B7280'
    },
    trailing: {              // 右侧图标
      type: 'icon',
      icon: 'chevron_right',
      color: '#9CA3AF'
    }
  },
  events: {
    onTap: 'handleItemTap'
  }
}
```

---

### 容器组件

#### scaffold (脚手架)
```javascript
{
  type: 'scaffold',
  props: {
    appBar: {
      title: '页面标题',
      actions: [
        {
          type: 'iconButton',
          icon: 'search',
          onTap: 'handleSearch'
        }
      ]
    },
    body: {
      // 主体内容
    },
    floatingActionButton: {
      type: 'fab',
      icon: 'add',
      onTap: 'handleAdd'
    }
  }
}
```

#### appBar (应用栏)
```javascript
{
  type: 'appBar',
  props: {
    title: '标题',
    leading: {
      type: 'iconButton',
      icon: 'arrow_back',
      onTap: 'handleBack'
    },
    actions: []
  }
}
```

---

## 样式系统

### 颜色规范

```javascript
// 主题色
const colors = {
  // 品牌色
  primary: '#2563EB',
  secondary: '#64748B',
  
  // 语义色
  success: '#16A34A',
  warning: '#EA580C',
  error: '#DC2626',
  info: '#0EA5E9',
  
  // 文本色
  textPrimary: '#111827',
  textSecondary: '#6B7280',
  textTertiary: '#9CA3AF',
  textDisabled: '#D1D5DB',
  
  // 背景色
  background: '#FFFFFF',
  backgroundSecondary: '#F9FAFB',
  backgroundTertiary: '#F3F4F6',
  
  // 边框色
  border: '#E5E7EB',
  borderFocus: '#3B82F6',
  
  // 表面色
  surface: '#FFFFFF',
  surfaceVariant: '#F9FAFB'
};
```

### 间距规范

```javascript
const spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  base: 16,
  lg: 20,
  xl: 24,
  '2xl': 32,
  '3xl': 40,
  '4xl': 48
};

// 使用示例
{
  style: {
    padding: '16,16,16,16',    // base
    margin: '8,8,8,8'          // sm
  }
}
```

### 圆角规范

```javascript
const borderRadius = {
  none: 0,
  sm: 4,
  base: 8,
  md: 12,
  lg: 16,
  xl: 20,
  full: 9999               // 完全圆角
};
```

### 阴影规范

```javascript
const elevation = {
  none: 0,
  sm: 2,
  base: 4,
  md: 6,
  lg: 8,
  xl: 12
};
```

---

## 常见布局模式

### 1. 表单布局

```javascript
{
  type: 'column',
  props: {
    crossAxisAlignment: 'stretch',
    spacing: 16
  },
  style: {
    padding: '16,16,16,16'
  },
  children: [
    {
      type: 'text',
      props: {
        text: '表单标题',
        style: 'headlineMedium'
      }
    },
    {
      type: 'card',
      style: { padding: '16,16,16,16' },
      children: [
        {
          type: 'textFormField',
          id: 'field1',
          props: { label: '字段1' }
        },
        {
          type: 'textFormField',
          id: 'field2',
          props: { label: '字段2' }
        },
        {
          type: 'button',
          props: { text: '提交' },
          events: { onTap: 'handleSubmit' }
        }
      ]
    }
  ]
}
```

### 2. 列表布局

```javascript
{
  type: 'column',
  props: {
    crossAxisAlignment: 'stretch',
    spacing: 0
  },
  children: [
    {
      type: 'listItem',
      props: {
        title: '项目1',
        subtitle: '描述1',
        trailing: { type: 'icon', icon: 'chevron_right' }
      },
      events: { onTap: 'handleItem1' }
    },
    { type: 'divider' },
    {
      type: 'listItem',
      props: {
        title: '项目2',
        subtitle: '描述2'
      },
      events: { onTap: 'handleItem2' }
    }
  ]
}
```

### 3. 卡片网格布局

```javascript
{
  type: 'gridView',
  props: {
    crossAxisCount: 2,
    spacing: 12,
    childAspectRatio: 1.2
  },
  children: [
    {
      type: 'card',
      style: { padding: '12,12,12,12' },
      children: [
        {
          type: 'icon',
          props: { icon: 'calendar_today', size: 32, color: '#2563EB' }
        },
        {
          type: 'text',
          props: { text: '日历', style: 'titleMedium' },
          style: { margin: '8,0,0,0' }
        }
      ],
      events: { onTap: 'handleCalendar' }
    },
    {
      type: 'card',
      style: { padding: '12,12,12,12' },
      children: [
        {
          type: 'icon',
          props: { icon: 'task', size: 32, color: '#16A34A' }
        },
        {
          type: 'text',
          props: { text: '任务', style: 'titleMedium' },
          style: { margin: '8,0,0,0' }
        }
      ],
      events: { onTap: 'handleTasks' }
    }
  ]
}
```

### 4. 详情页布局

```javascript
{
  type: 'column',
  props: {
    crossAxisAlignment: 'stretch',
    spacing: 16
  },
  style: {
    padding: '16,16,16,16',
    scrollable: true
  },
  children: [
    // 头部信息
    {
      type: 'card',
      children: [
        {
          type: 'text',
          props: { text: '标题', style: 'headlineSmall' }
        },
        {
          type: 'text',
          props: { text: '2024-06-20', style: 'bodySmall' },
          style: { color: '#6B7280', margin: '4,0,0,0' }
        }
      ]
    },
    
    // 内容区域
    {
      type: 'card',
      children: [
        {
          type: 'text',
          props: { text: '详细内容...' }
        }
      ]
    },
    
    // 操作按钮
    {
      type: 'row',
      props: {
        mainAxisAlignment: 'spaceBetween'
      },
      children: [
        {
          type: 'button',
          props: { text: '编辑', type: 'outlined' },
          events: { onTap: 'handleEdit' }
        },
        {
          type: 'button',
          props: { text: '删除', type: 'outlined' },
          events: { onTap: 'handleDelete' },
          style: { foregroundColor: '#DC2626' }
        }
      ]
    }
  ]
}
```

### 5. 统计面板布局

```javascript
{
  type: 'row',
  props: {
    mainAxisAlignment: 'spaceAround'
  },
  children: [
    {
      type: 'column',
      props: { crossAxisAlignment: 'center' },
      children: [
        {
          type: 'text',
          props: { text: '125', style: 'headlineMedium' },
          style: { fontWeight: '700', color: '#2563EB' }
        },
        {
          type: 'text',
          props: { text: '总数', style: 'bodySmall' },
          style: { color: '#6B7280' }
        }
      ]
    },
    { type: 'divider', style: { width: 1, height: 40 } },
    {
      type: 'column',
      props: { crossAxisAlignment: 'center' },
      children: [
        {
          type: 'text',
          props: { text: '48', style: 'headlineMedium' },
          style: { fontWeight: '700', color: '#16A34A' }
        },
        {
          type: 'text',
          props: { text: '完成', style: 'bodySmall' },
          style: { color: '#6B7280' }
        }
      ]
    }
  ]
}
```

---

## 数据绑定

### 静态数据
```javascript
{
  type: 'text',
  props: {
    text: 'Hello World'
  }
}
```

### 动态数据（从状态获取）
```javascript
{
  type: 'text',
  props: {
    text: `${pluginState.userName}`
  }
}
```

### 条件渲染
```javascript
{
  type: 'column',
  children: [
    pluginState.loading ? {
      type: 'text',
      props: { text: '加载中...' }
    } : {
      type: 'text',
      props: { text: '加载完成' }
    }
  ]
}
```

### 列表渲染
```javascript
{
  type: 'column',
  children: pluginState.items.map(item => ({
    type: 'listItem',
    props: {
      title: item.title,
      subtitle: item.description
    },
    events: {
      onTap: 'handleItemClick'
    }
  }))
}
```

---

## 事件处理

### 事件绑定
```javascript
{
  type: 'button',
  props: { text: '点击' },
  events: {
    onTap: 'handleClick'      // 绑定到 controllers/handlers.js 中的函数
  }
}
```

### 事件处理函数
```javascript
// controllers/handlers.js
export function handleClick(state, context) {
  // state: 当前表单状态
  // context: 上下文对象，包含 invokeHost 等方法
  
  context.invokeHost('toast.show', { message: '按钮被点击' });
  
  // 返回 UI 更新指令
  return {
    type: 'none'  // 'none' | 'full' | 'patch'
  };
}
```

### 表单事件
```javascript
{
  type: 'textFormField',
  id: 'email',
  props: { label: '邮箱' },
  events: {
    onChange: 'handleEmailChange',
    onSubmit: 'handleSubmit'
  }
}
```

---

## 表单校验

### 校验规则

```javascript
validation: [
  {
    type: 'required',
    message: '此字段不能为空'
  },
  {
    type: 'email',
    message: '邮箱格式不正确'
  },
  {
    type: 'minLength',
    value: 6,
    message: '至少6个字符'
  },
  {
    type: 'maxLength',
    value: 50,
    message: '最多50个字符'
  },
  {
    type: 'pattern',
    value: '^[0-9]+$',
    message: '只能输入数字'
  },
  {
    type: 'custom',
    validator: 'validateCustomRule',
    message: '自定义校验失败'
  }
]
```

---

## 响应式布局

### 使用 expanded 实现弹性布局
```javascript
{
  type: 'row',
  children: [
    {
      type: 'expanded',
      props: { flex: 2 },
      children: [{
        type: 'text',
        props: { text: '左侧（2/3）' }
      }]
    },
    {
      type: 'expanded',
      props: { flex: 1 },
      children: [{
        type: 'text',
        props: { text: '右侧（1/3）' }
      }]
    }
  ]
}
```

### 使用约束实现适配
```javascript
{
  type: 'container',
  style: {
    width: '100%',           // 宽度百分比
    maxWidth: 600,           // 最大宽度
    padding: '16,16,16,16'
  }
}
```

---

## UI 一致性检查清单

生成 UI 时确保：

- [ ] 使用标准颜色规范（colors）
- [ ] 使用标准间距规范（spacing）
- [ ] 使用标准圆角规范（borderRadius）
- [ ] 文本使用 Flutter TextStyle 预设或自定义字体大小
- [ ] 主按钮使用 primary 色，次按钮使用 outlined 类型
- [ ] 表单字段有 label 和 hint
- [ ] 表单字段有合适的校验规则
- [ ] 交互元素有事件绑定
- [ ] 列表项有间距和分割
- [ ] 卡片有合适的 padding 和 elevation
- [ ] 布局使用 column/row 而不是绝对定位
- [ ] 可滚动内容设置 scrollable: true
- [ ] 图标使用 Material Icons

---

## Checklist

生成 STAC UI 时确保：

- [ ] Schema 版本正确（schemaVersion: '1.0'）
- [ ] 组件类型在 STAC 支持列表中
- [ ] 所有表单字段有唯一 ID
- [ ] 事件处理函数名正确
- [ ] 样式使用标准规范
- [ ] 布局结构清晰合理
- [ ] 交互反馈完整
- [ ] 数据绑定正确
- [ ] 条件渲染逻辑正确
- [ ] 国际化键值正确

---

## 快速示例

### 简单页面
```javascript
export function renderSimplePage() {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: '示例页面',
    layout: {
      type: 'column',
      padding: '16,16,16,16',
      scrollable: true,
      spacing: 12
    },
    children: [
      {
        type: 'text',
        props: { text: '欢迎使用', style: 'headlineMedium' }
      },
      {
        type: 'button',
        props: { text: '开始使用' },
        events: { onTap: 'handleStart' }
      }
    ]
  };
}
```
