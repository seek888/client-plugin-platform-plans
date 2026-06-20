---
description: "辅助集成 Host Bridge 能力桥接 API，提供 API 查询、权限配置、错误处理和调用示例"
globs: ["**/plugins/**/src/services/host_api.js", "**/plugins/**/manifest.json"]
alwaysApply: false
---

# Capability Integration Skill

辅助集成 Flutter 插件平台的 Host Bridge 能力桥接 API，自动生成能力调用代码、权限配置和错误处理。

## 触发关键词
- integrate capability
- host bridge
- add permission
- call host api
- invoke host
- 集成能力
- 调用宿主
- 添加权限

---

## Host Bridge 架构

```text
┌─────────────────────────────────────────────┐
│            Host Bridge                       │
│                                              │
│  ┌─────────────────────────────────────────┐ │
│  │  Capability Registry                    │ │
│  │                                         │ │
│  │  ┌──────────┐  ┌──────────┐           │ │
│  │  │ Account  │  │   IM     │           │ │
│  │  │ & Org    │  │          │           │ │
│  │  └──────────┘  └──────────┘           │ │
│  │  ┌──────────┐  ┌──────────┐           │ │
│  │  │ Approval │  │ Network  │           │ │
│  │  │          │  │          │           │ │
│  │  └──────────┘  └──────────┘           │ │
│  └─────────────────────────────────────────┘ │
│                                              │
│  每个能力注册时声明:                          │
│  ├─ id（如 approval.submit）                │
│  ├─ requiredPermissions（权限要求）           │
│  ├─ inputSchema（参数校验）                   │
│  └─ outputSchema（返回校验）                  │
└─────────────────────────────────────────────┘
```

---

## 能力分类

### 1. Account & Org（账号与组织）

#### user.profile.get
获取当前用户信息

**权限**: `user.profile.read`

**调用示例**:
```javascript
export async function getCurrentUser() {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  try {
    const result = await invokeHost('user.profile.get', {});
    return result.user;
  } catch (error) {
    console.error('Failed to get user profile:', error);
    return null;
  }
}
```

**返回数据**:
```javascript
{
  user: {
    id: 'u_123',
    name: '张三',
    email: 'zhangsan@company.com',
    avatar: 'https://...',
    orgId: 'org_456'
  }
}
```

#### org.contacts.search
搜索通讯录

**权限**: `org.contacts.read`

**调用示例**:
```javascript
export async function searchContacts(query, limit = 10) {
  if (typeof invokeHost !== 'function') {
    return [];
  }
  
  try {
    const result = await invokeHost('org.contacts.search', {
      query,
      limit
    });
    return result.contacts || [];
  } catch (error) {
    console.error('Failed to search contacts:', error);
    return [];
  }
}
```

**参数**:
- `query` (string): 搜索关键词
- `limit` (number): 返回数量限制

**返回数据**:
```javascript
{
  contacts: [
    {
      id: 'c_001',
      name: '张三',
      email: 'zhangsan@company.com',
      department: '研发部',
      avatar: 'https://...'
    }
  ]
}
```

#### org.contacts.pick
选择联系人（打开选择器）

**权限**: `org.contacts.read`

**调用示例**:
```javascript
export async function pickContacts(selectedIds = [], multiple = true) {
  if (typeof invokeHost !== 'function') {
    return [];
  }
  
  try {
    const result = await invokeHost('org.contacts.pick', {
      multiple,
      selectedIds
    });
    return result.contacts || [];
  } catch (error) {
    console.error('Failed to pick contacts:', error);
    return [];
  }
}
```

---

### 2. IM & Message（即时通讯）

#### im.message.send
发送消息

**权限**: `im.message.send`

**调用示例**:
```javascript
export async function sendMessage(chatId, content, type = 'text') {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  try {
    const result = await invokeHost('im.message.send', {
      chatId,
      content,
      type
    });
    return result;
  } catch (error) {
    console.error('Failed to send message:', error);
    throw error;
  }
}
```

**参数**:
- `chatId` (string): 会话 ID
- `content` (string): 消息内容
- `type` (string): 消息类型 ('text' | 'image' | 'file')

#### im.chat.open
打开聊天窗口

**权限**: `im.chat.open`

