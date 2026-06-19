---
description: "快速生成 Flutter 插件脚手架，包含 manifest.json、目录结构、基础代码和构建脚本"
globs: ["**/plugins/**/manifest.json", "**/plugins/**/src/index.js"]
alwaysApply: false
---

# Plugin Scaffolding Skill

快速生成 Flutter 插件平台的插件脚手架，自动创建标准目录结构、配置文件和基础代码。

## 触发关键词
- create plugin
- new plugin
- plugin scaffold
- generate plugin
- init plugin
- 创建插件
- 生成插件

---

## 标准插件目录结构

```
your_plugin/
├── manifest.json           # 插件清单文件
├── i18n/                   # 国际化资源
│   ├── zh-CN.json
│   └── en-US.json
├── scripts/                # 构建脚本
│   └── build.py
├── src/                    # 源代码目录
│   ├── index.js            # 插件入口文件
│   ├── state/              # 状态管理
│   │   └── plugin_state.js
│   ├── services/           # 服务层
│   │   ├── host_api.js     # 宿主能力调用封装
│   │   └── data_service.js # 数据服务
│   ├── controllers/        # 控制器（事件处理）
│   │   └── handlers.js
│   ├── ui/                 # UI 层
│   │   ├── pages/          # 页面
│   │   │   └── main_page.js
│   │   ├── cards/          # 卡片
│   │   │   └── summary_card.js
│   │   ├── components/     # 可复用组件
│   │   │   └── common.js
│   │   └── tokens.js       # UI Token（颜色、样式等）
│   ├── utils/              # 工具函数
│   │   └── helpers.js
│   └── i18n.js             # 国际化工具
└── dist/                   # 构建输出
    └── bundle.js

```

---

## manifest.json 模板

```json
{
  "id": "com.company.{plugin_name}",
  "name": "{插件名称}",
  "description": "{插件描述}",
  "version": "1.0.0",
  "publisher": "company",
  "type": "js",
  "platforms": [
    "ios",
    "android",
    "windows",
    "macos",
    "linux"
  ],
  "minHostVersion": "1.0.0",
  "engine": {
    "runtime": "quickjs",
    "bundle": "dist/bundle.js",
    "bundleHash": "",
    "bundleSize": 0,
    "entryFunction": "onActivate",
    "memoryLimitMb": 16,
    "executionTimeoutMs": 5000,
    "background": false
  },
  "activationEvents": [
    "onCommand:{plugin_name}.open"
  ],
  "permissions": [
    "storage.local",
    "toast.show"
  ],
  "capabilities": [],
  "stac": {
    "schemaVersion": "1.0",
    "components": [
      "text",
      "button",
      "textFormField",
      "container",
      "column",
      "row",
      "card"
    ],
    "customComponents": []
  },
  "performanceBudget": {
    "startupMs": 800,
    "firstScreenMs": 1500,
    "maxMemoryMb": 16,
    "maxCpuPercent": 10
  },
  "updatePolicy": {
    "channel": "stable",
    "allowAutoUpdate": true,
    "allowRollback": true,
    "allowRemoteConfig": true,
    "allowRemoteSchema": true,
    "allowRemoteCode": true,
    "signatureRequired": false
  }
}
```

### Manifest 字段说明

| 字段 | 必填 | 说明 |
|---|---|---|
| `id` | 是 | 全局唯一插件 ID，反向域名格式 |
| `name` | 是 | 插件展示名称 |
| `description` | 是 | 插件描述 |
| `version` | 是 | 语义化版本号 (major.minor.patch) |
| `type` | 是 | 插件类型：`js` / `builtin` / `webview` / `capability_composition` |
| `platforms` | 是 | 支持的平台列表 |
| `minHostVersion` | 是 | 最低宿主版本要求 |
| `engine.runtime` | 是 | JS 引擎：`quickjs` / `v8` |
| `engine.bundle` | 是 | JS Bundle 相对路径 |
| `engine.memoryLimitMb` | 否 | 内存上限，默认 16MB |
| `engine.background` | 否 | 是否允许后台常驻，默认 false |
| `activationEvents` | 是 | 激活事件列表，用于懒加载 |
| `permissions` | 是 | 权限声明列表 |
| `stac.schemaVersion` | 是 | STAC Schema 版本 |
| `stac.components` | 是 | 使用的 STAC 组件列表 |

### 常用 activationEvents

```json
"activationEvents": [
  "onCommand:{plugin_name}.open",          // 命令触发
  "onMenu:workspace.grid",                  // 菜单项触发
  "onAppStart",                             // 应用启动
  "onUserLogin",                            // 用户登录
  "onEvent:approval.created",               // 业务事件
  "onPushMessage:approval"                  // 推送消息
]
```

