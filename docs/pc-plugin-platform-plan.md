# PC 端插件化与平台能力建设方案

## 1. 定位

PC 端可以建设真正意义上的插件平台。PC 环境支持本地进程、文件系统、本地服务、Web 容器和独立应用，也不受移动应用商店审核限制，因此可以比移动端开放更多运行时扩展能力。

PC 端平台定位：

- 公司内部办公应用入口。
- Web 应用容器。
- 本地能力开放平台。
- 命令面板和快捷工具平台。
- 独立应用集成平台。
- 后台服务和自动化能力平台。
- 企业应用市场和插件分发平台。

参考模型：

- uTools：Web 插件、命令入口、本地能力桥、插件 Manifest。
- VS Code：Manifest、Activation Events、Contribution Points、Extension Host、懒加载。
- Slack：权限、事件、远端应用、结构化 UI。

核心路线：

```text
Flutter Desktop 宿主
+ Web 插件
+ 独立进程插件
+ 后台服务插件
+ 标准 Manifest
+ 标准通信协议
+ 权限和性能治理
```

不建议把“运行时动态加载 Flutter Widget/Dart 代码”作为 PC 插件主路线。

---

## 2. 总体架构

```text
Flutter Desktop 宿主
├─ 主工作台
│  ├─ 首页
│  ├─ 应用中心
│  ├─ 命令面板
│  ├─ IM/办公协同入口
│  └─ 设置中心
├─ 插件管理器
│  ├─ 插件发现
│  ├─ Manifest 解析
│  ├─ 安装/卸载
│  ├─ 启用/禁用
│  ├─ 版本校验
│  ├─ 签名校验
│  └─ 灰度/回滚
├─ 插件运行时
│  ├─ 内置 Flutter 模块
│  ├─ Web 插件容器
│  ├─ 独立进程插件
│  └─ 后台服务插件
├─ 通信层
│  ├─ JS Bridge
│  ├─ JSON-RPC
│  ├─ WebSocket
│  ├─ gRPC
│  ├─ Named Pipe
│  └─ Unix Domain Socket
├─ 能力桥
│  ├─ 用户与组织
│  ├─ IM 与消息
│  ├─ 审批与办公流程
│  ├─ 通知
│  ├─ 文件
│  ├─ 剪贴板
│  ├─ 窗口
│  ├─ 系统信息
│  └─ 本地缓存
└─ 治理体系
   ├─ 权限控制
   ├─ 性能监控
   ├─ 日志采集
   ├─ 崩溃恢复
   ├─ 安全审计
   └─ 管理后台
```

---

## 3. 插件类型

### 3.1 内置 Flutter 模块

内置 Flutter 模块随客户端一起发版，对外可以表现为一个应用或插件入口，但运行方式仍是编译期集成。

适用场景：

- 核心业务页面。
- 高频使用页面。
- 对性能、交互、稳定性要求高的模块。
- 需要深度使用 Flutter Design System 的页面。

示例：

- IM 主界面。
- 工作台首页。
- 审批核心流程。
- 通讯录。
- 客户端设置。

建议：

- 核心模块优先用 Flutter 内置实现。
- 内置模块也注册到应用中心，复用统一入口、权限、埋点和菜单模型。

### 3.2 Web 插件

Web 插件用于接入现有公司内部 Web 应用，也可支持业务团队用 Web 技术开发插件。

运行方式：

```text
Flutter Desktop
└─ WebView 容器
   ├─ 加载远程 Web URL
   ├─ 加载本地 Web bundle
   ├─ 注入受控 JS Bridge
   └─ 与宿主进行 postMessage 通信
```

适用场景：

- OA、CRM、ERP、报表、后台管理系统。
- 低频工具应用。
- 需要频繁更新的业务页面。
- 跨端复用的 Web 应用。

接入要求：

- 声明入口 URL 或本地资源路径。
- 配置域名白名单。
- 声明所需权限。
- 接入统一 SSO。
- 接入统一埋点和错误监控。
- 提供白屏检测和加载失败兜底。

性能治理：

- DNS 预解析。
- 关键应用资源预加载。
- 静态资源缓存。
- Service Worker 或本地资源包缓存。
- 采集首屏、白屏、接口耗时、JS 错误。

安全治理：

