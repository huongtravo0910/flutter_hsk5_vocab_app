import 'package:flutter/foundation.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class WordService {
  static final WordService _instance = WordService._();
  Database _database;

  factory WordService() {
    return _instance;
  }

  WordService._() {
    _initDatabase();
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void _initDatabase() async {
    final localPath = await _localPath;
    debugPrint(localPath);
    final path = await getDatabasesPath();
    debugPrint(path);
    _database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(path, 'word_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE words(id INTEGER PRIMARY KEY, stt INTEGER, definition TEXT, word TEXT, pronounciation TEXT, remembered INTEGER, isMarked INTEGER, isStudied INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<int> countAllWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(
          await _database.rawQuery('SELECT COUNT(*) FROM words;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<int> countForgotWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(await _database
          .rawQuery('SELECT COUNT(*) FROM words WHERE remembered = 0;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<int> countRememberedWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(await _database
          .rawQuery('SELECT COUNT(*) FROM words WHERE remembered = 1;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<int> countMarkedWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(await _database
          .rawQuery('SELECT COUNT(*) FROM words WHERE isMarked = 1;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<int> countUnStudiedWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(await _database
          .rawQuery('SELECT COUNT(*) FROM words WHERE isStudied = 0;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<void> deleteWords() async {
    var dataPath = join(await getDatabasesPath(), 'word_database.db');
    await deleteDatabase(dataPath);
    debugPrint("done");
  }

  Future<void> insertWord(WordModel word) async {
    // Get a reference to the database.

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await _database.insert(
      'words',
      WordModel.toMap(word),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryOne(int id) async {
    return _database.query("words", where: "id = ?", whereArgs: [id], limit: 1);
  }

  Future<List<WordModel>> words() async {
    final List<Map<String, dynamic>> maps = await _database.query('words');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return WordModel(
        stt: maps[i]['stt'].toString(),
        word: maps[i]['word'],
        pronounciation: maps[i]['pronounciation'],
        definition: maps[i]['definition'],
        remembered: maps[i]['remembered'],
        isMarked: (maps[i]['isMarked'] == 0) ? false : true,
        isStudied: (maps[i]['isStudied'] == 0) ? false : true,
      );
    });
  }

  Future<List<WordModel>> forgotWords() async {
    final List<Map<String, dynamic>> maps =
        await _database.query('words', where: "remembered = ?", whereArgs: [0]);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return WordModel(
        stt: maps[i]['stt'].toString(),
        word: maps[i]['word'],
        pronounciation: maps[i]['pronounciation'],
        definition: maps[i]['definition'],
        remembered: maps[i]['remembered'],
        isMarked: (maps[i]['isMarked'] == 0) ? false : true,
        isStudied: (maps[i]['isStudied'] == 0) ? false : true,
      );
    });
  }

  Future<List<WordModel>> markedWords() async {
    final List<Map<String, dynamic>> maps =
        await _database.query('words', where: "isMarked = ?", whereArgs: [1]);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return WordModel(
        stt: maps[i]['stt'].toString(),
        word: maps[i]['word'],
        pronounciation: maps[i]['pronounciation'],
        definition: maps[i]['definition'],
        remembered: maps[i]['remembered'],
        isMarked: (maps[i]['isMarked'] == 0) ? false : true,
        isStudied: (maps[i]['isStudied'] == 0) ? false : true,
      );
    });
  }

  Future<List<WordModel>> unstudiedWords() async {
    final List<Map<String, dynamic>> maps =
        await _database.query('words', where: "isStudied = ?", whereArgs: [0]);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return WordModel(
        stt: maps[i]['stt'].toString(),
        word: maps[i]['word'],
        pronounciation: maps[i]['pronounciation'],
        definition: maps[i]['definition'],
        remembered: maps[i]['remembered'],
        isMarked: (maps[i]['isMarked'] == 0) ? false : true,
        isStudied: (maps[i]['isStudied'] == 0) ? false : true,
      );
    });
  }

  Future<void> updateWord(WordModel word) async {
    await _database.update(
      'words',
      WordModel.toMap(word),
      where: "id = ?",
      whereArgs: [int.parse(word.getStt)],
    );
  }

  Future<void> deleteWord(int id) async {
    await _database.delete(
      'words',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
