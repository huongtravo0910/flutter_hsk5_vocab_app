import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();
  Database _database;
  Database get database {
    return _database;
  }

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._() {
    debugPrint("init1");
    // initDatabase();
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> initDatabase() async {
    debugPrint("init2");
    final localPath = await _localPath;
    debugPrint(localPath);
    final path = await getDatabasesPath();
    String word =
        "CREATE TABLE history(id INTEGER PRIMARY KEY, numOfCards INTEGER, studiedType TEXT, packageName TEXT, roomName TEXT, dateTime TEXT)";
    String history =
        "CREATE TABLE words(id INTEGER PRIMARY KEY, stt INTEGER, definition TEXT, word TEXT, pronounciation TEXT, remembered INTEGER, isMarked INTEGER, isStudied INTEGER)";
    debugPrint(path);
    try {
      _database = await openDatabase(
        join(path, 'word_database.db'),
        onCreate: (db, version) async {
          try {
            await db.execute(word);
            await db.execute(history);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        version: 1,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteDB() async {
    var dataPath = join(await getDatabasesPath(), 'word_database.db');
    await deleteDatabase(dataPath);
    debugPrint("done");
  }
}
