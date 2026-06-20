# 插件能力桥接 API 文档

## 概述

能力桥接（Capability Bridge）是插件平台的核心机制，允许 JS 插件安全地调用宿主应用提供的原生能力。所有能力调用都经过权限校验和平台兼容性检查。

> **📊 实现状态**: 本文档定义了 40 个能力，其中 **27 个已完整实现**，**3 个部分实现**，**10 个规划中**。查看详细实现状态请参阅 [能力实现清单](./CAPABILITY_IMPLEMENTATION_STATUS.md)。

## 图例说明

- ✅ **已实现** - 可以直接使用
- ⚠️ **部分实现** - 基本功能可用，但存在已知限制（查看能力说明了解详情）
- 📋 **计划中** - 已规划但未实现，调用会返回错误

## 架构原理

### 能力定义

每个能力（Capability）包含以下元数据：

- **id**: 能力唯一标识符（如 `toast.show`）
- **inputSchema**: 输入参数 JSON Schema（可选）
- **outputSchema**: 输出结果 JSON Schema（可选）
- **requiredPermissions**: 所需权限列表
- **minHostVersion**: 最低宿主版本要求
- **platforms**: 支持的平台列表（`['all']` 或 `['ios', 'android']`）
- **handler**: 能力处理函数

### 调用流程

```
JS 插件 → invokeHost(method, params)
       ↓
HostBridge.handleInvoke(pluginId, method, params)
       ↓
1. 查找能力定义
2. 权限校验
3. 平台兼容性检查
4. 执行能力处理器
       ↓
返回结果 { success: true, data: {...} }
或错误 { success: false, error: "..." }
```

### 错误类型

- **HostBridgeError.methodNotFound**: 能力不存在
- **HostBridgeError.permissionDenied**: 权限不足
- **HostBridgeError.platformNotSupported**: 平台不支持

---

## UI 交互能力

### ✅ toast.show

显示轻量级提示信息。

**权限**: 无需权限
**实现状态**: 已实现，使用 Flutter SnackBar

**输入参数**:

```json
{
  "message": "string (必填) - 提示内容",
  "duration": "string (可选) - 显示时长，'short'(1秒) 或 'long'(3秒)，默认 'short'"
}
```

**输出结果**:

```json
{
  "shown": true
}
```

**代码示例**:

```javascript
// JS 插件代码
await invokeHost('toast.show', {
  message: '操作成功',
  duration: 'short'
});
```

---

### ✅ dialog.alert

显示警告对话框（仅确认按钮）。

**权限**: 无需权限
**实现状态**: 已实现，使用 Flutter AlertDialog

**输入参数**:

```json
{
  "title": "string (可选) - 标题，默认 '提示'",
  "message": "string (必填) - 对话框内容"
}
```

**输出结果**:

```json
{
  "confirmed": true
}
```

**代码示例**:

```javascript
await invokeHost('dialog.alert', {
  title: '提示',
  message: '这是一条重要信息'
});
```

---

### ✅ dialog.confirm

显示确认对话框（确认 + 取消按钮）。

**权限**: 无需权限
**实现状态**: 已实现，使用 Flutter AlertDialog

**输入参数**:

```json
{
  "title": "string (可选) - 标题，默认 '确认'",
  "message": "string (必填) - 对话框内容"
}
```

**输出结果**:

```json
{
  "confirmed": "boolean - 用户是否点击确认"
}
```

**代码示例**:

```javascript
const result = await invokeHost('dialog.confirm', {
  title: '删除确认',
  message: '确定要删除这条记录吗？'
});

if (result.confirmed) {
  // 用户点击了确认
  await deleteRecord();
}
```

---

### ✅ loading.show

显示加载中对话框。

**权限**: 无需权限
**实现状态**: 已实现，使用 Flutter AlertDialog + CircularProgressIndicator

**输入参数**:

```json
{
  "message": "string (可选) - 加载提示文字，默认 '加载中...'"
}
```

**输出结果**:

```json
{
  "shown": true
}
```

**代码示例**:

```javascript
// 显示加载
await invokeHost('loading.show', {
  message: '正在处理...'
});

// 执行耗时操作
await performHeavyTask();

// 隐藏加载
await invokeHost('loading.hide');
```

---

### ✅ loading.hide

隐藏加载中对话框。

**权限**: 无需权限
**实现状态**: 已实现

**输入参数**: 无

**输出结果**:

```json
{
  "hidden": true
}
```

---

## 导航能力

### ✅ navigation.open

打开新页面（push 导航）。

**权限**: 无需权限
**实现状态**: 已实现，使用 Navigator.pushNamed

**输入参数**:

```json
{
  "route": "string (必填) - 路由路径，如 '/detail'",
  "arguments": "any (可选) - 传递给目标页面的参数"
}
```

**输出结果**:

```json
{
  "navigated": true
}
```

**代码示例**:

```javascript
await invokeHost('navigation.open', {
  route: '/article/detail',
  arguments: {
    articleId: '12345',
    source: 'plugin'
  }
});
```

---

### ✅ navigation.back

返回上一页。

**权限**: 无需权限
**实现状态**: 已实现，使用 Navigator.pop

**输入参数**: 无

**输出结果**:

```json
{
  "navigated": true
}
```

**代码示例**:

```javascript
await invokeHost('navigation.back');
```

---

### ✅ navigation.replace

替换当前页面（replace 导航）。

**权限**: 无需权限
**实现状态**: 已实现，使用 Navigator.pushReplacementNamed

**输入参数**:

```json
{
  "route": "string (必填) - 路由路径",
  "arguments": "any (可选) - 传递的参数"
}
```

**输出结果**:

```json
{
  "navigated": true
}
```

**代码示例**:

```javascript
// 登录成功后替换到主页
await invokeHost('navigation.replace', {
  route: '/home'
});
```

---

## 存储能力

### ✅ storage.get

获取本地存储值。

**权限**: `storage.local`
**实现状态**: 已实现，使用 shared_preferences

**输入参数**:

```json
{
  "key": "string (必填) - 存储键名"
}
```

**输出结果**:

```json
{
  "value": "string | null - 存储的值，不存在时为 null"
}
```

**代码示例**:

```javascript
const result = await invokeHost('storage.get', {
  key: 'user_preferences'
});

const preferences = result.value ? JSON.parse(result.value) : {};
```

---

### ✅ storage.set

设置本地存储值。

**权限**: `storage.local`
**实现状态**: 已实现，使用 shared_preferences

**输入参数**:

```json
{
  "key": "string (必填) - 存储键名",
  "value": "string (必填) - 存储的值"
}
```

**输出结果**:

```json
{
  "saved": true
}
```

**代码示例**:

```javascript
await invokeHost('storage.set', {
  key: 'user_preferences',
  value: JSON.stringify({ theme: 'dark', fontSize: 16 })
});
```

---

### ✅ storage.remove

删除本地存储值。

**权限**: `storage.local`
**实现状态**: 已实现，使用 shared_preferences

**输入参数**:

```json
{
  "key": "string (必填) - 存储键名"
}
```

**输出结果**:

```json
{
  "removed": true
}
```

**代码示例**:

```javascript
await invokeHost('storage.remove', {
  key: 'user_preferences'
});
```

---

### ✅ storage.clear

清空所有本地存储。

**权限**: `storage.local`
**实现状态**: 已实现，使用 shared_preferences

**输入参数**: 无

**输出结果**:

```json
{
  "cleared": true
}
```

**警告**: 此操作会清空插件所有存储数据，请谨慎使用。

**代码示例**:

```javascript
await invokeHost('storage.clear');
```

---

## 剪贴板能力

### ⚠️ clipboard.write

写入剪贴板。

**权限**: `clipboard.write`
**实现状态**: 部分实现，需要集成 flutter/services ClipboardData（预计 2026-07-01 完成）

**输入参数**:

```json
{
  "text": "string (必填) - 要复制的文本"
}
```

**输出结果**:

```json
{
  "written": true,
  "text": "复制的文本内容"
}
```

**代码示例**:

