import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/features/article/domain/services/article_editor_service.dart';
import 'package:rss_reader/features/article/presentation/providers/article_editor_provider.dart';
import 'package:rss_reader/features/article/presentation/side_effects/article_editor_side_effect.dart';
import 'package:rss_reader/features/article/presentation/states/article_editor_state.dart';

part 'article_editor_notifier.g.dart';

/// 文章编辑器 Notifier
/// 负责管理文章编辑器的状态和业务逻辑
@riverpod
class ArticleEditorNotifier extends _$ArticleEditorNotifier {
  StreamController<ArticleEditorSideEffect>? _sideEffectController;
  bool _isDisposed = false;

  /// 获取编辑服务
  ArticleEditorService get _editorService =>
      ref.read(articleEditorServiceProvider);

  /// 获取或创建副作用控制器
  StreamController<ArticleEditorSideEffect> get _controller {
    _sideEffectController ??=
        StreamController<ArticleEditorSideEffect>.broadcast();
    return _sideEffectController!;
  }

  /// 副作用流
  Stream<ArticleEditorSideEffect> get sideEffect => _controller.stream;

  /// 安全地添加副作用事件
  void _addSideEffect(ArticleEditorSideEffect effect) {
    if (!_isDisposed &&
        _sideEffectController != null &&
        !_sideEffectController!.isClosed) {
      _sideEffectController!.add(effect);
    }
  }

  @override
  ArticleEditorState build(String articleId) {
    _isDisposed = false;

    // 确保创建新的控制器
    _sideEffectController =
        StreamController<ArticleEditorSideEffect>.broadcast();

    // 清理资源
    ref.onDispose(() {
      _isDisposed = true;
      _sideEffectController?.close();
      _sideEffectController = null;
    });

    // 初始加载
    _loadContent(articleId);

    return const ArticleEditorState.initial();
  }

  /// 加载文章内容
  Future<void> _loadContent(String articleId) async {
    state = const ArticleEditorState.loading();

    // 新建笔记场景
    final isNewNote = articleId.isEmpty;
    final hasEdited = isNewNote ? false : await _editorService.hasEditedVersion(articleId);
    final result = await _editorService.loadContent(articleId);

    result.fold(
      (failure) {
        state = ArticleEditorState.error(
          message: failure.userMessage,
          articleId: articleId,
        );
        _addSideEffect(ArticleEditorSideEffect.showLoadError(failure.userMessage));
      },
      (content) {
        state = ArticleEditorState.loaded(
          articleId: articleId,
          content: content,
          hasEditedVersion: hasEdited,
          isDirty: false,
          isSaving: false,
          isNewNote: isNewNote,
        );
      },
    );
  }

  /// Intent: 刷新内容
  Future<void> onRefresh() async {
    final currentState = state;
    if (currentState is! ArticleEditorLoaded) return;

    await _loadContent(currentState.articleId);
  }

  /// Intent: 标记内容已修改
  void onContentChanged(List<Map<String, dynamic>> newContent) {
    final currentState = state;
    if (currentState is! ArticleEditorLoaded) return;

    state = currentState.copyWith(
      content: newContent,
      isDirty: true,
    );
  }

  /// Intent: 保存内容
  Future<void> onSave() async {
    final currentState = state;
    if (currentState is! ArticleEditorLoaded) return;

    state = currentState.copyWith(isSaving: true);

    final result = await _editorService.saveContent(
      currentState.articleId,
      currentState.content,
    );

    result.fold(
      (failure) {
        state = currentState.copyWith(isSaving: false);
        _addSideEffect(ArticleEditorSideEffect.showSaveError(failure.userMessage));
      },
      (_) {
        state = currentState.copyWith(
          isSaving: false,
          isDirty: false,
          hasEditedVersion: true,
        );
        _addSideEffect(const ArticleEditorSideEffect.showSaveSuccess());
      },
    );
  }

  /// Intent: 丢弃更改
  Future<void> onDiscard() async {
    final currentState = state;
    if (currentState is! ArticleEditorLoaded) return;

    if (currentState.isDirty) {
      // 有未保存的更改，显示确认对话框
      _addSideEffect(const ArticleEditorSideEffect.showDiscardConfirmation());
    } else {
      // 没有更改，直接返回
      _addSideEffect(const ArticleEditorSideEffect.navigateBack());
    }
  }

  /// Intent: 确认丢弃更改
  Future<void> onConfirmDiscard() async {
    final currentState = state;
    if (currentState is! ArticleEditorLoaded) return;

    // 如果有已保存的编辑版本，删除它
    if (currentState.hasEditedVersion) {
      await _editorService.discardChanges(currentState.articleId);
    }

    _addSideEffect(const ArticleEditorSideEffect.navigateBack());
  }

  /// Intent: 取消操作（关闭对话框）
  void onCancelDiscard() {
    // 不做任何事，对话框会自动关闭
  }

  /// Intent: 返回（检查是否有未保存更改）
  void onBack() {
    final currentState = state;
    if (currentState is! ArticleEditorLoaded) {
      _addSideEffect(const ArticleEditorSideEffect.navigateBack());
      return;
    }

    if (currentState.isDirty) {
      _addSideEffect(const ArticleEditorSideEffect.showDiscardConfirmation());
    } else {
      _addSideEffect(const ArticleEditorSideEffect.navigateBack());
    }
  }

  /// Intent: 恢复原始内容
  Future<void> onRestoreOriginal() async {
    final currentState = state;
    if (currentState is! ArticleEditorLoaded) return;

    // 删除编辑版本
    await _editorService.discardChanges(currentState.articleId);

    // 重新加载原始内容
    await _loadContent(currentState.articleId);
  }
}

/// 副作用 Provider
@riverpod
Stream<ArticleEditorSideEffect> articleEditorSideEffect(
  Ref ref,
  String articleId,
) {
  return ref
      .watch(articleEditorNotifierProvider(articleId).notifier)
      .sideEffect;
}
