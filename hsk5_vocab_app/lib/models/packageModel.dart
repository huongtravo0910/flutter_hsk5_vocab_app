class PackageModel {
  String name;
  int startIndex;
  int endIndex;
  int numOfRooms;

  PackageModel({this.endIndex, this.startIndex, this.name});
  @override
  String toString() {
    // TODO: implement toString
    return "name: " +
        name.toString() +
        "startIndex :" +
        startIndex.toString() +
        ", " +
        "endIndex : " +
        endIndex.toString() +
        " numOfRooms: " +
        numOfRooms.toString();
  }
}
