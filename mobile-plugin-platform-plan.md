# 跨端客户端插件平台方案

## 1. 定位

客户端插件平台的目标是建设一套**跨端统一的插件运行时与能力接入体系**，覆盖移动端（iOS / Android）、PC 端（Windows / macOS / Linux）和桌面端。

与上一版「移动端插件化」方案相比，核心变化：

- **从"纯移动端"升级为"跨端客户端插件平台"**：统一架构、统一 Manifest、统一能力桥，一次开发可跨端运行。
- **引入 JS 引擎运行时**：每个插件拥有独立 JS 沙箱，下发 JS 逻辑而非纯 Schema 配置，具备完整的业务编排能力。
- **JS 引擎与 Flutter 宿主双向通信**：插件通过 JS 引擎调用宿主能力桥，宿主通过 JS 引擎向插件分发事件和指令。
- **结合 STAC / Server-Driven UI**：JS 逻辑负责数据处理和业务编排，UI 渲染走 STAC 框架，实现「逻辑动态化 + UI 声明式渲染」。
- **事件驱动模型**：宿主维护事件总线，插件在 Manifest 中声明关心的事件，宿主按需分发。
- **插件完全隔离**：每个插件独立 JS Runtime，内存、权限、生命周期互不干扰。

核心路线：

```text
Flutter 跨端宿主（Mobile / Desktop）
+ JS 引擎运行时（QuickJS / V8）
+ STAC Server-Driven UI
+ 事件驱动分发
+ 统一能力桥
+ 内置 Flutter 模块
+ 白名单 WebView
+ 远端插件服务
+ 远程配置
+ 严格权限与安全沙箱
```

客户端不做运行时动态加载 Dart / Native 可执行代码。插件逻辑由 JS 引擎承载，UI 渲染由 STAC 承载，能力调用由宿主代理，在跨端统一与平台合规之间取得平衡。

---

## 2. 总体架构

### 2.1 三层架构模型

```text
┌─────────────────────────────────────────────────────────┐
│                    Plugin Layer                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌─────────┐ │
│  │ Plugin A │  │ Plugin B │  │ Plugin C │  │Plugin D │ │
│  │ JS RT    │  │ JS RT    │  │ JS RT    │  │Flutter  │ │
│  │ (QuickJS)│  │ (QuickJS)│  │ (QuickJS)│  │Module   │ │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬────┘ │
├───────┼──────────────┼──────────────┼──────────────┼─────┤
│       │   STAC UI Layer (SDUI)     │              │     │
│  ┌────▼────────────────────────────▼────┐    ┌────▼───┐ │
│  │  STAC Renderer                       │    │Flutter │ │
│  │  ┌──────┐ ┌──────┐ ┌──────┐         │    │Widget  │ │
│  │  │Form  │ │List  │ │Card  │ ...     │    │Tree    │ │
│  │  └──────┘ └──────┘ └──────┘         │    └────────┘ │
│  └──────────────────┬──────────────────┘               │
├─────────────────────┼───────────────────────────────────┤
│       Host Capability Layer                              │
│  ┌──────────────────▼──────────────────────────────────┐ │
│  │  Host Bridge (Capability Registry)                  │ │
│  │  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐       │ │
│  │  │ Auth   │ │ IM     │ │ File   │ │ Device │ ...   │ │
│  │  └────────┘ └────────┘ └────────┘ └────────┘       │ │
│  └─────────────────────────────────────────────────────┘ │
├──────────────────────────────────────────────────────────┤
│  Flutter Host (Mobile / Desktop)                         │
│  ┌─────────┐ ┌──────────┐ ┌──────────┐ ┌─────────────┐ │
│  │ EventBus│ │ PluginMgr│ │ Config   │ │ Governance  │ │
│  └─────────┘ └──────────┘ └──────────┘ └─────────────┘ │
└──────────────────────────────────────────────────────────┘
```

三层职责：

| 层次 | 职责 | 技术载体 |
|---|---|---|
| **Plugin Layer** | 插件业务逻辑、状态管理、动作编排 | QuickJS / V8 JS Runtime |
| **STAC UI Layer** | 声明式 UI 渲染、用户交互事件回调 | STAC Framework / Flutter |
| **Host Capability Layer** | 原生能力开放、权限控制、资源管理 | Flutter Host + Platform Channel |

### 2.2 完整架构

```text
Flutter 跨端宿主
├─ 核心业务模块
│  ├─ IM
│  ├─ 工作台
│  ├─ 审批
│  ├─ 通讯录
│  └─ 设置
├─ 插件管理器（PluginManager）
│  ├─ 插件发现与注册
│  ├─ Manifest 解析与校验
│  ├─ 安装 / 卸载 / 更新
│  ├─ 启用 / 禁用
│  ├─ JS Runtime 池管理
│  ├─ 生命周期调度
│  ├─ 版本校验 & 签名校验
│  └─ 灰度 / 回滚
├─ JS 引擎运行时层（JS Runtime Layer）
│  ├─ QuickJS Engine（移动端 + PC 端）
│  ├─ V8 Engine（PC 端可选）
│  ├─ Runtime 实例池（每个插件独立实例）
│  ├─ 沙箱隔离（内存 / 权限 / 生命周期）
│  ├─ JS Bundle 加载与缓存
│  └─ 执行超时 & 资源限制
├─ STAC SDUI 层
│  ├─ STAC Schema 解析器
│  ├─ Flutter 渲染组件库
│  ├─ 用户交互事件回调 → JS 侧
│  ├─ 表单校验引擎
│  ├─ 动作执行器
│  └─ Schema 版本兼容
├─ 事件总线（EventBus）
│  ├─ 系统事件分发
│  ├─ 业务事件分发
│  ├─ 插件事件订阅管理
│  └─ 事件过滤与权限校验
├─ 能力桥（Host Bridge）
│  ├─ 账号 / 组织
│  ├─ IM 与消息
│  ├─ 审批与办公流程
│  ├─ 通知
│  ├─ 定位 / 文件 / 设备能力
│  ├─ 网络代理（所有请求经宿主）
│  ├─ 本地存储（沙箱化）
│  └─ 剪贴板 / 窗口（PC 端）
├─ 通信协议层
│  ├─ JS ↔ Host Bridge（invokeHost / JSON-RPC）
│  ├─ JS ↔ STAC（Schema JSON + Event Callback）
│  ├─ Web 插件 ↔ Host（postMessage + JS Bridge）
│  └─ 远端插件 ↔ Host（HTTP API + Event Push）
├─ 应用接入层
│  ├─ 内置 Flutter 模块
│  ├─ JS 插件（JS Runtime + STAC UI）
│  ├─ 白名单 WebView 插件
│  ├─ 能力编排型插件（纯 Schema，无 JS）
│  └─ 远端插件服务
├─ 配置中心
│  ├─ 应用入口配置
│  ├─ 菜单配置
│  ├─ STAC Schema
│  ├─ JS Bundle 版本管理
│  ├─ 功能开关
│  └─ 灰度策略
└─ 治理体系
   ├─ 权限控制
   ├─ 性能监控
   ├─ 错误监控
   ├─ 安全审计
   ├─ 资源限制（CPU / 内存 / 网络）
   └─ 版本兼容
```

---

## 3. 插件类型

### 3.1 内置 Flutter 模块

核心业务使用 Flutter 编译期内置实现，随 App 发版。

适用场景：

- 高频使用、复杂交互、强一致体验。
- 需要离线能力、高性能渲染。
- 需要深度调用 Native 能力。

示例：

- IM 聊天、通讯录、工作台首页、审批待办、消息通知中心。

建设建议：

