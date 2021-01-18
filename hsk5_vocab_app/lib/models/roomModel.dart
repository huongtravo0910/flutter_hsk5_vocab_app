import 'package:flutter/material.dart';

class RoomModel {
  int startIndex;
  int numOfCards;

  RoomModel({this.numOfCards, this.startIndex});
  @override
  String toString() {
    // TODO: implement toString
    return "startIndex :" +
        startIndex.toString() +
        ", " +
        "numOfCards : " +
        numOfCards.toString();
  }
}
