import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rss_reader/features/feed/data/services/opml_service_impl.dart';
import 'package:rss_reader/features/feed/data/services/feed_validator_impl.dart';
import 'package:rss_reader/features/feed/domain/entities/data_source.dart';
import 'package:rss_reader/features/feed/domain/entities/feed.dart';
import 'package:rss_reader/features/feed/domain/repositories/feed_repository.dart';
import 'package:rss_reader/features/feed/domain/services/opml_service.dart';
import 'package:rss_reader/features/feed/domain/services/feed_validator.dart';
import 'package:rss_reader/features/feed/presentation/notifiers/feed_list_notifier.dart';
import 'package:rss_reader/features/feed/presentation/providers/data_source_manager_provider.dart';
import 'package:rss_reader/features/feed/presentation/side_effects/feed_management_side_effect.dart';
import 'package:rss_reader/features/feed/presentation/states/feed_management_state.dart';
import 'package:rss_reader/core/services/rss_parser_provider.dart';

part 'feed_management_notifier.g.dart';

/// OPML 服务 Provider
@riverpod
OPMLService opmlService(Ref ref) {
  return OPMLServiceImpl();
}

/// 订阅源验证器 Provider
@riverpod
FeedValidator feedValidator(Ref ref) {
  final rssParserService = ref.watch(rssParserServiceProvider);
  final dataSourceManager = ref.watch(dataSourceManagerProvider);
  return FeedValidatorImpl(
    rssParserService: rssParserService,
    dataSourceManager: dataSourceManager,
  );
}

/// 订阅源管理 Notifier
/// 负责管理订阅源管理页的状态和业务逻辑
@riverpod
class FeedManagementNotifier extends _$FeedManagementNotifier {
  late final FeedRepository _feedRepository;
  late final OPMLService _opmlService;
  late final FeedValidator _feedValidator;
  StreamController<FeedManagementSideEffect>? _sideEffectController;
  StreamSubscription<List<Feed>>? _feedsSubscription;
  StreamSubscription<List<FeedCategory>>? _categoriesSubscription;
  bool _isDisposed = false;

  /// 获取或创建副作用控制器
  StreamController<FeedManagementSideEffect> get _controller {
    _sideEffectController ??=
        StreamController<FeedManagementSideEffect>.broadcast();
    return _sideEffectController!;
  }

  /// 副作用流
  Stream<FeedManagementSideEffect> get sideEffect => _controller.stream;

  /// 安全地添加副作用事件
  void _addSideEffect(FeedManagementSideEffect effect) {
    if (!_isDisposed &&
        _sideEffectController != null &&
        !_sideEffectController!.isClosed) {
      _sideEffectController!.add(effect);
    }
  }

  @override
  FeedManagementState build() {
    _feedRepository = ref.watch(feedRepositoryProvider);
    _opmlService = ref.watch(opmlServiceProvider);
    _feedValidator = ref.watch(feedValidatorProvider);
    _isDisposed = false;

    // 确保创建新的控制器
    _sideEffectController =
        StreamController<FeedManagementSideEffect>.broadcast();

    // 监听订阅源变化
    _setupWatchers();

    // 清理资源
    ref.onDispose(() {
      _isDisposed = true;
      _sideEffectController?.close();
      _sideEffectController = null;
      _feedsSubscription?.cancel();
      _categoriesSubscription?.cancel();
    });

    // 初始加载
    _loadFeeds();

    return const FeedManagementState.initial();
  }

  /// 设置数据监听
  void _setupWatchers() {
    _feedsSubscription = _feedRepository.watchAllFeeds().listen((feeds) {
      _updateStateWithFeeds(feeds);
    });

    _categoriesSubscription = _feedRepository.watchAllCategories().listen((
      categories,
    ) {
      _updateStateWithCategories(categories);
    });
  }

