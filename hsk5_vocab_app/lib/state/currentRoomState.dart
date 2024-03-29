import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/roomModel.dart';

class CurrentRoom extends ChangeNotifier {
  RoomModel _roomModel = RoomModel();

  RoomModel get getRoomModel => _roomModel;

  void setCurrentRoom(int startIndex, int numOfCards, String roomName) {
    _roomModel.startIndex = startIndex;
    _roomModel.numOfCards = numOfCards;
    _roomModel.roomName = roomName;
    // notifyListeners();
  }
}
