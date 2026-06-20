# 插件 Manifest 配置文档

## 概述

插件 Manifest 文件（`manifest.json`）是插件的核心配置文件，描述了插件的元数据、权限需求、能力声明和运行时配置。宿主应用通过解析 Manifest 来识别、加载和管理插件。

## 基本结构

```json
{
  "id": "com.example.myplugin",
  "name": "我的插件",
  "description": "这是一个示例插件",
  "version": "1.0.0",
  "publisher": "Example Inc.",
  "type": "js",
  "platforms": ["ios", "android"],
  "minHostVersion": "1.0.0",
  "engine": { ... },
  "activationEvents": [ ... ],
  "permissions": [ ... ],
  "capabilities": [ ... ],
  "stac": { ... },
  "performanceBudget": { ... },
  "updatePolicy": { ... }
}
```

---

## 字段详解

### 必填字段

#### id

插件唯一标识符，采用反向域名格式。

- **类型**: `string`
- **格式**: 反向域名，如 `com.company.plugin-name`
- **示例**: `"com.example.rss-reader"`

**规则**:
- 必须全局唯一
- 只能包含小写字母、数字、点号(`.`)和短横线(`-`)
- 建议使用公司域名倒序

```json
{
  "id": "com.example.news-aggregator"
}
```

---

#### name

插件展示名称。

- **类型**: `string`
- **长度**: 1-50 字符
- **示例**: `"RSS 新闻阅读器"`

```json
{
  "name": "RSS 新闻阅读器"
}
```

---

#### version

插件版本号，遵循语义化版本规范（Semantic Versioning）。

- **类型**: `string`
- **格式**: `MAJOR.MINOR.PATCH`
- **示例**: `"1.2.3"`

**版本号说明**:
- **MAJOR**: 重大更新，可能包含不兼容的 API 变更
- **MINOR**: 功能更新，向后兼容
- **PATCH**: 问题修复，向后兼容

```json
{
  "version": "1.2.3"
}
```

---

#### publisher

发布者名称。

- **类型**: `string`
- **示例**: `"Example Inc."`

```json
{
  "publisher": "Example Inc."
}
```

---

#### type

插件类型。

- **类型**: `enum`
- **可选值**:
  - `"js"` - JS 插件（QuickJS 运行时）
  - `"builtin"` - 内置 Flutter 模块
  - `"webview"` - WebView 插件
  - `"capability_composition"` - 能力编排插件
  - `"remote_action"` - 远程插件服务

```json
{
  "type": "js"
}
```

**类型说明**:

| 类型 | 说明 | 适用场景 |
|------|------|---------|
| `js` | 使用 QuickJS 运行时执行 JS 代码 | 大多数插件场景 |
| `builtin` | 编译期内置的 Flutter 模块 | 核心功能，性能要求高 |
| `webview` | 白名单 Web 应用 | 已有 Web 应用迁移 |
| `capability_composition` | 纯 Schema，无 JS 逻辑 | 简单的 UI 组合 |
| `remote_action` | 逻辑在服务端执行 | 需要服务端计算 |

---

#### platforms

支持的平台列表。

- **类型**: `string[]`
- **可选值**: `"ios"`, `"android"`, `"web"`, `"desktop"`
- **示例**: `["ios", "android"]`

```json
{
  "platforms": ["ios", "android"]
}
```

---

#### minHostVersion

最低宿主版本要求。

- **类型**: `string`
- **格式**: 语义化版本号
- **默认值**: `"1.0.0"`

```json
{
  "minHostVersion": "1.2.0"
}
```

---

### 可选字段

#### description

插件描述信息。

- **类型**: `string`
- **长度**: 最多 500 字符
- **示例**: `"一个强大的 RSS 新闻聚合阅读器"`

```json
{
  "description": "支持多源订阅、离线阅读和智能推荐的 RSS 阅读器"
}
```

---

## JS 引擎配置 (engine)

**仅 `type: "js"` 插件需要配置此字段。**