- JS Bridge 默认关闭。
- 根据 Manifest 权限按需注入能力。
- Web 页面不能直接获取主客户端长期 token。
- 使用短期 session token。
- 校验域名、证书、CSP 和跳转链路。

### 3.3 Flutter Web 插件

Flutter Web 插件本质仍是 Web 插件，只是前端由 Flutter Web 构建。

适用场景：

- 团队 Flutter 能力强。
- 插件交互相对独立。
- 对首屏体积和加载速度不敏感。

限制：

- Flutter Web runtime 体积较大。
- WebView 内的 Flutter Web 和宿主 Flutter Desktop 是两套渲染体系。
- 不应作为统一插件开发标准，只能作为 Web 插件的一种实现。

### 3.4 独立进程插件

独立进程插件是 PC 端最值得建设的插件形态之一。插件可以是独立应用程序，通过标准协议和宿主通信。

插件技术栈可以是：

- Flutter Desktop App。
- Electron App。
- Tauri App。
- Native App。
- .NET App。
- Go/Rust 本地程序。
- Python 打包应用。
- Web App + 本地服务。

运行模型：

```text
宿主客户端
├─ 启动插件进程
├─ 建立 IPC 通信
├─ 完成握手和权限授权
├─ 插件声明能力
├─ 宿主调用插件命令
├─ 插件返回结果或事件
└─ 宿主负责停止、重启和清理
```

优点：

- 技术栈开放。
- 崩溃隔离好。
- 性能隔离好。
- 插件可以独立升级。
- 适合复杂工具和本地能力。

UI 集成方式：

- 插件打开独立窗口。
- 插件提供 Web UI，由宿主 WebView 承载。
- 插件返回 JSON UI，由宿主 Flutter 渲染。
- 插件作为后台进程，宿主展示结果。

不建议优先做：

- 把插件原生窗口强行嵌入 Flutter Widget 树。
- 运行时加载插件 Flutter Widget。

### 3.5 后台服务插件

后台服务插件无主 UI，主要提供能力或计算任务。

适用场景：

- 文件扫描。
- 本地同步。
- AI 本地推理或代理。
- 数据采集。
- 本地搜索索引。
- 文档解析。
- 自动化任务。

运行要求：

- 支持心跳。
- 支持健康检查。
- 支持超时中断。
- 支持崩溃重启策略。
- 限制 CPU、内存和磁盘使用。
- 记录任务耗时、失败原因和资源消耗。

---

## 4. Manifest 设计

Manifest 是 PC 插件接入平台的核心协议。

```json
{
  "id": "com.company.approval",
  "name": "审批助手",
  "description": "提供审批查询、发起、处理和通知能力",
  "version": "1.0.0",
  "publisher": "company-office",
  "type": "web",
  "platforms": ["windows", "macos"],
  "minHostVersion": "1.0.0",
  "entry": {
    "web": "https://office.example.com/approval",
    "windows": "approval.exe",
    "macos": "Approval.app"
  },
  "activationEvents": [
    "onCommand:approval.open",
    "onMenu:workspace.sidebar",
    "onContext:selectedText"
  ],
  "contributes": {
    "commands": [
      {
        "id": "approval.open",
        "title": "打开审批助手",
        "category": "办公"
      }
    ],
    "menus": [
      {
        "location": "workspace.sidebar",
        "command": "approval.open",
        "title": "审批"
      }
    ],
    "search": [
      {
        "type": "approval",
        "placeholder": "搜索审批单"
      }
    ],
    "views": [
      {
        "id": "approval.main",
        "title": "审批",
        "entry": "approval.open"
      }
    ]
  },
  "permissions": [
    "user.profile.read",
    "org.contacts.read",
    "im.message.send",
    "notification.send"
  ],
  "protocol": {
    "type": "jsonrpc",
    "transport": "stdio",
    "version": "1.0"
  },
  "performanceBudget": {
    "startupMs": 1500,
    "firstScreenMs": 3000,
    "maxMemoryMb": 300
  },
  "updatePolicy": {
    "channel": "stable",
    "allowAutoUpdate": true,
    "allowRollback": true
  }
}
```

字段原则：

- `type` 决定插件运行方式。
- `platforms` 决定可安装平台。
- `entry` 定义不同平台入口。
- `activationEvents` 决定何时懒加载。
- `contributes` 决定插件给宿主贡献哪些入口。
- `permissions` 决定能力桥授权范围。
- `protocol` 决定通信协议。
- `performanceBudget` 用于性能治理。
- `updatePolicy` 用于灰度和回滚。

