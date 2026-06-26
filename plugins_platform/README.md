# Plugins Platform

Plugins Platform 是一个 Flutter 客户端插件平台，用于在宿主应用中加载、隔离执行并渲染 JS 插件。仓库包含平台 SDK、Host Bridge、STAC 渲染器、QuickJS 运行时适配层和一个可运行的 Demo App。

## 核心能力

- **跨平台宿主**：面向 iOS、Android、Web、Windows、macOS、Linux 等 Flutter 目标平台。
- **QuickJS Runtime**：每个 JS 插件拥有独立运行时，支持内存和执行超时约束。
- **Manifest 契约**：使用 `manifest.json` 描述插件元数据、Bundle、权限、能力、STAC 组件和性能预算。
- **Host Bridge**：通过能力注册表和权限校验，将宿主能力安全暴露给插件。
- **STAC SDUI**：插件返回 Schema，宿主渲染为 Flutter Widget。
- **示例宿主**：`examples/demo_app` 内置 `work_calendar` 示例插件，并支持从本地导入插件安装包。

## 架构概览

```
┌─────────────────────────────────────────────────────────┐
│                    Plugin Layer                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │ Plugin A │  │ Plugin B │  │ Plugin C │             │
│  │ JS RT    │  │ JS RT    │  │ JS RT    │             │
│  └──────────┘  └──────────┘  └──────────┘             │
├─────────────────────────────────────────────────────────┤
│                    STAC UI Layer                         │
│  ┌────────────────────────────────────────────────────┐ │
│  │  STAC Renderer                                     │ │
│  └────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────┤
│                 Host Capability Layer                   │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Host Bridge (Capability Registry)                │ │
│  └────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────┤
│              Flutter Host (Mobile / Desktop)            │
└─────────────────────────────────────────────────────────┘
```

详细设计见 [技术架构说明](docs/architecture.md)。

## Packages

| Package | Description |
|---------|-------------|
| `core` | Core abstract interfaces and data models |
| `quickjs_engine` | QuickJS engine implementation |
| `plugin_manager` | Plugin lifecycle management |
| `host_bridge` | Host capability bridge |
| `stac_renderer` | STAC UI renderer (Phase 2) |
| `event_bus` | Event bus and distribution (Phase 2) |
| `plugins_platform` | Unified export package |

## Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 3.0.0)
- Melos CLI
- Python 3.x (for example plugin build scripts)

### Installation

```bash
# Activate Melos
dart pub global activate melos

# Bootstrap the project
cd plugins_platform
melos bootstrap
```

### Verification

```bash
melos run analyze
melos run test
```

### Running the Demo

```bash
cd examples/demo_app
flutter run
```

## Documentation

| Topic | Document |
| --- | --- |
| Architecture and module boundaries | [docs/architecture.md](docs/architecture.md) |
| Local development and delivery checks | [docs/development.md](docs/development.md) |
| Environment setup | [docs/guides/getting-started.md](docs/guides/getting-started.md) |
| Build your first plugin | [docs/guides/quick-start.md](docs/guides/quick-start.md) |
| Plugin examples | [docs/guides/examples.md](docs/guides/examples.md) |
| Manifest contract | [docs/api/manifest.md](docs/api/manifest.md) |
| Host Bridge capabilities | [docs/api/capabilities.md](docs/api/capabilities.md) |
| JS runtime | [docs/api/js-runtime.md](docs/api/js-runtime.md) |
| STAC components | [docs/api/stac-components.md](docs/api/stac-components.md) |

## Plugin Development

Start with [Quick Start](docs/guides/quick-start.md) to create a basic JS plugin, then use [Manifest](docs/api/manifest.md), [Capabilities](docs/api/capabilities.md), and [STAC Components](docs/api/stac-components.md) as API references.

Example plugins:

- `examples/demo_app/assets/plugins/work_calendar`

When editing plugin source under `src/`, run the plugin build script so `dist/bundle.js` and Manifest bundle metadata stay in sync.

```bash
cd examples/demo_app/assets/plugins/work_calendar
python3 scripts/build.py
```

## License

MIT
