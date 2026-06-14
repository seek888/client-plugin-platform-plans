/// STAC 更新类型
///
/// 用于 UI 局部更新
enum STACUpdateType {
  /// 全量替换
  full,

  /// 局部更新（JSON Patch）
  patch,

  /// 不更新
  none,
}

/// STAC 更新指令
///
/// 从 JS 返回的更新指令
class STACUpdate {
  /// 更新类型
  final STACUpdateType type;

  /// 完整的 Schema（type == full 时使用）
  final Map<String, dynamic>? schema;

  /// JSON Patch 操作列表（type == patch 时使用）
  final List<STACPatchOp>? patches;

  const STACUpdate({
    required this.type,
    this.schema,
    this.patches,
  });

  /// 创建全量更新
  factory STACUpdate.full(Map<String, dynamic> schema) {
    return STACUpdate(
      type: STACUpdateType.full,
      schema: schema,
    );
  }

  /// 创建局部更新
  factory STACUpdate.patch(List<STACPatchOp> patches) {
    return STACUpdate(
      type: STACUpdateType.patch,
      patches: patches,
    );
  }

  /// 创建无更新
  factory STACUpdate.none() {
    return const STACUpdate(type: STACUpdateType.none);
  }

  /// 从 JS 返回值解析
  factory STACUpdate.fromJsResult(dynamic result) {
    if (result == null) {
      return STACUpdate.none();
    }

    if (result is Map<String, dynamic>) {
      // 检查是否是更新指令
      final type = result['type'] as String?;
      if (type == 'full') {
        final schema = result['schema'] as Map<String, dynamic>?;
        if (schema != null) {
          return STACUpdate.full(schema);
        }
      } else if (type == 'patch') {
        final patchesData = result['patches'] as List<dynamic>?;
        if (patchesData != null) {
          final patches = patchesData
              .map((e) => STACPatchOp.fromJson(e as Map<String, dynamic>))
              .toList();
          return STACUpdate.patch(patches);
        }
      }

      // 默认作为全量更新
      return STACUpdate.full(result);
    }

    // 其他情况返回无更新
    return STACUpdate.none();
  }
}

/// JSON Patch 操作
///
/// 参考 RFC 6902: https://tools.ietf.org/html/rfc6902
class STACPatchOp {
  /// 操作类型：add/remove/replace/move/copy/test
  final String op;

  /// JSON Pointer 路径
  final String path;

  /// 目标路径（move/copy 操作使用）
  final String? from;

  /// 值（add/replace/test 操作使用）
  dynamic value;

  STACPatchOp({
    required this.op,
    required this.path,
    this.from,
    this.value,
  });

  factory STACPatchOp.fromJson(Map<String, dynamic> json) {
    return STACPatchOp(
      op: json['op'] as String,
      path: json['path'] as String,
      from: json['from'] as String?,
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'op': op,
      'path': path,
      if (from != null) 'from': from,
      if (value != null) 'value': value,
    };
  }
}

/// 创建 replace 操作
STACPatchOp replace(String path, dynamic value) {
  return STACPatchOp(op: 'replace', path: path, value: value);
}

/// 创建 add 操作
STACPatchOp add(String path, dynamic value) {
  return STACPatchOp(op: 'add', path: path, value: value);
}

/// 创建 remove 操作
STACPatchOp remove(String path) {
  return STACPatchOp(op: 'remove', path: path);
}
