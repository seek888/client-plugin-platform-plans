library;

/// Core 抽象接口和数据模型
///
/// 提供插件平台的核心抽象，包括：
/// - JS 引擎抽象接口
/// - 能力桥抽象接口
/// - 插件数据模型
/// - 权限检查抽象

// 引擎抽象
export 'src/engine/js_engine.dart';
export 'src/engine/js_runtime.dart';

// 能力桥抽象
export 'src/bridge/bridge.dart';

// 插件数据模型
export 'src/plugin/plugin_manifest.dart';
export 'src/plugin/plugin_state.dart';

// STAC Schema 和更新类型
export 'src/stac/stac_schema.dart';
export 'src/stac/stac_update.dart';

// 业务事件类型
export 'src/events/business_events.dart';
