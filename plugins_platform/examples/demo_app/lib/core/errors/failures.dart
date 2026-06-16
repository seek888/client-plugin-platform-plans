import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// 失败基类 - 使用 Freezed 实现不可变性
@freezed
sealed class Failure with _$Failure {
  const Failure._();

  /// 网络错误
  const factory Failure.network({
    required String message,
    int? statusCode,
    String? url,
  }) = NetworkFailure;

  /// 解析错误
  const factory Failure.parse({
    required String message,
    String? source,
    String? details,
  }) = ParseFailure;

  /// 缓存错误
  const factory Failure.cache({required String message, String? key}) =
      CacheFailure;

  /// 数据库错误
  const factory Failure.database({
    required String message,
    String? table,
    String? operation,
  }) = DatabaseFailure;

  /// 验证错误
  const factory Failure.validation({
    required String message,
    String? field,
    dynamic value,
  }) = ValidationFailure;

  /// 同步错误
  const factory Failure.sync({
    required String message,
    String? syncType,
    DateTime? lastSyncTime,
  }) = SyncFailure;

  /// 文件错误
  const factory Failure.file({
    required String message,
    String? path,
    String? operation,
  }) = FileFailure;

  /// 权限错误
  const factory Failure.permission({
    required String message,
    String? permissionType,
  }) = PermissionFailure;

  /// 认证错误（API 数据源）
  const factory Failure.authentication({
    required String message,
    String? feedId,
  }) = AuthenticationFailure;

  /// 服务器错误（API 数据源）
  const factory Failure.server({
    required String message,
    required int statusCode,
    String? url,
  }) = ServerFailure;

  /// 资源未找到错误
  const factory Failure.notFound({
    required String message,
    String? resourceType,
    String? resourceId,
  }) = NotFoundFailure;

  /// 未知错误
  const factory Failure.unknown({
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) = UnknownFailure;

  /// HTML 解析错误（编辑器）
  const factory Failure.htmlParse({
    required String message,
    String? htmlSnippet,
  }) = HtmlParseFailure;

  /// Delta 转换错误（编辑器）
  const factory Failure.deltaConversion({
    required String message,
    String? details,
  }) = DeltaConversionFailure;

  /// 编辑器保存错误
  const factory Failure.editorSave({
    required String message,
    String? articleId,
  }) = EditorSaveFailure;

  /// 编辑器加载错误
  const factory Failure.editorLoad({
    required String message,
    String? articleId,
  }) = EditorLoadFailure;

  /// 获取用户友好的错误消息
  String get userMessage {
    return when(
      network: (message, statusCode, url) {
        if (statusCode == 404) return '资源不存在';
        if (statusCode == 401 || statusCode == 403) return '访问被拒绝';
        if (statusCode != null && statusCode >= 500) return '服务器错误，请稍后重试';
        return '网络连接失败，请检查网络设置';
      },
      parse: (message, source, details) => '内容解析失败',
      cache: (message, key) => '缓存操作失败',
      database: (message, table, operation) => '数据存储失败',
      validation: (message, field, value) => message,
      sync: (message, syncType, lastSyncTime) => '同步失败，请稍后重试',
      file: (message, path, operation) => '文件操作失败',
      permission: (message, permissionType) => '权限不足',
      authentication: (message, feedId) => '认证失败，请检查 API 密钥',
      server: (message, statusCode, url) => '服务器错误 ($statusCode)',
      notFound: (message, resourceType, resourceId) => '资源不存在',
      unknown: (message, error, stackTrace) => '发生未知错误',
      htmlParse: (message, htmlSnippet) => 'HTML 解析失败',
      deltaConversion: (message, details) => '内容格式转换失败',
      editorSave: (message, articleId) => '保存失败，请重试',
      editorLoad: (message, articleId) => '加载内容失败',
    );
  }

  /// 是否可重试
  bool get isRetryable {
    return when(
      network: (_, statusCode, __) =>
          statusCode == null || statusCode >= 500 || statusCode == 408,
      parse: (_, __, ___) => false,
      cache: (_, __) => true,
      database: (_, __, ___) => true,
      validation: (_, __, ___) => false,
      sync: (_, __, ___) => true,
      file: (_, __, ___) => true,
      permission: (_, __) => false,
      authentication: (_, __) => false,
      server: (_, statusCode, __) => statusCode >= 500,
      notFound: (_, __, ___) => false,
      unknown: (_, __, ___) => false,
      htmlParse: (_, __) => false,
      deltaConversion: (_, __) => false,
      editorSave: (_, __) => true,
      editorLoad: (_, __) => true,
    );
  }
}
