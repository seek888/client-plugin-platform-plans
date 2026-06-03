# 移动端插件化与平台能力建设方案

## 1. 定位

移动端不建议建设任意代码级插件平台。移动端应定位为受控的平台能力接入体系。

原因：

- 应用商店对动态下载和执行代码有严格限制。
- 任意插件会引入审核风险。
- 移动端对性能、电量、权限、隐私要求更高。
- WebView 高权限桥接容易产生安全风险。

移动端应重点支持：

- 内置 Flutter 模块。
- 白名单 WebView。
- 能力编排型插件。
- Server-driven UI。
- 远端插件服务。
- 远程配置。
- 统一能力桥。

核心路线：

```text
Flutter Mobile 宿主
+ 内置 Flutter 模块
+ 白名单 WebView
+ 能力编排型插件
+ Server-driven UI
+ 远端插件服务
+ 远程配置
+ 严格权限控制
```

移动端的插件化不是运行时代码插件，而是通过配置、Schema、远端服务和已注册能力组合实现小范围动态化。

---

## 2. 总体架构

```text
Flutter Mobile 宿主
├─ 核心业务模块
│  ├─ IM
│  ├─ 工作台
│  ├─ 审批
│  ├─ 通讯录
│  └─ 设置
├─ 应用接入层
│  ├─ 内置 Flutter 模块
│  ├─ 白名单 WebView
│  ├─ 能力编排型插件
│  ├─ Server-driven UI
│  └─ 远端插件动作
├─ 能力桥
│  ├─ 账号
│  ├─ 组织
│  ├─ IM
│  ├─ 审批
│  ├─ 通知
│  ├─ 定位
│  ├─ 文件
│  └─ 设备能力
├─ 配置中心
│  ├─ 应用入口配置
│  ├─ 菜单配置
│  ├─ 页面 Schema
│  ├─ 能力编排 Schema
│  ├─ 功能开关
│  └─ 灰度策略
└─ 治理体系
   ├─ 权限控制
   ├─ 性能监控
   ├─ 错误监控
   ├─ 安全审计
   └─ 版本兼容
```

---

## 3. 移动端能力类型

### 3.1 内置 Flutter 模块

移动端核心能力应使用 Flutter 内置实现。

适用场景：

- 高频使用。
- 复杂交互。
- 强一致体验。
- 需要离线能力。
- 需要高性能渲染。
- 需要深度调用 Native 能力。

示例：

- IM 聊天。
- 通讯录。
- 工作台首页。
- 审批待办。
- 消息通知中心。

建设建议：

- 使用 Flutter 分层架构：UI、Logic、Data。
- 数据层作为 Single Source of Truth。
- 服务层封装 API、缓存、本地数据库和平台能力。
- ViewModel 管理页面状态。
- 核心模块随 App 发版，不走动态插件更新。

### 3.2 白名单 WebView 应用

白名单 WebView 用于接入公司内部 Web 应用。

适用场景：

- 后台管理。
- 报表。
- 低频流程。
- 需要频繁更新但不涉及核心客户端能力的页面。

接入要求：

- 只能加载白名单域名。
- 必须统一 SSO。
- 必须接入页面加载监控。
- 必须接入 JS 错误监控。
- 必须限制 JS Bridge 权限。
- 必须有加载失败兜底页面。
- 必须支持网络变化后的恢复。

Bridge 策略：

- 默认不注入高权限能力。
- 按 Manifest 权限注入有限能力。
- 高风险能力需要用户确认或后台审批。
- Web 页面不能拿长期 token。
- Web 页面只能拿短期临时凭证。

性能策略：

- 关键 Web 应用预加载。
- 静态资源缓存。
- DNS 预解析。
- 慢接口监控。
- 白屏检测。
- 页面保活策略。
- WebView 复用池。

### 3.3 能力编排型插件

能力编排型插件是移动端插件化的核心补充方案。它不下发 Dart、Native、JavaScript 等可执行代码，而是把客户端已经内置和审核通过的能力封装成标准能力单元，再由服务端通过配置文件进行排列组合。

可以理解为：

```text
客户端内置能力
├─ UI 组件
├─ 数据源
├─ 业务动作
├─ 校验规则
├─ 权限检查
├─ 页面跳转
├─ 设备能力
└─ 埋点能力

服务端下发编排 Schema
└─ 描述页面结构、组件层级、数据绑定、动作流程和权限规则

客户端渲染与执行
└─ 根据 Schema 组合内置能力，渲染页面并执行动作
```

