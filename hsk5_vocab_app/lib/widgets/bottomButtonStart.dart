import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';
import 'package:hsk5_vocab_app/models/roomModel.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/localModels/historyModel.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomButton extends StatelessWidget {
  final String route;
  final String text;
  const BottomButton({Key key, this.route, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadowButton(
              onPressed: () {
                _saveHistory(route, context);
                Navigator.pushNamed(context, route);
              },
              child: Text(
                text,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void _saveHistory(String route, BuildContext context) async {
    debugPrint("hello");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String history;
    List<HistoryModel> historyList = [];
    DateTime _thisTime = DateTime.now();
    RoomModel _currentRoom =
        Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
    PackageModel _currentPackage =
        Provider.of<CurrentPackage>(context, listen: false).getPackageModel;
    history = (_prefs.getString("historyList") != null)
        ? _prefs.getString("historyList")
        : "";
    debugPrint("history string from pref" + history);
    if (route == "/matching") {
      HistoryModel thisHistory = HistoryModel(
        dateTime: _thisTime,
        roomName: _currentRoom.roomName,
        packageName: _currentPackage.name,
        studiedType: "Noi tu",
        numOfCard: _currentRoom.numOfCards,
      );
      debugPrint("thisHistory" + thisHistory.getDateTime().toString());
      debugPrint("thisHistory" + thisHistory.getStudiedType());
      if (history != "") {
        historyList = HistoryModel.decode(history);
        historyList.insert(0, thisHistory);
      } else {
        historyList.insert(0, thisHistory);
      }
      debugPrint(
          "historyList length" + historyList[0].getDateTime().toString());
      history = HistoryModel.encode(historyList);
      debugPrint("history after" + history);
      _prefs.setString("historyList", history);
    }
    if (route == "/reveal") {
      HistoryModel thisHistory = HistoryModel(
        dateTime: _thisTime,
        roomName: _currentRoom.roomName,
        packageName: "gói" + _currentPackage.name,
        studiedType: "Flash card",
        numOfCard: _currentRoom.numOfCards,
      );
      if (history != "") {
        historyList = HistoryModel.decode(history);
        historyList.insert(0, thisHistory);
      } else {
        historyList.insert(0, thisHistory);
      }
      debugPrint("historyList" + historyList[0].toString());
      history = HistoryModel.encode(historyList);
      _prefs.setString("historyList", history);
    }
    if (route == "/quiz") {
      HistoryModel thisHistory = HistoryModel(
        dateTime: _thisTime,
        roomName: _currentRoom.roomName,
        packageName: "gói" + _currentPackage.name,
        studiedType: "Cau hoi",
        numOfCard: _currentRoom.numOfCards,
      );
      if (history != "") {
        historyList = HistoryModel.decode(history);
        historyList.insert(0, thisHistory);
      } else {
        historyList.insert(0, thisHistory);
      }
      debugPrint("historyList" + historyList[0].toString());
      history = HistoryModel.encode(historyList);
      _prefs.setString("historyList", history);
    }
  }
}