```json
{
  "engine": {
    "runtime": "quickjs",
    "bundle": "https://cdn.example.com/plugins/my-plugin/bundle.js",
    "bundleHash": "sha256:a1b2c3d4...",
    "bundleSize": 102400,
    "entryFunction": "onActivate",
    "memoryLimitMb": 16,
    "executionTimeoutMs": 5000,
    "background": false
  }
}
```

### 字段说明

#### runtime

运行时类型。

- **类型**: `string`
- **可选值**: `"quickjs"`, `"v8"`
- **默认值**: `"quickjs"`

```json
{
  "runtime": "quickjs"
}
```

---

#### bundle

JS Bundle 的 URL 或本地路径。

- **类型**: `string`
- **示例**: 
  - 远程: `"https://cdn.example.com/bundle.js"`
  - 本地: `"file:///data/plugins/bundle.js"`

```json
{
  "bundle": "https://cdn.example.com/my-plugin/v1.0.0/bundle.js"
}
```

---

#### bundleHash

Bundle 文件的 SHA-256 哈希值，用于完整性校验。

- **类型**: `string`
- **格式**: `"sha256:hexstring"`
- **必填**: 是（生产环境）

```json
{
  "bundleHash": "sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
}
```

**生成方法**:

```bash
# macOS/Linux
shasum -a 256 bundle.js

# 输出格式
# e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  bundle.js
```

---

#### bundleSize

Bundle 文件大小（字节）。

- **类型**: `number`
- **示例**: `102400` (100 KB)

```json
{
  "bundleSize": 102400
}
```

---

#### entryFunction

插件入口函数名。

- **类型**: `string`
- **默认值**: `"onActivate"`

```json
{
  "entryFunction": "onActivate"
}
```

**对应的 JS 代码**:

```javascript
// 入口函数，插件激活时调用
function onActivate() {
  console.log('插件已激活');
  // 初始化逻辑
}
```

---

#### memoryLimitMb

内存限制（MB）。

- **类型**: `number`
- **默认值**: `16`
- **范围**: 1-128

```json
{
  "memoryLimitMb": 32
}
```

---

#### executionTimeoutMs

单次执行超时时间（毫秒）。

- **类型**: `number`
- **默认值**: `5000`
- **范围**: 1000-30000

```json
{
  "executionTimeoutMs": 10000
}
```

---

#### background

是否允许后台常驻。

- **类型**: `boolean`
- **默认值**: `false`

```json
{
  "background": true
}
```

**警告**: 后台常驻会持续占用内存和 CPU，需要谨慎使用。

---

## 激活事件 (activationEvents)

定义插件何时被激活（懒加载）。

- **类型**: `string[]`
- **默认值**: `[]`（立即激活）

```json
{
  "activationEvents": [
    "onStartup",
    "onCommand:openRssReader",
    "onView:rss-feed-list"
  ]
}
```

### 激活事件类型

| 事件 | 说明 | 示例 |
|------|------|------|
| `onStartup` | 应用启动时激活 | `"onStartup"` |
| `onCommand:{commandId}` | 执行特定命令时激活 | `"onCommand:openSettings"` |
| `onView:{viewId}` | 打开特定视图时激活 | `"onView:article-detail"` |
| `onFileSystem:{pattern}` | 匹配文件系统事件 | `"onFileSystem:**/*.rss"` |
| `onUri:{scheme}` | 处理特定 URI scheme | `"onUri:rss://"` |

**示例**:

```json
{
  "activationEvents": [
    "onStartup",
    "onCommand:refreshFeeds",
    "onView:feed-list"
  ]
}
```

---

## 权限声明 (permissions)

声明插件需要的权限列表。

- **类型**: `string[]`
- **默认值**: `[]`

```json
{
  "permissions": [
    "storage.local",
    "network.request",
    "notification.send",
    "org.contacts.read"
  ]
}
```

### 权限列表