### 常用 permissions

```json
"permissions": [
  // 低风险权限
  "storage.local",              // 本地存储
  "toast.show",                 // Toast 提示
  "dialog.alert",               // 弹窗
  "navigation.open",            // 导航
  
  // 中风险权限
  "network.request",            // 网络请求
  "notification.send",          // 通知
  "calendar.read",              // 日历读取
  "calendar.write",             // 日历写入
  
  // 高风险权限（需用户确认）
  "org.contacts.read",          // 通讯录读取
  "approval.read",              // 审批读取
  "approval.write",             // 审批写入
  "device.location.read"        // 位置信息
]
```

---

## src/index.js 入口模板

```javascript
import { ensurePluginData } from './state/plugin_state.js';
import { renderMainPage } from './ui/pages/main_page.js';
import { renderSummaryCard } from './ui/cards/summary_card.js';

// 导出所有事件处理函数
export {
  handleButtonClick,
  handleFormSubmit,
  handleRefresh
} from './controllers/handlers.js';

/**
 * 插件激活时调用
 * 用于初始化状态、加载数据
 */
export function onActivate() {
  ensurePluginData();
}

/**
 * 插件停用时调用
 * 用于清理资源、保存状态
 */
export function onDeactivate() {
  // 清理逻辑
}

/**
 * 渲染插件页面
 * @param {Object} route - 路由参数
 * @returns {Object} STAC Schema
 */
export function renderPage(route) {
  ensurePluginData();
  return renderMainPage(route);
}

/**
 * 渲染插件卡片
 * @param {Object} context - 上下文
 * @returns {Object} STAC Schema
 */
export function renderCard(context) {
  ensurePluginData();
  return renderSummaryCard(context);
}

/**
 * 事件处理函数（由 Manifest 声明）
 * @param {Object} event - 事件数据
 * @param {Object} context - 上下文
 */
export function onCustomEvent(event, context) {
  // 处理自定义事件
}
```

---

## src/state/plugin_state.js 状态模板

```javascript
/**
 * 插件全局状态
 * 所有状态集中管理，避免全局变量污染
 */
export const pluginState = {
  // 基础状态
  initialized: false,
  loading: false,
  error: null,
  
  // 业务数据
  data: [],
  selectedId: null,
  
  // UI 状态
  currentPage: 'main',
  searchQuery: '',
  filters: {},
  
  // 表单数据
  formData: {
    title: '',
    description: ''
  }
};

/**
 * 确保插件数据已初始化
 * 懒加载模式，首次访问时初始化
 */
export function ensurePluginData() {
  if (pluginState.initialized) {
    return;
  }
  
  // 初始化数据
  pluginState.data = [];
  pluginState.initialized = true;
}

/**
 * 重置插件状态
 */
export function resetPluginState() {
  pluginState.initialized = false;
  pluginState.data = [];
  pluginState.selectedId = null;
  pluginState.error = null;
}
```

---

## src/services/host_api.js 宿主能力封装模板

```javascript
/**
 * 显示 Toast 提示
 * @param {string} message - 提示消息
 */
export function showToast(message) {
  if (typeof invokeHost !== 'function') {
    console.warn('invokeHost not available');
    return null;
  }
  return invokeHost('toast.show', { message });
}

/**
 * 显示确认对话框
 * @param {string} title - 标题
 * @param {string} message - 消息内容
 * @returns {Promise<boolean>} 用户是否确认
 */
export function showConfirm(title, message) {
  if (typeof invokeHost !== 'function') {
    return Promise.resolve(false);
  }
  return invokeHost('dialog.confirm', { title, message });
}

/**
 * 显示警告对话框
 * @param {string} title - 标题
 * @param {string} message - 消息内容
 */
export function showAlert(title, message) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('dialog.alert', { title, message });
}

/**
 * 发送通知
 * @param {string} title - 通知标题
 * @param {string} body - 通知内容
 * @param {Object} payload - 附加数据
 */
export function sendNotification(title, body, payload = {}) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('notification.send', { title, body, payload });
}

/**
 * 页面导航
 * @param {string} route - 路由路径
 * @param {Object} params - 路由参数
 */
export function navigateTo(route, params = {}) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('navigation.open', { route, params });
}

/**
 * 返回上一页
 */
export function navigateBack() {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('navigation.back', {});
}

/**
 * 本地存储 - 保存
 * @param {string} key - 键
 * @param {*} value - 值
 */
export function storageSet(key, value) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('storage.set', { 
    key, 
    value: JSON.stringify(value) 
  });
}

/**
 * 本地存储 - 读取
 * @param {string} key - 键
 * @returns {Promise<*>} 值
 */
export async function storageGet(key) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  const result = await invokeHost('storage.get', { key });
  if (result && result.value) {
    return JSON.parse(result.value);
  }
  return null;
}
```