这类能力本质上也是一种插件化，但它是“配置驱动的插件化”，不是“代码驱动的插件化”。

适用场景：

- 小范围业务页面动态化。
- 表单和流程页面。
- 审批详情和审批动作。
- 工作台卡片。
- 业务入口组合。
- 简单数据列表。
- 配置页。
- 低风险业务动作。
- 运营配置型页面。

不适用场景：

- 强交互复杂页面。
- IM 聊天主界面。
- 高频核心链路。
- 复杂动画和手势。
- 大量本地状态协同。
- 强离线业务。
- 需要新增 Native 能力的页面。

能力单元建议分层：

```text
Capability Registry
├─ Component Capabilities
│  ├─ text
│  ├─ image
│  ├─ button
│  ├─ input
│  ├─ form
│  ├─ list
│  ├─ card
│  ├─ tabs
│  └─ dialog
├─ Data Capabilities
│  ├─ http.query
│  ├─ local.cache.read
│  ├─ user.profile
│  ├─ org.contacts
│  └─ approval.detail
├─ Action Capabilities
│  ├─ navigation.open
│  ├─ api.submit
│  ├─ dialog.confirm
│  ├─ toast.show
│  ├─ notification.send
│  └─ telemetry.track
├─ Validation Capabilities
│  ├─ required
│  ├─ maxLength
│  ├─ regex
│  └─ customRule
└─ Permission Capabilities
   ├─ permission.check
   ├─ visibleWhen
   └─ enabledWhen
```

客户端需要维护能力注册表：

```text
能力 id
能力类型
最小客户端版本
支持平台
输入参数 Schema
输出结果 Schema
权限要求
是否可组合
是否可异步执行
是否允许缓存
```

能力定义示例：

```json
{
  "id": "approval.submit",
  "type": "action",
  "minHostVersion": "1.3.0",
  "platforms": ["ios", "android"],
  "inputSchema": {
    "orderId": "string",
    "comment": "string"
  },
  "outputSchema": {
    "success": "boolean",
    "message": "string"
  },
  "permissions": ["approval.write"]
}
```

能力编排 Schema 示例：

```json
{
  "schemaVersion": "1.0",
  "pluginId": "approval.quick_action",
  "type": "capability_composition",
  "page": {
    "title": "快速审批",
    "layout": {
      "type": "column",
      "children": [
        {
          "type": "text",
          "props": {
            "text": "${approval.title}",
            "style": "titleMedium"
          }
        },
        {
          "type": "textarea",
          "id": "comment",
          "props": {
            "label": "审批意见",
            "maxLength": 300
          },
          "validation": [
            {
              "type": "required",
              "message": "请填写审批意见"
            }
          ]
        },
        {
          "type": "button",
          "props": {
            "text": "同意"
          },
          "visibleWhen": {
            "permission": "approval.write"
          },
          "onTap": {
            "action": "approval.submit",
            "params": {
              "orderId": "${route.orderId}",
              "comment": "${state.comment}"
            },
            "then": [
              {
                "action": "toast.show",
                "params": {
                  "message": "已提交"
                }
              },
              {
                "action": "navigation.back"
              }
            ]
          }
        }
      ]
    }
  },
  "dataSources": {
    "approval": {
      "capability": "approval.detail",
      "params": {
        "orderId": "${route.orderId}"
      }
    }
  }
}
```

客户端执行流程：

```text
1. 拉取插件/页面 Schema
2. 校验 schemaVersion 和 minHostVersion
3. 校验签名和灰度策略
4. 校验组件、动作、数据源是否在白名单能力注册表中
5. 校验权限
6. 加载数据源
7. 渲染 UI 层级
8. 用户触发动作
9. 按动作链执行能力
10. 上报埋点、错误和性能数据
```

STAC 这类 Flutter Server-driven UI 框架可以作为渲染引擎或参考实现，但完整平台方案不能只依赖 UI 渲染框架本身，还需要补齐：

- 能力注册表。
- 权限模型。
- 数据源协议。
- 动作协议。
- Schema 版本管理。
- 灰度和回滚。
- 埋点和错误监控。
- 安全校验。
- 宿主能力适配层。

