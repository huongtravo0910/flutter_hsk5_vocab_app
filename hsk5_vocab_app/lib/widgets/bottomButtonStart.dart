import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';
import 'package:hsk5_vocab_app/models/roomModel.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/localModels/historyModel.dart';
import 'package:hsk5_vocab_app/services/historyService.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';
import 'package:provider/provider.dart';

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
    try {
      debugPrint("hello");
      DateTime _thisTime = DateTime.now();
      RoomModel _currentRoom =
          Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
      PackageModel _currentPackage =
          Provider.of<CurrentPackage>(context, listen: false).getPackageModel;
      if (route == "/matching") {
        HistoryModel thisHistory = HistoryModel(
          dateTime: _thisTime,
          roomName: _currentRoom.roomName,
          packageName: _currentPackage.name,
          studiedType: "Nối từ",
          numOfCard: _currentRoom.numOfCards,
        );
        debugPrint("thisHistory" + thisHistory.getDateTime().toString());
        debugPrint("thisHistory" + thisHistory.getStudiedType());
        HistoryService().insertHistory(thisHistory);
      }
      if (route == "/reveal") {
        HistoryModel thisHistory = HistoryModel(
          dateTime: _thisTime,
          roomName: _currentRoom.roomName,
          packageName: _currentPackage.name,
          studiedType: "Flash card",
          numOfCard: _currentRoom.numOfCards,
        );
        HistoryService().insertHistory(thisHistory);
      }
      if (route == "/quiz") {
        HistoryModel thisHistory = HistoryModel(
          dateTime: _thisTime,
          roomName: _currentRoom.roomName,
          packageName: _currentPackage.name,
          studiedType: "Câu hỏi",
          numOfCard: _currentRoom.numOfCards,
        );
        HistoryService().insertHistory(thisHistory);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