```javascript
await invokeHost('clipboard.write', {
  text: 'https://example.com/share/12345'
});

await invokeHost('toast.show', {
  message: '已复制到剪贴板'
});
```

---

### ⚠️ clipboard.read

读取剪贴板内容。

**权限**: `clipboard.read`
**实现状态**: 部分实现，需要集成 flutter/services ClipboardData（预计 2026-07-01 完成）

**输入参数**: 无

**输出结果**:

```json
{
  "text": "string - 剪贴板文本内容"
}
```

**代码示例**:

```javascript
const result = await invokeHost('clipboard.read');
console.log('剪贴板内容:', result.text);
```

---

## 通知能力

### ⚠️ notification.send

发送系统通知。

**权限**: `notification.send`
**实现状态**: 部分实现，需要集成 flutter_local_notifications（预计 2026-07-15 完成）

**输入参数**:

```json
{
  "title": "string (必填) - 通知标题",
  "body": "string (必填) - 通知内容"
}
```

**输出结果**:

```json
{
  "sent": true,
  "title": "通知标题",
  "body": "通知内容"
}
```

**代码示例**:

```javascript
await invokeHost('notification.send', {
  title: '新消息',
  body: '您有一条待办事项即将到期'
});
```

---

### ✅ notification.cancel

取消指定通知。

**权限**: `notification.send`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "notificationId": "string (必填) - 通知 ID"
}
```

**输出结果**:

```json
{
  "cancelled": true
}
```

---

### ✅ notification.badge.set

设置应用角标数字。

**权限**: `notification.send`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "count": "number (必填) - 角标数字，0 表示清除角标"
}
```

**输出结果**:

```json
{
  "badge": 5
}
```

**代码示例**:

```javascript
// 设置角标
await invokeHost('notification.badge.set', { count: 5 });

// 清除角标
await invokeHost('notification.badge.set', { count: 0 });
```

---

### ✅ notification.list

获取通知列表。

**权限**: `notification.read`
**实现状态**: 已实现（Mock）

**输入参数**: 无

**输出结果**:

```json
{
  "items": [
    {
      "id": "string - 通知 ID",
      "title": "string - 通知标题",
      "read": "boolean - 是否已读"
    }
  ]
}
```

---

### ✅ notification.markRead

标记通知为已读。

**权限**: `notification.write`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "notificationId": "string (必填) - 通知 ID"
}
```

**输出结果**:

```json
{
  "marked": true
}
```

---

## 组织与联系人能力

### ✅ org.contacts.search

搜索联系人。

**权限**: `org.contacts.read`
**实现状态**: 已实现（Mock，返回模拟数据）

**输入参数**:

```json
{
  "keyword": "string (可选) - 搜索关键词（姓名、部门、IM ID）"
}
```

**输出结果**:

```json
{
  "items": [
    {
      "id": "string - 用户 ID",
      "name": "string - 姓名",
      "department": "string - 部门",
      "imId": "string - IM 账号",
      "avatar": "string - 头像 URL"
    }
  ],
  "total": "number - 搜索结果总数"
}
```

**代码示例**:

```javascript
const result = await invokeHost('org.contacts.search', {
  keyword: '张三'
});

result.items.forEach(contact => {
  console.log(`${contact.name} - ${contact.department}`);
});
```

---

### ✅ org.contacts.getById

根据 ID 获取联系人详情。

**权限**: `org.contacts.read`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "id": "string (必填) - 用户 ID"
}
```

**输出结果**:

```json
{
  "item": {
    "id": "string",
    "name": "string",
    "department": "string",
    "imId": "string",
    "avatar": "string"
  }
}
```

---

### ✅ org.contacts.pick

打开联系人选择器（由宿主提供 UI）。

**权限**: `org.contacts.read`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "selectedIds": "string[] (可选) - 预选中的用户 ID 列表",
  "multiple": "boolean (可选) - 是否允许多选，默认 true"
}
```

**输出结果**:

```json
{
  "items": [
    {
      "id": "string",
      "name": "string",
      "department": "string",
      "imId": "string",
      "avatar": "string"
    }
  ],
  "multiple": "boolean"
}
```

**代码示例**:

```javascript
const result = await invokeHost('org.contacts.pick', {
  multiple: true
});

