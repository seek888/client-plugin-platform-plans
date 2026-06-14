import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:plugins_platform/plugins_platform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        hostBridgeProvider.overrideWithValue(
          HostBridge(navigatorKey: _navigatorKey),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Plugins Platform Demo - Complete',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plugins = ref.watch(pluginListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('插件平台演示'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () => _showPluginList(context, ref, plugins),
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 标题
            Text(
              '跨端插件平台演示',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),

            // 插件状态卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '插件状态',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(
                          label: '已安装',
                          value: plugins.length.toString(),
                          icon: Icons.archive,
                        ),
                        _StatItem(
                          label: '已激活',
                          value: plugins
                              .where((p) => p.isActivated)
                              .length
                              .toString(),
                          icon: Icons.check_circle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Demo 插件
            _PluginSection(
              title: 'Demo 插件',
              description: '展示基础功能的示例插件',
              onInstall: () => _installDemoPlugin(context, ref),
              onActivate: () => _activateDemoPlugin(context, ref),
              onRender: () => _showPluginPage(context, ref),
              isInstalled:
                  plugins.any((p) => p.manifest.id == 'com.example.demo'),
              isActivated: plugins.any(
                  (p) => p.manifest.id == 'com.example.demo' && p.isActivated),
            ),

            const SizedBox(height: 8),

            // 工作日历插件
            _PluginSection(
              title: '📅 工作日历插件',
              description: '集成日程管理、会议安排、审批提醒',
              onInstall: () => _installWorkCalendarPlugin(context, ref),
              onActivate: () => _activateWorkCalendarPlugin(context, ref),
              onRender: () => _showWorkCalendarPage(context, ref),
              isInstalled: plugins
                  .any((p) => p.manifest.id == 'com.company.work_calendar'),
              isActivated: plugins.any((p) =>
                  p.manifest.id == 'com.company.work_calendar' &&
                  p.isActivated),
            ),

            const SizedBox(height: 24),

            // 说明文本
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '已实现功能：\n'
                  '• Phase 1: JS 引擎运行时 + 基础设施\n'
                  '• Phase 2: STAC SDUI + JS 插件 MVP\n'
                  '• Phase 3: 能力扩展 + 事件体系\n'
                  '• Phase 4: 开发者平台（SDK/模板）\n'
                  '• Phase 5: 高级特性（增量更新/协作/监控）',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPluginList(
      BuildContext context, WidgetRef ref, List<PluginInfo> plugins) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('插件列表'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: plugins.length,
            itemBuilder: (context, index) {
              final plugin = plugins[index];
              return ListTile(
                title: Text(plugin.manifest.name),
                subtitle:
                    Text('v${plugin.manifest.version} - ${plugin.state.name}'),
                trailing: plugin.isActivated
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.circle_outlined),
                onTap: () => _showPluginDetail(context, plugin),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showPluginDetail(BuildContext context, PluginInfo plugin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(plugin.manifest.name),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoRow('ID', plugin.manifest.id),
              _InfoRow('版本', plugin.manifest.version),
              _InfoRow('状态', plugin.state.name),
              _InfoRow('发布者', plugin.manifest.publisher),
              if (plugin.manifest.description != null)
                _InfoRow('描述', plugin.manifest.description!),
              const SizedBox(height: 8),
              const Text('权限:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...plugin.manifest.permissions.map((p) => Text('  • $p')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  // ===== Demo 插件 =====

  Future<void> _installDemoPlugin(BuildContext context, WidgetRef ref) async {
    try {
      const manifest = PluginManifest(
        id: 'com.example.demo',
        name: 'Demo Plugin',
        description: '演示 STAC 渲染和事件处理的插件',
        version: '2.0.0',
        publisher: 'example',
        type: PluginType.js,
        platforms: ['ios', 'android', 'windows', 'macos', 'linux'],
        minHostVersion: '1.0.0',
        engine: EngineConfig(
          runtime: 'quickjs',
          bundle: 'https://example.com/demo/bundle.js',
          bundleHash: '',
        ),
        activationEvents: ['onCommand:demo.open', 'onTestEvent'],
        permissions: ['storage.local', 'toast.show'],
        capabilities: [
          CapabilityConfig(id: 'demo.getData', type: 'data'),
        ],
        stac: STACConfig(
          schemaVersion: '1.0',
          components: ['text', 'button', 'form', 'list'],
        ),
      );

      const jsBundle = '''
        // Demo 插件
        let counter = 0;

        export function onActivate(context) {
          console.log('Demo plugin activated');
        }

        export function onDeactivate() {
          console.log('Demo plugin deactivated');
        }

        export function renderPage(route) {
          return {
            schemaVersion: '1.0',
            type: 'page',
            title: 'Demo 插件',
            layout: { type: 'column', padding: '16,16,16,16' },
            children: [
              {
                type: 'text',
                props: { text: '欢迎来到 Demo 插件！' },
                style: { fontSize: 18 }
              },
              {
                type: 'card',
                children: [
                  {
                    type: 'text',
                    props: { text: '计数器: ' + counter },
                    style: { fontSize: 16 }
                  },
                  {
                    type: 'row',
                    children: [
                      { type: 'button', id: 'btnDec', props: { text: '-' }, events: { onTap: 'handleDec' } },
                      { type: 'sizedBox', props: { width: 16 } },
                      { type: 'button', id: 'btnInc', props: { text: '+' }, events: { onTap: 'handleInc' } }
                    ]
                  }
                ]
              },
              {
                type: 'textFormField',
                id: 'inputField',
                props: { label: '输入消息', hint: '请输入' }
              },
              {
                type: 'button',
                id: 'btnSubmit',
                props: { text: '提交' },
                events: { onTap: 'handleSubmit' },
                style: { marginTop: 16 }
              }
            ]
          };
        }

        export function handleInc(state, context) {
          counter++;
          return {
            type: 'patch',
            patches: [
              { op: 'replace', path: '/children/1/children/0/props/text', value: '计数器: ' + counter }
            ]
          };
        }

        export function handleDec(state, context) {
          counter--;
          return {
            type: 'patch',
            patches: [
              { op: 'replace', path: '/children/1/children/0/props/text', value: '计数器: ' + counter }
            ]
          };
        }

        export function handleSubmit(state, context) {
          const input = state.form?.inputField;
          context.invokeHost('toast.show', { message: '提交成功！' });
          context.invokeHost('dialog.alert', { title: '成功', message: '你输入了: ' + input });
        }
      ''';

      final manager = ref.read(pluginManagerProvider);
      await manager.install(manifest, bundleSource: jsBundle);

      ref.read(pluginListProvider.notifier).state = manager.getAllPlugins();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Demo plugin installed')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to install: $e')),
        );
      }
    }
  }

  Future<void> _activateDemoPlugin(BuildContext context, WidgetRef ref) async {
    try {
      final manager = ref.read(pluginManagerProvider);
      await manager.activate('com.example.demo');

      ref.read(pluginListProvider.notifier).state = manager.getAllPlugins();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Demo plugin activated')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to activate: $e')),
        );
      }
    }
  }

  Future<void> _showPluginPage(BuildContext context, WidgetRef ref) async {
    final manager = ref.read(pluginManagerProvider);
    final renderer = PluginRenderer(manager);

    if (!manager.isActivated('com.example.demo')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please activate demo plugin first')),
      );
      return;
    }

    try {
      final widget = await renderer.renderPage(
        pluginId: 'com.example.demo',
        route: {'source': 'home'},
        onUpdate: (update) {
          // 处理更新
        },
      );

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Demo 插件页面'),
              ),
              body: widget,
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to render: $e')),
        );
      }
    }
  }

  // ===== 工作日历插件 =====

  Future<void> _installWorkCalendarPlugin(
      BuildContext context, WidgetRef ref) async {
    try {
      debugPrint('[WorkCalendar] install: start');
      const pluginAssetPath = 'assets/plugins/work_calendar';
      final manifestJson = await rootBundle.loadString(
        '$pluginAssetPath/manifest.json',
      );
      final jsBundle = await rootBundle.loadString(
        '$pluginAssetPath/dist/bundle.js',
      );
      debugPrint(
        '[WorkCalendar] install: package loaded, bundleLength=${jsBundle.length}',
      );

      final manifest = PluginManifest.fromJson(
        jsonDecode(manifestJson) as Map<String, dynamic>,
      );

      final manager = ref.read(pluginManagerProvider);
      debugPrint(
        '[WorkCalendar] install: before install, plugins=${manager.getAllPlugins().map((p) => '${p.manifest.id}:${p.state.name}').join(', ')}',
      );
      await manager.install(manifest, bundleSource: jsBundle);
      debugPrint('[WorkCalendar] install: manager.install completed');

      ref.read(pluginListProvider.notifier).state = manager.getAllPlugins();
      debugPrint(
        '[WorkCalendar] install: list refreshed, count=${manager.getAllPlugins().length}',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('工作日历插件 installed'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('[WorkCalendar] install: failed');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to install: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _activateWorkCalendarPlugin(
      BuildContext context, WidgetRef ref) async {
    try {
      debugPrint('[WorkCalendar] activate: start');
      final manager = ref.read(pluginManagerProvider);
      debugPrint(
        '[WorkCalendar] activate: before activate, plugins=${manager.getAllPlugins().map((p) => '${p.manifest.id}:${p.state.name}').join(', ')}',
      );
      await manager.activate('com.company.work_calendar');
      debugPrint('[WorkCalendar] activate: manager.activate completed');

      ref.read(pluginListProvider.notifier).state = manager.getAllPlugins();
      debugPrint(
        '[WorkCalendar] activate: list refreshed, count=${manager.getAllPlugins().length}',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('工作日历插件 activated'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('[WorkCalendar] activate: failed');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to activate: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showWorkCalendarPage(
      BuildContext context, WidgetRef ref) async {
    final manager = ref.read(pluginManagerProvider);
    final renderer = PluginRenderer(manager);

    if (!manager.isActivated('com.company.work_calendar')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please activate work calendar plugin first')),
      );
      return;
    }

    try {
      final widget = await renderer.renderPage(
        pluginId: 'com.company.work_calendar',
        route: {'source': 'home'},
        onUpdate: (update) {
          // 处理更新
        },
      );

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('📅 工作日历'),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              body: widget,
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to render: $e')),
        );
      }
    }
  }
}

class _PluginSection extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onInstall;
  final VoidCallback onActivate;
  final VoidCallback onRender;
  final bool isInstalled;
  final bool isActivated;

  const _PluginSection({
    required this.title,
    required this.description,
    required this.onInstall,
    required this.onActivate,
    required this.onRender,
    this.isInstalled = false,
    this.isActivated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isActivated ? Icons.check_circle : Icons.circle_outlined,
                  color: isActivated ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall,
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
                ElevatedButton.icon(
                  onPressed: isInstalled ? null : onInstall,
                  icon: const Icon(Icons.download),
                  label: Text(isInstalled ? '已安装' : '安装'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInstalled ? Colors.grey : Colors.blue,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: isInstalled && !isActivated ? onActivate : null,
                  icon: const Icon(Icons.play_arrow),
                  label: Text(isActivated ? '已激活' : '激活'),
                ),
                OutlinedButton.icon(
                  onPressed: isActivated ? onRender : null,
                  icon: const Icon(Icons.visibility),
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

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text('$label:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