**调用示例**:
```javascript
export async function openChat(userId) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('im.chat.open', { userId });
}
```

---

### 3. Approval & Workflow（审批与流程）

#### approval.detail.get
获取审批详情

**权限**: `approval.read`

**调用示例**:
```javascript
export async function getApprovalDetail(orderId) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  try {
    const result = await invokeHost('approval.detail.get', {
      orderId
    });
    return result.approval;
  } catch (error) {
    console.error('Failed to get approval:', error);
    return null;
  }
}
```

**返回数据**:
```javascript
{
  approval: {
    id: 'ord_001',
    title: '请假申请',
    status: 'pending',
    creator: '张三',
    createdAt: '2024-06-20T10:00:00Z',
    approvers: ['李四', '王五'],
    content: { /* 审批内容 */ }
  }
}
```

#### approval.submit
提交审批

**权限**: `approval.write`

**调用示例**:
```javascript
export async function submitApproval(orderId, comment, action = 'approve') {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  try {
    const result = await invokeHost('approval.submit', {
      orderId,
      action,      // 'approve' | 'reject' | 'transfer'
      comment
    });
    return result;
  } catch (error) {
    console.error('Failed to submit approval:', error);
    throw error;
  }
}
```

**参数**:
- `orderId` (string): 审批单 ID
- `action` (string): 操作类型
- `comment` (string): 审批意见

#### approval.list
获取审批列表

**权限**: `approval.read`

**调用示例**:
```javascript
export async function getApprovalList(status, page = 1, pageSize = 20) {
  if (typeof invokeHost !== 'function') {
    return { items: [], total: 0 };
  }
  
  try {
    const result = await invokeHost('approval.list', {
      status,      // 'pending' | 'approved' | 'rejected' | 'all'
      page,
      pageSize
    });
    return result;
  } catch (error) {
    console.error('Failed to get approval list:', error);
    return { items: [], total: 0 };
  }
}
```

---

### 4. Notification（通知）

#### notification.send
发送通知

**权限**: `notification.send`

**调用示例**:
```javascript
export async function sendNotification(title, body, payload = {}) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  try {
    const result = await invokeHost('notification.send', {
      title,
      body,
      payload,
      priority: 'normal'    // 'low' | 'normal' | 'high'
    });
    return result;
  } catch (error) {
    console.error('Failed to send notification:', error);
    return null;
  }
}
```

**参数**:
- `title` (string): 通知标题
- `body` (string): 通知内容
- `payload` (object): 附加数据
- `priority` (string): 优先级

#### notification.cancel
取消通知

**权限**: `notification.send`

**调用示例**:
```javascript
export async function cancelNotification(notificationId) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('notification.cancel', { notificationId });
}
```

---

### 5. Navigation（导航）

#### navigation.open
打开页面

**权限**: `navigation.open`

**调用示例**:
```javascript
export async function navigateTo(route, params = {}) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('navigation.open', { route, params });
}
```

**示例**:
```javascript
// 打开插件页面
navigateTo('/plugin/calendar', { date: '2024-06-20' });

// 打开审批详情
navigateTo('/approval/detail', { orderId: 'ord_001' });
```

#### navigation.back
返回上一页

**权限**: 无需权限

**调用示例**:
```javascript
export async function navigateBack() {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('navigation.back', {});
}
```

#### navigation.replace
替换当前页

**权限**: `navigation.open`

**调用示例**:
```javascript
export async function navigateReplace(route, params = {}) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('navigation.replace', { route, params });
}
```

---

### 6. Network（网络代理）

#### network.request
发起网络请求（所有插件网络请求必须通过宿主代理）

**权限**: `network.request`

**调用示例**:
```javascript
export async function httpRequest(method, url, options = {}) {
  if (typeof invokeHost !== 'function') {
    throw new Error('invokeHost not available');
  }
  
  try {
    const result = await invokeHost('network.request', {
      method,      // 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH'
      url,
      headers: options.headers || {},
      body: options.body,
      timeout: options.timeout || 30000
    });
    return result;
  } catch (error) {
    console.error('Network request failed:', error);
    throw error;
  }
}

// 便捷方法
export async function httpGet(url, headers = {}) {
  return httpRequest('GET', url, { headers });
}

export async function httpPost(url, body, headers = {}) {
  return httpRequest('POST', url, { body, headers });
}
```