设计原则：

- 服务端只能编排客户端已注册能力。
- 服务端不能下发任意可执行代码。
- 每个能力必须有稳定 id 和版本。
- 每个能力必须声明输入输出 Schema。
- 每个能力必须声明权限。
- 每个 Schema 必须有版本、签名、灰度和回滚。
- 动作链必须有最大深度，避免无限递归或复杂流程失控。
- 能力编排优先用于小范围和中低复杂度业务。

### 3.4 Server-driven UI

Server-driven UI 是移动端动态扩展的核心方案之一。

它不是下发可执行代码，而是下发结构化 UI 描述，由 Flutter 客户端渲染。

适用场景：

- 表单。
- 审批详情。
- 设置页。
- 简单列表。
- 低复杂度详情页。
- 业务动作确认页。

示例 Schema：

```json
{
  "schemaVersion": "1.0",
  "type": "form",
  "title": "请假申请",
  "fields": [
    {
      "type": "date",
      "key": "startDate",
      "label": "开始时间",
      "required": true
    },
    {
      "type": "date",
      "key": "endDate",
      "label": "结束时间",
      "required": true
    },
    {
      "type": "textarea",
      "key": "reason",
      "label": "请假原因",
      "maxLength": 500
    }
  ],
  "actions": [
    {
      "id": "submit",
      "label": "提交",
      "api": "/approval/leave/submit",
      "method": "POST"
    }
  ]
}
```

需要建设：

- Schema 解析器。
- Flutter 渲染组件库。
- 表单校验引擎。
- API 动作执行器。
- 权限判断器。
- 埋点自动采集。
- 错误兜底。
- Schema 版本兼容器。

设计原则：

- Schema 只描述 UI、数据绑定、校验和动作。
- 不允许下发脚本代码。
- 动作必须调用已注册 API。
- 组件类型必须白名单。
- Schema 版本必须可回滚。

### 3.5 远端插件服务

远端插件服务是移动端实现插件能力的主要方式之一。插件逻辑运行在服务端，移动端只负责展示入口、收集参数和展示结果。

常见功能：

- 业务动作：发起审批、同意/拒绝审批、创建工单、提交日报。
- 数据查询：查询审批详情、客户信息、库存、报表、项目进度。
- 表单/流程：请假、报销、巡检、合同审批。
- 机器人/自动化：IM 机器人、审批机器人、定时提醒、自动分配任务。
- 外部系统集成：CRM、ERP、OA、Jira、GitLab、BI、财务系统。
- 内容生成/处理：AI 总结、翻译、文档摘要、图片识别、会议纪要。
- 消息交互：消息按钮、卡片动作、文件转工单、事件推送。
- 动态 UI 返回：返回结果页、表单 Schema、卡片 Schema。

推荐架构：

```text
移动端 App
├─ 展示入口
├─ 收集参数
├─ 调用平台 API
├─ 渲染结果/Schema UI
└─ 上报埋点

平台插件网关
├─ 插件注册中心
├─ 权限校验
├─ Token 管理
├─ 插件路由
├─ 审计日志
├─ 限流熔断
└─ 回调/事件分发

远端插件服务
├─ 业务逻辑
├─ 外部系统集成
├─ 数据处理
├─ 返回结果
└─ 返回 UI Schema
```

调用链：

```text
1. App 获取插件 Manifest
2. App 展示插件入口
3. 用户触发插件动作
4. App 调用平台插件网关
5. 网关校验用户、组织、权限、插件状态
6. 网关调用具体插件服务
7. 插件服务执行业务逻辑
8. 插件服务返回数据或 UI Schema
9. 网关统一包装结果
10. App 渲染结果
```

移动端负责：

- 展示插件入口。
- 展示动态表单。
- 收集用户输入。
- 调用平台 API。
- 渲染插件返回结果。
- 执行有限本地能力，如跳转、弹窗、Toast、选择文件。
- 做权限提示。
- 做加载、失败、重试。
- 做埋点和性能监控。

平台插件网关负责：

- 插件注册。
- 插件审核。
- 插件启用/禁用。
- 权限校验。
- 用户身份转换。
- 临时 token 签发。
- 调用插件服务。
- 事件分发。
- 限流。
- 熔断。
- 超时控制。
- 日志审计。
- 灰度发布。
- 结果 Schema 校验。

