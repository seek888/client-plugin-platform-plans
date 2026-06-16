import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/features/settings/data/services/image_settings_service_impl.dart';
import 'package:rss_reader/features/settings/domain/entities/image_settings.dart';
import 'package:rss_reader/features/settings/domain/services/image_settings_service.dart';

part 'image_settings_provider.g.dart';

/// 图片设置服务 Provider
@riverpod
ImageSettingsService imageSettingsService(Ref ref) {
  final service = ImageSettingsServiceImpl();
  ref.onDispose(() => service.dispose());
  return service;
}

/// 图片设置状态 Provider
@riverpod
class ImageSettingsNotifier extends _$ImageSettingsNotifier {
  @override
  ImageSettings build() {
    final service = ref.watch(imageSettingsServiceProvider);

    // 监听设置变化
    final subscription = service.watchSettings().listen((settings) {
      state = settings;
    });

    ref.onDispose(() => subscription.cancel());

    return service.getSettings();
  }

  /// 设置图片加载模式
  Future<void> setLoadingMode(ImageLoadingMode mode) async {
    final service = ref.read(imageSettingsServiceProvider);
    await service.setLoadingMode(mode);
    state = service.getSettings();
  }

  /// 切换无图模式
  Future<void> toggleNoImageMode() async {
    final service = ref.read(imageSettingsServiceProvider);
    await service.toggleNoImageMode();
    state = service.getSettings();
  }

  /// 设置懒加载开关
  Future<void> setLazyLoadEnabled(bool enabled) async {
    final service = ref.read(imageSettingsServiceProvider);
    await service.setLazyLoadEnabled(enabled);
    state = service.getSettings();
  }

  /// 设置缓存大小限制
  Future<void> setCacheSizeLimit(int sizeMB) async {
    final service = ref.read(imageSettingsServiceProvider);
    await service.setCacheSizeLimit(sizeMB);
    state = service.getSettings();
  }

  /// 清除图片缓存
  Future<void> clearImageCache() async {
    final service = ref.read(imageSettingsServiceProvider);
    await service.clearImageCache();
  }
}

/// 是否启用图片加载的便捷 Provider
@riverpod
bool isImageLoadingEnabled(Ref ref) {
  final settings = ref.watch(imageSettingsNotifierProvider);
  return settings.isImageLoadingEnabled;
}

/// 是否为无图模式的便捷 Provider
@riverpod
bool isNoImageMode(Ref ref) {
  final settings = ref.watch(imageSettingsNotifierProvider);
  return settings.isNoImageMode;
}