| 权限 | 说明 | 风险等级 |
|------|------|---------|
| `storage.local` | 本地存储读写 | 低 |
| `clipboard.read` | 读取剪贴板 | 中 |
| `clipboard.write` | 写入剪贴板 | 低 |
| `notification.send` | 发送通知 | 低 |
| `notification.read` | 读取通知列表 | 中 |
| `org.contacts.read` | 读取联系人 | 高 |
| `org.department.read` | 读取部门列表 | 中 |
| `approval.read` | 读取审批信息 | 高 |
| `approval.write` | 提交/修改审批 | 高 |
| `device.location.read` | 读取设备位置 | 高 |
| `device.camera.use` | 使用摄像头 | 高 |
| `file.pick` | 选择文件 | 中 |
| `file.upload` | 上传文件 | 中 |
| `network.request` | 发起网络请求 | 中 |

**最小权限原则**: 只声明插件实际需要的权限。

---

## 能力配置 (capabilities)

声明插件提供或使用的能力。

- **类型**: `CapabilityConfig[]`
- **默认值**: `[]`

```json
{
  "capabilities": [
    {
      "id": "rss.parse",
      "type": "data",
      "permissions": ["network.request"]
    },
    {
      "id": "rss.subscribe",
      "type": "action",
      "permissions": ["storage.local", "network.request"]
    }
  ]
}
```

### CapabilityConfig 字段

#### id

能力唯一标识符。

- **类型**: `string`
- **示例**: `"rss.parse"`

---

#### type

能力类型。

- **类型**: `enum`
- **可选值**: `"data"`, `"action"`

**类型说明**:
- `data`: 数据获取能力（只读）
- `action`: 操作执行能力（可能修改状态）

---

#### permissions

该能力所需的权限列表。

- **类型**: `string[]`
- **默认值**: `[]`

```json
{
  "capabilities": [
    {
      "id": "article.fetch",
      "type": "data",
      "permissions": ["network.request"]
    }
  ]
}
```

---

## STAC 配置 (stac)

**仅 `type: "js"` 或 `type: "capability_composition"` 插件需要配置。**

```json
{
  "stac": {
    "schemaVersion": "1.0",
    "components": [
      "text",
      "button",
      "textFormField",
      "listView",
      "card"
    ],
    "customComponents": [
      "rss-feed-item",
      "article-preview"
    ]
  }
}
```

### 字段说明

#### schemaVersion

STAC Schema 版本。

- **类型**: `string`
- **当前版本**: `"1.0"`

---

#### components

使用的标准 STAC 组件列表。

- **类型**: `string[]`
- **默认值**: `[]`

**可用组件**: 参见 [STAC 组件库文档](./stac-components.md)

---

#### customComponents

自定义组件列表。

- **类型**: `string[]`
- **默认值**: `[]`

**示例**:

```json
{
  "stac": {
    "schemaVersion": "1.0",
    "components": ["text", "button", "image"],
    "customComponents": ["article-card"]
  }
}
```

---

## 性能预算 (performanceBudget)

设置插件的性能约束。

```json
{
  "performanceBudget": {
    "startupMs": 1500,
    "firstScreenMs": 3000,
    "maxMemoryMb": 16,
    "maxCpuPercent": 15
  }
}
```

### 字段说明

#### startupMs

启动时间预算（毫秒）。

- **类型**: `number`
- **默认值**: `1500`
- **说明**: 从激活到 `onActivate` 执行完成的时间

---

#### firstScreenMs

首屏渲染时间预算（毫秒）。

- **类型**: `number`
- **默认值**: `3000`
- **说明**: 从激活到首屏完全渲染的时间

---

#### maxMemoryMb

最大内存占用（MB）。

- **类型**: `number`
- **默认值**: `16`

---

#### maxCpuPercent

最大 CPU 占用百分比。

- **类型**: `number`
- **默认值**: `15`
- **范围**: 1-100

```json
{
  "performanceBudget": {
    "startupMs": 1000,
    "firstScreenMs": 2000,
    "maxMemoryMb": 32,
    "maxCpuPercent": 20
  }
}
```

---

## 更新策略 (updatePolicy)

配置插件的更新行为。

```json
{
  "updatePolicy": {
    "channel": "stable",
    "allowAutoUpdate": true,
    "allowRollback": true,
    "allowRemoteConfig": true,
    "allowRemoteSchema": true,
    "allowRemoteCode": true,
    "signatureRequired": true
  }
}
```

### 字段说明

#### channel

更新渠道。

