/// 日志标签常量
///
/// 预定义的模块标签，用于分类日志来源
abstract class LogTags {
  /// 数据库操作
  static const String database = 'Database';

  /// 网络请求
  static const String network = 'Network';

  /// 同步服务
  static const String sync = 'Sync';

  /// 订阅源管理
  static const String feed = 'Feed';

  /// 文章处理
  static const String article = 'Article';

  /// RSS 解析
  static const String parser = 'Parser';

  /// 界面交互
  static const String ui = 'UI';

  /// 路由导航
  static const String navigation = 'Navigation';

  /// 设置管理
  static const String settings = 'Settings';

  /// 通知服务
  static const String notification = 'Notification';

  /// 缓存服务
  static const String cache = 'Cache';

  /// 搜索服务
  static const String search = 'Search';
}
