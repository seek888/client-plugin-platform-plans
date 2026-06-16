import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rss_reader/core/desktop/window_settings.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';
import 'package:window_manager/window_manager.dart';

/// 桌面端窗口管理服务
///
/// 负责：
/// - 初始化窗口
/// - 保存/恢复窗口位置和大小
/// - 监听窗口状态变化
/// - 最小化到托盘功能
class WindowManagerService with WindowListener {
  WindowManagerService._();

  static final WindowManagerService _instance = WindowManagerService._();
  static WindowManagerService get instance => _instance;

  /// 当前窗口设置
  WindowSettings _settings = WindowSettings.defaultSettings;

  /// 设置文件名
  static const String _settingsFileName = 'window_settings.json';

  /// 防抖定时器
  Timer? _saveDebounceTimer;

  /// 是否已初始化
  bool _initialized = false;

  /// 关闭时是否最小化到托盘
  bool _closeToTray = true;

  /// 关闭时的回调（用于最小化到托盘）
  void Function()? _onCloseToTray;

  /// 获取当前窗口设置
  WindowSettings get settings => _settings;

  /// 设置关闭时是否最小化到托盘
  set closeToTray(bool value) => _closeToTray = value;

  /// 设置关闭到托盘的回调
  set onCloseToTray(void Function()? callback) => _onCloseToTray = callback;

  /// 初始化窗口管理器
  Future<void> initialize() async {
    if (!PlatformUtils.isDesktop || _initialized) return;

    await windowManager.ensureInitialized();

    // 加载保存的设置
    await _loadSettings();

    // 配置窗口选项
    final windowOptions = WindowOptions(
      size: Size(_settings.width, _settings.height),
      minimumSize: const Size(
        WindowSettings.minWidth,
        WindowSettings.minHeight,
      ),
      center: !_settings.hasPosition,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      title: 'RSS Reader',
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      // 如果有保存的位置，恢复位置
      if (_settings.hasPosition) {
        await windowManager.setPosition(Offset(_settings.x!, _settings.y!));
      }

      // 恢复最大化/全屏状态
      if (_settings.isFullScreen) {
        await windowManager.setFullScreen(true);
      } else if (_settings.isMaximized) {
        await windowManager.maximize();
      }

      await windowManager.show();
      await windowManager.focus();
    });

    // 添加窗口监听器
    windowManager.addListener(this);

    // 设置关闭前拦截
    await windowManager.setPreventClose(true);

    _initialized = true;
  }

  /// 释放资源
  void dispose() {
    if (PlatformUtils.isDesktop) {
      windowManager.removeListener(this);
    }
    _saveDebounceTimer?.cancel();
  }

  /// 加载保存的窗口设置
  Future<void> _loadSettings() async {
    try {
      final file = await _getSettingsFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;
        _settings = WindowSettings.fromJson(json);
      }
    } catch (e) {
      // 加载失败时使用默认设置
      debugPrint('Failed to load window settings: $e');
      _settings = WindowSettings.defaultSettings;
    }
  }

  /// 保存窗口设置
  Future<void> _saveSettings() async {
    try {
      final file = await _getSettingsFile();
      final json = jsonEncode(_settings.toJson());
      await file.writeAsString(json);
    } catch (e) {
      debugPrint('Failed to save window settings: $e');
    }
  }

  /// 防抖保存设置
  void _debounceSaveSettings() {
    _saveDebounceTimer?.cancel();
    _saveDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      _saveSettings();
    });
  }

  /// 获取设置文件
  Future<File> _getSettingsFile() async {
    final directory = await getApplicationSupportDirectory();
    return File('${directory.path}/$_settingsFileName');
  }

  /// 更新窗口设置
  Future<void> _updateSettings() async {
    if (!_initialized) return;

    final isMaximized = await windowManager.isMaximized();
    final isFullScreen = await windowManager.isFullScreen();

    // 只有在非最大化/全屏状态下才保存位置和大小
    if (!isMaximized && !isFullScreen) {
      final size = await windowManager.getSize();
      final position = await windowManager.getPosition();

      _settings = _settings.copyWith(
        width: size.width,
        height: size.height,
        x: position.dx,
        y: position.dy,
        isMaximized: false,
        isFullScreen: false,
      );
    } else {
      _settings = _settings.copyWith(
        isMaximized: isMaximized,
        isFullScreen: isFullScreen,
      );
    }

    _debounceSaveSettings();
  }

  // WindowListener 回调

  @override
  void onWindowResized() {
    _updateSettings();
  }

  @override
  void onWindowMoved() {
    _updateSettings();
  }

  @override
  void onWindowMaximize() {
    _settings = _settings.copyWith(isMaximized: true);
    _debounceSaveSettings();
  }

  @override
  void onWindowUnmaximize() {
    _settings = _settings.copyWith(isMaximized: false);
    _updateSettings();
  }

  @override
  void onWindowEnterFullScreen() {
    _settings = _settings.copyWith(isFullScreen: true);
    _debounceSaveSettings();
  }

  @override
  void onWindowLeaveFullScreen() {
    _settings = _settings.copyWith(isFullScreen: false);
    _updateSettings();
  }

  @override
  void onWindowClose() {
    // 关闭前立即保存设置
    _saveDebounceTimer?.cancel();
    _saveSettings();

    // 如果启用了关闭到托盘，则隐藏窗口而不是关闭
    if (_closeToTray && _onCloseToTray != null) {
      _onCloseToTray!();
    } else {
      // 真正关闭应用
      windowManager.destroy();
    }
  }

  /// 最小化到托盘
  /// Requirements: 4.1
  Future<void> minimizeToTray() async {
    try {
      await windowManager.hide();
    } catch (e) {
      debugPrint('Failed to minimize to tray: $e');
    }
  }

  /// 强制关闭应用（不最小化到托盘）
  Future<void> forceClose() async {
    _closeToTray = false;
    await windowManager.destroy();
  }

  @override
  void onWindowFocus() {}

  @override
  void onWindowBlur() {}

  @override
  void onWindowMinimize() {}

  @override
  void onWindowRestore() {}

  @override
  void onWindowEvent(String eventName) {}

  @override
  void onWindowDocked() {}

  @override
  void onWindowUndocked() {}
}