---

## 5. 通信协议

建议统一抽象 Host-Plugin Protocol，而不是为每类插件写散乱接口。

协议选择：

| 场景 | 推荐协议 |
|---|---|
| Web 插件 | postMessage + JS Bridge |
| 命令类轻量插件 | stdio + JSON-RPC |
| 独立应用插件 | WebSocket / Named Pipe / Unix Domain Socket |
| 内部复杂服务 | gRPC |
| 高性能本地能力 | Native service + FFI/IPC |

握手流程：

```text
1. 宿主启动插件
2. 插件返回 hello
3. 宿主校验插件 id、版本、签名
4. 插件声明 capabilities
5. 宿主下发 session token
6. 双方确认协议版本
7. 插件进入 ready 状态
```

示例消息：

```json
{
  "jsonrpc": "2.0",
  "method": "plugin.hello",
  "params": {
    "pluginId": "com.company.approval",
    "version": "1.0.0",
    "protocolVersion": "1.0",
    "capabilities": ["command", "search", "notification"]
  },
  "id": 1
}
```

宿主能力调用示例：

```json
{
  "jsonrpc": "2.0",
  "method": "host.notification.send",
  "params": {
    "title": "审批提醒",
    "body": "你有一条待处理审批"
  },
  "id": 100
}
```

生命周期事件：

- `plugin.install`
- `plugin.activate`
- `plugin.deactivate`
- `plugin.update`
- `plugin.shutdown`
- `host.context.changed`
- `host.user.changed`
- `host.network.changed`
- `host.permission.changed`

---

## 6. 权限模型

权限采用最小授权原则。

建议权限分类：

```text
user.profile.read
user.profile.write
org.contacts.read
im.message.read
im.message.send
approval.read
approval.write
file.read
file.write
clipboard.read
clipboard.write
notification.send
window.open
system.info.read
network.request
local.storage
```

权限策略：

- 插件安装时展示权限。
- 高风险权限需要管理员审批。
- 插件运行时按调用校验。
- 权限变更需要重新审核。
- 用户或管理员可以随时禁用插件权限。
- 插件 token 必须短期有效。
- 插件不能直接读取主客户端登录态。

高风险权限：

- 文件写入。
- 剪贴板读取。
- IM 消息读取。
- 通讯录读取。
- 系统命令执行。
- 本地网络代理。

---

## 7. 性能治理

性能目标：

- 插件不能影响宿主启动。
- 插件不能阻塞 Flutter UI 线程。
- 插件必须懒加载。
- 插件异常时必须可隔离、可停止、可禁用。

指标：

- 插件安装耗时。
- 插件激活耗时。
- 首屏耗时。
- API 调用耗时。
- JS 错误数量。
- 白屏率。
- 崩溃次数。
- CPU 占用。
- 内存占用。
- 磁盘占用。
- 网络请求耗时。

治理手段：

- Activation Events 懒加载。
- 插件启动超时控制。
- 独立进程心跳。
- WebView 空闲销毁。
- 资源缓存。
- 慢插件告警。
- 插件性能评分。
- 管理员可禁用问题插件。

---

## 8. 发布与更新

插件分发方式：

- 内部应用市场。
- 企业管理员分配。
- 用户自主安装。
- 灰度渠道。
- 离线安装包。

发布流程：

```text
开发者提交插件
→ 自动校验 Manifest
→ 权限审查
→ 安全扫描
→ 性能基准测试
→ 人工审核
→ 灰度发布
→ 正式发布
→ 监控与回滚
```

更新策略：

- Web 插件可以远程更新，但必须受版本和灰度控制。
- 独立进程插件需要签名包更新。
- 内置 Flutter 模块跟随客户端发版。
- 高风险插件不允许静默升级高风险权限。
- 更新失败必须支持回滚。

---

## 9. 现有办公 Web 应用治理

现有办公 Web 应用加载慢、更新频繁、性能不稳定，应先纳入统一治理。

接入标准：

- 应用 ID。
- 应用名称。
- 入口 URL。
- 支持平台。
- 权限声明。
- SSO 接入方式。
- 埋点配置。
- 白名单域名。
- 负责人。
- 灰度策略。

性能采集：

