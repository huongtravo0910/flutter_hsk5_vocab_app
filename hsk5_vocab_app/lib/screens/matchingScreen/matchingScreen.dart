import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/localModels/choiceModel.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';
import 'package:hsk5_vocab_app/models/roomModel.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/localWidgets/matchingCard.dart';
import 'package:hsk5_vocab_app/services/wordService.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchingScreen extends StatefulWidget {
  @override
  _MatchingScreenState createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  bool _isWordToDefinition;
  int score;
  List<WordModel> _data;
  List<ChoiceModel> choices = [];
  List<ChoiceModel> choices2 = [];
  int seed = 0;
  int _actualNumOfCards;
  bool gameOver;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gameOver = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));
    score = 0;
  }

  void _fetchData(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _isWordToDefinition = _prefs.getBool("isWordToDefinitionState");
    try {
      RoomModel _currentRoom =
          Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
      PackageModel _currentPackage =
          Provider.of<CurrentPackage>(context, listen: false).getPackageModel;
      if (_currentPackage.name == "Từ chưa nhớ") {
        _data = await WordService().forgotWords();
      } else if (_currentPackage.name == "Từ đánh dấu") {
        _data = await WordService().markedWords();
      } else if (_currentPackage.name == "Từ mới") {
        _data = await WordService().unstudiedWords();
      } else {
        _data = await WordService().words();
      }

      (_currentPackage.endIndex >
              (_currentRoom.startIndex + _currentRoom.numOfCards))
          ? setState(() {
              _actualNumOfCards = _currentRoom.numOfCards;
            })
          : setState(() {
              _actualNumOfCards =
                  _currentPackage.endIndex - _currentRoom.startIndex;
            });
      setState(() {
        for (var i = _currentRoom.startIndex;
            i < _currentRoom.startIndex + _currentRoom.numOfCards;
            i++) {
          try {
            choices.add(ChoiceModel(
                word: _data[i].getWord, definition: _data[i].getDefinition));

            choices2.add(ChoiceModel(
                word: _data[i].getWord, definition: _data[i].getDefinition));
          } catch (e) {
            debugPrint(e.toString());
          }
        }
        choices.shuffle(Random(seed));
        choices2.shuffle(Random(seed + 1));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    (choices.length == 0) ? gameOver = true : gameOver = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Score : $score/${_actualNumOfCards.toString()}"),
        ),
        body: Stack(
          children: [
            Background(
              imageURL: "assets/images/bg2.png",
            ),
            if (!gameOver)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: choices.map((choice) {
                          return Draggable<ChoiceModel>(
                              data: choice,
                              child: MatchingCard(
                                mainText: _isWordToDefinition
                                    ? choice.word
                                    : choice.definition,
                                isChosen: false,
                              ),
                              feedback: MatchingCard(
                                mainText: _isWordToDefinition
                                    ? choice.word
                                    : choice.definition,
                                isChosen: false,
                              ),
                              childWhenDragging: MatchingCard(
                                mainText: _isWordToDefinition
                                    ? choice.word
                                    : choice.definition,
                                isChosen: false,
                              ));
                        }).toList()),
                  ),
                  SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: choices2
                            .map((choice) => _buildDragTarget(choice))
                            .toList()),
                  ),
                ],
              ),
            if (gameOver)
              Center(child: Text("Chúc mừng bạn đã hoàn thành trò chơi!")),
          ],
        ),
      ),
    );
  }

  Widget _buildDragTarget(ChoiceModel choice) {
    return DragTarget<ChoiceModel>(
      builder:
          (BuildContext context, List<ChoiceModel> incoming, List rejected) {
        return MatchingCard(
          mainText: _isWordToDefinition ? choice.definition : choice.word,
          isChosen: choice.accepting,
        );
      },
      onWillAccept: (receivedItem) {
        setState(() {
          choice.accepting = true;
        });
        return true;
      },
      onAccept: (receivedItem) {
        if (choice.definition == receivedItem.definition) {
          setState(() {
            choices.remove(receivedItem);
            choices2.remove(choice);
            score += 1;
            choice.accepting = false;
          });
        } else {
          setState(() {
            choice.accepting = false;
          });
        }
      },
      onLeave: (receivedItem) {
        setState(() {
          choice.accepting = false;
        });
      },
    );
  }
}
