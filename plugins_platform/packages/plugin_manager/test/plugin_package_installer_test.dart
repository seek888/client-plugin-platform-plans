import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:core/core.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:host_bridge/host_bridge.dart';
import 'package:plugin_manager/plugin_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('plugin-package-test-');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (call) async {
        if (call.method == 'getApplicationDocumentsDirectory') {
          return tempDir.path;
        }
        return null;
      },
    );
  });

  tearDown(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      null,
    );
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('installs a standalone zip plugin package', () async {
    const bundleSource = 'function onActivate() {}';
    final manifest = _manifest(bundleSource);
    final archiveBytes = _zip({
      'manifest.json': jsonEncode(manifest.toJson()),
      'dist/bundle.js': bundleSource,
    });
    final manager = PluginManager(
      engine: _FakeJSEngine(),
      bridge: HostBridge(),
    );
    final installer = PluginPackageInstaller(manager);

    final installed = await installer.installFromBytes(archiveBytes);

    expect(installed.id, 'com.example.package_plugin');
    expect(manager.isInstalled(installed.id), isTrue);
    expect(
      File('${tempDir.path}/plugins/${installed.id}/bundle.js')
          .readAsStringSync(),
      bundleSource,
    );
  });

  test('rejects packages missing the manifest bundle file', () async {
    const bundleSource = 'function onActivate() {}';
    final archiveBytes = _zip({
      'manifest.json': jsonEncode(_manifest(bundleSource).toJson()),
    });
    final manager = PluginManager(
      engine: _FakeJSEngine(),
      bridge: HostBridge(),
    );
    final installer = PluginPackageInstaller(manager);

    expect(
      () => installer.installFromBytes(archiveBytes),
      throwsA(isA<PluginPackageInstallException>()),
    );
  });
}

PluginManifest _manifest(String bundleSource) {
  return PluginManifest(
    id: 'com.example.package_plugin',
    name: 'Package Plugin',
    version: '1.0.0',
    publisher: 'test',
    type: PluginType.js,
    platforms: const ['ios', 'android', 'macos', 'windows', 'linux'],
    minHostVersion: '1.0.0',
    engine: EngineConfig(
      runtime: 'quickjs',
      bundle: 'dist/bundle.js',
      bundleHash: sha256.convert(utf8.encode(bundleSource)).toString(),
    ),
  );
}

List<int> _zip(Map<String, String> files) {
  final archive = Archive();
  for (final entry in files.entries) {
    final bytes = utf8.encode(entry.value);
    archive.addFile(ArchiveFile(entry.key, bytes.length, bytes));
  }
  return ZipEncoder().encode(archive);
}

class _FakeJSEngine implements JSEngine {
  @override
  JSRuntime createRuntime({
    String? pluginId,
    int memoryLimitBytes = 16 * 1024 * 1024,
    Duration? executionTimeout,
  }) {
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  void registerHostHandler(String method, HostHandler handler) {}
}
