# 跨端客户端插件平台开发计划

## 项目概述

基于《跨端客户端插件平台方案》，建设一套统一的跨端插件运行时与能力接入体系，覆盖移动端（iOS/Android）和PC端（Windows/macOS/Linux）。

**核心技术栈**：Flutter 跨端宿主 + QuickJS 引擎运行时 + STAC SDUI + 事件驱动 + 统一能力桥

**开发周期**：预计 5 个阶段，约 6-9 个月

---

## 第一阶段：基础设施 + JS 引擎 PoC（6-8 周）

**目标**：验证 JS 引擎方案可行性，建立插件基础设施

### 1.1 QuickJS 引擎集成（2 周）

**负责人**：移动端工程师 × 2

| 任务 | 工作项 | 产出 |
|---|---|---|
| 引擎选型与集成 | - 调研 `quickjs_dart` / `flutter_js` 方案<br>- 选择集成方式（Dart FFI）<br>- iOS/Android/Desktop 环境配置 | 引擎集成 Demo |
| 基础封装 | - 设计 JSEngine 抽象接口<br>- 实现 JSRuntime 管理类<br>- 实现多实例隔离机制 | `JSEngine`、`JSRuntime` 核心类 |
| 单元测试 | - 引擎创建/销毁测试<br>- 多实例隔离测试<br>- 内存泄漏测试 | 测试覆盖率 > 80% |

**验收标准**：
- QuickJS 可在 iOS / Android / Desktop 上稳定运行
- 单个 JS Runtime 创建耗时 < 100ms
- JS Runtime 崩溃不影响宿主

### 1.2 JS ↔ Dart 通信协议（1.5 周）

**负责人**：移动端工程师 × 1

| 任务 | 工作项 | 产出 |
|---|---|---|
| 协议设计 | - 设计 JSON-RPC 风格消息格式<br>- 定义 invokeHost 调用协议<br>- 定义事件分发协议 | 协议文档 |
| 协议实现 | - 实现 invokeHost 调用<br>- 实现 Host → JS 事件分发<br>- 实现 Promise 桥接 | `JSBridge` 类 |
| 性能测试 | - 往返延迟测试<br>- 并发处理测试<br>- 大数据传输测试 | 性能测试报告 |

**验收标准**：
- invokeHost 往返延迟 < 100ms
- 支持并发调用
- Promise 正确桥接

### 1.3 插件管理器基础（2 周）

**负责人**：移动端工程师 × 1

| 任务 | 工作项 | 产出 |
|---|---|---|
| Manifest 解析 | - 设计 Manifest 数据模型<br>- 实现解析与校验<br>- 版本兼容性检查 | `Manifest`、`ManifestParser` 类 |
| 生命周期管理 | - 实现 install/activate/deactivate/uninstall 状态机<br>- 懒加载机制<br>- 状态持久化 | `PluginManager` 类 |
| 安装卸载流程 | - Bundle 下载<br>- 签名校验<br>- 沙箱目录管理 | 安装卸载完整流程 |

**验收标准**：
- Manifest 解析正确
- 状态转换正确
- 懒加载生效

### 1.4 Host Bridge 基础能力（1.5 周）

**负责人**：移动端工程师 × 1

| 任务 | 工作项 | 产出 |
|---|---|---|
| 能力注册机制 | - 设计 CapabilityRegistry<br>- 实现能力注册与查找<br>- 输入输出校验 | `HostBridge`、`CapabilityRegistry` 类 |
| 基础能力实现 | - toast.show<br>- navigation.open/back<br>- storage.get/set/remove<br>- dialog.alert/confirm | 基础能力实现 |
| 权限校验 | - Manifest 权限解析<br>- 运行时权限校验<br>- 错误处理 | `PermissionChecker` 类 |

**验收标准**：
- 基础能力可用
- 权限校验正确
- 未声明能力被拒绝

### 1.5 安全沙箱规则（1 周）

**负责人**：安全工程师 × 1

| 任务 | 工作项 | 产出 |
|---|---|---|
| 沙箱隔离 | - 禁用 eval / Function<br>- 禁用直接网络访问<br>- 禁用文件系统访问 | 沙箱配置 |
| 资源限制 | - 内存限制（16MB）<br>- 执行超时（5s 同步，30s 异步）<br>- 定时器限制 | 资源限制实现 |
| 数据隔离 | - 沙箱存储空间<br>- 插件间隔离<br>- 卸载清理 | 数据隔离机制 |