插件服务负责：

- 调用外部系统。
- 执行业务动作。
- 处理自动化逻辑。
- 聚合数据。
- 生成动态 UI Schema。
- 接收平台事件。
- 返回标准结果。

推荐接口：

```text
GET  /api/plugins/{pluginId}/manifest
POST /api/plugins/{pluginId}/actions/{actionId}
POST /api/plugins/events/dispatch
```

不建议：

```text
移动端 App -> 第三方插件服务
```

推荐：

```text
移动端 App -> 平台插件网关 -> 远端插件服务
```

### 3.6 远程配置

远程配置用于控制非代码逻辑。

可配置项：

- 应用入口。
- 菜单。
- 排序。
- 功能开关。
- 灰度策略。
- 文案。
- 主题轻量配置。
- 页面跳转。
- WebView URL。
- Schema 页面版本。
- 能力编排 Schema 版本。

约束：

- 不下发可执行代码。
- 配置需要版本号。
- 配置需要灰度。
- 配置需要回滚。
- 配置需要兼容旧客户端。

---

## 4. Manifest 设计

移动端 Manifest 与 PC 端保持相似抽象，但运行类型更受限。

```json
{
  "id": "com.company.approval.mobile",
  "name": "移动审批",
  "version": "1.0.0",
  "type": "builtin | webview | capability_composition | schema | remote_action",
  "platforms": ["ios", "android"],
  "minHostVersion": "1.0.0",
  "entry": {
    "route": "/approval",
    "web": "https://office.example.com/mobile/approval",
    "schema": "https://api.example.com/schema/approval-home",
    "composition": "https://api.example.com/schema/approval-quick-action"
  },
  "contributes": {
    "menus": [
      {
        "location": "workspace.grid",
        "title": "审批",
        "icon": "approval",
        "entry": "/approval"
      }
    ],
    "actions": [
      {
        "id": "approval.create",
        "title": "发起审批"
      },
      {
        "id": "approval.quick_action",
        "title": "快速审批",
        "type": "capability_composition"
      }
    ]
  },
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
  "permissions": [
    "user.profile.read",
    "approval.read",
    "approval.write",
    "notification.send"
  ],
  "updatePolicy": {
    "allowRemoteConfig": true,
    "allowRemoteSchema": true,
    "allowRemoteCode": false
  }
}
```

约束：

- 不允许 `external_process`。
- 不允许运行时加载 Dart/Native 可执行代码。
- 不允许任意高权限 JS Bridge。
- 允许 `builtin`、`webview`、`capability_composition`、`schema`、`remote_action`。
- 允许入口、Schema 和能力编排配置通过配置更新。
- 能力编排只能调用客户端已注册能力。
- 核心能力变更必须跟随 App 发版。

---

## 5. 权限模型

移动端权限要比 PC 更严格。

建议权限分类：

```text
user.profile.read
org.contacts.read
im.message.send
approval.read
approval.write
notification.send
device.location.read
device.camera.use
device.microphone.use
file.pick
file.upload
clipboard.write
```

默认不建议开放：

- 剪贴板读取。
- 任意文件读取。
- 任意本地存储读取。
- 系统命令。
- 任意网络代理。
- 高权限设备信息。

权限策略：

- Native 权限由 App 统一申请。
- 插件不能直接申请系统权限。
- WebView 不能直接获得 Native 权限。
- 插件能力调用由宿主代理。
- 能力编排 Schema 中声明的组件、数据源、动作都必须经过权限校验。
- 高风险能力需要用户确认。
- 后台策略可以禁用特定插件能力。

---

## 6. 性能治理

关键指标：

- App 启动耗时。
- 首页首屏耗时。
- WebView 首屏耗时。
- 能力编排 Schema 拉取耗时。
- 能力编排 Schema 校验耗时。
- Schema 页面渲染耗时。
- 动作链执行耗时。
- 接口耗时。
- 白屏率。
- 卡顿率。
- 崩溃率。
- 电量消耗。
- 内存峰值。

治理手段：

- 首页核心模块 Flutter 原生实现。
- WebView 懒加载。
- 常用 Web 应用预热。
- 能力编排 Schema 本地缓存。
- Schema 页面本地缓存。
- 能力注册表本地缓存。
- 接口缓存。
- 图片和静态资源缓存。
- 长列表虚拟化。
- 页面降级。
- 慢页面自动告警。

