import 'package:rss_reader/features/settings/domain/entities/image_settings.dart';

/// 图片设置服务接口
abstract class ImageSettingsService {
  /// 获取当前图片设置
  ImageSettings getSettings();

  /// 更新图片设置
  Future<void> updateSettings(ImageSettings settings);

  /// 设置图片加载模式
  Future<void> setLoadingMode(ImageLoadingMode mode);

  /// 切换无图模式
  Future<void> toggleNoImageMode();

  /// 设置懒加载开关
  Future<void> setLazyLoadEnabled(bool enabled);

  /// 设置缓存大小限制
  Future<void> setCacheSizeLimit(int sizeMB);

  /// 清除图片缓存
  Future<void> clearImageCache();

  /// 获取当前缓存大小（MB）
  Future<int> getCurrentCacheSize();

  /// 监听设置变化
  Stream<ImageSettings> watchSettings();
}
