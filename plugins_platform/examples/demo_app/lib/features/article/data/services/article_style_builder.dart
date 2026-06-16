import 'package:flutter/material.dart';
import 'package:rss_reader/app/theme/colors.dart';

/// 文章内容样式构建器
///
/// 提供代码块、引用块、链接等元素的自定义样式
class ArticleStyleBuilder {
  /// 当前主题亮度
  final Brightness brightness;

  /// 字体大小
  final double fontSize;

  /// 行高
  final double lineHeight;

  /// 链接颜色
  final Color? linkColor;

  /// 代码块背景色
  final Color? codeBackgroundColor;

  /// 引用块边框色
  final Color? blockquoteBorderColor;

  ArticleStyleBuilder({
    required this.brightness,
    this.fontSize = 16.0,
    this.lineHeight = 1.6,
    this.linkColor,
    this.codeBackgroundColor,
    this.blockquoteBorderColor,
  });

  /// 从 BuildContext 创建样式构建器
  factory ArticleStyleBuilder.fromContext(
    BuildContext context, {
    double fontSize = 16.0,
    double lineHeight = 1.6,
    Color? linkColor,
    Color? codeBackgroundColor,
    Color? blockquoteBorderColor,
  }) {
    final theme = Theme.of(context);
    return ArticleStyleBuilder(
      brightness: theme.brightness,
      fontSize: fontSize,
      lineHeight: lineHeight,
      linkColor: linkColor ?? theme.colorScheme.primary,
      codeBackgroundColor:
          codeBackgroundColor ?? AppColors.codeBackground(theme.brightness),
      blockquoteBorderColor:
          blockquoteBorderColor ?? AppColors.blockquoteBorder,
    );
  }

  /// 获取有效的链接颜色
  Color get effectiveLinkColor => linkColor ?? AppColors.link;

  /// 获取有效的代码块背景色
  Color get effectiveCodeBackgroundColor =>
      codeBackgroundColor ?? AppColors.codeBackground(brightness);

  /// 获取有效的引用块边框色
  Color get effectiveBlockquoteBorderColor =>
      blockquoteBorderColor ?? AppColors.blockquoteBorder;

  /// 获取文本颜色
  Color get textColor =>
      brightness == Brightness.dark ? Colors.white : Colors.black87;

  /// 获取次要文本颜色
  Color get secondaryTextColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black54;

  /// 构建元素样式
  ///
  /// [localName] HTML 元素名称
  /// [parentName] 父元素名称（可选）
  /// 返回 CSS 样式映射
  Map<String, String>? buildStyles(String? localName, String? parentName) {
    if (localName == null) return null;

    switch (localName) {
      case 'pre':
        return _buildPreStyles();
      case 'code':
        return _buildCodeStyles(parentName);
      case 'blockquote':
        return _buildBlockquoteStyles();
      case 'a':
        return _buildLinkStyles();
      case 'img':
        return _buildImageStyles();
      case 'table':
        return _buildTableStyles();
      case 'th':
        return _buildTableHeaderStyles();
      case 'td':
        return _buildTableCellStyles();
      case 'h1':
        return _buildHeadingStyles(1.5, 24, 16);
      case 'h2':
        return _buildHeadingStyles(1.3, 20, 12);
      case 'h3':
        return _buildHeadingStyles(1.15, 16, 8);
      case 'h4':
        return _buildHeadingStyles(1.0, 12, 6);
      case 'h5':
        return _buildHeadingStyles(0.9, 10, 4);
      case 'h6':
        return _buildHeadingStyles(0.85, 8, 4);
      case 'p':
        return _buildParagraphStyles();
      case 'ul':
      case 'ol':
        return _buildListStyles();
      case 'li':
        return _buildListItemStyles();
      case 'hr':
        return _buildHorizontalRuleStyles();
      case 'figure':
        return _buildFigureStyles();
      case 'figcaption':
        return _buildFigcaptionStyles();
      default:
        return null;
    }
  }

  /// 代码块样式（pre 标签）
  Map<String, String> _buildPreStyles() {
    return {
      'background-color': _colorToHex(effectiveCodeBackgroundColor),
      'padding': '12px 16px',
      'border-radius': '8px',
      'overflow-x': 'auto',
      'margin': '16px 0',
      'font-family': 'monospace, Consolas, "Courier New", monospace',
      'font-size': '${fontSize * 0.9}px',
      'line-height': '1.5',
    };
  }

  /// 行内代码样式（code 标签）
  Map<String, String> _buildCodeStyles(String? parentName) {
    // 如果在 pre 标签内，不添加额外样式
    if (parentName == 'pre') {
      return {'font-family': 'monospace, Consolas, "Courier New", monospace'};
    }

    // 行内代码样式
    return {
      'background-color': _colorToHex(effectiveCodeBackgroundColor),
      'padding': '2px 6px',
      'border-radius': '4px',
      'font-family': 'monospace, Consolas, "Courier New", monospace',
      'font-size': '${fontSize * 0.9}px',
    };
  }