- 使用 Flutter 分层架构（UI → Logic → Data）。
- 内置模块也注册到统一插件体系，复用入口、权限、埋点和菜单模型。
- 核心模块随 App 发版，不走动态插件更新。

### 3.2 JS 插件（核心新增）

JS 插件是本方案的**核心插件形态**。每个 JS 插件拥有独立的 JS 运行时，通过 JS 代码实现业务逻辑，通过 STAC Schema 描述 UI，通过 Host Bridge 调用宿主能力。

运行模型：

```text
Flutter 宿主
├─ PluginManager 创建独立 JS Runtime（QuickJS）
├─ 加载插件 JS Bundle
├─ JS 执行业务逻辑
├─ JS 调用 invokeHost('capability.id', params) → Host Bridge
├─ JS 返回 STAC Schema JSON → STAC Renderer 渲染
├─ 用户交互事件 → STAC 回调 → JS 处理
└─ 宿主事件 → EventBus → JS 回调函数处理
```

适用场景：

- 中等复杂度的业务页面（表单、审批、报表）。
- 需要本地状态管理和业务编排的动态功能。
- 需要响应宿主事件的扩展能力。
- 需要跨端统一的业务逻辑。

不适用场景：

- 强交互复杂页面（IM 聊天主界面）。
- 高频核心链路（首页）。
- 需要大量动画和手势的页面。
- 需要新增 Native 能力的页面。

JS 插件示例代码：

```javascript
// plugin-entry.js
export function onActivate(context) {
  context.log('Approval plugin activated');
}

// 返回 STAC Schema 描述的页面
export function renderPage(route) {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: '快速审批',
    layout: {
      type: 'column',
      children: [
        {
          type: 'text',
          props: { text: '${approval.title}', style: 'titleMedium' }
        },
        {
          type: 'textarea',
          id: 'comment',
          props: { label: '审批意见', maxLength: 300 },
          validation: [{ type: 'required', message: '请填写审批意见' }]
        },
        {
          type: 'button',
          props: { text: '同意' },
          onTap: 'handleApprove'
        }
      ]
    },
    dataSources: {
      approval: {
        capability: 'approval.detail',
        params: { orderId: '${route.orderId}' }
      }
    }
  };
}

// 用户交互回调
export async function handleApprove(state, context) {
  const result = await context.invokeHost('approval.submit', {
    orderId: state.route.orderId,
    comment: state.comment
  });

  if (result.success) {
    await context.invokeHost('toast.show', { message: '已提交' });
    await context.invokeHost('navigation.back');
  } else {
    await context.invokeHost('dialog.alert', {
      title: '提交失败',
      message: result.message
    });
  }
}

// 事件处理
export function onApprovalCreated(event, context) {
  context.invokeHost('notification.send', {
    title: '新审批',
    body: `你收到一条来自 ${event.creator} 的审批`
  });
}

export function onDeactivate() {
  // 清理资源
}
```

### 3.3 WebView 插件

WebView 插件用于接入公司内部 Web 应用，与上一版方案一致，但增加与 JS 插件统一的 Manifest 格式和权限模型。

适用场景：

- 后台管理、报表、低频流程。
- 需要频繁更新但不涉及核心客户端能力的页面。

接入要求：

- 只能加载白名单域名。
- 必须统一 SSO。
- 必须限制 JS Bridge 权限。
- 必须有加载失败兜底页面。

### 3.4 能力编排型插件（纯 Schema，无 JS）

能力编排型插件是 JS 插件的轻量子集，不下发 JS 代码，仅通过 Schema 描述页面结构、数据绑定和动作链。适合低复杂度场景。

适用场景：

- 简单表单、配置页、低风险业务动作。
- 不需要复杂状态管理和事件响应。

与 JS 插件的关系：

- 能力编排型插件可视作 JS 插件的简化模式。
- 当业务复杂度超出 Schema 表达能力时，升级为 JS 插件。
- 两者共享同一套 Manifest 格式和能力桥。

### 3.5 远端插件服务

远端插件服务的插件逻辑运行在服务端，客户端只负责展示入口、收集参数和展示结果。与上一版方案一致。

```text
客户端 App
├─ 展示入口
├─ 收集参数
├─ 调用平台插件网关
├─ 渲染结果 / STAC Schema UI
└─ 上报埋点

平台插件网关
├─ 插件注册中心
├─ 权限校验 & Token 管理
├─ 插件路由 & 限流熔断
├─ 审计日志
└─ 回调 / 事件分发

远端插件服务
├─ 业务逻辑
├─ 外部系统集成
├─ 数据处理
└─ 返回结果 / UI Schema
```

### 3.6 插件类型对比

| 类型 | 运行时载体 | UI 渲染 | 动态性 | 复杂度 | 跨端一致性 | 审核风险 |
|---|---|---|---|---|---|---|
| 内置 Flutter 模块 | Flutter 编译期 | Flutter Widget | 发版更新 | 高 | 高 | 无 |
| JS 插件 | QuickJS 沙箱 | STAC SDUI | JS Bundle 热更新 | 中高 | 高 | 低 |
| WebView 插件 | WebView | Web | Web 热更新 | 中 | 中 | 低（白名单） |
| 能力编排型 | 无运行时 | STAC SDUI | Schema 热更新 | 低 | 高 | 无 |
| 远端插件服务 | 服务端 | 客户端渲染 | 服务端更新 | 不限 | 高 | 无 |

---

## 4. JS 引擎运行时

### 4.1 引擎选型

| 维度 | QuickJS | V8 |
|---|---|---|
| 体积 | ~700KB（极轻量） | ~30MB+ |
| 启动速度 | 快（ms 级） | 慢（需初始化 Isolate） |
| ES 规范支持 | ES2020+（足够） | 完整最新 |
| 内存占用 | 低（适合多实例） | 高（单实例即大） |
| 嵌入式友好度 | 极高（API 简洁） | 中等（API 复杂） |
| Dart FFI 集成 | `quickjs_dart` / `flutter_js` 成熟 | 需自行封装 |
| 跨平台 | iOS / Android / Desktop 全支持 | Desktop 支持好，移动端体积大 |
| JIT | 不支持（纯解释） | 支持（但有安全风险） |
| 多实例隔离 | 天然支持 | 需要多 Isolate |
| 推荐场景 | **所有端默认选择** | PC 端高性能场景可选 |

**推荐结论**：

- **默认使用 QuickJS**：轻量、嵌入式友好、多实例隔离好、跨端一致。
- PC 端在性能要求极高时可选择 V8，但需额外评估安全和体积。
- 所有端保持 QuickJS 优先，降低维护成本。

### 4.2 集成方式

移动端集成：

```text
Flutter App
├─ quickjs_dart / flutter_js（Dart FFI Plugin）
├─ Dart 侧封装 JSEngine 类
├─ 每个 Plugin 创建独立 JSRuntime
├─ JSRuntime → JSEngine wrapper
├─ 注册 Host Bridge 回调
└─ 生命周期由 PluginManager 管理
```

PC 端集成：

```text
Flutter Desktop App
├─ quickjs_dart（Dart FFI，与移动端一致）
├─ 或 V8（通过 dart:ffi 自行封装）
├─ 其余架构与移动端完全一致
└─ 统一 API，引擎实现可插拔
```

Dart 侧引擎抽象：

