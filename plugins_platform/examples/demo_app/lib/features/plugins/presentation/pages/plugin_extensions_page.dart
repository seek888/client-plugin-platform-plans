import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugins_platform/plugins_platform.dart';

class PluginExtensionsPage extends ConsumerStatefulWidget {
  const PluginExtensionsPage({super.key});

  static const _workCalendarPluginId = 'com.company.work_calendar';
  static const _workCalendarAssetPath = 'assets/plugins/work_calendar';

  @override
  ConsumerState<PluginExtensionsPage> createState() =>
      _PluginExtensionsPageState();
}

class _PluginExtensionsPageState extends ConsumerState<PluginExtensionsPage> {
  bool _isImportingPlugin = false;

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
    final importedPlugins = plugins
        .where(
          (plugin) =>
              plugin.manifest.id != PluginExtensionsPage._workCalendarPluginId,
        )
        .toList(growable: false);
    final activatedCount = plugins.where((plugin) => plugin.isActivated).length;

    return Scaffold(
      appBar: AppBar(title: const Text('插件扩展')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 360;
          final pagePadding = isNarrow ? 12.0 : 16.0;

          return ListView(
            padding: EdgeInsets.all(pagePadding),
            children: [
              _SummaryPanel(
                installedCount: plugins.length,
                activatedCount: activatedCount,
              ),
              const SizedBox(height: 12),
              _LocalPluginImportPanel(
                isImporting: _isImportingPlugin,
                onImport: () => _installPluginPackage(context, ref),
                onImportAndActivate: () => _installPluginPackage(
                  context,
                  ref,
                  activateAfterInstall: true,
                ),
              ),
              const SizedBox(height: 12),
              PluginLifecycleCard(
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
                onInstallAndActivate: () => _installAndActivateAssetPlugin(
                  context,
                  ref,
                  assetPath: PluginExtensionsPage._workCalendarAssetPath,
                  pluginId: PluginExtensionsPage._workCalendarPluginId,
                  title: '工作日历',
                ),
                onOpen: () => _openPluginPage(
                  context,
                  ref,
                  pluginId: PluginExtensionsPage._workCalendarPluginId,
                  title: '工作日历',
                ),
              ),
              for (final plugin in importedPlugins) ...[
                const SizedBox(height: 12),
                PluginLifecycleCard(
                  title: plugin.manifest.name,
                  description:
                      plugin.manifest.description ?? plugin.manifest.id,
                  icon: Icons.extension_outlined,
                  permissions: plugin.manifest.permissions,
                  plugin: plugin,
                  onInstall: () {},
                  onActivate: () =>
                      _activatePlugin(context, ref, plugin.manifest.id),
                  onInstallAndActivate: () {},
                  onOpen: () => _openPluginPage(
                    context,
                    ref,
                    pluginId: plugin.manifest.id,
                    title: plugin.manifest.name,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              _CapabilityPanel(plugins: plugins),
            ],
          );
        },
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

  Future<void> _installPluginPackage(
    BuildContext context,
    WidgetRef ref, {
    bool activateAfterInstall = false,
  }) async {
    if (_isImportingPlugin) return;
    setState(() => _isImportingPlugin = true);
    try {
      _showSnack(context, '请选择本地插件安装包');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['zip'],
        withData: false,
      );
      final path = result?.files.single.path;
      if (path == null) {
        if (context.mounted) {
          _showSnack(context, '已取消导入');
        }
        return;
      }

      final manager = ref.read(pluginManagerProvider);
      await manager.ready;
      final installer = PluginPackageInstaller(manager);
      final manifest = await installer.installFromFile(File(path));
      if (activateAfterInstall) {
        await manager.activate(manifest.id);
      }

      ref.read(pluginListProvider.notifier).state = manager.getAllPlugins();

      if (context.mounted) {
        _showSnack(
          context,
          activateAfterInstall
              ? '${manifest.name} 已安装并激活'
              : '${manifest.name} 已安装',
        );
      }
    } catch (error, stackTrace) {
      if (context.mounted) {
        _showPluginErrorLog(
          context,
          title: activateAfterInstall ? '安装并激活失败' : '安装失败',
          pluginId: 'local-plugin-package',
          error: error,
          stackTrace: stackTrace,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isImportingPlugin = false);
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

  Future<void> _installAndActivateAssetPlugin(
    BuildContext context,
    WidgetRef ref, {
    required String assetPath,
    required String pluginId,
    required String title,
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
      if (manager.getPluginInfo(pluginId) == null) {
        await manager.install(manifest, bundleSource: jsBundle);
      }
      await manager.activate(pluginId);
      ref.read(pluginListProvider.notifier).state = manager.getAllPlugins();

      if (context.mounted) {
        _showSnack(context, '$title 已安装并激活');
      }
    } catch (error, stackTrace) {
      if (context.mounted) {
        _showPluginErrorLog(
          context,
          title: '安装并激活失败',
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
        final size = MediaQuery.sizeOf(dialogContext);
        final dialogWidth = (size.width * 0.9).clamp(280.0, 720.0);
        final maxHeight = (size.height * 0.72).clamp(280.0, 520.0);

        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: dialogWidth,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PluginErrorSummary(error: error),
                    const SizedBox(height: 12),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.zero,
                      title: const Text('技术详情'),
                      subtitle: Text(
                        '用于排查插件 ID、错误类型和调用栈',
                        style: theme.textTheme.bodySmall,
                      ),
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SelectableText(
                              log,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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

class _LocalPluginImportPanel extends StatelessWidget {
  const _LocalPluginImportPanel({
    required this.isImporting,
    required this.onImport,
    required this.onImportAndActivate,
  });

  final bool isImporting;
  final VoidCallback onImport;
  final VoidCallback onImportAndActivate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 420;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.upload_file_outlined,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('本地导入插件', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text(
                            '选择本地 .zip 插件安装包，导入后可在下方管理。',
                            style: theme.textTheme.bodyMedium,
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
                      onPressed: isImporting ? null : onImportAndActivate,
                      icon: const Icon(Icons.flash_on_outlined),
                      label: Text(
                        isImporting
                            ? '导入中'
                            : isNarrow
                            ? '导入激活'
                            : '导入并激活',
                      ),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: isImporting ? null : onImport,
                      icon: const Icon(Icons.file_open_outlined),
                      label: const Text('导入'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
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

class PluginLifecycleCard extends StatelessWidget {
  const PluginLifecycleCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.permissions,
    required this.plugin,
    required this.onInstall,
    required this.onActivate,
    required this.onInstallAndActivate,
    required this.onOpen,
  });

  final String title;
  final String description;
  final IconData icon;
  final List<String> permissions;
  final PluginInfo? plugin;
  final VoidCallback onInstall;
  final VoidCallback onActivate;
  final VoidCallback onInstallAndActivate;
  final VoidCallback onOpen;

  bool get _isInstalled => plugin != null;
  bool get _isActivated => plugin?.isActivated ?? false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final statusColor = _isActivated
        ? theme.colorScheme.primary
        : _isInstalled
        ? theme.colorScheme.tertiary
        : theme.colorScheme.outline;
    final stepText = _isActivated
        ? '步骤 3/3 已可使用'
        : _isInstalled
        ? '步骤 2/3 等待激活'
        : '步骤 1/3 等待安装';

    return Card(
      margin: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 360;
          final padding = isNarrow ? 12.0 : 16.0;

          return Padding(
            padding: EdgeInsets.all(padding),
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
                          const SizedBox(height: 10),
                          _PluginStepIndicator(
                            isInstalled: _isInstalled,
                            isActivated: _isActivated,
                          ),
                          const SizedBox(height: 8),
                          Semantics(
                            label: stepText,
                            child: ExcludeSemantics(
                              child: Row(
                                children: [
                                  Icon(
                                    _isActivated
                                        ? Icons.check_circle_outline
                                        : _isInstalled
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    size: 16,
                                    color: statusColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      stepText,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: statusColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: permissions
                                .map(
                                  (permission) => Chip(label: Text(permission)),
                                )
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
                    if (!_isInstalled)
                      FilledButton.icon(
                        onPressed: onInstallAndActivate,
                        icon: const Icon(Icons.flash_on_outlined),
                        label: const Text('安装并激活'),
                      ),
                    FilledButton.tonalIcon(
                      onPressed: _isInstalled ? null : onInstall,
                      icon: const Icon(Icons.download_outlined),
                      label: Text(_isInstalled ? '已安装' : '安装'),
                    ),
                    _isInstalled && !_isActivated
                        ? FilledButton.icon(
                            onPressed: onActivate,
                            icon: const Icon(Icons.play_arrow_outlined),
                            label: const Text('激活'),
                          )
                        : OutlinedButton.icon(
                            onPressed: null,
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
          );
        },
      ),
    );
  }
}

class _PluginStepIndicator extends StatelessWidget {
  const _PluginStepIndicator({
    required this.isInstalled,
    required this.isActivated,
  });

  final bool isInstalled;
  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    final steps = [
      _PluginStepData('安装', isInstalled || isActivated),
      _PluginStepData('激活', isActivated),
      _PluginStepData('使用', isActivated),
    ];

    return MergeSemantics(
      child: Row(
        children: [
          for (var index = 0; index < steps.length; index++) ...[
            Flexible(
              child: _PluginStepChip(
                label: steps[index].label,
                isComplete: steps[index].isComplete,
                isCurrent:
                    !steps[index].isComplete &&
                    (index == 0 || steps[index - 1].isComplete),
              ),
            ),
            if (index < steps.length - 1) const SizedBox(width: 6),
          ],
        ],
      ),
    );
  }
}

class _PluginStepData {
  const _PluginStepData(this.label, this.isComplete);

  final String label;
  final bool isComplete;
}

class _PluginStepChip extends StatelessWidget {
  const _PluginStepChip({
    required this.label,
    required this.isComplete,
    required this.isCurrent,
  });

  final String label;
  final bool isComplete;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isComplete
        ? theme.colorScheme.primary
        : isCurrent
        ? theme.colorScheme.tertiary
        : theme.colorScheme.outline;

    return Container(
      constraints: const BoxConstraints(minHeight: 32),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isComplete || isCurrent
            ? color.withValues(alpha: 0.12)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isComplete ? Icons.check : Icons.circle_outlined,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: isCurrent || isComplete
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PluginErrorSummary extends StatelessWidget {
  const _PluginErrorSummary({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final guidance = _guidanceFor(error);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: theme.colorScheme.error),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('插件操作未完成', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(guidance, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _guidanceFor(Object error) {
    final message = error.toString().toLowerCase();
    if (message.contains('network') ||
        message.contains('socket') ||
        message.contains('connection')) {
      return '网络连接失败，请检查网络设置后重试。';
    }
    if (message.contains('signature') || message.contains('hash')) {
      return '插件包校验未通过，请重新安装或确认插件来源可信。';
    }
    if (message.contains('not found') || message.contains('bundle')) {
      return '插件资源不完整，请重新安装插件后再激活。';
    }
    if (message.contains('already exists')) {
      return '插件已安装，可以直接激活或打开。';
    }
    return '请稍后重试。若问题持续存在，可复制技术详情交给开发排查。';
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
