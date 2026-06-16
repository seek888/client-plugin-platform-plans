import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:rss_reader/core/utils/platform_utils.dart';

/// 文章编辑器工具栏
class ArticleEditorToolbar extends StatelessWidget {
  final QuillController controller;
  final VoidCallback? onSave;
  final VoidCallback? onDiscard;
  final bool isSaving;
  final bool isDirty;

  const ArticleEditorToolbar({
    super.key,
    required this.controller,
    this.onSave,
    this.onDiscard,
    this.isSaving = false,
    this.isDirty = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = PlatformUtils.isDesktop;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 操作按钮栏
        _buildActionBar(context),
        const Divider(height: 1),
        // 格式化工具栏
        _buildFormattingToolbar(context, isDesktop),
      ],
    );
  }

  /// 构建操作按钮栏
  Widget _buildActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          // 返回/取消按钮
          TextButton.icon(
            onPressed: onDiscard,
            icon: const Icon(Icons.close),
            label: const Text('取消'),
          ),
          const Spacer(),
          // 保存状态指示
          if (isDirty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '未保存',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          const SizedBox(width: 8),
          // 保存按钮
          FilledButton.icon(
            onPressed: isSaving ? null : onSave,
            icon: isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            label: Text(isSaving ? '保存中...' : '保存'),
          ),
        ],
      ),
    );
  }

  /// 构建格式化工具栏
  Widget _buildFormattingToolbar(BuildContext context, bool isDesktop) {
    if (isDesktop) {
      return _buildDesktopToolbar(context);
    } else {
      return _buildMobileToolbar(context);
    }
  }

  /// 桌面端工具栏 - 完整功能
  Widget _buildDesktopToolbar(BuildContext context) {
    return QuillToolbar.simple(
      controller: controller,
      configurations: const QuillSimpleToolbarConfigurations(
        showAlignmentButtons: true,
        showBackgroundColorButton: false,
        showBoldButton: true,
        showCenterAlignment: true,
        showClearFormat: true,
        showCodeBlock: true,
        showColorButton: false,
        showDirection: false,
        showDividers: true,
        showFontFamily: false,
        showFontSize: false,
        showHeaderStyle: true,
        showIndent: true,
        showInlineCode: true,
        showItalicButton: true,
        showJustifyAlignment: false,
        showLeftAlignment: true,
        showLink: true,
        showListBullets: true,
        showListCheck: true,
        showListNumbers: true,
        showQuote: true,
        showRedo: true,
        showRightAlignment: true,
        showSearchButton: false,
        showSmallButton: false,
        showStrikeThrough: true,
        showSubscript: false,
        showSuperscript: false,
        showUnderLineButton: true,
        showUndo: true,
      ),
    );
  }

  /// 移动端工具栏 - 精简功能
  Widget _buildMobileToolbar(BuildContext context) {
    return QuillToolbar.simple(
      controller: controller,
      configurations: const QuillSimpleToolbarConfigurations(
        showAlignmentButtons: false,
        showBackgroundColorButton: false,
        showBoldButton: true,
        showCenterAlignment: false,
        showClearFormat: true,
        showCodeBlock: false,
        showColorButton: false,
        showDirection: false,
        showDividers: true,
        showFontFamily: false,
        showFontSize: false,
        showHeaderStyle: true,
        showIndent: false,
        showInlineCode: false,
        showItalicButton: true,
        showJustifyAlignment: false,
        showLeftAlignment: false,
        showLink: true,
        showListBullets: true,
        showListCheck: false,
        showListNumbers: true,
        showQuote: true,
        showRedo: true,
        showRightAlignment: false,
        showSearchButton: false,
        showSmallButton: false,
        showStrikeThrough: true,
        showSubscript: false,
        showSuperscript: false,
        showUnderLineButton: true,
        showUndo: true,
        multiRowsDisplay: false,
      ),
    );
  }
}