```dart
/// JS 引擎抽象接口，支持 QuickJS / V8 可插拔
abstract class JSEngine {
  /// 创建独立的 JS Runtime 实例
  JSRuntime createRuntime({
    int memoryLimitBytes = 16 * 1024 * 1024, // 16MB 默认内存限制
    Duration? executionTimeout,
  });

  /// 全局能力桥注册
  void registerHostHandler(String method, Future<Map<String, dynamic>> Function(Map<String, dynamic> params) handler);
}

/// 单个插件的 JS 运行时
abstract class JSRuntime {
  String get runtimeId;
  String get pluginId;

  /// 加载并执行 JS Bundle
  Future<void> loadBundle(String jsSource);

  /// 调用 JS 侧导出函数
  Future<dynamic> evaluate(String expression);

  /// 调用 JS 侧具名函数
  Future<dynamic> callFunction(String functionName, List<dynamic> args);

  /// 注册宿主能力供 JS 调用
  void registerHostBridge(String method, Future<dynamic> Function(Map<String, dynamic>) handler);

  /// 触发 JS 侧事件回调
  Future<void> dispatchEvent(String eventName, Map<String, dynamic> payload);

  /// 销毁运行时，释放资源
  void dispose();
}
```

### 4.3 沙箱隔离

每个 JS 插件运行在完全隔离的沙箱中：

```text
┌──────────────────────────────────────┐
│           JS Runtime (Plugin A)      │
│  ┌────────────────────────────────┐  │
│  │ JS Sandbox                     │  │
│  │ ├─ 独立全局对象                 │  │
│  │ ├─ 独立模块系统                 │  │
│  │ ├─ 受限 API 白名单              │  │
│  │ ├─ 内存限制：16MB              │  │
│  │ ├─ 执行超时：5s（同步）         │  │
│  │ └─ 无 eval / Function 构造器   │  │
│  └────────────────────────────────┘  │
│  ┌────────────────────────────────┐  │
│  │ Host Bridge (权限受控)          │  │
│  │ ├─ invokeHost()                │  │
│  │ └─ 仅注册 Manifest 声明的能力   │  │
│  └────────────────────────────────┘  │
└──────────────────────────────────────┘
```

隔离维度：

| 维度 | 策略 |
|---|---|
| **内存** | 每个 Runtime 独立堆，默认 16MB 上限，超限自动 OOM 终止 |
| **执行** | 同步调用超时 5s，异步调用超时 30s |
| **作用域** | 独立全局对象，JS 插件之间不可互相访问 |
| **文件** | 禁止直接访问文件系统，通过宿主代理读写沙箱目录 |
| **网络** | 禁止直接发起网络请求，必须通过 `invokeHost('network.request', ...)` |
| **API** | 禁用 `eval()`、`Function()` 构造器、`XMLHttpRequest`、`fetch` |
| **定时器** | 受限的 `setTimeout` / `setInterval`，最大间隔和总数受控 |
| **存储** | 独立沙箱存储空间，默认 5MB，不可访问其他插件数据 |

### 4.4 通信协议

JS 引擎与 Flutter 宿主之间采用 **JSON-RPC 风格消息传递**：

```text
JS Runtime                          Flutter Host
    │                                    │
    │  invokeHost('approval.submit',     │
    │    { orderId: '123', ... })        │
    │ ──────────────────────────────────>│
    │                                    │
    │         Promise<pending>           │  宿主校验权限
    │                                    │  宿主执行能力
    │                                    │
    │  { success: true, ... }            │
    │<──────────────────────────────────│
    │         Promise<resolved>          │
    │                                    │
```

**JS → Host 调用协议**：

```javascript
// JS 侧 API
const result = await invokeHost(method, params);

// 实际消息（JSON-RPC 风格）
{
  "jsonrpc": "2.0",
  "method": "approval.submit",
  "params": { "orderId": "123", "comment": "同意" },
  "id": 42,
  "meta": {
    "pluginId": "com.company.approval.plugin",
    "runtimeId": "rt_abc123"
  }
}

// Host 返回
{
  "jsonrpc": "2.0",
  "result": { "success": true, "message": "审批已提交" },
  "id": 42
}

// 或错误返回
{
  "jsonrpc": "2.0",
  "error": {
    "code": -32603,
    "message": "Permission denied: approval.write",
    "data": { "requiredPermission": "approval.write" }
  },
  "id": 42
}
```

**Host → JS 事件分发协议**：

```json
{
  "jsonrpc": "2.0",
  "method": "event.dispatch",
  "params": {
    "event": "onApprovalCreated",
    "payload": {
      "orderId": "ORD-20240613-001",
      "creator": "张三",
      "title": "请假申请"
    }
  }
}
```

**Host → JS 函数调用**：

```json
{
  "jsonrpc": "2.0",
  "method": "function.call",
  "params": {
    "functionName": "renderPage",
    "args": [{ "route": "/approval/detail", "params": { "orderId": "123" } }]
  },
  "id": 100
}
```

### 4.5 生命周期

```text
                  install
                    │
                    ▼
              ┌─── activate ───┐
              │                 │
              ▼                 │
           running ◄───────────┘
          │  │  │               │
          │  │  │  事件触发      │ 懒加载激活
          │  │  │  (onDemand)   │
          │  │  ▼               │
          │  │  idle ─── 事件 ──┘
          │  │         触发
          │  │
          │  └──── deactivate
          │           │
          │           ▼
          │       (可重新 activate)
          │
          └──── uninstall
                    │
                    ▼
                 (销毁 Runtime)
```

状态说明：

| 状态 | 说明 | JS Runtime |
|---|---|---|
| `install` | 插件已下载、解压、签名校验通过 | 未创建 |
| `activate` | 懒加载触发或用户打开，创建 JS Runtime 并加载 Bundle | 已创建 |
| `running` | JS Runtime 活跃，可响应事件和用户交互 | 活跃 |
| `idle` | 后台空闲超过阈值（默认 5 分钟），Runtime 可挂起释放内存 | 挂起 |
| `deactivate` | 用户关闭或宿主回收，销毁 JS Runtime | 已销毁 |
| `uninstall` | 用户卸载，删除所有数据和缓存 | 已销毁 |

懒加载策略：

- 插件在 Manifest 中声明 `activationEvents`，只在匹配时激活。
- 未激活的插件不创建 JS Runtime，不占用内存。
- 常驻后台插件需要 Manifest 声明 `background: true`，受严格资源限制。

崩溃隔离：

```text
Plugin A (JS Runtime)  ─── 异常/崩溃
        │
        ▼
PluginManager 捕获异常
        │
        ├─ 标记 Plugin A 为 error 状态
        ├─ 销毁 Plugin A 的 JS Runtime
        ├─ 上报错误日志
        ├─ 展示错误提示给用户
        │
Plugin B (JS Runtime)  ─── 不受影响 ✓
Flutter Host           ─── 不受影响 ✓
```

---

## 5. STAC SDUI 集成

### 5.1 三层协作模型

JS 插件的核心工作模式是 **JS Logic + STAC UI + Host Capability** 的三层协作：

```text
┌─────────────────────────────────────────────────────────┐
│  JS Logic Layer（QuickJS Runtime）                       │
│                                                          │
│  职责：                                                  │
│  ├─ 业务逻辑处理                                         │
│  ├─ 状态管理（页面状态、表单数据）                         │
│  ├─ 动作编排（调用多个 Host 能力的组合逻辑）               │
│  ├─ 事件处理（响应宿主事件）                               │
│  ├─ 数据转换（API 数据 → UI 数据）                        │
│  └─ 返回 STAC Schema JSON                                │
│                                                          │
├──────────────────────────┬──────────────────────────────┤
│  STAC UI Layer           │                              │
│                          │                              │
│  职责：                   │                              │
│  ├─ 接收 STAC Schema JSON│                              │
│  ├─ 解析为 Flutter Widget │                             │
│  ├─ 渲染 UI               │                             │
│  ├─ 用户交互 → 回调 JS    │                             │
│  └─ 表单校验 → 回调 JS    │                             │
│                          │                              │
├──────────────────────────┼──────────────────────────────┤
│  Host Capability Layer   │                              │
│                          │                              │
│  职责：                   │                              │
│  ├─ 注册能力 API          │                             │
│  ├─ 权限校验              │                             │
│  ├─ 网络代理              │                             │
│  ├─ 文件代理              │                             │
│  └─ 设备能力              │                             │
└──────────────────────────────────────────────────────────┘
```

