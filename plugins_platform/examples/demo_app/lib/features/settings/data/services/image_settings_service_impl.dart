import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:rss_reader/features/settings/domain/entities/image_settings.dart';
import 'package:rss_reader/features/settings/domain/services/image_settings_service.dart';

/// 图片设置服务实现
///
/// 使用内存存储设置，实际应用中应该使用 SharedPreferences 或数据库持久化
class ImageSettingsServiceImpl implements ImageSettingsService {
  /// 当前设置
  ImageSettings _settings;

  /// 设置变化流控制器
  final _settingsController = StreamController<ImageSettings>.broadcast();

  ImageSettingsServiceImpl({ImageSettings? initialSettings})
    : _settings = initialSettings ?? const ImageSettings();

  @override
  ImageSettings getSettings() => _settings;

  @override
  Future<void> updateSettings(ImageSettings settings) async {
    _settings = settings;
    _settingsController.add(_settings);
  }

  @override
  Future<void> setLoadingMode(ImageLoadingMode mode) async {
    await updateSettings(_settings.copyWith(loadingMode: mode));
  }

  @override
  Future<void> toggleNoImageMode() async {
    final newMode = _settings.isNoImageMode
        ? ImageLoadingMode.always
        : ImageLoadingMode.never;
    await setLoadingMode(newMode);
  }

  @override
  Future<void> setLazyLoadEnabled(bool enabled) async {
    await updateSettings(_settings.copyWith(lazyLoadEnabled: enabled));
  }

  @override
  Future<void> setCacheSizeLimit(int sizeMB) async {
    await updateSettings(_settings.copyWith(cacheSizeLimitMB: sizeMB));
  }

  @override
  Future<void> clearImageCache() async {
    // 实际实现中应该清除图片缓存
    // 例如使用 cached_network_image 的缓存管理
    debugPrint('Image cache cleared');
  }

  @override
  Future<int> getCurrentCacheSize() async {
    // 实际实现中应该返回真实的缓存大小
    return 0;
  }

  @override
  Stream<ImageSettings> watchSettings() => _settingsController.stream;

  /// 释放资源
  void dispose() {
    _settingsController.close();
  }
}
