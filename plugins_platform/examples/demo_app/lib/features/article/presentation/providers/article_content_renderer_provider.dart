import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/features/article/data/services/article_content_renderer_impl.dart';
import 'package:rss_reader/features/article/domain/services/article_content_renderer.dart';
import 'package:rss_reader/features/settings/presentation/providers/image_settings_provider.dart';

part 'article_content_renderer_provider.g.dart';

/// 文章内容渲染器 Provider
@riverpod
ArticleContentRenderer articleContentRenderer(Ref ref) {
  return ArticleContentRendererImpl();
}

/// 文章渲染配置 Provider（根据设置自动更新）
@riverpod
ArticleRenderConfig articleRenderConfig(Ref ref) {
  final imageSettings = ref.watch(imageSettingsNotifierProvider);

  return ArticleRenderConfig(
    fontSize: 16.0,
    lineHeight: 1.6,
    enableImages: imageSettings.isImageLoadingEnabled,
    enableVideos: false,
  );
}