### 5.2 数据流

```text
用户打开插件页面
        │
        ▼
PluginManager.activate(pluginId)
        │
        ▼
创建 JS Runtime → 加载 JS Bundle
        │
        ▼
Host 调用 JS: renderPage(routeParams)
        │
        ▼
JS 执行业务逻辑:
  ├─ 调用 invokeHost('data.fetch', params) 获取数据
  ├─ 处理数据
  └─ 返回 STAC Schema JSON
        │
        ▼
STAC Renderer 接收 Schema → 渲染 Flutter Widget
        │
        ▼
用户交互（点击按钮）
        │
        ▼
STAC 回调: handleApprove(state)
        │
        ▼
JS 执行动作:
  ├─ 调用 invokeHost('approval.submit', ...)
  ├─ 调用 invokeHost('toast.show', ...)
  └─ 调用 invokeHost('navigation.back')
        │
        ▼
页面更新或跳转
```

### 5.3 完整渲染流程

```text
1. 宿主根据路由/事件确定目标插件
2. PluginManager 检查插件是否已激活
3. 未激活 → 创建 JS Runtime → 加载 JS Bundle → 调用 onActivate()
4. 宿主调用 JS renderPage(route) / renderCard(context) 等入口函数
5. JS 内部可能通过 invokeHost() 获取数据
6. JS 返回 STAC Schema JSON
7. STAC Renderer 解析 Schema:
   a. 校验 schemaVersion 兼容性
   b. 解析组件树
   c. 绑定数据源
   d. 注册交互事件回调
   e. 渲染 Flutter Widget
8. 用户交互触发事件:
   a. STAC 将事件名 + 当前状态传递给 JS 回调
   b. JS 执行业务逻辑
   c. JS 可能返回更新后的 Schema（局部更新）或调用宿主动作
9. 宿主事件触发:
   a. EventBus 分发事件到已激活的 JS Runtime
   b. JS 调用对应的事件处理函数
   c. JS 可能更新 UI 或执行动作
```

### 5.4 局部更新与状态同步

为避免全量重渲染，JS 插件支持局部 Schema 更新：

```javascript
// 全量更新：返回完整 Schema
export function renderPage(route) {
  return fullSchema;
}

// 局部更新：返回差异
export function handleLike(state, context) {
  // 业务逻辑
  await context.invokeHost('social.like', { targetId: state.postId });

  // 返回局部更新指令
  return {
    type: 'patch',
    patches: [
      { op: 'replace', path: '/children/0/props/liked', value: true },
      { op: 'replace', path: '/children/0/props/likeCount', value: state.likeCount + 1 }
    ]
  };
}
```

STAC Renderer 支持：

- `type: 'full'` — 全量替换 Schema。
- `type: 'patch'` — JSON Patch 局部更新。
- `type: 'none'` — 不更新 UI（纯动作执行后）。

---

## 6. 事件驱动模型

### 6.1 事件总线架构

```text
┌──────────────────────────────────────────────────────┐
│                    EventBus                           │
│                                                       │
│  ┌─────────────┐  ┌─────────────┐  ┌──────────────┐ │
│  │ 系统事件源   │  │ 业务事件源   │  │ 插件事件源   │ │
│  └──────┬──────┘  └──────┬──────┘  └──────┬───────┘ │
│         │                │                 │          │
│         ▼                ▼                 ▼          │
│  ┌─────────────────────────────────────────────────┐ │
│  │            事件分发引擎                          │ │
│  │  ├─ 事件匹配（activationEvents + 运行时订阅）    │ │
│  │  ├─ 权限过滤                                    │ │
│  │  ├─ 频率限制                                    │ │
│  │  └─ 错误隔离                                    │ │
│  └─────────────┬───────────────────────────────────┘ │
│                 │                                     │
│    ┌────────────┼────────────┐                        │
│    ▼            ▼            ▼                        │
│  Plugin A    Plugin B    Plugin C                     │
│  (JS RT)     (JS RT)     (idle)                      │
│  onEvent()   onEvent()   不分发（未激活）              │
└──────────────────────────────────────────────────────┘
```

### 6.2 事件类型

#### 系统事件

由宿主客户端生命周期和系统状态变化触发：

| 事件名 | 触发时机 | Payload 示例 |
|---|---|---|
| `onAppStart` | App 启动完成 | `{ "launchTime": 1234567890 }` |
| `onAppEnterForeground` | App 从后台回到前台 | `{ "backgroundDuration": 300 }` |
| `onAppEnterBackground` | App 进入后台 | `{}` |
| `onUserLogin` | 用户登录成功 | `{ "userId": "u_123", "orgId": "org_456" }` |
| `onUserLogout` | 用户登出 | `{}` |
| `onNetworkChange` | 网络状态变化 | `{ "type": "wifi", "connected": true }` |
| `onPushMessage` | 收到推送消息 | `{ "messageId": "msg_789", "type": "approval" }` |
| `onLocaleChange` | 语言切换 | `{ "locale": "zh-CN" }` |
| `onThemeChange` | 主题切换 | `{ "theme": "dark" }` |

#### 业务事件

由核心业务模块触发：

| 事件名 | 触发时机 | Payload 示例 |
|---|---|---|
| `onApprovalCreated` | 新审批创建 | `{ "orderId": "ORD-001", "creator": "张三" }` |
| `onApprovalStatusChanged` | 审批状态变更 | `{ "orderId": "ORD-001", "status": "approved" }` |
| `onMessageReceived` | 收到新消息 | `{ "chatId": "c_123", "msgType": "text" }` |
| `onContactUpdated` | 通讯录变更 | `{ "userId": "u_456", "action": "profile_updated" }` |
| `onFileUploaded` | 文件上传完成 | `{ "fileId": "f_789", "fileName": "报告.pdf" }` |
| `onMeetingCreated` | 会议创建 | `{ "meetingId": "m_001", "startTime": "..." }` |

#### 自定义事件

插件可以通过 Host Bridge 发布自定义事件：

```javascript
// 插件 A 发布事件
await context.invokeHost('event.publish', {
  event: 'com.company.crm.deal_updated',
  payload: { dealId: 'D-001', amount: 50000 }
});

// 插件 B 在 Manifest 中订阅
// activationEvents: ["onEvent:com.company.crm.deal_updated"]
```

### 6.3 事件分发机制

```text
1. 事件源触发事件
2. EventBus 接收事件
3. 查询事件订阅表:
   a. 哪些插件的 activationEvents 包含此事件？
   b. 哪些已激活插件运行时订阅了此事件？
4. 权限过滤:
   a. 插件是否有权限接收此事件？
   b. 事件 payload 是否需要脱敏？
5. 频率限制:
   a. 单插件单事件最大频率（默认 10次/秒）
   b. 超限事件丢弃并告警
6. 懒激活检查:
   a. 如果插件未激活但声明了此 activationEvent → 触发 activate
   b. 如果插件已激活 → 直接分发
7. 分发到 JS Runtime:
   a. 调用 JS 侧 `on<EventName>(payload, context)` 函数
   b. JS 回调执行超时 30s
   c. 异常捕获并隔离
8. 上报事件处理埋点
```

### 6.4 插件事件订阅

插件通过 Manifest 声明事件订阅，也可以在运行时动态订阅：

**Manifest 声明式订阅（静态）**：

```json
{
  "activationEvents": [
    "onAppStart",
    "onApprovalCreated",
    "onPushMessage:approval",
    "onEvent:com.company.crm.deal_updated"
  ]
}
```

