# Wasm 插件运行时可行性研究

## 结论

当前不建议用 Wasm 直接替换 JS 作为默认插件运行时。

更合适的路径是：

1. 继续保留 JS / QuickJS 作为默认插件 ABI。
2. 把 Wasm 升级为下一轮技术探索候选，而不是长期搁置。
3. 先补足运行时抽象边界，再进入小范围 POC。

这次结论不是“Wasm 不行”，而是“不要直接替换主路径；应该用 POC 数据验证 Wasm 是否适合成为可选 runtime”。

## 结论依据

仓库当前的插件模型已经把 JS 当作 ABI 来使用：

- `renderPage` / `renderCard` 直接返回 STAC 结构。
- `invokeHost` 是宿主能力调用入口。
- STAC 事件回调默认回到 JS 侧处理。
- `PluginManager` 负责 JS runtime 生命周期。
- `EngineConfig.runtime` 目前就是 `quickjs` / `v8` 这一类 JS runtime 语义。

也就是说，替换的对象不是“脚本引擎”这么简单，而是整套插件执行协议。

## 关键判断

### 1. Flutter Web Wasm 不是客户端插件 Wasm

官方文档里的 Flutter / Dart Wasm，核心是“编译 Web 应用到 Wasm”，不是“在 Flutter mobile / desktop 里嵌一个通用 Wasm 插件 VM”。
Dart 文档还明确提到，当前 Dart 编译出的 Wasm 目标是 JavaScript 环境，不支持直接运行在 Wasmtime / Wasmer 这类标准 Wasm runtime 中。

参考：

- https://dart.dev/web/wasm
- https://docs.flutter.dev/platform-integration/web/wasm
- https://docs.flutter.dev/platform-integration/web

所以这里不能把“Flutter 支持 Wasm”直接等同为“插件平台可以直接切 Wasm”。

### 2. Wasm 的优势主要在边界更硬的执行模型

WASI 和 Component Model 提供的是显式能力导入 / 导出、接口隔离、跨语言组件化。

参考：

- https://wasi.dev/
- https://component-model.bytecodealliance.org/

这对计算型、能力受限型、边界明确的插件更有价值。对当前这套偏业务编排、STAC 组装、宿主能力调用的插件形态，收益没那么直接。

### 3. 当前仓库里 JS 已经承载了平台协议

这意味着 Wasm 替换 JS 时，至少要一起重做这些边界：

- 生命周期回调。
- 宿主桥协议。
- STAC 返回格式。
- 事件分发模型。
- Bundle 签名与更新策略。
- 调试和观测工具链。

不是单纯把 `.js` 换成 `.wasm`。

## 迁移影响

### Manifest

现有 `PluginType.js` 和 `EngineConfig.runtime=quickjs/v8` 已经绑定 JS 语义。
如果未来增加 Wasm，不建议直接复用现在的 JS 字段硬塞：

```json
{
  "type": "wasm",
  "engine": {
    "runtime": "wasm",
    "bundle": "dist/plugin.wasm",
    "bundleHash": "<sha256>",
    "abi": "plugin-wasi-json-v1"
  }
}
```

这个结构只能作为后续 POC 方向，本 issue 不改生产 manifest。

### 生命周期函数

现有 JS 插件可自然暴露 `onActivate`、`renderPage`、`renderCard` 和事件处理函数。
Wasm 需要显式定义导出函数签名，例如：

- `plugin_activate(context_ptr, context_len)`
- `plugin_render_page(route_ptr, route_len)`
- `plugin_dispatch_event(event_ptr, event_len)`

这些函数的内存分配、返回值所有权、错误编码都要成为 ABI 的一部分。

### Host Bridge

JS 当前通过 `invokeHost(method, params)` 调宿主能力。
Wasm 更适合把宿主能力定义成 imports：

- capability id 仍由 manifest 声明。
- 参数和返回值先统一走 JSON bytes。
- 每次调用仍由 Host Bridge 做权限校验、审计、限流。

也就是说，Wasm 不应该绕过现有 Host Bridge，只应该替换插件逻辑执行后端。

### STAC 返回值

现有 JS 可以直接返回 JSON-like STAC 对象。
Wasm runtime 不能直接把宿主对象跨边界传出来，建议 POC 先使用：

- UTF-8 JSON bytes 作为返回值。
- 宿主侧继续用现有 STAC schema 解析。
- 后续若性能瓶颈明显，再考虑二进制 schema 或 WIT 类型。

### 事件和异步模型

JS 的 Promise / async 函数天然适合 `invokeHost`。
Wasm 必须明确异步边界：

- POC 初期可以先做同步导出函数 + 宿主侧异步能力代理。
- 复杂异步能力需要等待 WASI P3 / Component Model async 能力成熟后再评估。
- STAC 事件回调必须能映射到可审计的 Wasm 导出函数。

### Bundle 更新和签名

Wasm bundle 仍应复用现有更新治理原则：

- HTTPS 下载。
- SHA-256 / 签名校验。
- 版本兼容校验。
- 灰度和回滚。