---

## src/controllers/handlers.js 事件处理模板

```javascript
import { pluginState } from '../state/plugin_state.js';
import { showToast } from '../services/host_api.js';

/**
 * 处理按钮点击
 * @param {Object} state - 当前表单状态
 * @param {Object} context - 上下文
 * @returns {Object} STAC Update 指令
 */
export function handleButtonClick(state, context) {
  showToast('按钮被点击');
  
  // 返回 UI 更新指令
  return {
    type: 'none' // 不更新 UI
  };
}

/**
 * 处理表单提交
 * @param {Object} state - 表单状态
 * @param {Object} context - 上下文
 */
export async function handleFormSubmit(state, context) {
  // 表单校验
  if (!state.title || state.title.trim() === '') {
    await context.invokeHost('toast.show', { 
      message: '标题不能为空' 
    });
    return { type: 'none' };
  }
  
  // 更新状态
  pluginState.formData = {
    title: state.title,
    description: state.description || ''
  };
  
  // 显示成功提示
  await showToast('提交成功');
  
  // 返回导航指令
  await context.invokeHost('navigation.back', {});
  
  return { type: 'none' };
}

/**
 * 处理刷新
 */
export function handleRefresh(state, context) {
  // 刷新数据逻辑
  showToast('刷新中...');
  
  // 返回全量更新
  return {
    type: 'full',
    schema: {
      // 新的 Schema
    }
  };
}
```

---

## src/ui/pages/main_page.js 页面模板

```javascript
import { pluginState } from '../../state/plugin_state.js';

/**
 * 渲染主页面
 * @param {Object} route - 路由参数
 * @returns {Object} STAC Schema
 */
export function renderMainPage(route) {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: '插件标题',
    layout: {
      type: 'column',
      padding: '16,16,16,16',
      scrollable: true,
      crossAxisAlignment: 'stretch',
      spacing: 12
    },
    children: [
      // 标题
      {
        type: 'text',
        props: {
          text: '欢迎使用插件',
          style: 'headlineMedium'
        },
        style: {
          fontWeight: '700',
          color: '#111827'
        }
      },
      
      // 表单
      {
        type: 'card',
        style: {
          padding: '16,16,16,16'
        },
        children: [
          {
            type: 'textFormField',
            id: 'title',
            props: {
              label: '标题',
              hint: '请输入标题',
              initialValue: pluginState.formData.title
            }
          },
          {
            type: 'textarea',
            id: 'description',
            props: {
              label: '描述',
              hint: '请输入描述',
              initialValue: pluginState.formData.description,
              maxLines: 4
            }
          },
          {
            type: 'button',
            props: {
              text: '提交'
            },
            events: {
              onTap: 'handleFormSubmit'
            },
            style: {
              margin: '16,0,0,0'
            }
          }
        ]
      }
    ]
  };
}
```

---

## src/ui/cards/summary_card.js 卡片模板

```javascript
import { pluginState } from '../../state/plugin_state.js';

/**
 * 渲染摘要卡片
 * @param {Object} context - 上下文
 * @returns {Object} STAC Schema
 */
export function renderSummaryCard(context) {
  return {
    schemaVersion: '1.0',
    type: 'card',
    style: {
      padding: '12,12,12,12',
      margin: '8,8,8,8'
    },
    children: [
      {
        type: 'text',
        props: {
          text: '插件摘要',
          style: 'titleMedium'
        },
        style: {
          fontWeight: '600',
          color: '#1F2937'
        }
      },
      {
        type: 'text',
        props: {
          text: `数据数量: ${pluginState.data.length}`,
          style: 'bodyMedium'
        },
        style: {
          margin: '8,0,0,0',
          color: '#6B7280'
        }
      }
    ]
  };
}
```

---

## src/ui/tokens.js UI Token 模板

```javascript
/**
 * UI 设计 Token
 * 集中管理颜色、字体、间距等设计元素
 */

// 颜色
export const colors = {
  primary: '#2563EB',
  secondary: '#64748B',
  success: '#16A34A',
  warning: '#EA580C',
  error: '#DC2626',
  
  text: {
    primary: '#111827',
    secondary: '#6B7280',
    disabled: '#9CA3AF'
  },
  
  background: {
    default: '#FFFFFF',
    card: '#F9FAFB',
    hover: '#F3F4F6'
  },
  
  border: {
    default: '#E5E7EB',
    focus: '#3B82F6'
  }
};

// 字体大小
export const fontSize = {
  xs: 12,
  sm: 14,
  base: 16,
  lg: 18,
  xl: 20,
  '2xl': 24
};

// 间距
export const spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 20,
  '2xl': 24
};

/**
 * 创建文本组件
 */
export function text(content, size = 16, color = '#111827', weight = '400') {
  return {
    type: 'text',
    props: { text: content },
    style: {
      fontSize: size,
      color: color,
      fontWeight: weight
    }
  };
}

/**
 * 创建按钮组件
 */
export function button(text, handler, isPrimary = true) {
  return {
    type: 'button',
    props: { text },
    events: { onTap: handler },
    style: {
      backgroundColor: isPrimary ? colors.primary : colors.secondary
    }
  };
}

/**
 * 创建间隔组件
 */
export function sizedBox(width = 0, height = 0) {
  return {
    type: 'sizedBox',
    props: { width, height }
  };
}
```

