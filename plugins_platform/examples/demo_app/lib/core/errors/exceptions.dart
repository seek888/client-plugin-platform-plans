/// 网络异常
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final String? url;

  const NetworkException({required this.message, this.statusCode, this.url});

  @override
  String toString() =>
      'NetworkException: $message (statusCode: $statusCode, url: $url)';
}

/// 解析异常
class ParseException implements Exception {
  final String message;
  final String? source;
  final String? details;

  const ParseException({required this.message, this.source, this.details});

  @override
  String toString() => 'ParseException: $message (source: $source)';
}

/// 缓存异常
class CacheException implements Exception {
  final String message;
  final String? key;

  const CacheException({required this.message, this.key});

  @override
  String toString() => 'CacheException: $message (key: $key)';
}

/// 数据库异常
class DatabaseException implements Exception {
  final String message;
  final String? table;
  final String? operation;

  const DatabaseException({required this.message, this.table, this.operation});

  @override
  String toString() =>
      'DatabaseException: $message (table: $table, operation: $operation)';
}

/// 验证异常
class ValidationException implements Exception {
  final String message;
  final String? field;
  final dynamic value;

  const ValidationException({required this.message, this.field, this.value});

  @override
  String toString() => 'ValidationException: $message (field: $field)';
}

/// 同步异常
class SyncException implements Exception {
  final String message;
  final String? syncType;

  const SyncException({required this.message, this.syncType});

  @override
  String toString() => 'SyncException: $message (syncType: $syncType)';
}

/// 文件异常
class FileException implements Exception {
  final String message;
  final String? path;
  final String? operation;

  const FileException({required this.message, this.path, this.operation});

  @override
  String toString() =>
      'FileException: $message (path: $path, operation: $operation)';
}
