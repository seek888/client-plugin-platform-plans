# 开发与交付指南

本文档面向维护 Plugins Platform 的研发人员，说明本地开发、验证、文档更新和交付检查流程。

## 本地环境

必需工具：

- Flutter SDK，满足各 package 的 `environment.sdk` 约束。
- Dart SDK，通常随 Flutter 安装。
- Melos CLI。
- Python 3，用于示例插件构建脚本。

安装 Melos：

```bash
dart pub global activate melos
```

初始化仓库：

```bash
melos bootstrap
```

## 常用命令

| 场景 | 命令 |
| --- | --- |
| 安装/链接全部依赖 | `melos bootstrap` |
| 格式化 Dart 代码 | `melos run format` |
| 静态分析 | `melos run analyze` |
| 运行全部包测试 | `melos run test` |
| 构建 Demo App debug APK | `melos run build` |
| 运行 Demo App | `cd examples/demo_app && flutter run` |

## 代码生成

仓库使用 `freezed`、`json_serializable`、`riverpod_generator`、`drift_dev` 等代码生成工具。修改带有 `part '*.g.dart'` 或 `part '*.freezed.dart'` 的源文件后，需要在对应 package 或 app 中运行：

```bash
dart run build_runner build --delete-conflicting-outputs
```

示例：

```bash
cd packages/core
dart run build_runner build --delete-conflicting-outputs
```

## 插件资产开发

示例插件位于：

- `examples/demo_app/assets/plugins/ai_news_daily`
- `examples/demo_app/assets/plugins/work_calendar`

修改插件 `src/` 后，需要运行对应插件的构建脚本：

```bash
cd examples/demo_app/assets/plugins/work_calendar
python3 scripts/build.py
```

构建脚本应更新：

- `dist/bundle.js`
- `manifest.json` 中的 `engine.bundleHash`
- `manifest.json` 中的 `engine.bundleSize`

随后在 Demo App 中重新运行或热重启验证。

## 文档维护规则

文档应跟随代码边界维护：

- 架构和模块职责更新时，维护 `docs/architecture.md`。
- 本地开发、测试、构建流程变化时，维护 `docs/development.md` 和 `README.md`。
- Manifest 字段变化时，维护 `docs/api/manifest.md`。
- Host Bridge 能力变化时，维护 `docs/api/capabilities.md`。
- STAC 组件或事件变化时，维护 `docs/api/stac-components.md`。
- QuickJS 运行时限制、全局函数或生命周期变化时，维护 `docs/api/js-runtime.md`。
- 插件入门流程变化时，维护 `docs/guides/getting-started.md` 和 `docs/guides/quick-start.md`。

不要在 README 中复制完整 API 参考。README 应保持入口性质，并链接到更细的文档。

## 变更检查清单

### 修改核心模型

- 更新 `packages/core` 的模型和生成文件。
- 检查所有引用该模型的 package。
- 更新 API 文档。
- 增加序列化/反序列化测试。

### 修改 Host Bridge 能力

- 注册能力并明确权限。
- 补充无权限、未知能力和异常参数测试。
- 更新能力 API 文档。
- 在示例插件或 Demo App 中验证调用链。

### 修改 STAC 渲染器

- 覆盖基础渲染、样式、事件和表单行为。
- 检查移动端和桌面端布局差异。
- 更新组件 API 文档和示例。

### 修改插件生命周期

- 覆盖安装、重复安装、激活、停用、卸载和异常 Bundle。
- 检查 Runtime 释放和状态回写。
- 更新架构文档和入门指南。

### 修改示例插件

- 重新构建 Bundle。
- 确认 Manifest hash/size 与 Bundle 一致。
- 在 Demo App 中验证插件可见、可激活、可渲染、可调用能力。

## 发布前验收

最小验收命令：

```bash
melos run analyze
melos run test
```

涉及 Demo App 时追加：

```bash
cd examples/demo_app
flutter test
```

涉及平台构建时追加对应目标平台构建，例如：

```bash
flutter build apk --debug
```

如果因为本地环境缺少 Flutter、设备、Xcode、Android SDK 或网络依赖导致无法验证，需要在交付说明中明确未验证项和原因。
