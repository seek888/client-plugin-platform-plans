import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugins_platform/plugins_platform.dart';

class PluginExtensionsPage extends ConsumerStatefulWidget {
  const PluginExtensionsPage({super.key});

  static const _workCalendarPluginId = 'com.company.work_calendar';
  static const _workCalendarAssetPath = 'assets/plugins/work_calendar';
  static const _aiNewsPluginId = 'com.rss.ai_news_daily';
  static const _aiNewsAssetPath = 'assets/plugins/ai_news_daily';

  @override
  ConsumerState<PluginExtensionsPage> createState() =>
      _PluginExtensionsPageState();
}

class _PluginExtensionsPageState extends ConsumerState<PluginExtensionsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final manager = ref.read(pluginManagerProvider);
      await manager.ready;
      if (!mounted) return;
      ref.read(pluginListProvider.notifier).state = manager.getAllPlugins();
    });
  }

  @override
  Widget build(BuildContext context) {
    final plugins = ref.watch(pluginListProvider);
    final workCalendar = _findPlugin(
      plugins,
      PluginExtensionsPage._workCalendarPluginId,
    );
    final aiNews = _findPlugin(plugins, PluginExtensionsPage._aiNewsPluginId);
    final activatedCount = plugins.where((plugin) => plugin.isActivated).length;

    return Scaffold(
      appBar: AppBar(title: const Text('插件扩展')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SummaryPanel(
            installedCount: plugins.length,
            activatedCount: activatedCount,
          ),
          const SizedBox(height: 12),
          _PluginCard(
            title: '工作日历',
            description: '在 RSS Reader 中集成日程、会议、审批和通知能力。',
            icon: Icons.calendar_month_outlined,
            permissions: const ['日程读取/写入', '组织通讯录', '审批读写', '通知发送'],
            plugin: workCalendar,
            onInstall: () => _installAssetPlugin(
              context,
              ref,
              assetPath: PluginExtensionsPage._workCalendarAssetPath,
              successMessage: '工作日历插件已安装',
            ),
            onActivate: () => _activatePlugin(
              context,
              ref,
              PluginExtensionsPage._workCalendarPluginId,
            ),
            onOpen: () => _openPluginPage(
              context,
              ref,
              pluginId: PluginExtensionsPage._workCalendarPluginId,
              title: '工作日历',
            ),
          ),
          const SizedBox(height: 12),
          _PluginCard(
            title: 'AI 资讯快报',
            description: '启用后自动注入订阅源，并拉取 AI、大模型领域的日更资讯。',
            icon: Icons.auto_awesome_outlined,
            permissions: const ['网络请求', '本地存储', '订阅源注入'],
            plugin: aiNews,
            onInstall: () => _installAssetPlugin(
              context,
              ref,
              assetPath: PluginExtensionsPage._aiNewsAssetPath,
              successMessage: 'AI 资讯快报插件已安装',
            ),
            onActivate: () => _activatePlugin(
              context,
              ref,
              PluginExtensionsPage._aiNewsPluginId,
            ),
            onOpen: () => _openPluginPage(
              context,
              ref,
              pluginId: PluginExtensionsPage._aiNewsPluginId,
              title: 'AI 资讯快报',
            ),
          ),
          const SizedBox(height: 16),
          _CapabilityPanel(plugins: plugins),
        ],
      ),
    );
  }

  PluginInfo? _findPlugin(List<PluginInfo> plugins, String pluginId) {
    for (final plugin in plugins) {
      if (plugin.manifest.id == pluginId) {
        return plugin;
      }
    }
    return null;
  }

  Future<void> _installAssetPlugin(
    BuildContext context,
    WidgetRef ref, {
    required String assetPath,
    required String successMessage,
  }) async {
    try {
      final manifestJson = await rootBundle.loadString(
        '$assetPath/manifest.json',
      );
      final jsBundle = await rootBundle.loadString('$assetPath/dist/bundle.js');
      final manifest = PluginManifest.fromJson(
        jsonDecode(manifestJson) as Map<String, dynamic>,
      );

      final manager = ref.read(pluginManagerProvider);
      await manager.ready;
      await manager.install(manifest, bundleSource: jsBundle);
      ref.read(pluginListProvider.notifier).state = manager.getAllPlugins();

      if (context.mounted) {
        _showSnack(context, successMessage);
      }
    } catch (error, stackTrace) {
      if (context.mounted) {
        _showPluginErrorLog(
          context,
          title: '安装失败',
          pluginId: assetPath,
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  Future<void> _activatePlugin(
    BuildContext context,
    WidgetRef ref,
    String pluginId,
  ) async {
    try {
      final manager = ref.read(pluginManagerProvider);
      await manager.ready;
      await manager.activate(pluginId);
      ref.read(pluginListProvider.notifier).state = manager.getAllPlugins();

      if (context.mounted) {
        _showSnack(context, '插件已激活');
      }
    } catch (error, stackTrace) {
      if (context.mounted) {
        _showPluginErrorLog(
          context,
          title: '激活失败',
          pluginId: pluginId,
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  Future<void> _openPluginPage(
    BuildContext context,
    WidgetRef ref, {
    required String pluginId,
    required String title,
  }) async {
    final manager = ref.read(pluginManagerProvider);
    if (!manager.isActivated(pluginId)) {
      _showSnack(context, '请先激活插件');
      return;
    }

    try {
      final renderer = PluginRenderer(manager);
      final widget = await renderer.renderPage(
        pluginId: pluginId,
        route: {'source': 'rss_reader'},
      );

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: Text(title)),
              body: widget,
            ),
          ),
        );
      }
    } catch (error, stackTrace) {
      if (context.mounted) {
        _showPluginErrorLog(
          context,
          title: '打开失败',
          pluginId: pluginId,
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  Future<void> _showPluginErrorLog(
    BuildContext context, {
    required String title,
    required String pluginId,
    required Object error,
    required StackTrace stackTrace,
  }) async {
    final log = [
      'Time: ${DateTime.now().toIso8601String()}',
      'Plugin: $pluginId',
      'Error: $error',
      '',
      'Stack trace:',
      stackTrace.toString(),
    ].join('\n');

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: 720,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 520),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: SelectableText(
                    log,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: log));
                if (dialogContext.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('错误日志已复制')));
                }
              },
              icon: const Icon(Icons.copy),
              label: const Text('复制日志'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('关闭'),
            ),
          ],
        );
      },
    );
  }

  void _showSnack(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }
}