- 声明的事件用于懒加载：事件首次触发时自动激活插件。
- `onPushMessage:approval` 表示只接收 type=approval 的推送。
- `onEvent:com.company.crm.deal_updated` 表示订阅自定义事件。

**运行时动态订阅**：

```javascript
export function onActivate(context) {
  // 动态订阅事件
  context.subscribe('onMessageReceived', (payload) => {
    if (payload.msgType === 'approval_card') {
      context.invokeHost('notification.send', {
        title: '新审批消息',
        body: payload.preview
      });
    }
  });

  // 动态取消订阅
  context.unsubscribe('onMessageReceived');
}
```

### 6.5 事件处理约束

| 约束项 | 默认值 | 说明 |
|---|---|---|
| 事件回调超时 | 30s | 超时自动中断 |
| 单插件事件频率 | 10次/秒 | 超限丢弃并告警 |
| 事件队列长度 | 100 | 溢出时丢弃旧事件 |
| 后台插件事件 | 受限 | 后台插件只接收白名单事件 |
| 事件 payload 大小 | 64KB | 超限截断或拒绝 |

---

## 7. Manifest 设计

Manifest 是插件接入平台的核心协议。JS 插件的 Manifest 在原有基础上增加 JS 运行时相关字段。

```json
{
  "id": "com.company.approval.plugin",
  "name": "审批助手",
  "description": "提供审批查询、发起、处理和通知能力",
  "version": "1.2.0",
  "publisher": "company-office",
  "type": "js",
  "platforms": ["ios", "android", "windows", "macos", "linux"],
  "minHostVersion": "2.0.0",

  "engine": {
    "runtime": "quickjs",
    "bundle": "https://cdn.example.com/plugins/approval/1.2.0/main.js",
    "bundleHash": "sha256:a1b2c3d4e5f6...",
    "bundleSize": 45678,
    "entryFunction": "onActivate",
    "memoryLimitMb": 16,
    "executionTimeoutMs": 5000,
    "background": false
  },

  "activationEvents": [
    "onCommand:approval.open",
    "onMenu:workspace.sidebar",
    "onApprovalCreated",
    "onPushMessage:approval"
  ],

  "entry": {
    "route": "/approval",
    "renderFunction": "renderPage"
  },

  "contributes": {
    "menus": [
      {
        "location": "workspace.grid",
        "title": "审批",
        "icon": "approval",
        "command": "approval.open"
      }
    ],
    "commands": [
      {
        "id": "approval.open",
        "title": "打开审批助手"
      },
      {
        "id": "approval.quick_action",
        "title": "快速审批"
      }
    ],
    "search": [
      {
        "type": "approval",
        "placeholder": "搜索审批单",
        "handler": "handleSearch"
      }
    ]
  },

  "permissions": [
    "user.profile.read",
    "org.contacts.read",
    "approval.read",
    "approval.write",
    "notification.send",
    "network.request"
  ],

  "capabilities": [
    {
      "id": "approval.detail",
      "type": "data",
      "permissions": ["approval.read"]
    },
    {
      "id": "approval.submit",
      "type": "action",
      "permissions": ["approval.write"]
    }
  ],

  "stac": {
    "schemaVersion": "1.0",
    "components": ["text", "textarea", "button", "list", "card", "form", "dialog"],
    "customComponents": []
  },

  "performanceBudget": {
    "startupMs": 1500,
    "firstScreenMs": 3000,
    "maxMemoryMb": 16,
    "maxCpuPercent": 15
  },

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

### Manifest 字段说明

| 字段 | 必填 | 说明 |
|---|---|---|
| `id` | 是 | 全局唯一插件 ID，反向域名格式 |
| `name` | 是 | 展示名称 |
| `version` | 是 | 语义化版本号 |
| `type` | 是 | `js` / `builtin` / `webview` / `capability_composition` / `remote_action` |
| `platforms` | 是 | 支持平台列表 |
| `minHostVersion` | 是 | 最低宿主版本要求 |
| `engine.runtime` | JS 插件必填 | `quickjs` / `v8` |
| `engine.bundle` | JS 插件必填 | JS Bundle URL |
| `engine.bundleHash` | JS 插件必填 | SHA-256 签名 |
| `engine.memoryLimitMb` | 否 | 内存上限，默认 16 |
| `engine.background` | 否 | 是否允许后台常驻，默认 false |
| `activationEvents` | 是 | 激活事件列表，用于懒加载 |
| `permissions` | 是 | 权限声明 |
| `stac.schemaVersion` | JS 插件必填 | STAC Schema 版本 |
| `performanceBudget` | 否 | 性能预算 |
| `updatePolicy.signatureRequired` | JS 插件必填 | 必须为 true |

---

## 8. 能力桥设计

### 8.1 能力注册机制

Host Bridge 是插件访问宿主能力的唯一通道。每个能力必须注册后才能被 JS 调用。

```text
┌─────────────────────────────────────────────┐
│            Host Bridge                       │
│                                              │
│  ┌─────────────────────────────────────────┐ │
│  │  Capability Registry                    │ │
│  │                                         │ │
│  │  ┌─────────────┐  ┌─────────────────┐  │ │
│  │  │ approval.*  │  │ notification.*  │  │ │
│  │  │ ├─ detail   │  │ ├─ send         │  │ │
│  │  │ ├─ submit   │  │ └─ cancel       │  │ │
│  │  │ └─ list     │  │                 │  │ │
│  │  └─────────────┘  └─────────────────┘  │ │
│  │  ┌─────────────┐  ┌─────────────────┐  │ │
│  │  │ network.*   │  │ navigation.*    │  │ │
│  │  │ ├─ request  │  │ ├─ open         │  │ │
│  │  │ └─ upload   │  │ ├─ back         │  │ │
│  │  │             │  │ └─ replace      │  │ │
│  │  └─────────────┘  └─────────────────┘  │ │
│  └─────────────────────────────────────────┘ │
│                                              │
│  每个能力注册时声明:                          │
│  ├─ id（如 approval.submit）                │
│  ├─ inputSchema（参数校验）                   │
│  ├─ outputSchema（返回校验）                  │
│  ├─ requiredPermissions（权限要求）           │
│  ├─ minHostVersion（版本要求）               │
│  └─ platforms（支持平台）                    │
└─────────────────────────────────────────────┘
```

### 8.2 能力分类

```text
Host Bridge
├─ Account & Org
│  ├─ user.profile.get
│  ├─ org.contacts.search
│  ├─ org.contacts.getById
│  └─ org.department.list
├─ IM & Message
│  ├─ im.message.send
│  ├─ im.chat.open
│  ├─ im.message.search
│  └─ im.file.share
├─ Approval & Workflow
│  ├─ approval.detail.get
│  ├─ approval.submit
│  ├─ approval.list
│  └─ approval.history
├─ Notification
│  ├─ notification.send
│  ├─ notification.cancel
│  └─ notification.badge.set
├─ Navigation
│  ├─ navigation.open
│  ├─ navigation.back
│  ├─ navigation.replace
│  └─ navigation.tab.switch
├─ Network（代理）
│  ├─ network.request
│  ├─ network.upload
│  └─ network.download
├─ Storage（沙箱）
│  ├─ storage.get
│  ├─ storage.set
│  ├─ storage.remove
│  └─ storage.clear
├─ UI Helpers
│  ├─ toast.show
│  ├─ dialog.alert
│  ├─ dialog.confirm
│  ├─ clipboard.write
│  └─ loading.show
├─ Device（需权限）
│  ├─ device.location.get
│  ├─ device.camera.scan
│  ├─ device.bluetooth.scan
│  └─ device.info.get
├─ Event
│  ├─ event.publish
│  ├─ event.subscribe
│  └─ event.unsubscribe
├─ Telemetry
│  ├─ telemetry.track
│  └─ telemetry.log
└─ Clipboard / Window（PC 端）
   ├─ clipboard.read
   ├─ clipboard.write
   └─ window.open
