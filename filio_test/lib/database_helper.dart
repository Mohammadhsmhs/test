import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static const String TABLE_NAME = 'counter';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_COUNT = 'count';

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = '${documentsDirectory.path}counter.db';
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_COUNT INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
    return db;
  }
}