**验收标准**：
- 内存限制生效，超限自动终止
- 执行超时生效
- 插件间数据隔离

### 第一阶段里程碑

**时间节点**：第 8 周末

**交付物**：
1. QuickJS 引擎在 iOS/Android/Desktop 上稳定运行
2. JS ↔ Dart 通信协议完整实现
3. 插件管理器基础功能
4. Host Bridge 基础能力
5. 安全沙箱规则生效

**演示 Demo**：
- 简单 JS 插件可加载并调用基础能力
- 可在模拟器中运行完整的加载-调用-卸载流程

---

## 第二阶段：STAC SDUI + JS 插件 MVP（6-8 周）

**目标**：打通 JS Logic + STAC UI + Host Capability 的完整闭环

### 2.1 STAC 渲染器集成（3 周）

**负责人**：前端工程师 × 2

| 任务 | 工作项 | 产出 |
|---|---|---|
| STAC 框架调研 | - 调研 STAC / Flutter SDUI 方案<br>- 设计组件体系<br>- 设计 Schema 版本策略 | 技术方案文档 |
| 核心组件实现 | - Page / Column / Row<br>- Text / Image / Button<br>- Form / Input / TextArea<br>- List / Card | 核心组件库 |
| 渲染引擎 | - Schema 解析器<br>- 组件树构建<br>- 数据绑定 | `STACRenderer` 类 |

**验收标准**：
- STAC Schema 可正确渲染为 Flutter Widget
- 核心组件功能完整
- 数据绑定正确

### 2.2 JS → STAC 渲染流程（2 周）

**负责人**：前端工程师 × 1

| 任务 | 工作项 | 产出 |
|---|---|---|
| 渲染流程设计 | - renderPage 入口函数<br>- 数据源绑定<br>- 异步加载支持 | 流程设计文档 |
| 流程实现 | - JS 返回 Schema → STAC 渲染<br>- 首屏渲染优化<br>- 加载状态处理 | 渲染流程实现 |
| 性能优化 | - 组件缓存<br>- 虚拟列表 | 性能优化报告 |

**验收标准**：
- JS 插件可返回 Schema 并正确渲染
- 首屏渲染 < 1s
- 加载状态正确

### 2.3 用户交互事件处理（1.5 周）

**负责人**：前端工程师 × 1

| 任务 | 工作项 | 产出 |
|---|---|---|
| 事件回调机制 | - onTap / onChange / onSubmit<br>- 事件 → JS 回调<br>- 状态传递 | 事件处理机制 |
| 表单校验 | - Schema 定义校验规则<br>- 校验执行<br>- 错误提示 | 表单校验引擎 |
| 动作执行 | - 按钮点击 → JS 函数<br>- invokeHost 调用<br>- UI 更新 | 动作执行器 |

**验收标准**：
- 用户交互可正确回调 JS
- 表单校验正确
- 动作执行完整

### 2.4 EventBus 基础实现（1.5 周）

**负责人**：移动端工程师 × 1

| 任务 | 工作项 | 产出 |
|---|---|---|
| 事件总线设计 | - 系统事件定义<br>- 事件分发机制<br>- 订阅管理 | `EventBus` 类 |
| 懒加载支持 | - activationEvents 解析<br>- 懒激活触发<br>- 生命周期绑定 | 懒加载机制 |
| 系统事件实现 | - onAppStart<br>- onUserLogin<br>- onNetworkChange<br>- onPushMessage | 系统事件实现 |

**验收标准**：
- 事件可正确分发到已激活插件
- 懒加载触发正确
- 系统事件触发正确

### 第二阶段里程碑

**时间节点**：第 16 周末

**交付物**：
1. STAC 渲染器完整实现
2. JS → STAC 渲染流程打通
3. 用户交互事件处理完整
4. EventBus 基础功能

**演示 Demo**：
- 审批插件 MVP：可加载审批列表、查看详情、提交审批
- 完整的 UI 交互流程

---

## 第三阶段：能力扩展 + 事件体系（6-8 周）

**目标**：扩展能力桥和事件驱动体系，支持更多业务场景

### 3.1 Host Bridge 能力扩展（3 周）

**负责人**：各业务线工程师

