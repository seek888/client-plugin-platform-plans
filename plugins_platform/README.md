# Plugins Platform

A cross-platform client plugin platform built with Flutter, supporting iOS, Android, and Desktop platforms.

## Overview

This platform provides a unified plugin runtime and capability access system with the following features:

- **Cross-Platform**: Single codebase for iOS/Android/Desktop
- **JS Engine Runtime**: Each plugin runs in an isolated QuickJS sandbox
- **STAC SDUI**: Server-Driven UI rendering
- **Event-Driven**: Lazy loading and event-based activation
- **Capability Bridge**: Unified host capability access with permission control

## Architecture

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

### Installation

```bash
# Activate Melos
dart pub global activate melos

# Bootstrap the project
cd plugins_platform
melos bootstrap
```

### Running the Demo

```bash
cd examples/demo_app
flutter run
```

## Plugin Development

See [Plugin Development Guide](docs/plugin-development.md) for details on creating plugins.

### Work Calendar Plugin

- [接入说明](docs/work_calendar_plugin_integration.md)
- [使用说明](docs/work_calendar_quick_start.md)
- [AI Skill 草案](docs/skills/work-calendar-plugin-dev/SKILL.md)

## License

MIT
