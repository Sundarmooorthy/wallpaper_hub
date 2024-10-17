import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('images.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        path TEXT
      )
    ''');
  }

  Future<void> insertImage(String name, String path) async {
    final db = await instance.database;
    await db.insert('images', {'name': name, 'path': path});
  }

  // this function is to display downloaded image in app currently not needed.
  // Future<List<Map<String, dynamic>>> fetchAllImages() async {
  //   final db = await instance.database;
  //   return await db.query('images');
  // }
}