| 能力域 | 工作项 | 负责人 |
|---|---|---|
| Account & Org | - user.profile.get<br>- org.contacts.search<br>- org.department.list | 账号/组织工程师 |
| IM & Message | - im.message.send<br>- im.chat.open<br>- im.message.search | IM 工程师 |
| Approval & Workflow | - approval.detail.get<br>- approval.submit<br>- approval.list | 审批工程师 |
| Notification | - notification.send<br>- notification.badge.set | 消息工程师 |
| Network | - network.request<br>- network.upload | 网络工程师 |
| Device | - device.location.get<br>- device.camera.scan | 设备工程师 |

**验收标准**：
- 所有能力可用
- 权限校验正确
- 错误处理完善

### 3.2 业务事件接入（2 周）

**负责人**：各业务线工程师

| 事件源 | 工作项 | 负责人 |
|---|---|---|
| 审批事件 | - onApprovalCreated<br>- onApprovalStatusChanged | 审批工程师 |
| 消息事件 | - onMessageReceived<br>- onChatUpdated | IM 工程师 |
| 通讯录事件 | - onContactUpdated | 通讯录工程师 |
| 文件事件 | - onFileUploaded | 文件工程师 |

**验收标准**：
- 业务事件可实时分发
- 事件 payload 正确
- 插件可响应事件

### 3.3 高级特性（3 周）

**负责人**：移动端工程师 × 2

| 特性 | 工作项 | 产出 |
|---|---|---|
| 后台插件 | - 常驻机制<br>- 资源预算缩减<br>- 事件限制 | 后台插件支持 |
| 自定义事件 | - event.publish<br>- event.subscribe<br>- 权限控制 | 自定义事件机制 |
| 能力编排型插件 | - 纯 Schema 插件<br>- 无 JS 运行时<br>- 动作链执行 | 能力编排型插件 |
| 远端插件服务 | - 平台插件网关<br>- 网络调用<br>- 结果渲染 | 远端插件集成 |

### 第三阶段里程碑

**时间节点**：第 24 周末

**交付物**：
1. 完整的 Host Bridge 能力
2. 业务事件体系
3. 后台插件支持
4. 能力编排型插件
5. 远端插件服务

**演示 Demo**：
- 多插件协作场景
- 事件驱动场景
- 后台插件场景

---

## 第四阶段：开发者平台 + 生态（6-8 周）

**目标**：建立开发者工具链和插件生态

### 4.1 Plugin SDK（2 周）

**负责人**：前端工程师 × 1

| 任务 | 工作项 | 产出 |
|---|---|---|
| NPM 包 | - @company/plugin-sdk<br>- TypeScript 类型定义<br>- 工具函数 | SDK 包 |
| 模拟器 | - 模拟宿主环境<br>- 模拟能力调用<br>- 热重载 | 本地模拟器 |

### 4.2 Plugin CLI（2 周）

**负责人**：前端工程师 × 1

| 命令 | 工作项 | 产出 |
|---|---|---|
| plugin create | - 脚手架<br>- 模板选择 | 创建命令 |
| plugin dev | - 本地开发服务器<br>- 热重载 | 开发命令 |
| plugin build | - 构建 Bundle<br>- 压缩混淆 | 构建命令 |
| plugin lint | - Manifest 校验<br>- 代码规范检查 | 校验命令 |
| plugin test | - 单元测试<br>- 集成测试 | 测试命令 |
| plugin publish | - 发布到平台<br>- 版本管理 | 发布命令 |

### 4.3 插件模板（1 周）

**负责人**：前端工程师 × 1

| 模板 | 内容 |
|---|---|
| template-basic | 基础页面 + 按钮 |
| template-form | 表单提交 |
| template-event-driven | 事件驱动 |
| template-full-featured | 全功能示例 |

### 4.4 插件审核后台（2 周）

**负责人**：后端工程师 × 2

| 模块 | 工作项 | 产出 |
|---|---|---|
| 审核管理 | - 插件列表<br>- 权限审核<br>- 安全扫描 | 审核后台 |
| 灰度发布 | - 灰度配置<br>- 监控告警<br>- 回滚操作 | 灰度发布系统 |
| 性能看板 | - 性能指标<br>- 错误率<br>- 崩溃率 | 性能看板 |

### 4.5 插件应用市场（1 周）

**负责人**：产品经理 + 前端工程师

| 功能 | 工作项 |
|---|---|
| 插件展示 | - 插件列表<br>- 详情页<br>- 评价 |
| 插件安装 | - 一键安装<br>- 权限展示<br>- 使用说明 |

### 第四阶段里程碑

**时间节点**：第 32 周末

**交付物**：
1. Plugin SDK（npm 包）
2. Plugin CLI（完整命令）
3. 插件模板
4. 插件审核后台
5. 插件应用市场
6. 开发者文档