console.log('选中的联系人:', result.items);
```

---

### ✅ org.department.list

获取部门列表。

**权限**: `org.department.read`
**实现状态**: 已实现（Mock）

**输入参数**: 无

**输出结果**:

```json
{
  "items": [
    {
      "id": "string - 部门 ID",
      "name": "string - 部门名称"
    }
  ]
}
```

---

## 审批能力

### ✅ approval.list

获取审批列表。

**权限**: `approval.read`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "status": "string (可选) - 筛选状态：'pending' | 'approved' | 'rejected'",
  "page": "number (可选) - 页码，从 1 开始",
  "pageSize": "number (可选) - 每页条数"
}
```

**输出结果**:

```json
{
  "items": [
    {
      "id": "string - 审批 ID",
      "title": "string - 审批标题",
      "status": "string - 状态",
      "owner": "string - 审批人"
    }
  ]
}
```

---

### ✅ approval.detail.get

获取审批详情。

**权限**: `approval.read`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "id": "string (必填) - 审批 ID"
}
```

**输出结果**:

```json
{
  "item": {
    "id": "string",
    "title": "string",
    "status": "string",
    "steps": [
      {
        "name": "string - 步骤名称",
        "state": "string - 'done' | 'current' | 'todo'"
      }
    ]
  }
}
```

---

### ✅ approval.submit

提交审批。

**权限**: `approval.write`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "type": "string (必填) - 审批类型",
  "title": "string (必填) - 审批标题",
  "data": "object (必填) - 审批数据"
}
```

**输出结果**:

```json
{
  "submitted": true,
  "payload": "提交的数据"
}
```

---

### ✅ approval.history

获取审批历史记录。

**权限**: `approval.read`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "approvalId": "string (必填) - 审批 ID"
}
```

**输出结果**:

```json
{
  "items": [
    {
      "action": "string - 操作类型（submitted/approved/rejected）",
      "at": "string - ISO 8601 时间戳"
    }
  ]
}
```

---

### ✅ approval.cancel

撤销审批。

**权限**: `approval.write`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "approvalId": "string (必填) - 审批 ID"
}
```

**输出结果**:

```json
{
  "cancelled": true
}
```

---

### ✅ approval.forward

转发审批。

**权限**: `approval.write`
**实现状态**: 已实现（Mock）

**输入参数**:

```json
{
  "approvalId": "string (必填) - 审批 ID",
  "targetUserId": "string (必填) - 目标用户 ID"
}
```

**输出结果**:

```json
{
  "forwarded": true
}
```

---

## 设备能力

### 📋 device.location.get

获取设备位置（需要用户授权）。

**权限**: `device.location.read`
**实现状态**: 计划中，需要集成 geolocator 包（预计 Q3 2026）

**输入参数**:

```json
{
  "accuracy": "string (可选) - 精度要求：'high' | 'low'，默认 'high'"
}
```

**输出结果**:

```json
{
  "latitude": "number - 纬度",
  "longitude": "number - 经度",
  "accuracy": "number - 精度（米）"
}
```

---

### 📋 device.camera.scan

扫码（二维码 / 条形码）。

**权限**: `device.camera.use`
**实现状态**: 计划中，需要集成 mobile_scanner 包（预计 Q3 2026）

**输入参数**: 无

**输出结果**:

```json
{
  "type": "string - 码类型（qr/barcode）",
  "content": "string - 扫描内容"
}
```

**代码示例**:

```javascript
const result = await invokeHost('device.camera.scan');

if (result.type === 'qr') {
  console.log('二维码内容:', result.content);
}
```

---

### 📋 device.bluetooth.scan

扫描蓝牙设备。

**权限**: `device.bluetooth.use`
**实现状态**: 计划中，需要集成 flutter_blue_plus 包（预计 Q4 2026）

**输入参数**:

```json
{
  "timeout": "number (可选) - 扫描超时时间（毫秒），默认 10000"
}
```

**输出结果**:

```json
{
  "devices": [
    {
      "id": "string - 设备 ID",
      "name": "string - 设备名称",
      "rssi": "number - 信号强度"
    }
  ]
}
```

---

### 📋 device.info.get

获取设备信息。

**权限**: `device.info.read`
**实现状态**: 计划中，需要集成 device_info_plus 包（预计 Q3 2026）

**输入参数**: 无

**输出结果**:

```json
{
  "platform": "string - 'ios' | 'android'",
  "osVersion": "string - 操作系统版本",
  "appVersion": "string - 应用版本",
  "deviceModel": "string - 设备型号"
}
```

---

### 📋 file.pick

选择文件。

**权限**: `file.pick`
**实现状态**: 计划中，需要集成 file_picker 包（预计 Q3 2026）

**输入参数**:

```json
{
  "type": "string (可选) - 文件类型：'image' | 'video' | 'document' | 'any'",
  "multiple": "boolean (可选) - 是否允许多选，默认 false"
}
```

**输出结果**:

```json
{
  "files": [
    {
      "path": "string - 文件路径",
      "name": "string - 文件名",
      "size": "number - 文件大小（字节）",
      "mimeType": "string - MIME 类型"
    }
  ]
}
```

---

### 📋 file.upload

上传文件。

**权限**: `file.upload`
**实现状态**: 计划中（预计 Q4 2026）

**输入参数**:

```json
{
  "filePath": "string (必填) - 文件路径",
  "url": "string (必填) - 上传 URL",
  "method": "string (可选) - HTTP 方法，默认 'POST'",
  "headers": "object (可选) - HTTP 请求头"
}
```

**输出结果**:

```json
{
  "success": "boolean",
  "statusCode": "number",
  "response": "string - 服务器响应"
}
```

---

## 网络能力

### ✅ network.request

发起 HTTP 请求（代理请求，解决跨域问题）。

**权限**: `network.request`
**实现状态**: 已实现，当前支持 GET/POST 方法，使用 http 包

> **已知限制**: 当前仅支持 GET 和 POST 方法。PUT、DELETE、PATCH 支持计划在 Q4 2026 添加。

**输入参数**:

```json
{
  "method": "string (必填) - HTTP 方法：'GET' | 'POST' | 'PUT' | 'DELETE'",
  "url": "string (必填) - 请求 URL",
  "headers": "object (可选) - HTTP 请求头",
  "query": "object (可选) - URL 查询参数",
  "body": "string | object (可选) - 请求体（POST/PUT）"
}
```

**输出结果**:

```json
{
  "statusCode": "number - HTTP 状态码",
  "headers": "object - 响应头",
  "body": "string - 响应体（文本）",
  "json": "object | null - 解析后的 JSON（如果是 JSON 响应）"
}
```

**代码示例**:

```javascript
// GET 请求
const result = await invokeHost('network.request', {
  method: 'GET',
  url: 'https://api.example.com/articles',
  query: {
    page: 1,
    limit: 20
  },
  headers: {
    'Authorization': 'Bearer token123'
  }
});

if (result.statusCode === 200) {
  const articles = result.json;
  console.log('获取到文章:', articles);
}

// POST 请求
const postResult = await invokeHost('network.request', {
  method: 'POST',
  url: 'https://api.example.com/comments',
  headers: {
    'Content-Type': 'application/json'
  },
  body: {
    articleId: '12345',
    content: '这是一条评论'
  }
});
```

---

### 📋 network.upload

上传文件到指定 URL。

**权限**: `network.request`
**实现状态**: 计划中（预计 Q4 2026）

**输入参数**:

```json
{
  "url": "string (必填) - 上传 URL",
  "filePath": "string (必填) - 本地文件路径",
  "headers": "object (可选) - HTTP 请求头"
}
```

**输出结果**:

```json
{
  "statusCode": "number",
  "body": "string",
  "json": "object | null"
}
```

---

### 📋 network.download

下载文件。

**权限**: `network.request`
**实现状态**: 计划中（预计 Q4 2026）

**输入参数**:

```json
{
  "url": "string (必填) - 下载 URL",
  "savePath": "string (可选) - 保存路径，不提供则使用临时路径"
}
```