```

### 8.3 能力注册示例（Dart 侧）

```dart
class HostBridge {
  final CapabilityRegistry _registry;
  final PermissionChecker _permissionChecker;

  void registerBuiltinCapabilities() {
    // 注册审批能力
    _registry.register(Capability(
      id: 'approval.submit',
      inputSchema: ApprovalSubmitInput.schema(),
      outputSchema: ApprovalSubmitOutput.schema(),
      requiredPermissions: ['approval.write'],
      minHostVersion: '2.0.0',
      platforms: ['ios', 'android', 'windows', 'macos', 'linux'],
      handler: (params) async {
        final orderId = params['orderId'] as String;
        final comment = params['comment'] as String;
        final result = await _approvalService.submit(orderId, comment);
        return {'success': result.success, 'message': result.message};
      },
    ));

    // 注册网络代理能力
    _registry.register(Capability(
      id: 'network.request',
      inputSchema: NetworkRequestInput.schema(),
      outputSchema: NetworkRequestOutput.schema(),
      requiredPermissions: ['network.request'],
      minHostVersion: '2.0.0',
      platforms: ['all'],
      handler: (params) async {
        // 所有网络请求经宿主代理，可审计、可限流
        return await _networkProxy.request(
          method: params['method'],
          url: params['url'],
          headers: params['headers'],
          body: params['body'],
        );
      },
    ));
  }

  /// 处理 JS 侧的 invokeHost 调用
  Future<Map<String, dynamic>> handleInvoke({
    required String pluginId,
    required String method,
    required Map<String, dynamic> params,
  }) async {
    // 1. 查找能力
    final capability = _registry.get(method);
    if (capability == null) {
      throw HostBridgeError.methodNotFound(method);
    }

    // 2. 权限校验
    final pluginManifest = _pluginManager.getManifest(pluginId);
    final hasPermission = _permissionChecker.check(
      pluginPermissions: pluginManifest.permissions,
      requiredPermissions: capability.requiredPermissions,
    );
    if (!hasPermission) {
      throw HostBridgeError.permissionDenied(
        method, capability.requiredPermissions,
      );
    }

    // 3. 参数校验
    capability.validateInput(params);

    // 4. 平台校验
    if (!capability.supportsPlatform(_currentPlatform)) {
      throw HostBridgeError.platformNotSupported(
        method, _currentPlatform,
      );
    }

    // 5. 执行能力
    final result = await capability.handle(params);

    // 6. 返回结果
    capability.validateOutput(result);

    // 7. 审计日志
    _auditLogger.log(
      pluginId: pluginId,
      method: method,
      params: params,
      result: result,
    );

    return result;
  }
}
```

---

## 9. 权限模型

### 9.1 权限分类

```text
权限树
├─ account
│  ├─ user.profile.read
│  └─ user.profile.write
├─ org
│  ├─ org.contacts.read
│  └─ org.department.read
├─ im
│  ├─ im.message.read
│  └─ im.message.send
├─ approval
│  ├─ approval.read
│  └─ approval.write
├─ notification
│  ├─ notification.send
│  └─ notification.badge
├─ network
│  └─ network.request
├─ storage
│  └─ storage.local
├─ device
│  ├─ device.location.read
│  ├─ device.camera.use
│  ├─ device.microphone.use
│  └─ device.info.read
├─ clipboard
│  ├─ clipboard.read
│  └─ clipboard.write
├─ file
│  ├─ file.pick
│  └─ file.upload
└─ system (PC 端)
   ├─ system.info.read
   ├─ window.open
   └─ system.command.execute（高风险）
```

### 9.2 权限分级

| 级别 | 权限示例 | 审批方式 |
|---|---|---|
| **低风险** | `user.profile.read`, `toast.show`, `navigation.back` | Manifest 声明即可 |
| **中风险** | `approval.write`, `notification.send`, `network.request` | Manifest 声明 + 安装时展示 |
| **高风险** | `device.location.read`, `device.camera.use`, `clipboard.read` | Manifest 声明 + 用户运行时确认 |
| **关键** | `system.command.execute`, `file.write` | Manifest 声明 + 管理员审批 |

### 9.3 权限策略

- JS 引擎默认**没有任何能力**，所有能力必须通过 Manifest 声明。
- 宿主根据 Manifest 权限列表注册对应的 Host Bridge API。
- 未声明的能力调用直接拒绝并报错。
- 高风险能力需要用户确认或管理员审批。
- 网络请求必须通过宿主代理（可审计、可限流）。
- 权限变更需要重新审核。
- 用户或管理员可以随时禁用插件权限。
- 后台策略可以禁用特定插件能力。

### 9.4 移动端额外限制

移动端权限比 PC 端更严格：

- 不允许 `system.command.execute`。
- 不允许任意文件系统访问。
- Native 系统权限由 App 统一申请，插件不能直接申请。
- WebView 不能直接获得 Native 权限。
- 默认不开放剪贴板读取。

---

## 10. 性能治理

### 10.1 性能指标

| 指标 | 目标 | 告警阈值 |
|---|---|---|
| JS Bundle 下载耗时 | < 2s（50KB） | > 5s |
| JS Runtime 创建耗时 | < 100ms | > 300ms |
| JS Bundle 加载+执行 | < 500ms | > 1500ms |
| 首屏渲染（STAC） | < 1s | > 3s |
| JS 函数调用延迟 | < 50ms | > 200ms |
| invokeHost 往返延迟 | < 100ms | > 500ms |
| 插件内存占用 | < 16MB | > 32MB |
| 插件 CPU 占比 | < 10% | > 25% |
| App 冷启动影响 | 0ms（懒加载） | > 100ms |

### 10.2 治理手段

```text
┌──────────────────────────────────────────────┐
│           Performance Manager                  │
│                                                │
│  ├─ 启动阶段                                   │
│  │   ├─ 插件懒加载（不影响宿主启动）            │
│  │   ├─ JS Runtime 实例池复用                  │
│  │   └─ Bundle 本地缓存                        │
│  │                                            │
│  ├─ 运行阶段                                   │
│  │   ├─ 内存监控（超限告警/OOM 终止）           │
│  │   ├─ CPU 监控（超限限流）                    │
│  │   ├─ 执行超时控制                           │
│  │   ├─ 空闲 Runtime 挂起释放                  │
│  │   └─ STAC 局部更新减少重渲染                │
│  │                                            │
│  ├─ 后台阶段                                   │
│  │   ├─ 后台插件资源预算缩减                    │
│  │   ├─ 后台事件频率限制                        │
│  │   └─ 后台超时自动 deactivate                 │
│  │                                            │
│  └─ 异常阶段                                   │
│      ├─ 性能劣化自动告警                       │
│      ├─ 连续崩溃自动禁用                       │
│      └─ 管理员可强制停止                       │
└──────────────────────────────────────────────┘
```

### 10.3 Runtime 池管理

```text
活跃 Runtime 数量限制:
├─ 移动端: 最多 3 个同时活跃
├─ PC 端: 最多 10 个同时活跃
└─ 超限时挂起最久未使用的 Runtime

Runtime 挂起策略:
├─ 空闲超过 5 分钟 → 可挂起
├─ 内存压力 → 优先挂起后台插件
├─ 用户切换到其他插件 → 前一个可挂起
└─ 挂起后重新激活需重新加载 Bundle

