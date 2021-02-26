import 'package:flutter/foundation.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/localModels/historyModel.dart';
import 'package:hsk5_vocab_app/services/databaseService.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class HistoryService {
  // static final HistoryService _instance = HistoryService._();
  // Database _database;

  // factory HistoryService() {
  //   return _instance;
  // }

  // HistoryService._() {
  //   debugPrint("init1");
  //   _initDatabase();
  // }
  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }

  // void _initDatabase() async {
  //   debugPrint("init2");
  //   final localPath = await _localPath;
  //   debugPrint(localPath);
  //   final path = await getDatabasesPath();
  //   debugPrint(path);
  //   _database = await openDatabase(
  //     // Set the path to the database. Note: Using the `join` function from the
  //     // `path` package is best practice to ensure the path is correctly
  //     // constructed for each platform.
  //     join(path, 'word_database.db'),
  //     // When the database is first created, create a table to store dogs.
  //     onCreate: (db, version) {
  //       return db.execute(
  //         "CREATE TABLE history(id INTEGER PRIMARY KEY, numOfCards INTEGER, studiedType TEXT, packageName TEXT, roomName TEXT, dateTime TEXT)",
  //       );
  //     },
  //     // Set the version. This executes the onCreate function and provides a
  //     // path to perform database upgrades and downgrades.
  //     version: 1,
  //   );
  // }

  Future<void> deleteHistory() async {
    await DatabaseService().database.delete("history");
  }

  Future<void> insertHistory(HistoryModel historyModel) async {
    // Get a reference to the database.

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    final id = await DatabaseService().database.insert(
          'history',
          HistoryModel.toMap(historyModel),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    debugPrint("id" + id.toString());
  }

  //query limit
  // Future<List<Map<String, dynamic>>> queryOne(int id) async {
  //   return _database.query("history",
  //       where: "id = ?", whereArgs: [id], limit: 1);
  // }

  // Future<List<HistoryModel>> getHistory() async {
  //   final List<Map<String, dynamic>> maps = await _database.query('history');

  //   // Convert the List<Map<String, dynamic> into a List<Dog>.
  //   return List.generate(maps.length, (i) {
  //     return HistoryModel(
  //       dateTime: DateTime.parse(maps[i]['dateTime']),
  //       packageName: maps[i]['packageName'],
  //       roomName: maps[i]['roomName'],
  //       numOfCard: int.parse(maps[i]['numOfCards']),
  //       studiedType: maps[i]['studiedType'],
  //     );
  //   });
  // }

  Future<List<HistoryModel>> getHistoryLimitOffset(int page) async {
    int _limit = 10;
    final List<Map<String, dynamic>> maps =
        await DatabaseService().database.query(
              "history",
              //  limit: _limit, offset: page
            );

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return HistoryModel(
        dateTime: DateTime.parse(maps[i]['dateTime']),
        packageName: maps[i]['packageName'],
        roomName: maps[i]['roomName'],
        numOfCard: maps[i]['numOfCards'],
        studiedType: maps[i]['studiedType'],
      );
    });
  }

  Future<void> deleteOneHistory(int id) async {
    await DatabaseService().database.delete(
      'history',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
