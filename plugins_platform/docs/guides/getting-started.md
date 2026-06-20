# 环境准备

欢迎使用 Plugins Platform！本文档将帮助你快速搭建插件开发环境。

## 前置要求

在开始之前，请确保你的开发环境满足以下要求：

### 必需工具

1. **Flutter SDK** (>= 3.0.0)
   - 下载地址：https://flutter.dev/docs/get-started/install
   - 验证安装：`flutter --version`

2. **Dart SDK** (>= 3.0.0)
   - 通常随 Flutter SDK 一起安装
   - 验证安装：`dart --version`

3. **Melos CLI**
   - Melos 是一个用于管理 Dart 和 Flutter monorepo 的工具
   - 安装命令：
     ```bash
     dart pub global activate melos
     ```
   - 验证安装：`melos --version`

### 推荐工具

- **IDE/编辑器**：
  - VS Code + Flutter 插件
  - Android Studio + Flutter 插件
  - IntelliJ IDEA + Flutter 插件

- **命令行工具**：
  - Git
  - Python 3.x（用于运行插件构建脚本）

## 项目结构说明

克隆或下载项目后，你会看到以下目录结构：

```
plugins_platform/
├── packages/                    # 核心功能包
│   ├── core/                   # 核心接口和数据模型
│   ├── quickjs_engine/         # QuickJS 引擎实现
│   ├── plugin_manager/         # 插件生命周期管理
│   ├── host_bridge/            # 宿主能力桥接
│   ├── stac_renderer/          # STAC UI 渲染器
│   ├── event_bus/              # 事件总线
│   └── plugins_platform/       # 统一导出包
├── examples/                    # 示例和演示
│   └── demo_app/               # Demo 应用
│       └── assets/plugins/     # 插件示例
│           ├── ai_news_daily/  # AI 资讯插件
│           └── work_calendar/  # 工作日历插件
├── docs/                        # 文档目录
│   └── guides/                 # 教程指南
├── melos.yaml                   # Melos 配置文件
└── README.md                    # 项目说明
```

### 核心概念

了解以下核心概念将帮助你更好地理解插件系统：

1. **QuickJS 引擎**
   - 每个插件运行在独立的 QuickJS 沙箱中
   - 提供内存隔离和安全执行环境
   - 支持 ES6+ 语法

2. **STAC UI 渲染**
   - STAC（Server-To-App Components）是一种服务端驱动 UI 的方案
   - 插件通过返回 JSON Schema 来描述 UI
   - 宿主应用负责将 Schema 渲染为原生 Flutter Widget

3. **Host Bridge 能力系统**
   - 插件通过 Host Bridge 访问宿主能力
   - 所有能力调用都受权限控制
   - 支持的能力包括：网络请求、本地存储、通知、日历等

4. **事件驱动激活**
   - 插件采用懒加载机制
   - 仅在特定事件触发时才加载和激活
   - 节省内存和提高性能

## 初始化项目

### 1. 克隆项目

```bash
git clone <repository-url>
cd plugins_platform
```

### 2. Bootstrap 项目

使用 Melos 初始化所有依赖：

```bash
melos bootstrap
```

这个命令会：
- 安装所有子包的依赖
- 链接本地包之间的依赖关系
- 生成必要的代码

### 3. 运行 Demo App

进入 Demo App 目录并运行：

```bash
cd examples/demo_app
flutter run
```

如果有多个设备，可以指定设备：

```bash
# 查看可用设备
flutter devices

# 在指定设备上运行
flutter run -d <device-id>
```

### 4. 验证环境

成功运行 Demo App 后，你应该能看到：
- 应用主界面
- 可用的插件列表（AI 资讯快报、工作日历）
- 可以激活插件并查看其界面

## 插件目录结构

一个标准的插件目录结构如下：

```
my_plugin/
├── manifest.json           # 插件配置文件（必需）
├── src/                    # 源代码目录
│   └── index.js           # 入口文件（必需）
├── dist/                   # 构建输出目录
│   └── bundle.js          # 打包后的代码
├── scripts/                # 构建脚本
│   └── build.py           # Python 构建脚本
├── i18n/                   # 国际化文件（可选）
│   ├── zh-CN.json
│   └── en-US.json
└── assets/                 # 资源文件（可选）
```

### 关键文件说明

1. **manifest.json**
   - 插件的元数据和配置
   - 定义插件 ID、名称、版本、权限等
   - 声明所需的 STAC 组件和能力

2. **src/index.js**
   - 插件的 JavaScript 入口
   - 导出生命周期函数：`onActivate`、`onDeactivate`
   - 导出 UI 渲染函数：`renderPage`、`renderCard`
   - 导出能力处理函数（根据插件功能）

3. **dist/bundle.js**
   - 构建后的单文件 bundle
   - 由构建脚本生成
   - 包含所有依赖和代码

## 开发工作流

标准的插件开发流程：

1. **创建插件目录**
   ```bash
   cd examples/demo_app/assets/plugins
   mkdir my_plugin
   cd my_plugin
   ```

2. **编写 manifest.json**
   - 定义插件基本信息
   - 声明所需权限和能力

3. **编写源代码**
   - 在 `src/` 目录下创建 JavaScript 文件
   - 实现必要的生命周期函数

4. **构建插件**
   ```bash
   python3 scripts/build.py
   ```

5. **在 Demo App 中测试**
   ```bash
   cd ../../..  # 回到 demo_app 目录
   flutter run
   ```

6. **调试和迭代**
   - 查看控制台日志
   - 修改代码后重新构建
   - 热重载查看效果

## 常用命令

### Melos 命令

```bash
# Bootstrap 所有包
melos bootstrap

# 清理所有包
melos clean

# 运行所有测试
melos test

# 分析所有包的代码
melos analyze
```

### Flutter 命令

```bash
# 运行应用
flutter run

# 热重载（应用运行时按 'r'）
# 热重启（应用运行时按 'R'）

# 清理构建缓存
flutter clean

# 获取依赖
flutter pub get

# 运行测试
flutter test
```

## 下一步

环境准备完成后，你可以：

1. 阅读 [快速入门教程](quick-start.md) 创建你的第一个插件
2. 查看 [示例集合](examples.md) 了解常见场景的实现
3. 探索 `examples/demo_app/assets/plugins/` 下的现有插件代码

## 常见问题

### Q: Melos bootstrap 失败怎么办？

A: 首先确保 Flutter 和 Dart 版本符合要求，然后尝试：
```bash
flutter clean
melos clean
melos bootstrap
```

### Q: Demo App 运行报错怎么办？

A: 检查以下几点：
1. Flutter SDK 版本是否满足要求
2. 是否执行了 `melos bootstrap`
3. 查看具体错误信息，可能是依赖问题或平台特定问题

### Q: 如何查看插件的日志输出？

A: 插件中的 `console.log()` 会输出到 Flutter 应用的控制台。运行 Demo App 时在终端查看日志。

### Q: 是否支持 TypeScript？

A: 当前版本使用纯 JavaScript。你可以在开发时使用 TypeScript，然后编译为 JavaScript 后打包。

## 获取帮助

- 查看项目 README：`plugins_platform/README.md`
- 阅读示例代码：`examples/demo_app/assets/plugins/`
- 阅读技术架构：[../architecture.md](../architecture.md)
- 查看开发与交付指南：[../development.md](../development.md)
- 参考 API 文档：[Manifest](../api/manifest.md)、[能力桥接](../api/capabilities.md)、[JS Runtime](../api/js-runtime.md)、[STAC 组件](../api/stac-components.md)