Bundle 缓存策略:
├─ LRU 缓存，最大 50MB
├─ 版本变更时自动清理旧版本
├─ 离线可用（缓存命中时不下载）
└─ 增量更新（差分包）
```

---

## 11. 安全治理

### 11.1 安全沙箱规则

```text
┌─────────────────────────────────────────────┐
│         JS Sandbox Security Rules            │
│                                              │
│  ✗ 禁止直接访问文件系统                       │
│  ✗ 禁止直接发起网络请求                       │
│  ✗ 禁止访问其他插件的数据                     │
│  ✗ 禁止 eval() 和 new Function()             │
│  ✗ 禁止 XMLHttpRequest / fetch               │
│  ✗ 禁止访问 DOM / window / document           │
│  ✗ 禁止动态加载外部脚本                       │
│  ✓ 只能通过 invokeHost() 调用宿主能力          │
│  ✓ 只能通过 STAC Schema 描述 UI              │
│  ✓ 只能访问自己沙箱内的存储空间               │
└─────────────────────────────────────────────┘
```

### 11.2 JS Bundle 安全

| 安全措施 | 说明 |
|---|---|
| **签名校验** | 每个 Bundle 必须有平台私钥签名，客户端校验后才加载 |
| **Hash 校验** | Manifest 中声明 SHA-256 Hash，下载后校验完整性 |
| **HTTPS 强制** | Bundle 必须通过 HTTPS 下载 |
| **证书固定** | Bundle CDN 使用证书固定，防中间人 |
| **版本控制** | Bundle 与 Manifest 版本严格对应 |
| **回滚保护** | 已知安全的旧版本可快速回滚 |

### 11.3 网络安全

- 所有插件网络请求必须通过 `invokeHost('network.request', ...)` 代理。
- 宿主可审计、限流、过滤请求。
- 插件不能直接使用 `XMLHttpRequest` 或 `fetch`（已禁用）。
- 请求域名必须在 Manifest 声明的 `allowedDomains` 内。
- 请求头由宿主统一注入鉴权信息。

### 11.4 数据隔离

```text
Plugin A 存储空间
├─ /sandbox/plugin-a/
│  ├─ storage/（KV 存储）
│  ├─ cache/（临时缓存）
│  └─ temp/（临时文件）

Plugin B 存储空间
├─ /sandbox/plugin-b/
│  ├─ storage/
│  ├─ cache/
│  └─ temp/

规则:
├─ Plugin A 无法访问 Plugin B 的数据 ✓
├─ Plugin A 无法访问宿主本地数据库 ✓
├─ Plugin A 无法访问宿主文件系统 ✓
├─ 卸载插件时，对应沙箱目录全部清除 ✓
└─ 宿主可设置沙箱存储上限 ✓
```

### 11.5 移动端审核合规

```text
App Store / Google Play 合规要点:
├─ 不下发可执行的机器码（Arm/x86 二进制）
├─ JS 代码属于解释型脚本，非编译型二进制
├─ QuickJS 是内置引擎，非动态下载的运行时
├─ Bundle 功能范围受 Manifest 和权限控制
├─ 不使用 JIT（QuickJS 是纯解释执行）
├─ Bundle 内容可被审核（明文或可反混淆）
└─ 核心业务仍走 Flutter 编译期内置

---

## 12. 发布与更新

### 12.1 更新类型

| 类型 | 是否允许 | 说明 |
|---|---|---|
| App 二进制更新 | 允许 | 走应用商店或企业分发 |
| 内置 Flutter 模块更新 | 允许 | 跟随 App 发版 |
| JS Bundle 更新 | 允许 | 必须签名、Hash 校验、灰度、回滚 |
| STAC Schema 更新 | 允许 | 随 JS Bundle 或独立更新 |
| Web 内容更新 | 允许 | 限白名单和安全策略 |
| 能力编排 Schema 更新 | 允许 | 非 JS 代码，只能编排已注册能力 |
| 远程配置更新 | 允许 | 非代码，需灰度和回滚 |
| Dart / Native 可执行代码更新 | 不允许 | 存在审核和安全风险 |

### 12.2 JS Bundle 发布流程

```text
开发者提交 JS Bundle
  │
  ▼
平台端:
├─ 自动化校验 Manifest
├─ 校验 Bundle 语法和大小（< 500KB）
├─ 权限审查（与上次版本的权限差异）
├─ 安全扫描（敏感 API 调用、域名白名单）
├─ 性能基准测试（启动耗时、内存占用）
├─ 人工审核（首次提交 / 权限变更 / 高风险能力）
├─ 签名（平台私钥）
├─ 生成 Hash
│
  ▼
发布阶段:
├─ 灰度发布（按组织 / 用户 / 比例）
├─ 监控崩溃率、错误率、性能指标
├─ 异常自动暂停发布
├─ 正式发布
└─ 支持回滚到任意历史版本
```

### 12.3 Bundle 版本管理

```text
版本号规则:
├─ 遵循语义化版本（major.minor.patch）
├─ major: 破坏性变更（API 不兼容）
├─ minor: 新增功能（向后兼容）
└─ patch: Bug 修复

兼容性管理:
├─ Manifest 声明 minHostVersion
├─ 宿主版本低于要求时拒绝加载
├─ Bundle 内可做特性检测（feature detection）
├─ 旧版宿主不加载新版 Bundle（版本门控）
└─ 新版宿主兼容旧版 Bundle

灰度策略:
├─ 按百分比灰度（1% → 5% → 20% → 50% → 100%）
├─ 按组织灰度
├─ 按用户白名单灰度
├─ 按平台灰度（iOS 先行 / Android 先行）
├─ 自动监控灰度期间错误率
└─ 错误率超阈值自动暂停并告警
```

### 12.4 Bundle 分发优化

```text
分发链路:
├─ CDN 分发（全球加速）
├─ 增量更新（bsdiff / 自定义差分算法）
├─ 压缩传输（gzip / brotli）
├─ 本地缓存（LRU，离线可用）
├─ 预加载（高频插件 Wi-Fi 环境下预下载）
└─ 降级（下载失败使用本地缓存版本）

Bundle 大小控制:
├─ 单个 Bundle 上限: 500KB（压缩前）
├─ 超限时需拆分或优化
├─ 不允许内嵌大资源（图片走 CDN）
└─ Tree-shaking 和压缩由构建工具链保证
```

---

## 13. 技术选型建议

### 13.1 跨端宿主

继续使用 **Flutter** 作为跨端宿主：

- 统一代码库覆盖 iOS / Android / Windows / macOS / Linux。
- 核心业务使用 Flutter Widget 直接渲染。
- JS 插件 UI 通过 STAC 框架在 Flutter 内渲染。
- Native 能力通过 Platform Channel / Pigeon 封装。
- PC 端 WebView 使用系统 WebView。

### 13.2 JS 引擎

| 端 | 推荐引擎 | 集成方式 |
|---|---|---|
| iOS | QuickJS | `quickjs_dart` Dart FFI |
| Android | QuickJS | `quickjs_dart` Dart FFI |
| Windows | QuickJS（默认）/ V8（高性能场景） | Dart FFI |
| macOS | QuickJS（默认）/ V8（高性能场景） | Dart FFI |
| Linux | QuickJS | Dart FFI |

建议统一使用 QuickJS，降低跨端差异和维护成本。

### 13.3 SDUI 框架

推荐使用 **STAC**（Server-Driven UI 框架）：

- STAC Schema 描述 UI 结构。
- Flutter 侧 STAC Renderer 解析并渲染。
- 支持表单、列表、卡片、弹窗等常用组件。
- 支持事件回调和动作执行。
- 与 JS 逻辑层配合，JS 返回 Schema，STAC 负责渲染。

### 13.4 构建 SDK

为插件开发者提供统一的 SDK / CLI 工具链：

