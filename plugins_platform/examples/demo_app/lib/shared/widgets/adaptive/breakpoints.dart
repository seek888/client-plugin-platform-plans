/// 响应式布局断点定义
abstract class Breakpoints {
  /// 紧凑型（手机竖屏）
  static const double compact = 600;

  /// 中等（手机横屏、小平板）
  static const double medium = 840;

  /// 扩展型（平板、桌面）
  static const double expanded = 1200;

  /// 大屏（大桌面显示器）
  static const double large = 1600;
}

/// 布局类型枚举
enum LayoutType {
  /// 单栏布局（移动端）
  compact,

  /// 双栏布局（平板）
  medium,

  /// 三栏布局（桌面）
  expanded,
}

/// 根据屏幕宽度获取布局类型
LayoutType getLayoutType(double width) {
  if (width < Breakpoints.compact) {
    return LayoutType.compact;
  } else if (width < Breakpoints.expanded) {
    return LayoutType.medium;
  } else {
    return LayoutType.expanded;
  }
}
