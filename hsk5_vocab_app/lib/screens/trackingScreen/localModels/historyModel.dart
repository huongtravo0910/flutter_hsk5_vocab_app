import 'dart:convert';

class HistoryModel {
  DateTime dateTime;
  DateTime getDateTime() {
    return dateTime;
  }

  String packageName;
  String getPackageName() {
    return packageName;
  }

  String roomName;
  String getroomName() {
    return roomName;
  }

  String studiedType;
  String getStudiedType() {
    return studiedType;
  }

  int numOfCard;
  int getNumOfCards() {
    return numOfCard;
  }

  HistoryModel(
      {this.dateTime,
      this.packageName,
      this.studiedType,
      this.numOfCard,
      this.roomName});

  //from Model to String

  static String encode(List<HistoryModel> historyList) {
    return json.encode(historyList
        .map<Map<String, dynamic>>((history) => toMap(history))
        .toList());
  }

  static Map<String, dynamic> toMap(HistoryModel history) {
    return {
      "numOfCards": history.getNumOfCards(),
      "studiedType": history.getStudiedType(),
      "packageName": history.getPackageName(),
      "roomName": history.getroomName(),
      "dateTime": history.getDateTime().toString(),
    };
  }

  //From String to Model List

  static List<HistoryModel> decode(String historyList) =>
      (json.decode(historyList) as List<dynamic>)
          .map<HistoryModel>((item) => HistoryModel.fromJson(item))
          .toList();

  factory HistoryModel.fromJson(Map<String, dynamic> jsonData) {
    return HistoryModel(
      dateTime: DateTime.parse(jsonData['dateTime']),
      numOfCard: int.parse(jsonData['numOfCards']),
      studiedType: jsonData['studiedType'],
      packageName: jsonData['packageName'],
      roomName: jsonData['roomName'],
    );
  }
}