```text
Plugin SDK
├─ @company/plugin-sdk（npm 包）
│  ├─ 类型定义（invokeHost, STAC Schema 类型等）
│  ├─ 本地模拟器（模拟宿主环境）
│  ├─ 热重载开发服务器
│  └─ 单元测试工具
├─ @company/plugin-cli
│  ├─ plugin create（脚手架）
│  ├─ plugin dev（本地开发）
│  ├─ plugin build（构建 Bundle）
│  ├─ plugin lint（校验 Manifest + 代码）
│  ├─ plugin test（运行测试）
│  └─ plugin publish（发布到平台）
└─ 插件模板
   ├─ template-basic（基础模板）
   ├─ template-form（表单插件）
   ├─ template-event-driven（事件驱动插件）
   └─ template-full-featured（全功能模板）
```

### 13.5 PoC 建议

第一阶段重点验证：

1. **QuickJS 集成**：`quickjs_dart` 在 iOS / Android / Desktop 上的稳定性、内存占用、多实例管理。
2. **JS ↔ Dart 通信性能**：`invokeHost` 往返延迟、并发处理、Promise 桥接。
3. **STAC + JS 集成**：JS 返回 Schema → STAC 渲染 → 事件回调 → JS 处理的完整闭环。
4. **沙箱安全**：隔离有效性、资源限制可执行性、崩溃隔离。
5. **Bundle 加载性能**：下载、缓存、加载、执行的全链路耗时。

---

## 14. 分阶段落地

### 第一阶段：基础设施 + JS 引擎 PoC

**目标**：验证 JS 引擎方案可行性，建立插件基础设施。

建设内容：

- QuickJS Dart FFI 集成（`quickjs_dart` 或自研封装）。
- JS Runtime 管理器（创建、销毁、隔离）。
- Host Bridge 基础能力注册（toast、navigation、storage）。
- JS ↔ Dart 通信协议（invokeHost / JSON-RPC）。
- 插件 Manifest 解析与校验。
- 插件安装 / 卸载基础流程。
- 白名单 WebView。
- 统一 SSO。
- 远程配置。

验收标准：

- QuickJS 可在 iOS / Android / Desktop 上稳定运行。
- 单个 JS Runtime 创建耗时 < 100ms。
- invokeHost 往返延迟 < 100ms。
- JS Runtime 崩溃不影响宿主。
- 内存限制可执行，超限自动终止。

### 第二阶段：STAC SDUI + JS 插件 MVP

**目标**：打通 JS Logic + STAC UI + Host Capability 的完整闭环。

建设内容：

- STAC Schema 渲染器集成。
- JS 返回 Schema → STAC 渲染流程。
- 用户交互事件 → JS 回调流程。
- EventBus 基础实现（系统事件）。
- activationEvents 懒加载。
- 权限模型（Manifest 声明 + 运行时校验）。
- JS Bundle 下载、缓存、签名校验。
- 性能监控基础埋点。

验收标准：

- JS 插件可以返回 STAC Schema 并正确渲染。
- 用户交互（点击、表单提交）可回调 JS 处理。
- 宿主事件可分发到 JS 插件处理。
- 权限未声明的能力调用被拒绝。
- Bundle 下载失败可降级使用缓存。

### 第三阶段：能力扩展 + 事件体系

**目标**：扩展能力桥和事件驱动体系，支持更多业务场景。

建设内容：

- 扩展 Host Bridge 能力（IM、审批、通知、文件、设备）。
- 业务事件源接入（审批事件、消息事件、通讯录事件）。
- 自定义事件发布 / 订阅。
- 后台插件支持（常驻但受限）。
- 能力编排型插件（纯 Schema，无 JS）。
- 远端插件服务。
- 平台插件网关。
- JS Bundle 灰度发布。

验收标准：

- 插件可通过 invokeHost 调用完整的业务能力。
- 业务事件可实时分发到已激活插件。
- 后台插件可响应事件但资源受限。
- 灰度发布可按组织和用户比例控制。

### 第四阶段：开发者平台 + 生态

**目标**：建立开发者工具链和插件生态。

建设内容：

- Plugin SDK（npm 包 + 类型定义）。
- Plugin CLI（create / dev / build / lint / test / publish）。
- 本地模拟器（脱离真实宿主调试）。
- 插件模板（基础 / 表单 / 事件驱动 / 全功能）。
- 插件审核后台。
- 插件性能看板。
- 插件应用市场。
- 开发者文档。

验收标准：

- 开发者可通过 CLI 5 分钟内创建并运行一个插件。
- 插件可在本地模拟器中完整调试。
- 插件发布有完整的审核和灰度流程。

### 第五阶段：高级特性

**目标**：支持复杂场景和跨端一致性。

建设内容：

- Bundle 增量更新。
- STAC 局部更新（JSON Patch）。
- 插件间协作协议。
- PC 端独立进程插件支持。
- 离线能力增强。
- AI 辅助插件开发。

---

## 15. 风险与应对

| 风险 | 等级 | 应对 |
|---|---|---|
| QuickJS 多实例内存压力 | 中 | Runtime 池管理、空闲挂起、数量限制 |
| JS ↔ Dart FFI 性能瓶颈 | 中 | PoC 验证、批量调用、二进制编码优化 |
| JS Bundle 被篡改 | 高 | 签名校验、Hash 校验、HTTPS、证书固定 |
| 移动端审核风险 | 高 | 不下发机器码、QuickJS 内置、Bundle 可审核 |
| 插件拖慢宿主 | 中 | 懒加载、资源限制、崩溃隔离、自动禁用 |
| STAC 渲染性能 | 中 | 局部更新、虚拟化列表、组件缓存 |
| 跨端一致性问题 | 中 | 统一引擎（QuickJS）、统一 Schema、跨端测试 |
| 开发者学习成本 | 低 | SDK / CLI / 模板 / 文档 / 模拟器 |
| 能力桥 API 膨胀 | 中 | 能力版本管理、废弃策略、兼容层 |
| 插件安全漏洞 | 高 | 沙箱隔离、权限最小化、安全扫描、审计日志 |

---

## 16. 推荐结论

跨端客户端插件平台推荐路线：

```text
Flutter 跨端宿主（Mobile + Desktop）
+ JS 引擎运行时（QuickJS，每个插件独立沙箱）
+ STAC Server-Driven UI（声明式渲染）
+ 事件驱动模型（系统事件 + 业务事件 + 自定义事件）
+ 统一能力桥（Host Bridge，权限受控）
+ 内置 Flutter 模块（核心业务编译期内置）
+ 白名单 WebView（现有 Web 应用接入）
+ 能力编排型插件（纯 Schema 轻量场景）
+ 远端插件服务（服务端逻辑扩展）
+ 远程配置（非代码动态化）
+ 严格权限与安全沙箱
+ 开发者 SDK / CLI / 模板
```

核心原则：

1. **JS 逻辑 + STAC UI + Host Capability 三层分离**，各司其职，安全可控。
2. **每个插件独立 JS Runtime**，完全隔离，崩溃不影响宿主和其他插件。
3. **所有能力调用经宿主代理**，可审计、可限流、可权限控制。
4. **事件驱动懒加载**，不影响宿主启动性能，按需激活。
5. **跨端统一**，同一套 Manifest、同一套能力桥、同一套 JS Bundle，在 Mobile 和 Desktop 上行为一致。
6. **渐进式落地**，先基础设施和 PoC，再 MVP 闭环，再能力扩展，最后生态建设。

移动端不做运行时动态加载 Dart / Native 可执行代码。插件逻辑由 JS 引擎承载，UI 由 STAC 承载，能力由宿主代理，在动态化能力与平台合规之间取得平衡。