---

## 第五阶段：高级特性（4-6 周）

**目标**：支持复杂场景和跨端一致性

### 5.1 性能优化（2 周）

| 特性 | 工作项 | 产出 |
|---|---|---|
| Bundle 增量更新 | - 差分算法<br>- 增量分发 | 增量更新系统 |
| STAC 局部更新 | - JSON Patch<br>- 局部重渲染 | 局部更新支持 |
| Runtime 池管理 | - 实例复用<br>- 空闲挂起 | 池管理系统 |

### 5.2 高级功能（2 周）

| 特性 | 工作项 | 产出 |
|---|---|---|
| 插件间协作 | - 跨插件调用<br>- 数据共享协议 | 协作协议 |
| PC 端独立进程 | - 进程隔离<br>- 通信机制 | 独立进程支持 |
| 离线能力 | - 离线 Bundle<br>- 离线数据缓存 | 离线增强 |

### 5.3 AI 辅助开发（1 周）

| 功能 | 工作项 | 产出 |
|---|---|---|
| AI 代码生成 | - 根据 PRD 生成插件代码<br>- 根据设计生成 Schema | AI 辅助工具 |
| 智能建议 | - 性能建议<br>- 安全建议 | 智能建议系统 |

### 第五阶段里程碑

**时间节点**：第 38 周末

**交付物**：
1. Bundle 增量更新
2. STAC 局部更新
3. 插件间协作协议
4. PC 端独立进程支持
5. 离线能力增强
6. AI 辅助开发工具

---

## 资源配置建议

### 团队配置

| 角色 | 人数 | 职责 |
|---|---|---|
| 架构师 | 1 | 整体架构设计、技术决策 |
| 移动端工程师 | 3 | Flutter 宿主、JS 引擎、通信协议 |
| 前端工程师 | 2 | STAC 渲染器、SDK/CLI |
| 后端工程师 | 2 | 插件网关、审核后台、性能监控 |
| 各业务线工程师 | 若干 | Host Bridge 能力实现 |
| 安全工程师 | 1 | 安全沙箱、权限模型、安全审计 |
| 测试工程师 | 2 | 自动化测试、性能测试、安全测试 |
| 产品经理 | 1 | 需求管理、开发者体验 |

### 技术栈

| 层次 | 技术选型 |
|---|---|
| 跨端宿主 | Flutter |
| JS 引擎 | QuickJS (quickjs_dart) |
| SDUI 框架 | STAC / 自研 |
| 构建工具 | Node.js + TypeScript |
| 后端 | Go / Java |
| 监控 | Prometheus + Grafana |
| 日志 | ELK / Loki |

---

## 风险管理

| 风险 | 等级 | 应对措施 |
|---|---|---|
| QuickJS 多实例内存压力 | 中 | Runtime 池管理、空闲挂起、数量限制 |
| JS ↔ Dart FFI 性能瓶颈 | 中 | PoC 验证、批量调用、二进制编码优化 |
| JS Bundle 被篡改 | 高 | 签名校验、Hash 校验、HTTPS、证书固定 |
| 移动端审核风险 | 高 | 不下发机器码、QuickJS 内置、Bundle 可审核 |
| 插件拖慢宿主 | 中 | 懒加载、资源限制、崩溃隔离、自动禁用 |
| STAC 渲染性能 | 中 | 局部更新、虚拟化列表、组件缓存 |
| 跨端一致性问题 | 中 | 统一引擎（QuickJS）、统一 Schema、跨端测试 |

---

## 关键里程碑

| 阶段 | 时间 | 里程碑 |
|---|---|---|
| Phase 1 | 第 8 周末 | JS 引擎 PoC 验证通过 |
| Phase 2 | 第 16 周末 | JS 插件 MVP 闭环 |
| Phase 3 | 第 24 周末 | 能力扩展完成，可支持实际业务 |
| Phase 4 | 第 32 周末 | 开发者平台上线，生态建立 |
| Phase 5 | 第 38 周末 | 高级特性完成，产品 GA |

---

## 成功指标

| 指标 | 目标 |
|---|---|
| 插件加载时间 | < 2s |
| 首屏渲染时间 | < 1s |
| invokeHost 延迟 | < 100ms |
| 插件内存占用 | < 16MB |
| 插件 CPU 占比 | < 10% |
| 插件崩溃率 | < 0.1% |
| 开发者创建插件时间 | < 5 分钟 |
