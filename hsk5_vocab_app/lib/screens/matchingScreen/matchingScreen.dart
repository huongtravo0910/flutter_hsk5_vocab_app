import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/choiceModel.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';
import 'package:hsk5_vocab_app/models/roomModel.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/localWidgets/matchingCard.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:provider/provider.dart';

class MatchingScreen extends StatefulWidget {
  @override
  _MatchingScreenState createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  int score;
  dynamic _data;
  List<ChoiceModel> choices = [];
  int seed = 0;
  int _actualNumOfCards;
  bool gameOver;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));
    gameOver = false;
    score = 0;
  }

  void _fetchData(BuildContext context) async {
    try {
      var jsonData = await DefaultAssetBundle.of(context)
          .loadString("assets/completeHsk5Vocab.json");
      _data = json.decode(jsonData);
      RoomModel _currentRoom =
          Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
      PackageModel _currentPackage =
          Provider.of<CurrentPackage>(context, listen: false).getPackageModel;

      (_currentPackage.endIndex >
              (_currentRoom.startIndex + _currentRoom.numOfCards))
          ? setState(() {
              _actualNumOfCards = _currentRoom.numOfCards;
            })
          : setState(() {
              _actualNumOfCards =
                  _currentPackage.endIndex - _currentRoom.startIndex + 1;
            });
      setState(() {
        for (var i = _currentRoom.startIndex;
            i < _currentRoom.startIndex + _currentRoom.numOfCards;
            i++) {
          try {
            choices.add(ChoiceModel(
                word: _data[i]["word"], definition: _data[i]["definition"]));
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score : $score/${_actualNumOfCards.toString()}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            score = 0;
            seed++;
          });
        },
        child: Icon(Icons.refresh),
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
                              mainText: choice.word,
                              isChosen: false,
                            ),
                            feedback: MatchingCard(
                              mainText: choice.word,
                              isChosen: false,
                            ),
                            childWhenDragging: MatchingCard(
                              mainText: choice.word,
                              isChosen: false,
                            ));
                      }).toList()
                        ..shuffle(Random(seed + 1))),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: choices
                        .map((choice) => _buildDragTarget(choice))
                        .toList()
                          ..shuffle(Random(seed)),
                  ),
                ),
              ],
            ),
          if (gameOver) Text("Game Over"),
        ],
      ),
    );
  }

  Widget _buildDragTarget(ChoiceModel choice) {
    return DragTarget<ChoiceModel>(
      builder:
          (BuildContext context, List<ChoiceModel> incoming, List rejected) {
        return MatchingCard(
          mainText: choice.definition,
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