- **类型**: `enum`
- **可选值**: `"stable"`, `"beta"`, `"canary"`
- **默认值**: `"stable"`

**渠道说明**:
- `stable`: 稳定版，推荐生产环境
- `beta`: 测试版，包含新功能
- `canary`: 金丝雀版，最新特性，可能不稳定

---

#### allowAutoUpdate

是否允许自动更新。

- **类型**: `boolean`
- **默认值**: `true`

---

#### allowRollback

是否允许回滚到旧版本。

- **类型**: `boolean`
- **默认值**: `true`

---

#### allowRemoteConfig

是否允许远程配置。

- **类型**: `boolean`
- **默认值**: `true`

---

#### allowRemoteSchema

是否允许远程 Schema（动态 UI）。

- **类型**: `boolean`
- **默认值**: `true`

---

#### allowRemoteCode

是否允许远程代码热更新。

- **类型**: `boolean`
- **默认值**: `true`

**安全警告**: 允许远程代码更新存在安全风险，建议配合 `signatureRequired: true` 使用。

---

#### signatureRequired

是否需要数字签名验证。

- **类型**: `boolean`
- **默认值**: `true`

```json
{
  "updatePolicy": {
    "channel": "stable",
    "allowAutoUpdate": true,
    "signatureRequired": true
  }
}
```

---

## 完整示例

### 示例 1: RSS 新闻阅读器插件

```json
{
  "id": "com.example.rss-reader",
  "name": "RSS 新闻阅读器",
  "description": "支持多源订阅、离线阅读和智能推荐",
  "version": "1.0.0",
  "publisher": "Example Inc.",
  "type": "js",
  "platforms": ["ios", "android"],
  "minHostVersion": "1.0.0",
  
  "engine": {
    "runtime": "quickjs",
    "bundle": "https://cdn.example.com/rss-reader/v1.0.0/bundle.js",
    "bundleHash": "sha256:abc123...",
    "bundleSize": 204800,
    "entryFunction": "onActivate",
    "memoryLimitMb": 32,
    "executionTimeoutMs": 10000,
    "background": false
  },
  
  "activationEvents": [
    "onStartup",
    "onCommand:openRssReader",
    "onView:feed-list"
  ],
  
  "permissions": [
    "storage.local",
    "network.request",
    "notification.send"
  ],
  
  "capabilities": [
    {
      "id": "rss.parse",
      "type": "data",
      "permissions": ["network.request"]
    },
    {
      "id": "rss.subscribe",
      "type": "action",
      "permissions": ["storage.local", "network.request"]
    }
  ],
  
  "stac": {
    "schemaVersion": "1.0",
    "components": [
      "scaffold",
      "appBar",
      "listView",
      "card",
      "text",
      "image",
      "button"
    ],
    "customComponents": []
  },
  
  "performanceBudget": {
    "startupMs": 1500,
    "firstScreenMs": 3000,
    "maxMemoryMb": 32,
    "maxCpuPercent": 15
  },
  
  "updatePolicy": {
    "channel": "stable",
    "allowAutoUpdate": true,
    "allowRollback": true,
    "allowRemoteConfig": true,
    "allowRemoteSchema": true,
    "allowRemoteCode": false,
    "signatureRequired": true
  }
}
```

---

### 示例 2: 内置工具插件

```json
{
  "id": "com.builtin.image-editor",
  "name": "图片编辑器",
  "description": "内置图片编辑工具",
  "version": "1.0.0",
  "publisher": "Built-in",
  "type": "builtin",
  "platforms": ["ios", "android"],
  "minHostVersion": "1.0.0",
  
  "activationEvents": [
    "onCommand:editImage"
  ],
  
  "permissions": [
    "file.pick",
    "storage.local"
  ],
  
  "capabilities": [
    {
      "id": "image.crop",
      "type": "action",
      "permissions": []
    },
    {
      "id": "image.filter",
      "type": "action",
      "permissions": []
    }
  ]
}
```

---

### 示例 3: 纯 Schema 插件（无 JS）