**注意事项**:
- 插件不能直接使用 `fetch` 或 `XMLHttpRequest`
- 所有请求必须通过 Host Bridge 代理
- 请求域名必须在 Manifest 的 `allowedDomains` 中声明
- 宿主会自动注入鉴权信息

**Manifest 配置**:
```json
{
  "permissions": ["network.request"],
  "network": {
    "allowedDomains": [
      "api.company.com",
      "cdn.company.com"
    ]
  }
}
```

---

### 7. Storage（本地存储）

#### storage.set
保存数据

**权限**: `storage.local`

**调用示例**:
```javascript
export async function storageSet(key, value) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  try {
    return await invokeHost('storage.set', {
      key,
      value: JSON.stringify(value)
    });
  } catch (error) {
    console.error('Failed to set storage:', error);
    return null;
  }
}
```

#### storage.get
读取数据

**权限**: `storage.local`

**调用示例**:
```javascript
export async function storageGet(key, defaultValue = null) {
  if (typeof invokeHost !== 'function') {
    return defaultValue;
  }
  
  try {
    const result = await invokeHost('storage.get', { key });
    if (result && result.value) {
      return JSON.parse(result.value);
    }
    return defaultValue;
  } catch (error) {
    console.error('Failed to get storage:', error);
    return defaultValue;
  }
}
```

#### storage.remove
删除数据

**权限**: `storage.local`

**调用示例**:
```javascript
export async function storageRemove(key) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('storage.remove', { key });
}
```

#### storage.clear
清空所有数据

**权限**: `storage.local`

**调用示例**:
```javascript
export async function storageClear() {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('storage.clear', {});
}
```

**注意事项**:
- 每个插件有独立的存储空间（5MB 限制）
- 插件之间数据隔离
- 卸载插件时自动清除数据

---

### 8. UI Helpers（UI 辅助）

#### toast.show
显示 Toast 提示

**权限**: `toast.show`

**调用示例**:
```javascript
export async function showToast(message, duration = 'short') {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('toast.show', {
    message,
    duration    // 'short' | 'long'
  });
}
```

#### dialog.alert
显示警告对话框

**权限**: `dialog.alert`

**调用示例**:
```javascript
export async function showAlert(title, message) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('dialog.alert', { title, message });
}
```

#### dialog.confirm
显示确认对话框

**权限**: `dialog.confirm`

**调用示例**:
```javascript
export async function showConfirm(title, message) {
  if (typeof invokeHost !== 'function') {
    return false;
  }
  
  try {
    const result = await invokeHost('dialog.confirm', {
      title,
      message,
      confirmText: '确定',
      cancelText: '取消'
    });
    return result.confirmed || false;
  } catch (error) {
    return false;
  }
}
```

#### clipboard.write
写入剪贴板

**权限**: `clipboard.write`

**调用示例**:
```javascript
export async function copyToClipboard(text) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  try {
    await invokeHost('clipboard.write', { text });
    await showToast('已复制到剪贴板');
  } catch (error) {
    console.error('Failed to copy:', error);
  }
}
```

#### loading.show / loading.hide
显示/隐藏加载指示器

**权限**: 无需权限

**调用示例**:
```javascript
export async function showLoading(message = '加载中...') {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('loading.show', { message });
}

export async function hideLoading() {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('loading.hide', {});
}
```

---

### 9. Device（设备能力）

#### device.location.get
获取位置信息

**权限**: `device.location.read` (高风险，需用户确认)

**调用示例**:
```javascript
export async function getLocation() {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  try {
    const result = await invokeHost('device.location.get', {
      accuracy: 'high'    // 'low' | 'medium' | 'high'
    });
    return result.location;
  } catch (error) {
    console.error('Failed to get location:', error);
    return null;
  }
}
```

**返回数据**:
```javascript
{
  location: {
    latitude: 39.9042,
    longitude: 116.4074,
    accuracy: 10,
    timestamp: '2024-06-20T10:00:00Z'
  }
}
```

#### device.camera.scan
扫描二维码

**权限**: `device.camera.use` (高风险)

