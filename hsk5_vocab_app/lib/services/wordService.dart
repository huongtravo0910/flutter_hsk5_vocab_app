import 'package:flutter/foundation.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/services/databaseService.dart';
import 'package:sqflite/sqflite.dart';

class WordService {
  Future<int> countAllWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(await DatabaseService()
          .database
          .rawQuery('SELECT COUNT(*) FROM words;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<int> countForgotWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(await DatabaseService()
          .database
          .rawQuery('SELECT COUNT(*) FROM words WHERE remembered = 0;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<int> countRememberedWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(await DatabaseService()
          .database
          .rawQuery('SELECT COUNT(*) FROM words WHERE remembered = 1;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<int> countMarkedWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(await DatabaseService()
          .database
          .rawQuery('SELECT COUNT(*) FROM words WHERE isMarked = 1;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<int> countUnStudiedWords() async {
    int _count = 0;
    try {
      _count = Sqflite.firstIntValue(await DatabaseService()
          .database
          .rawQuery('SELECT COUNT(*) FROM words WHERE isStudied = 0;'));
    } catch (e) {
      debugPrint(e.toString());
    }
    return _count;
  }

  Future<void> insertWord(WordModel word) async {
    await DatabaseService().database.insert(
          'words',
          WordModel.toMap(word),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
  }

  Future<List<Map<String, dynamic>>> queryOne(int id) async {
    return DatabaseService()
        .database
        .query("words", where: "id = ?", whereArgs: [id], limit: 1);
  }

  Future<List<WordModel>> words() async {
    final List<Map<String, dynamic>> maps =
        await DatabaseService().database.query('words');

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
    final List<Map<String, dynamic>> maps = await DatabaseService()
        .database
        .query('words', where: "remembered = ?", whereArgs: [0]);

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
    final List<Map<String, dynamic>> maps = await DatabaseService()
        .database
        .query('words', where: "isMarked = ?", whereArgs: [1]);

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
    final List<Map<String, dynamic>> maps = await DatabaseService()
        .database
        .query('words', where: "isStudied = ?", whereArgs: [0]);

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
    await DatabaseService().database.update(
      'words',
      WordModel.toMap(word),
      where: "id = ?",
      whereArgs: [int.parse(word.getStt)],
    );
  }

  Future<void> deleteWord(int id) async {
    await DatabaseService().database.delete(
      'words',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
