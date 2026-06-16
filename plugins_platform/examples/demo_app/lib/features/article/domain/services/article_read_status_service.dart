import 'package:dartz/dartz.dart';
import 'package:rss_reader/core/errors/failures.dart';

/// 文章已读状态服务接口
abstract class ArticleReadStatusService {
  /// 标记单篇文章已读
  Future<Either<Failure, void>> markAsRead(String articleId);

  /// 标记单篇文章未读
  Future<Either<Failure, void>> markAsUnread(String articleId);

  /// 切换文章已读状态
  Future<Either<Failure, bool>> toggleReadStatus(String articleId);

  /// 批量标记订阅源所有文章已读
  Future<Either<Failure, int>> markAllAsReadByFeed(String feedId);

  /// 批量标记所有文章已读
  Future<Either<Failure, int>> markAllAsRead();

  /// 获取订阅源未读数
  Future<Either<Failure, int>> getUnreadCountByFeed(String feedId);

  /// 获取总未读数
  Future<Either<Failure, int>> getTotalUnreadCount();
}
