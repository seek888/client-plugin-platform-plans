import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:plugins_platform/plugins_platform.dart';

/// 内置插件引导服务
class BuiltinPluginBootstrap {
  static const aiNewsDailyPluginId = 'com.rss.ai_news_daily';
  static const aiNewsDailyFeedKey = 'ai-news';
  static const aiNewsDailyFeedTitle = 'AI 资讯快报';

  static const _builtinPlugins = [
    _BuiltinPluginAsset(
      pluginId: aiNewsDailyPluginId,
      assetPath: 'assets/plugins/ai_news_daily',
    ),
  ];

  final PluginManager _pluginManager;

  bool _bootstrapped = false;

  BuiltinPluginBootstrap({
    required PluginManager pluginManager,
  }) : _pluginManager = pluginManager;

  Future<void> ensureInstalledAndActivated() async {
    if (_bootstrapped) return;

    for (final plugin in _builtinPlugins) {
      final manifestJson = await rootBundle.loadString(
        '${plugin.assetPath}/manifest.json',
      );
      final bundle = await rootBundle.loadString(
        '${plugin.assetPath}/dist/bundle.js',
      );
      final manifest = PluginManifest.fromJson(
        jsonDecode(manifestJson) as Map<String, dynamic>,
      );

      if (!_pluginManager.isInstalled(plugin.pluginId)) {
        await _pluginManager.installFromAsset(
          manifest: manifest,
          bundleSource: bundle,
        );
      }

      if (!_pluginManager.isActivated(plugin.pluginId)) {
        await _pluginManager.activate(plugin.pluginId);
      }
    }

    _bootstrapped = true;
  }

  Future<void> ensureReady() async {
    await ensureInstalledAndActivated();
  }
}

class _BuiltinPluginAsset {
  final String pluginId;
  final String assetPath;

  const _BuiltinPluginAsset({
    required this.pluginId,
    required this.assetPath,
  });
}
