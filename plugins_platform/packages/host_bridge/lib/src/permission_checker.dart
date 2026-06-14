import 'package:core/core.dart';

/// 权限检查器实现
///
/// 检查插件是否具有执行某个能力的权限
class PermissionCheckerImpl implements PermissionChecker {
  @override
  bool check({
    required List<String> pluginPermissions,
    required List<String> requiredPermissions,
  }) {
    // 如果能力不需要权限，直接通过
    if (requiredPermissions.isEmpty) {
      return true;
    }

    // 检查插件是否拥有所有必需的权限
    for (final permission in requiredPermissions) {
      if (!pluginPermissions.contains(permission)) {
        return false;
      }
    }

    return true;
  }
}