**输出结果**:

```json
{
  "path": "string - 下载后的文件路径",
  "size": "number - 文件大小（字节）"
}
```

---

## UI 辅助能力

### 📋 bottomSheet.show

显示底部表单。

**权限**: 无需权限
**实现状态**: 计划中，使用 showModalBottomSheet（预计 2026-08-01）

**输入参数**:

```json
{
  "title": "string (可选) - 标题",
  "items": [
    {
      "id": "string - 选项 ID",
      "label": "string - 选项文本",
      "icon": "string (可选) - 图标名称"
    }
  ]
}
```

**输出结果**:

```json
{
  "selectedId": "string | null - 选中的选项 ID，取消时为 null"
}
```

---

### 📋 picker.show

显示选择器（通用选择器）。

**权限**: 无需权限
**实现状态**: 计划中，支持日期/时间选择器（预计 2026-08-01）

**输入参数**:

```json
{
  "type": "string (必填) - 选择器类型：'date' | 'time' | 'datetime'",
  "initialValue": "string (可选) - 初始值（ISO 8601 格式）"
}
```

**输出结果**:

```json
{
  "value": "string | null - 选中的值（ISO 8601 格式），取消时为 null"
}
```

**代码示例**:

```javascript
// 日期选择器
const result = await invokeHost('picker.show', {
  type: 'date',
  initialValue: '2024-01-01'
});

if (result.value) {
  console.log('选择的日期:', result.value);
}
```

---

## 最佳实践

### 1. 错误处理

```javascript
try {
  const result = await invokeHost('storage.get', { key: 'config' });
  // 处理结果
} catch (error) {
  if (error.message.includes('Permission denied')) {
    console.error('权限不足，请在 manifest.json 中声明 storage.local 权限');
  } else {
    console.error('调用失败:', error);
  }
}
```

### 2. 权限声明

在 `manifest.json` 中声明所需权限：

```json
{
  "permissions": [
    "storage.local",
    "network.request",
    "org.contacts.read",
    "notification.send"
  ]
}
```

### 3. 平台兼容性检查

某些能力可能仅在特定平台可用，建议先检查设备信息：

```javascript
const deviceInfo = await invokeHost('device.info.get');

if (deviceInfo.platform === 'android') {
  // Android 特有逻辑
} else if (deviceInfo.platform === 'ios') {
  // iOS 特有逻辑
}
```

### 4. 异步调用优化

对于并发调用，使用 `Promise.all`：

```javascript
const [contacts, departments] = await Promise.all([
  invokeHost('org.contacts.search', { keyword: '' }),
  invokeHost('org.department.list')
]);
```

---

## 附录

### 权限列表

| 权限标识                 | 说明                     |
|-------------------------|------------------------|
| `storage.local`         | 本地存储读写              |
| `clipboard.read`        | 读取剪贴板               |
| `clipboard.write`       | 写入剪贴板               |
| `notification.send`     | 发送通知                 |
| `notification.read`     | 读取通知列表              |
| `notification.write`    | 标记通知已读              |
| `org.contacts.read`     | 读取联系人               |
| `org.department.read`   | 读取部门列表              |
| `approval.read`         | 读取审批信息              |
| `approval.write`        | 提交/修改审批             |
| `device.location.read`  | 读取设备位置              |
| `device.camera.use`     | 使用摄像头（扫码）         |
| `device.bluetooth.use`  | 使用蓝牙                 |
| `device.info.read`      | 读取设备信息              |
| `file.pick`            | 选择文件                 |
| `file.upload`          | 上传文件                 |
| `network.request`       | 发起网络请求              |

### 相关文档

- [能力实现清单](./CAPABILITY_IMPLEMENTATION_STATUS.md) - 查看所有能力的详细实现状态和开发路线图
- [插件开发指南](../guide/plugin-development.md) - 了解如何开发插件
- [权限系统](../guide/permissions.md) - 了解权限申请和管理

### 版本历史

- **1.1.0** (2026-06-20) - 添加能力实现状态标注，新增实现清单文档
- **1.0.0** - 初始版本，包含所有核心能力