  /// 引用块样式
  Map<String, String> _buildBlockquoteStyles() {
    return {
      'border-left': '4px solid ${_colorToHex(effectiveBlockquoteBorderColor)}',
      'padding': '8px 16px',
      'margin': '16px 0',
      'background-color': brightness == Brightness.dark
          ? 'rgba(255, 255, 255, 0.05)'
          : 'rgba(0, 0, 0, 0.03)',
      'font-style': 'italic',
      'color': _colorToHex(secondaryTextColor),
    };
  }

  /// 链接样式
  Map<String, String> _buildLinkStyles() {
    return {
      'color': _colorToHex(effectiveLinkColor),
      'text-decoration': 'none',
    };
  }

  /// 图片样式
  Map<String, String> _buildImageStyles() {
    return {
      'max-width': '100%',
      'height': 'auto',
      'border-radius': '8px',
      'margin': '12px 0',
      'display': 'block',
    };
  }

  /// 表格样式
  Map<String, String> _buildTableStyles() {
    return {
      'border-collapse': 'collapse',
      'width': '100%',
      'margin': '16px 0',
      'overflow-x': 'auto',
    };
  }

  /// 表头单元格样式
  Map<String, String> _buildTableHeaderStyles() {
    return {
      'border': '1px solid ${brightness == Brightness.dark ? '#444' : '#ddd'}',
      'padding': '10px 12px',
      'background-color': brightness == Brightness.dark
          ? 'rgba(255, 255, 255, 0.1)'
          : 'rgba(0, 0, 0, 0.05)',
      'font-weight': 'bold',
      'text-align': 'left',
    };
  }

  /// 表格单元格样式
  Map<String, String> _buildTableCellStyles() {
    return {
      'border': '1px solid ${brightness == Brightness.dark ? '#444' : '#ddd'}',
      'padding': '8px 12px',
    };
  }

  /// 标题样式
  Map<String, String> _buildHeadingStyles(
    double sizeMultiplier,
    double marginTop,
    double marginBottom,
  ) {
    return {
      'font-size': '${fontSize * sizeMultiplier}px',
      'font-weight': 'bold',
      'margin': '${marginTop}px 0 ${marginBottom}px 0',
      'line-height': '1.3',
    };
  }

  /// 段落样式
  Map<String, String> _buildParagraphStyles() {
    return {'margin': '12px 0', 'line-height': '$lineHeight'};
  }

  /// 列表样式
  Map<String, String> _buildListStyles() {
    return {'margin': '12px 0', 'padding-left': '24px'};
  }

  /// 列表项样式
  Map<String, String> _buildListItemStyles() {
    return {'margin': '6px 0', 'line-height': '$lineHeight'};
  }

  /// 水平分隔线样式
  Map<String, String> _buildHorizontalRuleStyles() {
    return {
      'border': 'none',
      'border-top':
          '1px solid ${brightness == Brightness.dark ? '#444' : '#ddd'}',
      'margin': '24px 0',
    };
  }

  /// 图片容器样式
  Map<String, String> _buildFigureStyles() {
    return {'margin': '16px 0', 'text-align': 'center'};
  }

  /// 图片说明样式
  Map<String, String> _buildFigcaptionStyles() {
    return {
      'font-size': '${fontSize * 0.85}px',
      'color': _colorToHex(secondaryTextColor),
      'margin-top': '8px',
      'font-style': 'italic',
    };
  }

  /// 将 Color 转换为 CSS 十六进制颜色
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}

/// 代码块语法高亮主题
class CodeBlockTheme {
  /// 关键字颜色
  final Color keywordColor;

  /// 字符串颜色
  final Color stringColor;

  /// 注释颜色
  final Color commentColor;

  /// 数字颜色
  final Color numberColor;

  /// 函数颜色
  final Color functionColor;

  /// 类名颜色
  final Color classColor;

  const CodeBlockTheme({
    required this.keywordColor,
    required this.stringColor,
    required this.commentColor,
    required this.numberColor,
    required this.functionColor,
    required this.classColor,
  });

  /// 亮色主题
  static const CodeBlockTheme light = CodeBlockTheme(
    keywordColor: Color(0xFF0000FF),
    stringColor: Color(0xFFA31515),
    commentColor: Color(0xFF008000),
    numberColor: Color(0xFF098658),
    functionColor: Color(0xFF795E26),
    classColor: Color(0xFF267F99),
  );

  /// 暗色主题
  static const CodeBlockTheme dark = CodeBlockTheme(
    keywordColor: Color(0xFF569CD6),
    stringColor: Color(0xFFCE9178),
    commentColor: Color(0xFF6A9955),
    numberColor: Color(0xFFB5CEA8),
    functionColor: Color(0xFFDCDCAA),
    classColor: Color(0xFF4EC9B0),
  );

  /// 根据亮度获取主题
  static CodeBlockTheme fromBrightness(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }
}