---

## 7. 发布与更新

移动端更新类型：

| 类型 | 是否允许 | 说明 |
|---|---|---|
| App 二进制更新 | 允许 | 走应用商店或企业分发 |
| 内置 Flutter 模块更新 | 允许 | 跟随 App 发版 |
| Web 内容更新 | 允许 | 限白名单和安全策略 |
| 能力编排 Schema 更新 | 允许 | 非代码，只能编排已注册能力 |
| Schema 更新 | 允许 | 非代码，需版本兼容 |
| 远程配置更新 | 允许 | 非代码，需灰度和回滚 |
| Dart/Native 可执行代码更新 | 不建议 | 存在审核和安全风险 |

发布流程：

```text
业务提交移动端应用配置
→ 校验 Manifest
→ 校验权限
→ 校验能力注册表
→ 校验 Schema
→ 校验动作链
→ 安全审核
→ 灰度发布
→ 监控白屏/崩溃/性能
→ 正式发布
→ 支持回滚
```

---

## 8. 技术选型建议

移动端继续使用 Flutter 是合理选择。

建议：

- 核心业务使用 Flutter。
- Native 能力通过 Platform Channel/Pigeon 封装。
- Web 应用通过白名单 WebView 承载。
- 动态页面通过 Server-driven UI 实现。
- 移动端插件化优先通过能力编排型插件实现，即服务端配置页面、组件、数据源和动作链，客户端只执行已注册能力。
- 业务扩展通过远端插件服务实现。

不建议：

- 移动端运行时代码插件。
- 动态加载 Dart/Native 可执行代码。
- 任意第三方 Web 页面调用高权限 Bridge。

---

## 9. 分阶段落地

### 第一阶段：移动端接入基础能力

建设内容：

- 移动端应用 Manifest。
- 工作台入口配置。
- 白名单 WebView。
- 统一 SSO。
- 受控 JS Bridge。
- WebView 性能监控。
- 远程配置。
- 基础能力注册表。

验收标准：

- 移动端应用入口可配置。
- WebView 应用可控接入。
- 可以采集 WebView 首屏、白屏、错误和接口耗时。
- 不存在运行时代码插件风险。

### 第二阶段：能力编排与 SDUI

建设内容：

- 能力编排型插件。
- Server-driven UI。
- Schema 渲染器。
- 动作执行器。
- 数据源协议。
- Schema 签名、灰度和回滚。
- 权限审批。
- 移动端应用灰度。

验收标准：

- 客户端已注册能力可以被服务端 Schema 编排使用。
- 低复杂度页面可通过 Schema 动态渲染。
- 业务动作链可以按权限、版本和平台受控执行。
- Schema 可灰度、可回滚。

### 第三阶段：远端插件服务

建设内容：

- 平台插件网关。
- 插件 Manifest 注册。
- 远端 Action 调用协议。
- Event 事件协议。
- 结果 Schema 校验。
- 插件服务限流、熔断、超时。
- 日志审计。

验收标准：

- 移动端不直连第三方插件服务。
- 平台网关可统一校验权限和插件状态。
- 远端插件可以返回数据、结果页或 Schema UI。
- 异常插件可禁用、限流和回滚。

---

## 10. 风险与应对

| 风险 | 应对 |
|---|---|
| 动态代码审核风险 | 不做运行时代码插件 |
| WebView 安全风险 | 白名单、Bridge 权限、短期 token |
| 能力编排失控 | 能力白名单、动作链深度限制、Schema 签名和权限校验 |
| Schema 版本不兼容 | Schema 版本管理和回滚 |
| 页面性能差 | 核心页面 Flutter 实现，WebView 懒加载 |
| 远端插件依赖网络 | 关键业务不依赖远端插件，提供降级 |

---

## 11. 推荐结论

移动端插件化推荐路线：

```text
Flutter Mobile 宿主
+ 内置 Flutter 模块
+ 白名单 WebView
+ 能力编排型插件
+ Server-driven UI
+ 远端插件服务
+ 远程配置
+ 严格权限控制
```

移动端不要做运行时代码插件。优先通过能力编排型插件和 Server-driven UI 实现小范围动态化，通过远端插件服务实现业务逻辑扩展，通过白名单 WebView 承载低频 Web 应用。
