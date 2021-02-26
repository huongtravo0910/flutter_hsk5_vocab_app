import 'package:flutter/foundation.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/localModels/historyModel.dart';
import 'package:hsk5_vocab_app/services/databaseService.dart';
import 'package:sqflite/sqflite.dart';

class HistoryService {
  Future<void> deleteHistory() async {
    await DatabaseService().database.delete("history");
  }

  Future<void> insertHistory(HistoryModel historyModel) async {
    final id = await DatabaseService().database.insert(
          'history',
          HistoryModel.toMap(historyModel),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    debugPrint("id" + id.toString());
  }

  Future<List<HistoryModel>> getHistoryLimitOffset(int size) async {
    int _limit = size;
    final List<Map<String, dynamic>> maps = await DatabaseService()
        .database
        .query("history", orderBy: "id DESC", limit: _limit);

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
