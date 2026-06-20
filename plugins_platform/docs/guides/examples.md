# 常见场景示例

本文档提供了多个常见场景的插件示例，帮助你快速理解不同类型插件的实现方法。

## 示例概览

| 示例 | 难度 | 主要技术点 | 适用场景 |
|------|------|-----------|---------|
| [Hello World](#示例-1-hello-world-插件) | ⭐ | 基础 UI、状态管理 | 学习插件基础 |
| [表单提交插件](#示例-2-表单提交插件) | ⭐⭐ | 表单组件、数据验证 | 数据收集、设置页面 |
| [列表展示插件](#示例-3-列表展示插件) | ⭐⭐ | 网络请求、列表渲染 | 内容展示、RSS 订阅 |
| [日历集成插件](#示例-4-日历集成插件) | ⭐⭐⭐ | 能力调用、复杂交互 | 日程管理、事件提醒 |

---

## 示例 1: Hello World 插件

**难度：** ⭐  
**技术点：** 基础 UI 渲染、按钮交互、本地存储

这是最简单的插件示例，已在[快速入门](quick-start.md)中详细介绍。

### 核心代码片段

```javascript
export function renderPage() {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: 'Hello Plugin',
    layout: {
      type: 'column',
      padding: '16,16,16,16'
    },
    children: [
      {
        type: 'text',
        props: { text: '👋 Hello World!' },
        style: { fontSize: 24, color: '#111827' }
      }
    ]
  };
}
```

### 学习要点

- ✅ 理解 STAC Schema 结构
- ✅ 掌握基础组件使用
- ✅ 学习事件处理机制

---

## 示例 2: 表单提交插件

**难度：** ⭐⭐  
**技术点：** 表单组件、输入验证、数据持久化

创建一个用户反馈表单，包含文本输入、多行文本和提交按钮。

### manifest.json 配置

```json
{
  "id": "com.example.feedback_form",
  "name": "用户反馈表单",
  "description": "收集用户反馈和建议",
  "version": "1.0.0",
  "permissions": [
    "storage.local",
    "toast.show",
    "network.request"
  ],
  "stac": {
    "schemaVersion": "1.0",
    "components": [
      "text",
      "button",
      "textFormField",
      "textarea",
      "card",
      "column",
      "sizedBox"
    ]
  }
}
```

### src/index.js 完整实现

```javascript
// 表单状态
let formData = {
  name: '',
  email: '',
  feedback: ''
};

let errors = {
  name: '',
  email: '',
  feedback: ''
};

export function onActivate() {
  console.log('[feedback_form] Plugin activated');
  // 尝试恢复草稿
  const draft = invokeHost('storage.local.get', { key: 'feedback_draft' });
  if (draft && draft.value) {
    try {
      formData = JSON.parse(draft.value);
    } catch (e) {
      console.error('[feedback_form] Failed to parse draft:', e);
    }
  }
}

export function onDeactivate() {
  // 保存草稿
  invokeHost('storage.local.set', {
    key: 'feedback_draft',
    value: JSON.stringify(formData)
  });
}

export function renderPage() {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: '用户反馈',
    layout: {
      type: 'column',
      padding: '16,16,16,16',
      scrollable: true,
      crossAxisAlignment: 'stretch'
    },
    children: [
      // 表单说明
      {
        type: 'card',
        style: { padding: '16,16,16,16' },
        children: [
          createText('📝 我们重视您的意见', 20, '#111827', '600'),
          createSizedBox(8),
          createText('请填写以下表单，帮助我们改进产品。', 14, '#6B7280', '400')
        ]
      },
      
      createSizedBox(16),
      
      // 表单卡片
      {
        type: 'card',
        style: { padding: '16,16,16,16' },
        children: [
          // 姓名输入
          createText('姓名 *', 14, '#374151', '500'),
          createSizedBox(8),
          {
            type: 'textFormField',
            props: {
              value: formData.name,
              placeholder: '请输入您的姓名',
              onChange: 'handleNameChange',
              enabled: true
            },
            style: {
              borderColor: errors.name ? '#EF4444' : '#D1D5DB',
              borderRadius: '8'
            }
          },
          errors.name ? createErrorText(errors.name) : createSizedBox(4),
          
          createSizedBox(16),
          
          // 邮箱输入
          createText('邮箱 *', 14, '#374151', '500'),
          createSizedBox(8),
          {
            type: 'textFormField',
            props: {
              value: formData.email,
              placeholder: 'your@email.com',
              onChange: 'handleEmailChange',
              keyboardType: 'email',
              enabled: true
            },
            style: {
              borderColor: errors.email ? '#EF4444' : '#D1D5DB',
              borderRadius: '8'
            }
          },
          errors.email ? createErrorText(errors.email) : createSizedBox(4),
          
          createSizedBox(16),
          
          // 反馈内容
          createText('反馈内容 *', 14, '#374151', '500'),
          createSizedBox(8),
          {
            type: 'textarea',
            props: {
              value: formData.feedback,
              placeholder: '请详细描述您的反馈或建议...',
              onChange: 'handleFeedbackChange',
              maxLines: 8,
              minLines: 4,
              enabled: true
            },
            style: {
              borderColor: errors.feedback ? '#EF4444' : '#D1D5DB',
              borderRadius: '8'
            }
          },
          errors.feedback ? createErrorText(errors.feedback) : createSizedBox(4),
          
          createSizedBox(24),
          
          // 提交按钮
          {
            type: 'button',
            props: {
              text: '提交反馈',
              onPressed: 'handleSubmit'
            },
            style: {
              backgroundColor: '#3B82F6',
              textColor: '#FFFFFF',
              borderRadius: '8',
              padding: '14,0,14,0'
            }
          }
        ]
      }
    ]
  };
}

/**
 * 处理姓名输入变化
 */
export function handleNameChange(event) {
  formData.name = event.value || '';
  errors.name = '';
  updateUI();
}

/**
 * 处理邮箱输入变化
 */
export function handleEmailChange(event) {
  formData.email = event.value || '';
  errors.email = '';
  updateUI();
}

/**
 * 处理反馈内容变化
 */
export function handleFeedbackChange(event) {
  formData.feedback = event.value || '';
  errors.feedback = '';
  updateUI();
}

/**
 * 验证表单
 */
function validateForm() {
  let isValid = true;
  
  // 验证姓名
  if (!formData.name.trim()) {
    errors.name = '请输入姓名';
    isValid = false;
  } else if (formData.name.length < 2) {
    errors.name = '姓名至少 2 个字符';
    isValid = false;
  }
  
  // 验证邮箱
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!formData.email.trim()) {
    errors.email = '请输入邮箱';
    isValid = false;
  } else if (!emailRegex.test(formData.email)) {
    errors.email = '邮箱格式不正确';
    isValid = false;
  }
  
  // 验证反馈内容
  if (!formData.feedback.trim()) {
    errors.feedback = '请输入反馈内容';
    isValid = false;
  } else if (formData.feedback.length < 10) {
    errors.feedback = '反馈内容至少 10 个字符';
    isValid = false;
  }
  
  return isValid;
}

/**
 * 处理表单提交
 */
export function handleSubmit() {
  console.log('[feedback_form] Submitting form...');
  
  // 验证表单
  if (!validateForm()) {
    console.log('[feedback_form] Validation failed');
    updateUI();
    invokeHost('toast.show', {
      message: '请检查表单输入',
      duration: 2000
    });
    return;
  }
  
  // 提交数据（这里模拟提交到服务器）
  try {
    const response = invokeHost('network.request', {
      method: 'POST',
      url: 'https://api.example.com/feedback',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        name: formData.name,
        email: formData.email,
        feedback: formData.feedback,
        timestamp: new Date().toISOString()
      })
    });
    
    // 提交成功
    console.log('[feedback_form] Submit success');
    invokeHost('toast.show', {
      message: '感谢您的反馈！',
      duration: 3000
    });
    
    // 清空表单
    formData = { name: '', email: '', feedback: '' };
    errors = { name: '', email: '', feedback: '' };
    
    // 删除草稿
    invokeHost('storage.local.remove', { key: 'feedback_draft' });
    
    updateUI();
  } catch (error) {
    console.error('[feedback_form] Submit failed:', error);
    invokeHost('toast.show', {
      message: '提交失败，请稍后重试',
      duration: 2000
    });
  }
}

// ============ 辅助函数 ============

function createText(text, size, color, weight) {
  return {
    type: 'text',
    props: { text },
    style: {
      fontSize: size,
      color,
      fontWeight: weight || '400'
    }
  };
}

function createErrorText(text) {
  return {
    type: 'text',
    props: { text },
    style: {
      fontSize: 12,
      color: '#EF4444',
      fontWeight: '400',
      margin: '4,0,0,0'
    }
  };
}

function createSizedBox(height) {
  return {
    type: 'sizedBox',
    props: { height }
  };
}
```

### 学习要点

- ✅ 表单组件的使用（textFormField、textarea）
- ✅ 表单状态管理和双向绑定
- ✅ 输入验证和错误提示
- ✅ 数据持久化（草稿保存）
- ✅ 网络请求提交数据

---

## 示例 3: 列表展示插件

**难度：** ⭐⭐  
**技术点：** 网络请求、列表渲染、分页加载

创建一个新闻列表插件，从 API 获取数据并展示。

### manifest.json 配置

```json
{
  "id": "com.example.news_list",
  "name": "新闻列表",
  "description": "展示最新新闻资讯",
  "version": "1.0.0",
  "permissions": [
    "network.request",
    "storage.local"
  ],
  "stac": {
    "schemaVersion": "1.0",
    "components": [
      "text",
      "button",
      "card",
      "column",
      "row",
      "sizedBox",
      "iconButton",
      "image"
    ]
  }
}
```

### src/index.js 核心实现

```javascript
// 状态管理
let articles = [];
let isLoading = false;
let hasError = false;
let errorMessage = '';

export function onActivate() {
  console.log('[news_list] Plugin activated');
  loadArticles();
}

export function onDeactivate() {
  console.log('[news_list] Plugin deactivated');
}

export function renderPage() {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: '新闻资讯',
    layout: {
      type: 'column',
      padding: '0,0,0,0',
      scrollable: true,
      crossAxisAlignment: 'stretch'
    },
    children: [
      // 头部操作栏
      {
        type: 'card',
        style: {
          padding: '16,16,16,16',
          margin: '0,0,0,0'
        },
        children: [
          {
            type: 'row',
            props: {
              mainAxisAlignment: 'spaceBetween',
              crossAxisAlignment: 'center'
            },
            children: [
              createText('📰 最新资讯', 20, '#111827', '600'),
              {
                type: 'iconButton',
                props: {
                  icon: 'refresh',
                  onPressed: 'handleRefresh'
                }
              }
            ]
          }
        ]
      },
      
      // 加载状态
      isLoading ? createLoadingView() : null,
      
      // 错误状态
      hasError ? createErrorView() : null,
      
      // 文章列表
      ...articles.map((article, index) => createArticleCard(article, index))
    ].filter(Boolean)
  };
}

/**
 * 加载文章列表
 */
async function loadArticles() {
  if (isLoading) return;
  
  isLoading = true;
  hasError = false;
  updateUI();
  
  try {
    console.log('[news_list] Fetching articles...');
    const response = await invokeHost('network.request', {
      method: 'GET',
      url: 'https://api.example.com/news',
      headers: {
        'Accept': 'application/json'
      }
    });
    
    if (!response || !response.success) {
      throw new Error('Network request failed');
    }
    
    const data = response.data?.json || {};
    articles = data.articles || [];
    
    console.log('[news_list] Loaded', articles.length, 'articles');
    
    // 缓存到本地
    invokeHost('storage.local.set', {
      key: 'news_cache',
      value: JSON.stringify({ articles, timestamp: Date.now() })
    });
    
  } catch (error) {
    console.error('[news_list] Failed to load articles:', error);
    hasError = true;
    errorMessage = '加载失败，请稍后重试';
    
    // 尝试从缓存加载
    const cached = invokeHost('storage.local.get', { key: 'news_cache' });
    if (cached && cached.value) {
      try {
        const data = JSON.parse(cached.value);
        articles = data.articles || [];
        hasError = false;
        errorMessage = '';
      } catch (e) {
        console.error('[news_list] Failed to parse cache:', e);
      }
    }
  } finally {
    isLoading = false;
    updateUI();
  }
}

/**
 * 处理刷新
 */
export function handleRefresh() {
  console.log('[news_list] Refreshing...');
  articles = [];
  loadArticles();
}

/**
 * 处理文章点击
 */
export function handleArticleClick(event) {
  const index = event.index;
  const article = articles[index];
  
  console.log('[news_list] Article clicked:', article.title);
  
  // 打开文章详情（这里简化为显示 toast）
  invokeHost('toast.show', {
    message: `打开: ${article.title}`,
    duration: 2000
  });
}

// ============ UI 组件 ============

function createLoadingView() {
  return {
    type: 'card',
    style: {
      padding: '32,16,32,16',
      margin: '16,16,16,16'
    },
    children: [
      {
        type: 'column',
        props: {
          mainAxisAlignment: 'center',
          crossAxisAlignment: 'center'
        },
        children: [
          createText('正在加载...', 16, '#6B7280', '400')
        ]
      }
    ]
  };
}

function createErrorView() {
  return {
    type: 'card',
    style: {
      padding: '32,16,32,16',
      margin: '16,16,16,16',
      backgroundColor: '#FEE2E2'
    },
    children: [
      createText('⚠️ ' + errorMessage, 14, '#DC2626', '400'),
      createSizedBox(12),
      {
        type: 'button',
        props: {
          text: '重试',
          onPressed: 'handleRefresh'
        },
        style: {
          backgroundColor: '#DC2626',
          textColor: '#FFFFFF',
          borderRadius: '6'
        }
      }
    ]
  };
}

function createArticleCard(article, index) {
  return {
    type: 'card',
    props: {
      onTap: 'handleArticleClick',
      tapData: { index }
    },
    style: {
      padding: '16,16,16,16',
      margin: '16,16,0,16'
    },
    children: [
      createText(article.title, 16, '#111827', '600'),
      createSizedBox(8),
      createText(article.summary || '', 14, '#6B7280', '400'),
      createSizedBox(8),
      {
        type: 'row',
        props: {
          mainAxisAlignment: 'spaceBetween'
        },
        children: [
          createText(article.author || '未知', 12, '#9CA3AF', '400'),
          createText(formatDate(article.publishedAt), 12, '#9CA3AF', '400')
        ]
      }
    ]
  };
}

// ============ 辅助函数 ============

function createText(text, size, color, weight) {
  return {
    type: 'text',
    props: { text },
    style: {
      fontSize: size,
      color,
      fontWeight: weight || '400'
    }
  };
}

function createSizedBox(height) {
  return {
    type: 'sizedBox',
    props: { height }
  };
}

function formatDate(dateString) {
  if (!dateString) return '';
  const date = new Date(dateString);
  return date.toLocaleDateString('zh-CN');
}
```

### 学习要点

- ✅ 异步网络请求处理
- ✅ 列表数据渲染
- ✅ 加载状态管理
- ✅ 错误处理和重试
- ✅ 本地缓存优化

---

## 示例 4: 日历集成插件

**难度：** ⭐⭐⭐  
**技术点：** 宿主能力调用、复杂状态管理、多模块组织

创建一个日历插件，展示事件并支持创建、编辑和删除。

> **提示：** 这是一个较复杂的示例，建议先学习前面的示例。完整实现可参考 `examples/demo_app/assets/plugins/work_calendar/`。

### 项目结构

```
calendar_plugin/
├── manifest.json
├── src/
│   ├── index.js              # 入口文件
│   ├── state/
│   │   └── calendar_state.js # 状态管理
│   ├── ui/
│   │   ├── pages/
│   │   │   └── calendar_page.js  # 日历页面
│   │   └── components/
│   │       ├── month_view.js     # 月视图
│   │       └── event_card.js     # 事件卡片
│   └── controllers/
│       └── event_handlers.js     # 事件处理
├── dist/
│   └── bundle.js
└── scripts/
    └── build.py
```

### manifest.json 关键配置

```json
{
  "id": "com.example.calendar",
  "name": "日历助手",
  "permissions": [
    "calendar.read",
    "calendar.write",
    "notification.send",
    "storage.local"
  ],
  "capabilities": [
    {
      "id": "calendar.event.get",
      "type": "data",
      "permissions": ["calendar.read"]
    },
    {
      "id": "calendar.event.create",
      "type": "action",
      "permissions": ["calendar.write"]
    }
  ],
  "activationEvents": [
    "onCommand:calendar.open",
    "onEvent:calendar.eventCreated"
  ]
}
```

### src/index.js 入口

```javascript
import { initCalendarState, getEventsForMonth } from './state/calendar_state.js';
import { renderCalendarPage } from './ui/pages/calendar_page.js';
import { 
  handleDateClick, 
  handleCreateEvent,
  handleDeleteEvent 
} from './controllers/event_handlers.js';

// 导出生命周期函数
export function onActivate() {
  console.log('[calendar] Plugin activated');
  initCalendarState();
}

export function onDeactivate() {
  console.log('[calendar] Plugin deactivated');
}

// 导出 UI 渲染函数
export function renderPage(route) {
  return renderCalendarPage(route);
}

// 导出事件处理函数
export {
  handleDateClick,
  handleCreateEvent,
  handleDeleteEvent
};
```

### 状态管理示例

```javascript
// src/state/calendar_state.js

let currentMonth = new Date();
let events = [];

export function initCalendarState() {
  loadEventsFromHost();
}

export function loadEventsFromHost() {
  try {
    const response = invokeHost('calendar.event.get', {
      startDate: getMonthStart(currentMonth),
      endDate: getMonthEnd(currentMonth)
    });
    
    if (response && response.events) {
      events = response.events;
    }
  } catch (error) {
    console.error('[calendar] Failed to load events:', error);
  }
}

export function getEventsForDate(date) {
  const dateString = formatDate(date);
  return events.filter(e => formatDate(new Date(e.startTime)) === dateString);
}

export function createEvent(eventData) {
  try {
    const response = invokeHost('calendar.event.create', eventData);
    if (response && response.success) {
      events.push(response.event);
      return true;
    }
  } catch (error) {
    console.error('[calendar] Failed to create event:', error);
  }
  return false;
}

// ... 更多状态管理函数
```

### 学习要点

- ✅ 模块化代码组织
- ✅ 复杂状态管理
- ✅ 宿主能力深度集成
- ✅ 多页面路由
- ✅ 权限和安全

---

## 更多资源

### 现有插件参考

在 `examples/demo_app/assets/plugins/` 目录下有两个完整的插件实现：

1. **ai_news_daily**
   - 简单的数据提供插件
   - RSS feed 集成
   - 网络请求和数据映射

2. **work_calendar**
   - 复杂的业务插件
   - 完整的 CRUD 操作
   - 多模块架构
   - 国际化支持

### STAC 组件参考

常用组件及其用途：

| 组件 | 用途 | 示例 |
|------|------|------|
| `text` | 文本显示 | 标题、说明文字 |
| `button` | 按钮 | 提交、取消操作 |
| `textFormField` | 单行输入 | 姓名、邮箱 |
| `textarea` | 多行输入 | 评论、反馈 |
| `card` | 卡片容器 | 分组内容 |
| `column` | 垂直布局 | 表单、列表 |
| `row` | 水平布局 | 操作栏、标签 |
| `image` | 图片 | 封面、图标 |
| `iconButton` | 图标按钮 | 刷新、删除 |
| `sizedBox` | 间距 | 组件间距 |

### 宿主能力参考

常用能力及其用途：

| 能力 | 权限 | 用途 |
|------|------|------|
| `storage.local.get/set` | `storage.local` | 本地数据存储 |
| `network.request` | `network.request` | HTTP 请求 |
| `toast.show` | `toast.show` | 轻提示 |
| `dialog.alert` | `dialog.alert` | 弹窗提示 |
| `notification.send` | `notification.send` | 系统通知 |
| `calendar.event.get` | `calendar.read` | 读取日历 |
| `calendar.event.create` | `calendar.write` | 创建事件 |

### 调试技巧

1. **使用 console.log**
   ```javascript
   console.log('[plugin_name] Debug info:', data);
   ```

2. **错误处理**
   ```javascript
   try {
     const result = invokeHost('some.capability', params);
   } catch (error) {
     console.error('[plugin_name] Error:', error);
     invokeHost('toast.show', { message: '操作失败' });
   }
   ```

3. **状态追踪**
   ```javascript
   export function handleAction() {
     console.log('[plugin_name] Before:', state);
     // ... 修改状态
     console.log('[plugin_name] After:', state);
     updateUI();
   }
   ```

---

## 总结

通过这些示例，你应该已经掌握了：

- ✅ 不同复杂度插件的开发方法
- ✅ 表单、列表等常见 UI 模式
- ✅ 网络请求和数据处理
- ✅ 宿主能力的调用方式
- ✅ 代码组织和模块化

### 下一步建议

1. **实践**: 选择一个示例，动手实现并运行
2. **改造**: 修改现有插件，添加新功能
3. **创新**: 基于你的需求，设计一个新插件
4. **深入**: 阅读现有插件的完整源码

祝你开发顺利！🚀