新增的关键点是 ABI 版本校验：宿主不能只校验文件 hash，还要校验 `.wasm` 是否声明了宿主支持的 ABI。

### 调试和观测

Wasm 的调试体验会弱于 JS：

- 源码映射、栈追踪、异常信息需要单独设计。
- 多语言插件会带来不同工具链的差异。
- 宿主日志要记录 runtime、ABI version、导出函数名、能力调用链路。

如果没有这些基础设施，Wasm 插件会比 JS 插件更难排查线上问题。

### 插件作者工作流

JS 插件可以直接复用 npm、TypeScript、lint、test、bundle 生态。
Wasm 插件需要定义目标语言、SDK、模板和构建链路。建议 POC 先限定一种语言，例如 Rust 或 AssemblyScript，不要一开始承诺多语言生态。

## 可行性矩阵

| 维度 | 现状 JS / QuickJS | Wasm 作为插件 runtime |
|---|---|---|
| 跨平台可用性 | 已覆盖现有目标端 | 可做，但需要每端 runtime 适配 |
| iOS 合规 | 现状稳定 | 可行，但 host / ABI 设计要更严格 |
| 宿主桥 | `invokeHost` 已成型 | 需重定义导入接口和数据编码 |
| STAC 返回 | 直接返回 JSON / Schema | 可行，但要统一序列化边界 |
| 事件模型 | JS 回调天然适配 | 需要明确 async / callback 语义 |
| Bundle 分发 | JS bundle 直接下发 | Wasm 需要额外编译、签名、ABI 校验 |
| 调试体验 | 现有工具链较直观 | 调试成本更高，栈和源码映射更重 |
| 插件作者体验 | JS 门槛低，生态广 | 学习成本高，工具链更碎 |
| 安全模型 | 依赖沙箱和权限控制 | Wasm 更适合做更硬的能力边界 |
| 迁移成本 | 低 | 高，且会影响现有插件资产 |

## 推荐路径

### 现在

保持当前 JS 方案：

- 默认 runtime 仍是 QuickJS。
- 现有 JS 插件、STAC 结构、Host Bridge 协议不改。
- 不在本 issue 引入 manifest 破坏性变化。

### 近期

补一个更宽的运行时抽象边界，并把 Wasm 明确列入下一轮探索候选：

- 运行时能力从“JS 引擎”逐步收敛成“插件 runtime”。
- `PluginManager` 的生命周期调度不绑定单一执行后端。
- manifest 里先保留现有 `runtime=quickjs/v8` 语义，不急着加 `wasm` 强制字段。
- 新建后续 POC issue 时，应限定插件形态、ABI、目标端和验收指标。

### 未来 POC

如果后续要验证 Wasm，建议只做一个很小的 POC：

- 一个插件，一个最小 ABI。
- 只支持少量导出函数。
- 宿主能力通过显式 imports 暴露。
- 返回值统一走 JSON bytes / WIT-compatible schema。

POC 通过后，再决定是否把 Wasm 扩成正式 runtime。

## 架构 TODO

为了给 Wasm 留出可验证空间，但不影响当前 JS 主路径，后续可以拆出这些非功能 TODO：

1. 抽象 `PluginRuntime`：承载 `loadBundle`、生命周期调用、事件派发和销毁。
2. 保留 `JSEngine` / `JSRuntime` 作为 JS runtime 的实现细节。
3. 让 `PluginManager` 面向 `PluginRuntime` 调度，而不是直接面向 JS runtime。
4. 明确 `Host Bridge` 是唯一能力出口，任何 runtime 都不能绕过权限校验。
5. 把 STAC 返回值定义为 runtime-neutral 的 schema payload。
6. 为未来 runtime 添加 ABI version / runtime capability 检查。

## 这次 issue 不做什么

- 不实现 Wasm runtime adapter。
- 不迁移现有 JS demo 插件。
- 不改生产 manifest 兼容面。
- 不改插件更新和签名体系的线上行为。

## 建议的落地顺序

1. 先把 JS 路径继续做稳。
2. 在架构文档里保留 runtime 抽象 TODO。
3. 如果后续确实要探索 Wasm，再单开一个 POC issue。

## 参考

- [mobile-plugin-platform-plan.md](mobile-plugin-platform-plan.md)
- [plugins_platform/packages/core/lib/src/engine/js_engine.dart](plugins_platform/packages/core/lib/src/engine/js_engine.dart)
- [plugins_platform/packages/core/lib/src/engine/js_runtime.dart](plugins_platform/packages/core/lib/src/engine/js_runtime.dart)
- [plugins_platform/packages/core/lib/src/plugin/plugin_manifest.dart](plugins_platform/packages/core/lib/src/plugin/plugin_manifest.dart)
- [plugins_platform/packages/plugin_manager/lib/src/plugin_manager.dart](plugins_platform/packages/plugin_manager/lib/src/plugin_manager.dart)
- [plugins_platform/packages/host_bridge/lib/src/host_bridge.dart](plugins_platform/packages/host_bridge/lib/src/host_bridge.dart)
