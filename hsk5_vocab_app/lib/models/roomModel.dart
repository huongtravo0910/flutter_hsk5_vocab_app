class RoomModel {
  int startIndex;
  int numOfCards;
  String roomName;

  RoomModel({this.numOfCards, this.startIndex, this.roomName});
  @override
  String toString() {
    // TODO: implement toString
    return "startIndex :" +
        startIndex.toString() +
        ", " +
        "numOfCards : " +
        numOfCards.toString() +
        "roomName : " +
        roomName;
  }
}
