/// 应用路由路径定义
abstract class AppRoutes {
  /// 首页
  static const String home = '/';

  /// 搜索页
  static const String search = '/search';

  /// 订阅源管理页
  static const String feedManagement = '/feed-management';

  /// 设置页
  static const String settings = '/settings';

  /// 插件扩展页
  static const String plugins = '/plugins';

  /// 收藏页
  static const String favorites = '/favorites';

  /// 富文本编辑器页（新建笔记）
  static const String editor = '/editor';

  /// 文章详情页路径模板（用于嵌套路由）
  static const String articlePath = 'article/:id';

  /// 文章详情页（完整路径）
  static String article(String id) => '/article/$id';

  /// 文章编辑页路径模板
  static const String articleEditPath = 'article/:id/edit';

  /// 文章编辑页（完整路径）
  static String articleEdit(String id) => '/article/$id/edit';

  /// 分类页路径模板
  static const String categoryPath = 'category/:id';

  /// 分类页（完整路径）
  static String category(String id) => '/category/$id';

  /// 订阅源详情页路径模板
  static const String feedDetailPath = 'feed/:id';

  /// 订阅源详情页（完整路径）
  static String feedDetail(String id) => '/feed/$id';
}

/// 路由参数名称常量
abstract class RouteParams {
  static const String id = 'id';
  static const String feedId = 'feedId';
  static const String categoryId = 'categoryId';
}

/// 路由查询参数常量
abstract class RouteQueryParams {
  static const String filter = 'filter';
  static const String sort = 'sort';
  static const String search = 'q';
}
