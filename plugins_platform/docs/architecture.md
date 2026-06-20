# 技术架构说明

本文档说明 Plugins Platform 的模块边界、运行链路和关键工程约束，帮助研发、测试和插件开发者在同一套技术语义下协作。

## 目标与范围

Plugins Platform 是一个面向 Flutter 宿主应用的客户端插件平台，当前重点支持以下能力：

- 使用 QuickJS 为每个 JS 插件创建独立运行时，降低插件之间的状态耦合。
- 使用 Manifest 描述插件元数据、运行时约束、权限、能力和 STAC 组件依赖。
- 使用 Host Bridge 将宿主原生能力以受控 API 暴露给插件。
- 使用 STAC Schema 将插件 UI 渲染为 Flutter Widget。
- 使用 Demo App 验证插件安装、激活、页面渲染和能力调用链路。

当前仓库更接近 SDK + 示例宿主的形态，不包含线上插件市场、远程分发后台、签名服务或完整灰度系统。

## 模块边界

| 模块 | 责任 | 不应承担的责任 |
| --- | --- | --- |
| `packages/core` | 抽象接口、Manifest/STAC/插件状态等共享数据模型 | 具体运行时实现、Flutter 宿主业务逻辑 |
| `packages/quickjs_engine` | QuickJS 适配层、`invokeHost` 注入、JS 函数调用与事件派发 | 插件安装、权限策略、具体宿主能力 |
| `packages/host_bridge` | 能力注册表、权限校验、内置能力处理器 | JS Runtime 生命周期、STAC 渲染 |
| `packages/plugin_manager` | 插件安装、Bundle 校验、激活/停用/卸载、Runtime 绑定 | UI 组件实现、业务插件代码 |
| `packages/stac_renderer` | STAC Schema/Node 到 Flutter Widget 的渲染、事件和表单处理 | 插件 Manifest 解析、能力权限判断 |
| `packages/event_bus` | 事件分发基础设施 | 插件生命周期管理 |
| `packages/plugins_platform` | 对外统一导出包 | 新业务逻辑 |
| `examples/demo_app` | 示例宿主应用、内置示例插件、集成验证入口 | 平台核心抽象定义 |

## 运行链路

### 插件安装

1. 宿主构造或读取 `PluginManifest`。
2. `PluginManager.install()` 校验插件是否重复安装。
3. 当传入 `bundleSource` 时，`PluginManager` 使用 Manifest 中的 `engine.bundleHash` 校验 Bundle 内容。
4. Manifest 和 Bundle 写入宿主应用文档目录下的插件目录。
5. 插件状态记录为 `installed`。

### 插件激活

1. `PluginManager.activate(pluginId)` 查找 Manifest。
2. 仅 `type: "js"` 的插件会创建 JS Runtime。
3. `JSEngine.createRuntime()` 按 Manifest 中的内存和执行超时创建 Runtime。
4. Runtime 加载 `bundle.js`，并注入全局 `invokeHost(method, params)`。
5. `PluginManager` 将 Host Bridge 注册表中的能力逐个注册到该 Runtime。
6. Runtime 调用插件的 `onActivate()`。该步骤失败会记录日志，但不会中断激活。
7. 插件状态更新为 `activated`。

### 能力调用

```text
插件 JS
  -> invokeHost(method, params)
  -> QuickJSRuntime runtime handler
  -> HostBridge.handleInvoke(pluginId, method, params)
  -> CapabilityRegistry 查找能力
  -> PermissionChecker 校验 Manifest permissions
  -> Capability handler 执行业务
  -> 返回 { success, data } 或 { success, error }
```

插件调用能力前，必须在 `manifest.json` 的 `permissions` 中声明对应权限。无权限能力，例如 `toast.show`，可以直接调用。

### UI 渲染

插件通过导出函数返回 STAC Schema，宿主侧使用 `STACRenderer.render()` 或 `STACRenderer.renderNode()` 转换为 Flutter Widget。渲染器负责：

- 解析 `type`、`props`、`children`、`style` 等字段。
- 处理事件回调并接收 `STACUpdate`。
- 在表单场景维护 `STACFormKey` 的当前值。
- 支持全量 Schema 更新和 patch 更新。

## 插件契约

一个 JS 插件至少需要：

- `manifest.json`：声明 `id`、`name`、`version`、`publisher`、`type`、`platforms`、`minHostVersion`、`engine`、`permissions`、`stac` 等字段。
- `dist/bundle.js`：运行时实际加载的 JS Bundle。
- 入口函数：默认 `onActivate()`，可通过 `engine.entryFunction` 描述，但当前激活流程固定调用 `onActivate()`。
- 可选生命周期：`onDeactivate()`。
- 可选渲染函数：例如 Demo App 中由宿主调用的页面或卡片渲染函数。

插件代码运行在 QuickJS 环境，不应依赖浏览器 DOM、`window`、`document`、`fetch` 或 Node.js API。网络请求、存储、通知等能力应通过 `invokeHost` 转发给宿主。

## 安全与可靠性约束

- **权限最小化**：Manifest 只声明插件真实需要的权限，Host Bridge 以能力维度校验。
- **运行时隔离**：每个激活插件持有独立 Runtime，不共享 JS 全局状态。
- **资源预算**：Manifest 中的 `performanceBudget` 和 `engine.memoryLimitMb`、`executionTimeoutMs` 是插件验收的重要参考。
- **完整性校验**：安装时应提供 `engine.bundleHash`，避免 Bundle 与 Manifest 不一致。
- **失败降级**：能力调用以结构化结果返回；插件侧需要处理 `success: false`。
- **可回滚**：发布策略应保留旧版本 Bundle 和 Manifest，避免更新失败后无法恢复。

## 扩展新宿主能力

1. 在 `packages/host_bridge` 中新增 `Capability` 定义，明确 `id`、权限、平台和处理器。
2. 如需复用业务能力元数据，可在 `capabilities/business_capabilities.dart` 中集中定义。
3. 为能力处理器补充参数校验和错误返回。
4. 在 API 文档中更新能力 ID、权限、入参、出参和示例。
5. 在 Demo App 或单元测试中覆盖有权限、无权限和异常输入场景。

## 扩展 STAC 组件

1. 在 `packages/core/lib/src/stac` 中确认 Schema 字段是否足够表达新组件。
2. 在 `packages/stac_renderer` 的节点构建逻辑中新增组件渲染分支。
3. 定义事件、样式、数据绑定和表单行为。
4. 更新 `docs/api/stac-components.md`。
5. 增加渲染测试，至少覆盖基础渲染和事件触发。

## 质量门禁

提交代码或文档前建议执行：

```bash
melos bootstrap
melos run analyze
melos run test
```

当修改 Demo App 或插件资产时，补充执行：

```bash
cd examples/demo_app
flutter test
flutter run
```

当修改示例插件 JS 源码时，需要重新执行对应插件目录下的构建脚本，确保 `dist/bundle.js` 与 Manifest 中的哈希和大小一致。

## 已知限制

- Manifest 版本兼容比较在 `PluginManager.install()` 中仍为 TODO。
- 当前 `PluginManager.activate()` 固定调用 `onActivate()`，尚未使用 `engine.entryFunction` 动态选择入口。
- 部分 API 参考文档描述了规划中的能力，实际可用能力以 `HostBridge.registerBuiltinCapabilities()` 注册内容为准。
- Demo App 是集成示例，不等同于完整生产宿主。
