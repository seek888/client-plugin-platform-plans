library;

/// Plugins Platform - 统一导出
///
/// 跨端客户端插件平台，提供 JS 引擎运行时、插件管理、宿主能力桥等功能
///
/// ## 使用方式
///
/// ```dart
/// import 'package:plugins_platform/plugins_platform.dart';
/// ```

// 核心抽象接口和数据模型
export 'package:core/core.dart';

// QuickJS 引擎实现
export 'package:plugins_quickjs_engine/plugins_quickjs_engine.dart';

// 插件生命周期管理
export 'package:plugin_manager/plugin_manager.dart';

// 宿主能力桥
export 'package:host_bridge/host_bridge.dart';

// STAC 渲染器
export 'package:stac_renderer/stac_renderer.dart';