class _SummaryPanel extends StatelessWidget {
  const _SummaryPanel({
    required this.installedCount,
    required this.activatedCount,
  });

  final int installedCount;
  final int activatedCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _Metric(
                label: '已安装',
                value: installedCount.toString(),
                icon: Icons.inventory_2_outlined,
              ),
            ),
            Container(
              width: 1,
              height: 48,
              color: theme.colorScheme.outlineVariant,
            ),
            Expanded(
              child: _Metric(
                label: '已激活',
                value: activatedCount.toString(),
                icon: Icons.verified_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(height: 8),
        Text(value, style: theme.textTheme.headlineSmall),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _PluginCard extends StatelessWidget {
  const _PluginCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.permissions,
    required this.plugin,
    required this.onInstall,
    required this.onActivate,
    required this.onOpen,
  });

  final String title;
  final String description;
  final IconData icon;
  final List<String> permissions;
  final PluginInfo? plugin;
  final VoidCallback onInstall;
  final VoidCallback onActivate;
  final VoidCallback onOpen;

  bool get _isInstalled => plugin != null;
  bool get _isActivated => plugin?.isActivated ?? false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(description, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: permissions
                            .map((permission) => Chip(label: Text(permission)))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: _isInstalled ? null : onInstall,
                  icon: const Icon(Icons.download_outlined),
                  label: Text(_isInstalled ? '已安装' : '安装'),
                ),
                OutlinedButton.icon(
                  onPressed: _isInstalled && !_isActivated ? onActivate : null,
                  icon: const Icon(Icons.play_arrow_outlined),
                  label: Text(_isActivated ? '已激活' : '激活'),
                ),
                OutlinedButton.icon(
                  onPressed: _isActivated ? onOpen : null,
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('打开'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CapabilityPanel extends StatelessWidget {
  const _CapabilityPanel({required this.plugins});

  final List<PluginInfo> plugins;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final capabilities =
        plugins
            .expand((plugin) => plugin.manifest.capabilities)
            .map((capability) => capability.id)
            .toSet()
            .toList()
          ..sort();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('已接入能力', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            if (capabilities.isEmpty)
              Text('安装插件后会在这里显示能力声明。', style: theme.textTheme.bodyMedium)
            else
              ...capabilities.map(
                (capability) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Icon(
                    Icons.extension_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(capability),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
