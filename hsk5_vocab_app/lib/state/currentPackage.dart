import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';

class CurrentPackage extends ChangeNotifier {
  PackageModel _packageModel = PackageModel();

  PackageModel get getPackageModel => _packageModel;

  void setCurrentPackage(
      int startIndex, int endIndex, String name, int numOfRooms) {
    _packageModel.startIndex = startIndex;
    _packageModel.endIndex = endIndex;
    _packageModel.name = name;
    _packageModel.numOfRooms = numOfRooms;
    // notifyListeners();
  }
}
