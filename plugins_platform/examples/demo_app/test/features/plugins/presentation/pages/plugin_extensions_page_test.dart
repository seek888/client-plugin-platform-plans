import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugins_platform/plugins_platform.dart';
import 'package:rss_reader/features/plugins/presentation/pages/plugin_extensions_page.dart';

void main() {
  Widget buildSubject({PluginInfo? plugin}) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 390,
          child: PluginLifecycleCard(
            title: '测试插件',
            description: '用于验证插件安装流程的卡片。',
            icon: Icons.extension_outlined,
            permissions: const ['网络请求', '本地存储'],
            plugin: plugin,
            onInstall: () {},
            onActivate: () {},
            onInstallAndActivate: () {},
            onOpen: () {},
          ),
        ),
      ),
    );
  }

  testWidgets('renders install step and shortcut before plugin is installed', (
    tester,
  ) async {
    await tester.pumpWidget(buildSubject());

    expect(find.text('步骤 1/3 等待安装'), findsOneWidget);
    expect(find.text('安装并激活'), findsOneWidget);
    expect(find.text('安装'), findsWidgets);
    expect(find.text('激活'), findsWidgets);
    expect(find.text('打开'), findsOneWidget);
  });

  testWidgets('renders activation as primary action after install', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildSubject(plugin: _pluginInfo(state: PluginState.installed)),
    );

    expect(find.text('步骤 2/3 等待激活'), findsOneWidget);
    expect(find.text('安装并激活'), findsNothing);
    expect(find.text('已安装'), findsOneWidget);
    expect(find.text('激活'), findsWidgets);
    expect(find.text('打开'), findsOneWidget);
  });

  testWidgets('renders usable state after activation', (tester) async {
    await tester.pumpWidget(
      buildSubject(plugin: _pluginInfo(state: PluginState.activated)),
    );

    expect(find.text('步骤 3/3 已可使用'), findsOneWidget);
    expect(find.text('已安装'), findsOneWidget);
    expect(find.text('已激活'), findsOneWidget);
    expect(find.text('打开'), findsOneWidget);
  });
}

PluginInfo _pluginInfo({required PluginState state}) {
  return PluginInfo(
    manifest: const PluginManifest(
      id: 'com.example.test',
      name: '测试插件',
      version: '1.0.0',
      publisher: 'Example',
      type: PluginType.js,
      platforms: ['web'],
      minHostVersion: '1.0.0',
    ),
    state: state,
  );
}
