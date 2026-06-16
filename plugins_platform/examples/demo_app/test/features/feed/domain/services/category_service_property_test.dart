import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:glados/glados.dart';
import 'package:rss_reader/core/database/app_database.dart';
import 'package:rss_reader/core/database/daos/category_dao.dart';
import 'package:rss_reader/core/database/daos/feed_dao.dart';
import 'package:rss_reader/features/feed/data/services/category_service_impl.dart';
import 'package:rss_reader/features/feed/domain/services/category_service.dart';

/// **Property 4: 分类创建后列表包含**
/// **Validates: Requirements 2.2**
///
/// WHEN 用户创建新分类 THEN THE Feed_Manager SHALL 创建分类文件夹并在横向栏以折叠形式展示

// Custom generators for category testing
extension CategoryGenerators on Any {
  /// Generator for valid category names
  Generator<String> get validCategoryName {
    return any.combine2(any.lowercaseLetters, any.positiveIntOrZero, (
      String name,
      int index,
    ) {
      final safeName = name.isEmpty ? 'category' : name;
      return '$safeName$index';
    });
  }

  /// Generator for category names with special characters
  Generator<String> get categoryNameWithSpecialChars {
    return any.combine3(
      any.lowercaseLetters,
      any.choose(['_', '-', ' ', '.']),
      any.positiveIntOrZero,
      (String name, String special, int index) {
        final safeName = name.isEmpty ? 'category' : name;
        return '$safeName$special$index';
      },
    );
  }

  /// Generator for whitespace-only strings
  Generator<String> get whitespaceOnly {
    return any.combine2(
      any.positiveIntOrZero,
      any.choose([' ', '\t', '\n', '\r']),
      (int count, String char) {
        final actualCount = (count % 5) + 1; // 1-5 characters
        return char * actualCount;
      },
    );
  }
}

/// Helper to create fresh database and service for each test
class TestContext {
  final AppDatabase database;
  final CategoryDao categoryDao;
  final FeedDao feedDao;
  final CategoryService categoryService;

  TestContext._({
    required this.database,
    required this.categoryDao,
    required this.feedDao,
    required this.categoryService,
  });

