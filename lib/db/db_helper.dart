import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 5;
  static final String _tableName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'task.db';
      _db = await openDatabase(_path, version: _version,
          onCreate: (Database db, int version) async {
        return db.execute(
          'CREATE TABLE $_tableName'
          ' (id INTEGER PRIMARY KEY AUTOINCREMENT ,'
          ' title STRING , note TEXT , date STRING,'
          ' startTime STRING,endTime STRING,'
          ' remind INTEGER , repeat STRING,'
          'color INTEGER,'
          'isCompleted INTEGER)',
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Map<String, dynamic>>> Query() async {
    return await _db!.query(_tableName);
  }

  static Future<int> insert(Task task) async {
    try {
      return await _db!.insert(_tableName, task.toJson());
    } catch (e) {
      return 90000;
    }
  }

  static Future<int> delete(Task? task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task!.id]);
  }

  static Future<int> deleteAll() async {
    return await _db!.delete(_tableName);
  }

  static Future<int> Update(int id) async {
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id =?  
    ''', [1, id]);
  }
}
