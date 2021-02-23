import 'package:flutter/material.dart';

class CurrentWordState extends ChangeNotifier {
  WordState _wordState = WordState();
  WordState get getRoomModel => _wordState;

  void setCurrentWordState(bool isWordToDefinition) {
    _wordState.isWordToState = isWordToDefinition;
    // notifyListeners();
  }
}

class WordState {
  bool isWordToState;
  WordState({this.isWordToState});
}
