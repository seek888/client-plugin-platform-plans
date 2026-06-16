import 'dart:io';
import 'dart:ffi';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/open.dart';
import 'package:rss_reader/core/constants/app_constants.dart';
import 'package:rss_reader/core/database/tables/feeds_table.dart';
import 'package:rss_reader/core/database/tables/articles_table.dart';
import 'package:rss_reader/core/database/tables/categories_table.dart';
import 'package:rss_reader/core/database/tables/annotations_table.dart';
import 'package:rss_reader/core/database/tables/edited_articles_table.dart';
import 'package:rss_reader/core/logging/logging.dart';

part 'app_database.g.dart';

final _log = logger.tag(LogTags.database);

/// 初始化 Windows 平台的本地 SQLite
/// 需要将 sqlite3.dll 放到项目根目录或 Windows 可执行文件同级目录
void setupWindowsSqlite() {
  if (Platform.isWindows) {
    _log.debug('初始化 Windows SQLite');
    open.overrideFor(OperatingSystem.windows, () {
      // 优先从可执行文件同级目录加载
      final exeDir = File(Platform.resolvedExecutable).parent.path;
      final dllPath = p.join(exeDir, 'sqlite3.dll');

      if (File(dllPath).existsSync()) {
        _log.debug('从 $dllPath 加载 sqlite3.dll');
        return DynamicLibrary.open(dllPath);
      }

      // 回退到系统 PATH 中的 sqlite3.dll
      _log.debug('从系统 PATH 加载 sqlite3.dll');
      return DynamicLibrary.open('sqlite3.dll');
    });
  }
}

/// 应用数据库
@DriftDatabase(
  tables: [
    FeedsTable,
    ArticlesTable,
    CategoriesTable,
    FavoriteFoldersTable,
    AnnotationsTable,
    SyncLogsTable,
    EditedArticlesTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// 用于测试的构造函数
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // 版本 1 -> 2: 添加 edited_articles 表
        if (from < 2) {
          await m.createTable(editedArticlesTable);
        }
        // 版本 2 -> 3: 添加插件数据源字段
        if (from < 3) {
          await m.addColumn(feedsTable, feedsTable.pluginId);
          await m.addColumn(feedsTable, feedsTable.pluginFeedKey);
          await m.addColumn(feedsTable, feedsTable.pluginProvider);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConstants.databaseName));
    _log.info('打开数据库: ${file.path}');
    return NativeDatabase.createInBackground(file);
  });
}
