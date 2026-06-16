/// 应用常量定义
abstract class AppConstants {
  /// 应用名称
  static const String appName = 'RSS Reader';

  /// 数据库名称
  static const String databaseName = 'rss_reader.db';

  /// 默认分页大小
  static const int defaultPageSize = 20;

  /// 文章摘要最大行数
  static const int summaryMaxLines = 2;

  /// 未读标记宽度
  static const double unreadIndicatorWidth = 4.0;

  /// 订阅源图标大小
  static const double feedIconSize = 32.0;

  /// 文章卡片图片高度
  static const double articleImageHeight = 120.0;

  /// 默认刷新间隔（分钟）
  static const int defaultRefreshInterval = 30;

  /// 订阅源失效检测天数
  static const int feedInactiveDays = 30;

  /// 最大缓存文章数
  static const int maxCachedArticles = 1000;

  /// 搜索防抖延迟（毫秒）
  static const int searchDebounceMs = 300;

  /// 滑动操作阈值
  static const double swipeThreshold = 0.3;

  /// 横向订阅源栏最大显示数量
  static const int maxVisibleFeeds = 8;
}
