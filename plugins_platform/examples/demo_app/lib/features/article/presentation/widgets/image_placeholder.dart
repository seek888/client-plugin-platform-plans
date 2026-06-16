import 'package:flutter/material.dart';

/// 图片占位符类型
enum ImagePlaceholderType {
  /// 图片已隐藏（无图模式）
  hidden,

  /// 图片加载中
  loading,

  /// 图片加载失败
  error,

  /// 图片不可用
  unavailable,
}

/// 图片占位符组件
///
/// 用于在无图模式、加载中、加载失败等情况下显示占位符
class ImagePlaceholder extends StatelessWidget {
  /// 占位符类型
  final ImagePlaceholderType type;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 点击回调（用于重试加载）
  final VoidCallback? onTap;

  /// 自定义消息
  final String? message;

  const ImagePlaceholder({
    super.key,
    this.type = ImagePlaceholderType.hidden,
    this.width,
    this.height,
    this.onTap,
    this.message,
  });

  /// 创建隐藏图片占位符
  const ImagePlaceholder.hidden({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.message,
  }) : type = ImagePlaceholderType.hidden;

  /// 创建加载中占位符
  const ImagePlaceholder.loading({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.message,
  }) : type = ImagePlaceholderType.loading;

  /// 创建加载失败占位符
  const ImagePlaceholder.error({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.message,
  }) : type = ImagePlaceholderType.error;

  /// 创建不可用占位符
  const ImagePlaceholder.unavailable({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.message,
  }) : type = ImagePlaceholderType.unavailable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark ? Colors.grey[800] : Colors.grey[200];
    final iconColor = isDark ? Colors.grey[400] : Colors.grey[600];
    final textColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 120,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: _buildContent(iconColor, textColor),
      ),
    );
  }

  Widget _buildContent(Color? iconColor, Color? textColor) {
    switch (type) {
      case ImagePlaceholderType.hidden:
        return _buildHiddenContent(iconColor, textColor);
      case ImagePlaceholderType.loading:
        return _buildLoadingContent(iconColor, textColor);
      case ImagePlaceholderType.error:
        return _buildErrorContent(iconColor, textColor);
      case ImagePlaceholderType.unavailable:
        return _buildUnavailableContent(iconColor, textColor);
    }
  }

  Widget _buildHiddenContent(Color? iconColor, Color? textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.image_outlined, size: 32, color: iconColor),
        const SizedBox(height: 8),
        Text(
          message ?? '图片已隐藏',
          style: TextStyle(color: textColor, fontSize: 13),
        ),
        if (onTap != null) ...[
          const SizedBox(height: 4),
          Text(
            '点击加载',
            style: TextStyle(
              color: textColor?.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLoadingContent(Color? iconColor, Color? textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2, color: iconColor),
        ),
        const SizedBox(height: 8),
        Text(
          message ?? '加载中...',
          style: TextStyle(color: textColor, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildErrorContent(Color? iconColor, Color? textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.broken_image_outlined, size: 32, color: iconColor),
        const SizedBox(height: 8),
        Text(
          message ?? '图片加载失败',
          style: TextStyle(color: textColor, fontSize: 13),
        ),
        if (onTap != null) ...[
          const SizedBox(height: 4),
          Text(
            '点击重试',
            style: TextStyle(
              color: textColor?.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUnavailableContent(Color? iconColor, Color? textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.image_not_supported_outlined, size: 32, color: iconColor),
        const SizedBox(height: 8),
        Text(
          message ?? '图片不可用',
          style: TextStyle(color: textColor, fontSize: 13),
        ),
      ],
    );
  }
}

/// 无图模式提示横幅
class NoImageModeBanner extends StatelessWidget {
  /// 关闭回调
  final VoidCallback? onDismiss;

  /// 设置回调
  final VoidCallback? onSettings;

  const NoImageModeBanner({super.key, this.onDismiss, this.onSettings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: theme.colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '无图模式已开启',
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (onSettings != null)
            TextButton(
              onPressed: onSettings,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(0, 32),
              ),
              child: const Text('设置'),
            ),
          if (onDismiss != null)
            IconButton(
              onPressed: onDismiss,
              icon: const Icon(Icons.close, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
        ],
      ),
    );
  }
}