---

## src/i18n.js 国际化模板

```javascript
import { pluginState } from './state/plugin_state.js';

// 加载国际化资源
let i18nData = {};

/**
 * 加载国际化文件
 * @param {string} locale - 语言代码
 */
export async function loadI18n(locale) {
  try {
    // 通过 Host Bridge 加载国际化文件
    const response = await invokeHost('file.read', {
      path: `i18n/${locale}.json`
    });
    i18nData = JSON.parse(response.content);
  } catch (error) {
    console.error('Failed to load i18n:', error);
    i18nData = {};
  }
}

/**
 * 翻译文本
 * @param {string} key - 翻译键
 * @param {Object} params - 参数
 * @returns {string} 翻译后的文本
 */
export function t(key, params = {}) {
  let text = i18nData[key] || key;
  
  // 替换参数
  Object.keys(params).forEach(param => {
    text = text.replace(`{${param}}`, params[param]);
  });
  
  return text;
}
```

---

## i18n/zh-CN.json 国际化资源模板

```json
{
  "plugin.name": "插件名称",
  "plugin.description": "插件描述",
  
  "common.ok": "确定",
  "common.cancel": "取消",
  "common.save": "保存",
  "common.delete": "删除",
  "common.edit": "编辑",
  "common.refresh": "刷新",
  
  "form.title": "标题",
  "form.description": "描述",
  "form.submit": "提交",
  
  "message.success": "操作成功",
  "message.error": "操作失败",
  "message.loading": "加载中..."
}
```

---

## scripts/build.py 构建脚本模板

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import json
import hashlib

def build_bundle():
    """构建 JS Bundle"""
    src_dir = 'src'
    dist_dir = 'dist'
    output_file = os.path.join(dist_dir, 'bundle.js')
    
    # 确保输出目录存在
    os.makedirs(dist_dir, exist_ok=True)
    
    # 简单的合并策略（生产环境应使用 webpack/rollup）
    bundle_content = []
    
    # 读取所有 JS 文件
    for root, dirs, files in os.walk(src_dir):
        for file in files:
            if file.endswith('.js'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    bundle_content.append(f'// {file_path}\n{content}\n')
    
    # 写入 bundle
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(bundle_content))
    
    # 计算 hash
    with open(output_file, 'rb') as f:
        bundle_hash = hashlib.sha256(f.read()).hexdigest()
    
    # 更新 manifest.json
    manifest_path = 'manifest.json'
    with open(manifest_path, 'r', encoding='utf-8') as f:
        manifest = json.load(f)
    
    manifest['engine']['bundleHash'] = bundle_hash
    manifest['engine']['bundleSize'] = os.path.getsize(output_file)
    
    with open(manifest_path, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)
    
    print(f'✓ Bundle built: {output_file}')
    print(f'✓ Size: {manifest["engine"]["bundleSize"]} bytes')
    print(f'✓ Hash: {bundle_hash}')

if __name__ == '__main__':
    build_bundle()
```

---

## Checklist

创建插件时确保：

- [ ] manifest.json 所有必填字段已填写
- [ ] 插件 ID 使用反向域名格式（如 com.company.plugin_name）
- [ ] permissions 只声明需要的权限
- [ ] activationEvents 配置了合适的激活条件
- [ ] src/index.js 导出了必要的入口函数
- [ ] 状态管理集中在 state/ 目录
- [ ] 宿主能力调用封装在 services/host_api.js
- [ ] UI 代码分离到 ui/ 目录
- [ ] 国际化资源准备完整
- [ ] 构建脚本可以正常执行
- [ ] 目录结构清晰，职责分明

---

## 快速命令

```bash
# 创建插件目录
mkdir -p your_plugin/{src/{state,services,controllers,ui/{pages,cards,components},utils},i18n,scripts,dist}

# 创建基础文件
touch your_plugin/manifest.json
touch your_plugin/src/index.js
touch your_plugin/src/state/plugin_state.js
touch your_plugin/scripts/build.py

# 构建插件
cd your_plugin && python3 scripts/build.py
```