```json
{
  "id": "com.example.about-page",
  "name": "关于页面",
  "description": "应用关于页面",
  "version": "1.0.0",
  "publisher": "Example Inc.",
  "type": "capability_composition",
  "platforms": ["ios", "android"],
  "minHostVersion": "1.0.0",
  
  "activationEvents": [
    "onView:about"
  ],
  
  "permissions": [],
  
  "stac": {
    "schemaVersion": "1.0",
    "components": [
      "scaffold",
      "appBar",
      "column",
      "text",
      "image",
      "button"
    ],
    "customComponents": []
  }
}
```

---

## 最佳实践

### 1. 版本管理

- 遵循语义化版本规范
- 重大变更升级主版本号
- 功能更新升级次版本号
- 问题修复升级修订号

### 2. 权限最小化

只声明必需的权限，避免过度请求。

❌ **不推荐**:

```json
{
  "permissions": [
    "storage.local",
    "network.request",
    "org.contacts.read",
    "device.location.read",
    "device.camera.use"
  ]
}
```

✅ **推荐**:

```json
{
  "permissions": [
    "storage.local",
    "network.request"
  ]
}
```

### 3. 性能优化

- 设置合理的性能预算
- Bundle 体积控制在 500KB 以内
- 启动时间控制在 1.5 秒以内

### 4. 安全性

- 生产环境必须提供 `bundleHash`
- 启用 `signatureRequired`
- 谨慎使用 `allowRemoteCode`

### 5. 懒加载

使用 `activationEvents` 实现按需加载，提升应用启动性能。

```json
{
  "activationEvents": [
    "onCommand:openPlugin",
    "onView:plugin-page"
  ]
}
```

---

## 常见错误

### 错误 1: 缺少必填字段

```
Error: Missing required field 'id' in manifest.json
```

**解决方案**: 确保所有必填字段都已填写。

---

### 错误 2: 版本号格式错误

```
Error: Invalid version format '1.0'. Expected semantic version (e.g., '1.0.0')
```

**解决方案**: 使用完整的语义化版本号 `MAJOR.MINOR.PATCH`。

---

### 错误 3: Bundle 哈希验证失败

```
Error: Bundle hash mismatch. Expected 'sha256:abc...', got 'sha256:def...'
```

**解决方案**: 重新计算并更新 `bundleHash` 字段。

---

### 错误 4: 权限未声明

```
Error: Permission 'network.request' not declared in manifest
```

**解决方案**: 在 `permissions` 数组中添加所需权限。

---

## 附录

### Manifest Schema (TypeScript 定义)

```typescript
interface PluginManifest {
  id: string;
  name: string;
  description?: string;
  version: string;
  publisher: string;
  type: 'js' | 'builtin' | 'webview' | 'capability_composition' | 'remote_action';
  platforms: string[];
  minHostVersion: string;
  engine?: EngineConfig;
  activationEvents?: string[];
  permissions?: string[];
  capabilities?: CapabilityConfig[];
  stac?: STACConfig;
  performanceBudget?: PerformanceBudget;
  updatePolicy?: UpdatePolicy;
}

interface EngineConfig {
  runtime: string;
  bundle: string;
  bundleHash: string;
  bundleSize?: number;
  entryFunction?: string;
  memoryLimitMb?: number;
  executionTimeoutMs?: number;
  background?: boolean;
}

interface CapabilityConfig {
  id: string;
  type: 'data' | 'action';
  permissions?: string[];
}

interface STACConfig {
  schemaVersion: string;
  components?: string[];
  customComponents?: string[];
}

interface PerformanceBudget {
  startupMs?: number;
  firstScreenMs?: number;
  maxMemoryMb?: number;
  maxCpuPercent?: number;
}

interface UpdatePolicy {
  channel?: 'stable' | 'beta' | 'canary';
  allowAutoUpdate?: boolean;
  allowRollback?: boolean;
  allowRemoteConfig?: boolean;
  allowRemoteSchema?: boolean;
  allowRemoteCode?: boolean;
  signatureRequired?: boolean;
}
```

---

## 相关文档

- [能力桥接 API 文档](./capabilities.md)
- [STAC 组件库文档](./stac-components.md)
- [JS 运行时 API 文档](./js-runtime.md)