**调用示例**:
```javascript
export async function scanQRCode() {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  try {
    const result = await invokeHost('device.camera.scan', {
      type: 'qrcode'    // 'qrcode' | 'barcode'
    });
    return result.content;
  } catch (error) {
    console.error('Failed to scan:', error);
    return null;
  }
}
```

#### device.info.get
获取设备信息

**权限**: `device.info.read`

**调用示例**:
```javascript
export async function getDeviceInfo() {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  const result = await invokeHost('device.info.get', {});
  return result.device;
}
```

**返回数据**:
```javascript
{
  device: {
    platform: 'ios',           // 'ios' | 'android' | 'windows' | 'macos' | 'linux'
    model: 'iPhone 14 Pro',
    osVersion: '17.0',
    appVersion: '2.0.0'
  }
}
```

---

### 10. Event（事件）

#### event.publish
发布自定义事件

**权限**: `event.publish`

**调用示例**:
```javascript
export async function publishEvent(eventName, payload = {}) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  
  return invokeHost('event.publish', {
    event: eventName,
    payload
  });
}
```

**示例**:
```javascript
// 插件 A 发布事件
publishEvent('com.company.crm.deal_updated', {
  dealId: 'D-001',
  amount: 50000
});

// 插件 B 在 Manifest 中订阅
// "activationEvents": ["onEvent:com.company.crm.deal_updated"]
```

---

## 权限配置

### Manifest 权限声明

```json
{
  "permissions": [
    // 低风险权限（无需用户确认）
    "storage.local",
    "toast.show",
    "dialog.alert",
    "dialog.confirm",
    "navigation.open",
    "navigation.back",
    
    // 中风险权限（安装时展示）
    "network.request",
    "notification.send",
    "clipboard.write",
    "calendar.read",
    "calendar.write",
    
    // 高风险权限（需用户运行时确认）
    "org.contacts.read",
    "approval.read",
    "approval.write",
    "device.location.read",
    "device.camera.use",
    "clipboard.read",
    
    // 高风险权限（需管理员审批）
    "im.message.send",
    "file.write"
  ]
}
```

### 权限分级

| 级别 | 权限示例 | 审批方式 |
|---|---|---|
| **低风险** | `storage.local`, `toast.show` | Manifest 声明即可 |
| **中风险** | `network.request`, `notification.send` | 安装时展示 |
| **高风险** | `device.location.read`, `clipboard.read` | 运行时用户确认 |
| **关键** | `file.write`, `system.command.execute` | 管理员审批 |

---

## 错误处理

### 统一错误处理模式

```javascript
export async function safeInvokeHost(method, params = {}) {
  if (typeof invokeHost !== 'function') {
    console.warn('invokeHost not available');
    return { success: false, error: 'HOST_NOT_AVAILABLE' };
  }
  
  try {
    const result = await invokeHost(method, params);
    return { success: true, data: result };
  } catch (error) {
    console.error(`Failed to invoke ${method}:`, error);
    
    // 解析错误类型
    const errorType = error.code || 'UNKNOWN_ERROR';
    const errorMessage = error.message || '操作失败';
    
    return {
      success: false,
      error: errorType,
      message: errorMessage
    };
  }
}
```

### 常见错误码

```javascript
const ERROR_CODES = {
  // 权限错误
  PERMISSION_DENIED: '权限不足',
  PERMISSION_REQUIRED: '需要申请权限',
  
  // 网络错误
  NETWORK_ERROR: '网络请求失败',
  TIMEOUT: '请求超时',
  
  // 参数错误
  INVALID_PARAMS: '参数不合法',
  MISSING_PARAMS: '缺少必要参数',
  
  // 资源错误
  NOT_FOUND: '资源不存在',
  RESOURCE_EXHAUSTED: '资源配额已用尽',
  
  // 系统错误
  HOST_NOT_AVAILABLE: '宿主环境不可用',
  INTERNAL_ERROR: '内部错误',
  UNKNOWN_ERROR: '未知错误'
};

export function getErrorMessage(errorCode) {
  return ERROR_CODES[errorCode] || ERROR_CODES.UNKNOWN_ERROR;
}
```

### 错误处理示例