  factory TestContext.create() {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final categoryDao = CategoryDao(database);
    final feedDao = FeedDao(database);
    final categoryService = CategoryServiceImpl(
      categoryDao: categoryDao,
      feedDao: feedDao,
    );
    return TestContext._(
      database: database,
      categoryDao: categoryDao,
      feedDao: feedDao,
      categoryService: categoryService,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}

void main() {
  group('Property 4: Category Creation Contains in List', () {
    // Property 4a: Created category should appear in the list
    Glados(any.validCategoryName).test(
      'Property 4a: Created category appears in getAllCategories',
      (String name) async {
        final ctx = TestContext.create();

        try {
          // Create category
          final createResult = await ctx.categoryService.createCategory(name);

          expect(
            createResult.isRight(),
            isTrue,
            reason: 'Category creation should succeed for valid name "$name"',
          );

          final createdCategory = createResult.getOrElse(
            () => throw StateError('Expected Right'),
          );

          // Get all categories
          final listResult = await ctx.categoryService.getAllCategories();

          expect(
            listResult.isRight(),
            isTrue,
            reason: 'Getting categories should succeed',
          );

          final categories = listResult.getOrElse(
            () => throw StateError('Expected Right'),
          );

          // Verify the created category is in the list
          final found = categories.any((c) => c.id == createdCategory.id);
          expect(
            found,
            isTrue,
            reason: 'Created category should be found in the list',
          );

          // Verify the name matches
          final foundCategory = categories.firstWhere(
            (c) => c.id == createdCategory.id,
          );
          expect(
            foundCategory.name,
            equals(name.trim()),
            reason: 'Category name should match',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 4b: Category with special characters should be created correctly
    Glados(any.categoryNameWithSpecialChars).test(
      'Property 4b: Category with special characters is created correctly',
      (String name) async {
        final ctx = TestContext.create();

        try {
          final createResult = await ctx.categoryService.createCategory(name);

          expect(
            createResult.isRight(),
            isTrue,
            reason:
                'Category creation should succeed for name with special chars "$name"',
          );

          final createdCategory = createResult.getOrElse(
            () => throw StateError('Expected Right'),
          );

          // Verify the name is preserved
          expect(
            createdCategory.name,
            equals(name.trim()),
            reason: 'Category name should be preserved',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 4c: Empty category name should fail
    test('Property 4c: Empty category name fails validation', () async {
      final ctx = TestContext.create();

      try {
        final createResult = await ctx.categoryService.createCategory('');

        expect(
          createResult.isLeft(),
          isTrue,
          reason: 'Empty category name should fail',
        );
      } finally {
        await ctx.dispose();
      }
    });

    // Property 4d: Whitespace-only category name should fail
    Glados(any.whitespaceOnly).test(
      'Property 4d: Whitespace-only category name fails validation',
      (String name) async {
        final ctx = TestContext.create();

        try {
          final createResult = await ctx.categoryService.createCategory(name);

          expect(
            createResult.isLeft(),
            isTrue,
            reason: 'Whitespace-only category name "$name" should fail',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 4e: Duplicate category name should fail
    Glados(any.validCategoryName).test(
      'Property 4e: Duplicate category name fails validation',
      (String name) async {
        final ctx = TestContext.create();

        try {
          // Create first category
          final firstResult = await ctx.categoryService.createCategory(name);
          expect(firstResult.isRight(), isTrue);

          // Try to create duplicate
          final duplicateResult = await ctx.categoryService.createCategory(
            name,
          );

          expect(
            duplicateResult.isLeft(),
            isTrue,
            reason: 'Duplicate category name should fail',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );

    // Property 4f: Category can be retrieved by ID after creation
    Glados(any.validCategoryName).test(
      'Property 4f: Category can be retrieved by ID after creation',
      (String name) async {
        final ctx = TestContext.create();

        try {
          final createResult = await ctx.categoryService.createCategory(name);
          expect(createResult.isRight(), isTrue);

          final createdCategory = createResult.getOrElse(
            () => throw StateError('Expected Right'),
          );

          // Get by ID
          final getResult = await ctx.categoryService.getCategoryById(
            createdCategory.id,
          );

          expect(
            getResult.isRight(),
            isTrue,
            reason: 'Getting category by ID should succeed',
          );

          final retrievedCategory = getResult.getOrElse(
            () => throw StateError('Expected Right'),
          );

          expect(
            retrievedCategory.id,
            equals(createdCategory.id),
            reason: 'Retrieved category ID should match',
          );
          expect(
            retrievedCategory.name,
            equals(createdCategory.name),
            reason: 'Retrieved category name should match',
          );
        } finally {
          await ctx.dispose();
        }
      },
    );
  });

  group('Category Management Edge Cases', () {
    test('Deleting category moves feeds to uncategorized', () async {
      final ctx = TestContext.create();

      try {
        // Create a category
        final categoryResult = await ctx.categoryService.createCategory(
          'TestCategory',
        );
        expect(categoryResult.isRight(), isTrue);
        final category = categoryResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        // Add a feed to the category
        final feedId = 'test-feed-id';
        await ctx.feedDao.insertFeed(
          FeedsTableCompanion(
            id: Value(feedId),
            url: const Value('https://example.com/feed.xml'),
            title: const Value('Test Feed'),
            categoryId: Value(category.id),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );

        // Delete the category
        final deleteResult = await ctx.categoryService.deleteCategory(
          category.id,
        );
        expect(deleteResult.isRight(), isTrue);

        // Verify feed is now uncategorized
        final feedData = await ctx.feedDao.getFeedById(feedId);
        expect(feedData, isNotNull);
        expect(feedData!.categoryId, isNull);
      } finally {
        await ctx.dispose();
      }
    });

    test('Renaming category preserves ID', () async {
      final ctx = TestContext.create();

      try {
        // Create a category
        final categoryResult = await ctx.categoryService.createCategory(
          'OriginalName',
        );
        expect(categoryResult.isRight(), isTrue);
        final category = categoryResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        // Rename the category
        final renameResult = await ctx.categoryService.renameCategory(
          category.id,
          'NewName',
        );
        expect(renameResult.isRight(), isTrue);

        final renamedCategory = renameResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        expect(renamedCategory.id, equals(category.id));
        expect(renamedCategory.name, equals('NewName'));
      } finally {
        await ctx.dispose();
      }
    });

    test('Toggle category expanded state', () async {
      final ctx = TestContext.create();

      try {
        // Create a category
        final categoryResult = await ctx.categoryService.createCategory(
          'TestCategory',
        );
        expect(categoryResult.isRight(), isTrue);
        final category = categoryResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        final initialExpanded = category.isExpanded;

        // Toggle expanded state
        final toggleResult = await ctx.categoryService.toggleCategoryExpanded(
          category.id,
        );
        expect(toggleResult.isRight(), isTrue);

        final toggledCategory = toggleResult.getOrElse(
          () => throw StateError('Expected Right'),
        );

        expect(toggledCategory.isExpanded, equals(!initialExpanded));
      } finally {
        await ctx.dispose();
      }
    });
  });
}
