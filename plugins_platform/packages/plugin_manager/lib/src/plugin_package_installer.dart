import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:core/core.dart';

import 'plugin_manager.dart';

/// Installs standalone plugin packages produced as zip archives.
///
/// A valid package contains a root-level `manifest.json` and the JS bundle path
/// declared by `manifest.engine.bundle`, for example `dist/bundle.js`.
class PluginPackageInstaller {
  final PluginManager _pluginManager;

  const PluginPackageInstaller(this._pluginManager);

  Future<PluginManifest> installFromFile(File packageFile) async {
    if (!packageFile.existsSync()) {
      throw PluginPackageInstallException(
        'Plugin package does not exist: ${packageFile.path}',
      );
    }

    final bytes = await packageFile.readAsBytes();
    return installFromBytes(bytes, sourceName: packageFile.path);
  }

  Future<PluginManifest> installFromBytes(
    List<int> bytes, {
    String sourceName = 'plugin package',
  }) async {
    final archive = _decodeArchive(bytes, sourceName);
    final manifestEntry = _findRequiredFile(archive, 'manifest.json');
    final manifestJson = utf8.decode(manifestEntry.content as List<int>);
    final manifest = PluginManifest.fromJson(
      jsonDecode(manifestJson) as Map<String, dynamic>,
    );

    if (manifest.type != PluginType.js) {
      throw PluginPackageInstallException(
        'Only JS plugin packages are supported: ${manifest.id}',
      );
    }

    final bundlePath = manifest.engine?.bundle;
    if (bundlePath == null || bundlePath.isEmpty) {
      throw PluginPackageInstallException(
        'Missing engine.bundle in manifest: ${manifest.id}',
      );
    }

    final bundleEntry = _findRequiredFile(archive, bundlePath);
    final bundleSource = utf8.decode(bundleEntry.content as List<int>);

    await _pluginManager.ready;
    await _pluginManager.install(manifest, bundleSource: bundleSource);
    return manifest;
  }

  Archive _decodeArchive(List<int> bytes, String sourceName) {
    try {
      return ZipDecoder().decodeBytes(bytes);
    } catch (error) {
      throw PluginPackageInstallException(
        'Invalid plugin package archive: $sourceName',
        cause: error,
      );
    }
  }

  ArchiveFile _findRequiredFile(Archive archive, String path) {
    final normalizedPath = _normalizePath(path);
    for (final file in archive.files) {
      if (!file.isFile) continue;
      if (_normalizePath(file.name) == normalizedPath) {
        return file;
      }
    }
    throw PluginPackageInstallException(
      'Plugin package is missing required file: $path',
    );
  }

  String _normalizePath(String path) =>
      path.replaceAll('\\', '/').replaceFirst(RegExp(r'^\./+'), '');
}

class PluginPackageInstallException implements Exception {
  final String message;
  final Object? cause;

  const PluginPackageInstallException(this.message, {this.cause});

  @override
  String toString() =>
      'PluginPackageInstallException: $message${cause == null ? '' : ' ($cause)'}';
}