```javascript
export async function submitApprovalWithErrorHandling(orderId, comment) {
  const result = await safeInvokeHost('approval.submit', {
    orderId,
    action: 'approve',
    comment
  });
  
  if (!result.success) {
    // 根据错误类型处理
    switch (result.error) {
      case 'PERMISSION_DENIED':
        await showAlert('权限不足', '您没有审批权限');
        break;
      case 'NOT_FOUND':
        await showAlert('审批单不存在', '该审批单已被删除或不存在');
        break;
      default:
        await showAlert('提交失败', getErrorMessage(result.error));
    }
    return false;
  }
  
  await showToast('提交成功');
  return true;
}
```

---

## Host API 封装模板

### services/host_api.js

```javascript
/**
 * Host Bridge API 封装
 * 所有宿主能力调用统一封装在此文件
 */

// ============= 基础工具 =============

function checkHost() {
  if (typeof invokeHost !== 'function') {
    console.warn('invokeHost not available');
    return false;
  }
  return true;
}

async function safeInvoke(method, params = {}) {
  if (!checkHost()) {
    throw new Error('HOST_NOT_AVAILABLE');
  }
  
  try {
    return await invokeHost(method, params);
  } catch (error) {
    console.error(`Failed to invoke ${method}:`, error);
    throw error;
  }
}

// ============= UI 辅助 =============

export async function showToast(message) {
  if (!checkHost()) return null;
  return safeInvoke('toast.show', { message });
}

export async function showAlert(title, message) {
  if (!checkHost()) return null;
  return safeInvoke('dialog.alert', { title, message });
}

export async function showConfirm(title, message) {
  if (!checkHost()) return false;
  const result = await safeInvoke('dialog.confirm', { title, message });
  return result.confirmed || false;
}

export async function showLoading(message = '加载中...') {
  if (!checkHost()) return null;
  return safeInvoke('loading.show', { message });
}

export async function hideLoading() {
  if (!checkHost()) return null;
  return safeInvoke('loading.hide', {});
}

// ============= 导航 =============

export async function navigateTo(route, params = {}) {
  if (!checkHost()) return null;
  return safeInvoke('navigation.open', { route, params });
}

export async function navigateBack() {
  if (!checkHost()) return null;
  return safeInvoke('navigation.back', {});
}

// ============= 存储 =============

export async function storageSet(key, value) {
  if (!checkHost()) return null;
  return safeInvoke('storage.set', {
    key,
    value: JSON.stringify(value)
  });
}

export async function storageGet(key, defaultValue = null) {
  if (!checkHost()) return defaultValue;
  try {
    const result = await safeInvoke('storage.get', { key });
    if (result && result.value) {
      return JSON.parse(result.value);
    }
    return defaultValue;
  } catch (error) {
    return defaultValue;
  }
}

// ============= 业务能力（根据需要添加）=============

export async function sendNotification(title, body, payload = {}) {
  if (!checkHost()) return null;
  return safeInvoke('notification.send', { title, body, payload });
}

export async function pickContacts(selectedIds = []) {
  if (!checkHost()) return [];
  const result = await safeInvoke('org.contacts.pick', {
    multiple: true,
    selectedIds
  });
  return result.contacts || [];
}

// 添加更多 API 封装...
```

---

## Checklist

集成能力桥接时确保：

- [ ] Manifest 中声明了所需权限
- [ ] 所有 Host API 调用都检查了 `invokeHost` 是否可用
- [ ] 错误处理完整（try-catch）
- [ ] 参数类型正确
- [ ] 返回值处理正确
- [ ] 高风险操作有用户确认
- [ ] API 调用封装在 services/host_api.js
- [ ] 网络请求域名在 Manifest 中声明
- [ ] 存储数据使用 JSON 序列化
- [ ] 错误信息对用户友好

---

## 快速参考

### 常用能力速查表

| 功能 | API | 权限 |
|---|---|---|
| Toast 提示 | `toast.show` | `toast.show` |
| 确认对话框 | `dialog.confirm` | `dialog.confirm` |
| 页面跳转 | `navigation.open` | `navigation.open` |
| 本地存储 | `storage.set/get` | `storage.local` |
| 发送通知 | `notification.send` | `notification.send` |
| 网络请求 | `network.request` | `network.request` |
| 选择联系人 | `org.contacts.pick` | `org.contacts.read` |
| 提交审批 | `approval.submit` | `approval.write` |
| 获取位置 | `device.location.get` | `device.location.read` |