  /// 更新状态中的订阅源列表
  void _updateStateWithFeeds(List<Feed> feeds) {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(feeds: feeds),
      orElse: () => FeedManagementState.loaded(feeds: feeds, categories: []),
    );
  }

  /// 更新状态中的分类列表
  void _updateStateWithCategories(List<FeedCategory> categories) {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(categories: categories),
      orElse: () =>
          FeedManagementState.loaded(feeds: [], categories: categories),
    );
  }

  /// 加载订阅源列表
  Future<void> _loadFeeds() async {
    state = const FeedManagementState.loading();

    final feedsResult = await _feedRepository.getAllFeeds();
    final categoriesResult = await _feedRepository.getCategories();

    feedsResult.fold(
      (failure) =>
          state = FeedManagementState.error(message: failure.userMessage),
      (feeds) {
        categoriesResult.fold(
          (failure) =>
              state = FeedManagementState.error(message: failure.userMessage),
          (categories) => state = FeedManagementState.loaded(
            feeds: feeds,
            categories: categories,
          ),
        );
      },
    );
  }

  // ============================================================================
  // 批量选择操作
  // ============================================================================

  /// Intent: 进入批量选择模式
  void onEnterSelectionMode() {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(isSelectionMode: true, selectedFeedIds: []),
      orElse: () => state,
    );
  }

  /// Intent: 退出批量选择模式
  void onExitSelectionMode() {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(isSelectionMode: false, selectedFeedIds: []),
      orElse: () => state,
    );
  }

  /// Intent: 切换订阅源选中状态
  void onToggleFeedSelection(String feedId) {
    state = state.maybeMap(
      loaded: (s) {
        final selectedIds = List<String>.from(s.selectedFeedIds);
        if (selectedIds.contains(feedId)) {
          selectedIds.remove(feedId);
        } else {
          selectedIds.add(feedId);
        }
        return s.copyWith(selectedFeedIds: selectedIds);
      },
      orElse: () => state,
    );
  }

  /// Intent: 全选/取消全选
  void onToggleSelectAll() {
    state = state.maybeMap(
      loaded: (s) {
        if (s.selectedFeedIds.length == s.feeds.length) {
          // 已全选，取消全选
          return s.copyWith(selectedFeedIds: []);
        } else {
          // 未全选，全选
          return s.copyWith(selectedFeedIds: s.feeds.map((f) => f.id).toList());
        }
      },
      orElse: () => state,
    );
  }

  /// Intent: 批量删除选中的订阅源
  Future<void> onBatchDelete() async {
    final currentState = state;
    if (currentState is! FeedManagementStateLoaded) return;
    if (currentState.selectedFeedIds.isEmpty) return;

    final count = currentState.selectedFeedIds.length;

    _addSideEffect(
      FeedManagementSideEffect.showConfirmDialog(
        title: '确认删除',
        message: '确定要删除选中的 $count 个订阅源吗？',
        onConfirm: () async {
          int successCount = 0;
          int failCount = 0;

          for (final feedId in currentState.selectedFeedIds) {
            final result = await _feedRepository.deleteFeed(feedId);
            result.fold((_) => failCount++, (_) => successCount++);
          }

          if (failCount > 0) {
            _addSideEffect(
              FeedManagementSideEffect.showToast(
                message: '删除完成，$successCount 成功，$failCount 失败',
                isError: true,
              ),
            );
          } else {
            _addSideEffect(
              FeedManagementSideEffect.showToast(
                message: '已删除 $successCount 个订阅源',
              ),
            );
          }

          // 退出选择模式
          onExitSelectionMode();
        },
      ),
    );
  }

  /// Intent: 批量移动到分类
  void onBatchMoveToCategory() {
    final currentState = state;
    if (currentState is! FeedManagementStateLoaded) return;
    if (currentState.selectedFeedIds.isEmpty) return;

    _addSideEffect(
      FeedManagementSideEffect.showCategoryPicker(
        feedIds: currentState.selectedFeedIds,
      ),
    );
  }

  /// Intent: 执行批量移动到分类
  Future<void> onExecuteBatchMoveToCategory(String? categoryId) async {
    final currentState = state;
    if (currentState is! FeedManagementStateLoaded) return;

    int successCount = 0;
    int failCount = 0;

    for (final feedId in currentState.selectedFeedIds) {
      final result = await _feedRepository.moveFeedToCategory(
        feedId,
        categoryId,
      );
      result.fold((_) => failCount++, (_) => successCount++);
    }

    if (failCount > 0) {
      _addSideEffect(
        FeedManagementSideEffect.showToast(
          message: '移动完成，$successCount 成功，$failCount 失败',
          isError: true,
        ),
      );
    } else {
      _addSideEffect(
        FeedManagementSideEffect.showToast(message: '已移动 $successCount 个订阅源'),
      );
    }

    // 退出选择模式
    onExitSelectionMode();
  }

  // ============================================================================
  // 拖拽排序
  // ============================================================================

  /// Intent: 开始拖拽
  void onDragStart() {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(isDragging: true),
      orElse: () => state,
    );
  }

  /// Intent: 结束拖拽
  void onDragEnd() {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(isDragging: false),
      orElse: () => state,
    );
  }

  /// Intent: 重排序订阅源
  Future<void> onReorderFeeds(int oldIndex, int newIndex) async {
    final currentState = state;
    if (currentState is! FeedManagementStateLoaded) return;

    // 调整索引
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    // 本地更新列表顺序
    final feeds = List<Feed>.from(currentState.feeds);
    final item = feeds.removeAt(oldIndex);
    feeds.insert(newIndex, item);

    // 更新状态
    state = currentState.copyWith(feeds: feeds);

    // 保存到数据库
    final feedIds = feeds.map((f) => f.id).toList();
    final result = await _feedRepository.reorderFeeds(feedIds);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedManagementSideEffect.showToast(message: '排序保存失败', isError: true),
        );
        // 重新加载数据
        _loadFeeds();
      },
      (_) {
        // 排序成功，无需提示
      },
    );
  }

  // ============================================================================
  // OPML 导入导出
  // ============================================================================

  /// Intent: 显示导入 OPML 文件选择器
  void onShowImportPicker() {
    _addSideEffect(const FeedManagementSideEffect.openFilePicker());
  }

  /// Intent: 导入 OPML 文件
  Future<void> onImportOPML(File file) async {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(isImporting: true),
      orElse: () => state,
    );

    final parseResult = await _opmlService.importFromFile(file);

    await parseResult.fold(
      (failure) async {
        _addSideEffect(
          FeedManagementSideEffect.showToast(
            message: '导入失败: ${failure.userMessage}',
            isError: true,
          ),
        );
      },
      (opmlFeeds) async {
        // 转换为 Feed 并添加
        final feeds = _opmlService.convertToFeeds(opmlFeeds);
        int importedCount = 0;
        int failedCount = 0;

        for (final feed in feeds) {
          final result = await _feedRepository.addFeed(feed.url);
          result.fold((_) => failedCount++, (_) => importedCount++);
        }

        _addSideEffect(
          FeedManagementSideEffect.importCompleted(
            importedCount: importedCount,
            failedCount: failedCount,
          ),
        );
      },
    );

    state = state.maybeMap(
      loaded: (s) => s.copyWith(isImporting: false),
      orElse: () => state,
    );
  }

  /// Intent: 显示导出 OPML 文件保存对话框
  void onShowExportSaver() {
    final timestamp = DateTime.now().toIso8601String().split('T')[0];
    _addSideEffect(
      FeedManagementSideEffect.openFileSaver(
        suggestedFileName: 'rss_export_$timestamp.opml',
      ),
    );
  }

  /// Intent: 导出 OPML 文件
  Future<void> onExportOPML(String filePath) async {
    final currentState = state;
    if (currentState is! FeedManagementStateLoaded) return;

    state = currentState.copyWith(isExporting: true);

    final result = await _opmlService.exportToFile(
      currentState.feeds,
      filePath,
      categories: currentState.categories,
    );

    result.fold(
      (failure) {
        _addSideEffect(
          FeedManagementSideEffect.showToast(
            message: '导出失败: ${failure.userMessage}',
            isError: true,
          ),
        );
      },
      (file) {
        _addSideEffect(
          FeedManagementSideEffect.exportCompleted(filePath: file.path),
        );
      },
    );

    state = state.maybeMap(
      loaded: (s) => s.copyWith(isExporting: false),
      orElse: () => state,
    );
  }

  // ============================================================================
  // 添加订阅源
  // ============================================================================

  /// Intent: 显示添加订阅源对话框
  void onShowAddFeedDialog() {
    _addSideEffect(const FeedManagementSideEffect.showAddFeedDialog());
  }

  /// Intent: 切换数据源类型
  void onChangeSourceType(SourceType sourceType) {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(
        selectedSourceType: sourceType,
        validationState: null,
        isValidating: false,
      ),
      orElse: () => state,
    );
  }

  /// Intent: 验证订阅源 URL
  Future<void> onValidateFeedUrl(String url) async {
    if (url.trim().isEmpty) {
      state = state.maybeMap(
        loaded: (s) => s.copyWith(isValidating: false, validationState: null),
        orElse: () => state,
      );
      return;
    }

    // 先验证 URL 格式
    final urlValidation = _feedValidator.validateUrlFormat(url);
    if (!urlValidation.isValid) {
      state = state.maybeMap(
        loaded: (s) => s.copyWith(
          isValidating: false,
          validationState: FeedValidationState.failure(
            errorMessage: urlValidation.errorMessage ?? 'URL 格式无效',
          ),
        ),
        orElse: () => state,
      );
      return;
    }

    // 设置验证中状态
    state = state.maybeMap(
      loaded: (s) => s.copyWith(
        isValidating: true,
        validationState: const FeedValidationState.validating(),
      ),
      orElse: () => state,
    );

    // 验证 Feed 内容
    final result = await _feedValidator.validateFeedUrl(url);

    result.fold(
      (failure) {
        state = state.maybeMap(
          loaded: (s) => s.copyWith(
            isValidating: false,
            validationState: FeedValidationState.failure(
              errorMessage: failure.userMessage,
            ),
          ),
          orElse: () => state,
        );
      },
      (validation) {
        if (validation.isValid) {
          state = state.maybeMap(
            loaded: (s) => s.copyWith(
              isValidating: false,
              validationState: FeedValidationState.success(
                feedTitle: validation.feedTitle ?? '未知标题',
                feedDescription: validation.feedDescription,
                iconUrl: validation.iconUrl,
                articleCount: validation.articleCount,
              ),
            ),
            orElse: () => state,
          );
        } else {
          state = state.maybeMap(
            loaded: (s) => s.copyWith(
              isValidating: false,
              validationState: FeedValidationState.failure(
                errorMessage: validation.errorMessage ?? '验证失败',
              ),
            ),
            orElse: () => state,
          );
        }
      },
    );
  }

  /// Intent: 清除验证状态
  void onClearValidation() {
    state = state.maybeMap(
      loaded: (s) => s.copyWith(isValidating: false, validationState: null),
      orElse: () => state,
    );
  }

  /// Intent: 添加订阅源
  Future<void> onAddFeed(String url) async {
    final result = await _feedRepository.addFeed(url);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedManagementSideEffect.showToast(
            message: failure.userMessage,
            isError: true,
          ),
        );
      },
      (feed) {
        // 清除验证状态
        onClearValidation();
        // 先关闭对话框，再显示 Toast，避免 Navigator 锁定问题
        _addSideEffect(const FeedManagementSideEffect.closeAddFeedDialog());
        // 延迟显示 Toast，确保对话框已关闭
        Future.microtask(() {
          _addSideEffect(
            FeedManagementSideEffect.showToast(message: '已添加: ${feed.title}'),
          );
        });
      },
    );
  }

  /// Intent: 添加订阅源（不关闭对话框，由调用方负责关闭）
  Future<void> onAddFeedWithoutClose(String url) async {
    final result = await _feedRepository.addFeed(url);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedManagementSideEffect.showToast(
            message: failure.userMessage,
            isError: true,
          ),
        );
      },
      (feed) {
        // 清除验证状态
        onClearValidation();
        // 只显示 Toast，不关闭对话框（对话框已由调用方关闭）
        _addSideEffect(
          FeedManagementSideEffect.showToast(message: '已添加: ${feed.title}'),
        );
      },
    );
  }

  /// Intent: 验证 API 数据源配置
  Future<void> onValidateApiSource({
    required String baseUrl,
    String? apiKey,
    String? remoteFeedId,
  }) async {
    if (baseUrl.trim().isEmpty) {
      state = state.maybeMap(
        loaded: (s) => s.copyWith(isValidating: false, validationState: null),
        orElse: () => state,
      );
      return;
    }

    // 设置验证中状态
    state = state.maybeMap(
      loaded: (s) => s.copyWith(
        isValidating: true,
        validationState: const FeedValidationState.validating(),
      ),
      orElse: () => state,
    );

    // 创建 API 配置
    final config = ApiSourceConfig(
      baseUrl: baseUrl.trim(),
      apiKey: apiKey?.trim(),
      remoteFeedId: remoteFeedId?.trim(),
    );

    // 验证 API 配置
    final result = await _feedRepository.validateApiSource(config);

    result.fold(
      (failure) {
        state = state.maybeMap(
          loaded: (s) => s.copyWith(
            isValidating: false,
            validationState: FeedValidationState.failure(
              errorMessage: failure.userMessage,
            ),
          ),
          orElse: () => state,
        );
      },
      (validation) {
        if (validation.isValid) {
          state = state.maybeMap(
            loaded: (s) => s.copyWith(
              isValidating: false,
              validationState: FeedValidationState.success(
                feedTitle: validation.feedTitle ?? '未知标题',
                feedDescription: validation.feedDescription,
                iconUrl: validation.iconUrl,
                articleCount: 0,
                sourceType: SourceType.api,
              ),
            ),
            orElse: () => state,
          );
        } else {
          state = state.maybeMap(
            loaded: (s) => s.copyWith(
              isValidating: false,
              validationState: FeedValidationState.failure(
                errorMessage: validation.errorMessage ?? '验证失败',
              ),
            ),
            orElse: () => state,
          );
        }
      },
    );
  }

  /// Intent: 添加 API 数据源
  Future<void> onAddApiFeed({
    required String title,
    required String baseUrl,
    String? apiKey,
    String? remoteFeedId,
    String? description,
  }) async {
    final config = ApiSourceConfig(
      baseUrl: baseUrl.trim(),
      apiKey: apiKey?.trim(),
      remoteFeedId: remoteFeedId?.trim(),
    );

    final result = await _feedRepository.addApiFeed(
      title: title.trim(),
      apiConfig: config,
      description: description?.trim(),
    );

    result.fold(
      (failure) {
        _addSideEffect(
          FeedManagementSideEffect.showToast(
            message: failure.userMessage,
            isError: true,
          ),
        );
      },
      (feed) {
        // 清除验证状态并重置数据源类型
        state = state.maybeMap(
          loaded: (s) => s.copyWith(
            isValidating: false,
            validationState: null,
            selectedSourceType: SourceType.rss,
          ),
          orElse: () => state,
        );
        _addSideEffect(
          FeedManagementSideEffect.showToast(message: '已添加: ${feed.title}'),
        );
      },
    );
  }

  // ============================================================================
  // 单个订阅源操作
  // ============================================================================

  /// Intent: 删除单个订阅源
  Future<void> onDeleteFeed(String feedId) async {
    final feedResult = await _feedRepository.getFeedById(feedId);

    feedResult.fold(
      (failure) {
        _addSideEffect(
          FeedManagementSideEffect.showToast(message: '订阅源不存在', isError: true),
        );
      },
      (feed) {
        _addSideEffect(
          FeedManagementSideEffect.showConfirmDialog(
            title: '确认删除',
            message: '确定要取消订阅「${feed.title}」吗？',
            onConfirm: () async {
              final deleteResult = await _feedRepository.deleteFeed(feedId);
              deleteResult.fold(
                (failure) {
                  _addSideEffect(
                    FeedManagementSideEffect.showToast(
                      message: '删除失败',
                      isError: true,
                    ),
                  );
                },
                (_) {
                  _addSideEffect(
                    FeedManagementSideEffect.showToast(message: '已取消订阅'),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  /// Intent: 移动单个订阅源到分类
  void onMoveFeedToCategory(String feedId) {
    _addSideEffect(
      FeedManagementSideEffect.showCategoryPicker(feedIds: [feedId]),
    );
  }

  /// Intent: 执行移动单个订阅源到分类
  Future<void> onExecuteMoveFeedToCategory(
    String feedId,
    String? categoryId,
  ) async {
    final result = await _feedRepository.moveFeedToCategory(feedId, categoryId);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedManagementSideEffect.showToast(message: '移动失败', isError: true),
        );
      },
      (_) {
        _addSideEffect(FeedManagementSideEffect.showToast(message: '已移动到分类'));
      },
    );
  }

  // ============================================================================
  // 分类操作
  // ============================================================================

  /// Intent: 显示创建分类对话框
  void onShowCreateCategoryDialog() {
    _addSideEffect(const FeedManagementSideEffect.showCreateCategoryDialog());
  }

  /// Intent: 创建分类
  Future<void> onCreateCategory(String name) async {
    final result = await _feedRepository.createCategory(name);

    result.fold(
      (failure) {
        _addSideEffect(
          FeedManagementSideEffect.showToast(message: '创建分类失败', isError: true),
        );
      },
      (category) {
        _addSideEffect(
          FeedManagementSideEffect.showToast(
            message: '已创建分类: ${category.name}',
          ),
        );
      },
    );
  }

  /// Intent: 返回上一页
  void onNavigateBack() {
    _addSideEffect(const FeedManagementSideEffect.navigateBack());
  }
}

/// 副作用 Provider
@riverpod
Stream<FeedManagementSideEffect> feedManagementSideEffect(Ref ref) {
  return ref.watch(feedManagementNotifierProvider.notifier).sideEffect;
}