- 首屏时间。
- 白屏时间。
- 页面加载时间。
- 接口耗时。
- JS 错误。
- 资源加载失败。
- 页面崩溃。
- 用户退出率。

治理措施：

- WebView 预热。
- 常用应用资源预加载。
- 静态资源 CDN。
- 本地缓存。
- 接口聚合。
- 慢接口治理。
- 首屏骨架屏。
- 白屏兜底。

更新治理：

- Web 应用版本化。
- 每次发布生成版本号。
- 应用中心记录当前版本。
- 支持按组织、用户、部门灰度。
- 支持回滚上一个稳定版本。
- 高风险版本需要审核。
- 线上错误率异常自动暂停发布。

---

## 10. 技术选型建议

如果 PC 端继续使用 Flutter Desktop，建议：

- Flutter 负责主壳和核心业务 UI。
- Web 插件使用 WebView 容器。
- 独立进程插件通过 IPC 接入。
- 后台服务插件通过 JSON-RPC/gRPC 接入。
- 不把 Flutter 动态组件加载作为主路线。

需要重点 PoC：

- Windows/macOS WebView 能力。
- WebView 与 Flutter 的焦点、快捷键、窗口行为。
- JS Bridge 权限控制。
- 独立进程插件通信。
- 插件进程管理。
- Web 应用缓存和预加载。

如果 PC 插件生态复杂度继续提高，可评估：

- Tauri：适合轻量桌面壳、本地能力、安全边界。
- Electron：适合 Web 插件生态和成熟工具链。
- Flutter + Tauri/Electron 混合：复杂度高，建议后置评估。

---

## 11. 分阶段落地

### 第一阶段：统一接入标准

目标：

- 先把现有办公 Web 应用纳入统一平台管理。

建设内容：

- 应用 Manifest。
- 应用中心。
- 统一 SSO。
- 白名单域名。
- WebView 容器。
- 基础 JS Bridge。
- 应用性能埋点。
- 应用启用/禁用。
- 负责人和版本管理。

验收标准：

- 所有现有 Web 应用可通过统一应用中心进入。
- 每个应用有 Manifest。
- 能看到首屏、白屏、错误、接口耗时。
- Web 应用更新有版本记录。

### 第二阶段：PC Web 插件 MVP

建设内容：

- 命令面板。
- 菜单贡献点。
- Web 插件容器。
- JS Bridge 权限控制。
- 插件安装/禁用。
- 插件懒加载。
- 插件性能预算。

验收标准：

- Web 插件可以通过 Manifest 注册命令和菜单。
- 插件只在触发时加载。
- 插件权限可控。
- 插件异常不影响宿主。

### 第三阶段：PC 独立进程插件

建设内容：

- JSON-RPC 协议。
- 插件进程启动/停止。
- 插件握手。
- 心跳和健康检查。
- 崩溃重启。
- 插件签名。
- 插件灰度。
- 后台服务插件。

验收标准：

- 插件可作为独立应用或服务运行。
- 宿主可通过协议调用插件能力。
- 插件崩溃可隔离。
- 插件权限可审计。

### 第四阶段：开发者平台

建设内容：

- 插件 SDK。
- 插件 CLI。
- 插件模板。
- 本地调试工具。
- Manifest 校验工具。
- 权限申请流程。
- 插件审核后台。
- 插件性能看板。
- 插件日志查询。

---

## 12. 风险与应对

| 风险 | 应对 |
|---|---|
| 插件拖慢宿主启动 | Activation Events 懒加载 |
| Web 插件加载慢 | 预加载、缓存、白屏监控、性能预算 |
| 独立插件崩溃 | 进程隔离、心跳、崩溃恢复 |
| 权限滥用 | Manifest 权限、最小授权、审计日志 |
| 插件更新不可控 | 签名、灰度、回滚 |
| 技术栈过度复杂 | 分类型接入，先 Web 插件，后独立进程 |

---

## 13. 推荐结论

PC 端建议优先建设：

```text
Flutter Desktop 宿主
+ Web 插件
+ 独立进程插件
+ 后台服务插件
+ 标准 Manifest
+ 标准通信协议
+ 权限和性能治理
```

优先顺序：

1. 先治理现有办公 Web 应用。
2. 再建设 Web 插件和命令面板。
3. 然后支持独立进程插件。
4. 最后完善应用市场、SDK、CLI 和开发者体系。
