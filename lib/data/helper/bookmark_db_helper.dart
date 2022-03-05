import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class BookmarkDbHelper {
  static Future<sql.Database> databse() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'bookmark.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE bookmark(id TEXT PRIMARY KEY, name TEXT, resto TEXT, date TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await databse();
    db.insert(
      'bookmark',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await databse();
    return db.query('bookmark');
  }

  static Future<void> delete(String id) async {
    final db = await databse();
    db.delete('bookmark', where: 'id = ?', whereArgs: [id]);
  }
}
