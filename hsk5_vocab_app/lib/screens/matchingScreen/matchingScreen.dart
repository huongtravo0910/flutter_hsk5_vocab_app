import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
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
  Map<String, bool> score = {};
  dynamic _data;
  Map choices = {};
  int seed = 0;
  int _actualNumOfCards;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));
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
            choices[_data[i]["word"]] = _data[i]["definition"];
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
        title: Text("Score : ${score.length}/${_actualNumOfCards.toString()}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            score.clear();
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
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: choices.keys.map((value) {
                          return Draggable<String>(
                              data: value,
                              child: MatchingCard(
                                mainText: score[value] == true ? "✔️" : value,
                                isChosen: false,
                              ),
                              feedback: MatchingCard(
                                mainText: value,
                                isChosen: false,
                              ),
                              childWhenDragging: MatchingCard(
                                mainText: value,
                                isChosen: false,
                              ));
                        }).toList()
                          ..shuffle(Random(seed + 1))),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: choices.keys
                          .map((value) => _buildDragTarget(value))
                          .toList()
                            ..shuffle(Random(seed)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(key) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        if (score[key] == true) {
          return MatchingCard(
            mainText: "✔️",
            isChosen: false,
          );
        } else {
          return MatchingCard(
            mainText: choices[key],
            isChosen: false,
          );
        }
      },
      onWillAccept: (data) => data == key,
      onAccept: (data) {
        setState(() {
          score[key] = true;
        });
      },
      onLeave: (data) {},
    );
  }
}
