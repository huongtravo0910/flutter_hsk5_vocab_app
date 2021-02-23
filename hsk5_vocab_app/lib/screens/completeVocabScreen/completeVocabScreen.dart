import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/bottomButtonContinue.dart';
import 'package:hsk5_vocab_app/screens/completeVocabScreen/localWigets/completeVocabCard.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/methodsScreen.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/drawer.dart';
import 'package:provider/provider.dart';

class CompleteVocabScreen extends StatefulWidget {
  @override
  _CompleteVocabScreenState createState() => _CompleteVocabScreenState();
}

class _CompleteVocabScreenState extends State<CompleteVocabScreen> {
  int _startIndexOfPackage = 0;
  int _endIndexOfPackage = 0;
  int _numOfCards = 0;
  int _numOfRooms = 0;
  String _packageName = "";

  List<bool> _isFirstColumnChosen = [false, false, false, false, false, false];
  List<bool> _isSecondColumnChosen = [false, false, false, false, false, false];

  void _setCurrentPackage(int startIndex, int endIndex, String packageName) {
    _numOfRooms = ((endIndex - startIndex + 1) / _numOfCards).ceil();
    Provider.of<CurrentPackage>(context, listen: false)
        .setCurrentPackage(startIndex, endIndex, packageName, _numOfRooms);
  }

  void _setIndex(int startIndex, int endIndex, int chosenPos) {
    if (_numOfCards == 1300) {
      setState(() {
        _isFirstColumnChosen = [false, false, false, false, false, true];
      });

      setState(() {
        _startIndexOfPackage = 0;
        _endIndexOfPackage = 1299;
      });
    } else {
      switch (chosenPos) {
        case 1:
          {
            setState(() {
              _isFirstColumnChosen = [true, false, false, false, false, false];
              _packageName = "Gói 1";
            });
          }
          break;
        case 2:
          {
            setState(() {
              _isFirstColumnChosen = [false, true, false, false, false, false];
              _packageName = "Gói 2";
            });
          }
          break;
        case 3:
          {
            setState(() {
              _isFirstColumnChosen = [false, false, true, false, false, false];
              _packageName = "Gói 3";
            });
          }
          break;
        case 4:
          {
            setState(() {
              _isFirstColumnChosen = [false, false, false, true, false, false];
              _packageName = "Gói 4";
            });
          }
          break;
        case 5:
          {
            setState(() {
              _isFirstColumnChosen = [false, false, false, false, true, false];
              _packageName = "Gói 5";
            });
          }
          break;
        case 6:
          {
            setState(() {
              _isFirstColumnChosen = [false, false, false, false, false, true];
              _packageName = "Gói 6";
            });
          }
          break;
      }
      setState(() {
        _startIndexOfPackage = startIndex;
        _endIndexOfPackage = endIndex;
      });
    }
  }

  void _setNumOfCards(int numOfCards, int chosenPos) {
    switch (chosenPos) {
      case 1:
        {
          _isSecondColumnChosen = [true, false, false, false, false, false];
        }
        break;
      case 2:
        {
          _isSecondColumnChosen = [false, true, false, false, false, false];
        }
        break;
      case 3:
        {
          _isSecondColumnChosen = [false, false, true, false, false, false];
        }
        break;
      case 4:
        {
          _isSecondColumnChosen = [false, false, false, true, false, false];
        }
        break;
      case 5:
        {
          _isSecondColumnChosen = [false, false, false, false, true, false];
        }
        break;
      case 6:
        {
          _isSecondColumnChosen = [false, false, false, false, false, true];
        }
        break;
    }
    setState(() {
      _numOfCards = numOfCards;
    });
    if (numOfCards == 1300) {
      _setIndex(0, 1299, 6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomedDrawer(),
      body: Builder(
        builder: (context) => Stack(
          children: [
            Background(
              imageURL: "assets/images/bg1.png",
            ),
            Row(
              children: [
                Spacer(),
                Column(
                  children: [
                    Spacer(),
                    Text(
                      "Các gói từ vựng",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    CompleteVocabCard(
                      title: "250 tu",
                      subtitle: "Gói 1",
                      isChosen: _isFirstColumnChosen[0],
                      onPressed: () => _setIndex(0, 249, 1),
                    ),
                    CompleteVocabCard(
                      title: "250 từ",
                      subtitle: "Gói 2",
                      isChosen: _isFirstColumnChosen[1],
                      onPressed: () => _setIndex(250, 499, 2),
                    ),
                    CompleteVocabCard(
                      title: "250 từ",
                      subtitle: "Gói 3",
                      isChosen: _isFirstColumnChosen[2],
                      onPressed: () => _setIndex(500, 749, 3),
                    ),
                    CompleteVocabCard(
                      title: "250 từ",
                      subtitle: "Gói 4",
                      isChosen: _isFirstColumnChosen[3],
                      onPressed: () => _setIndex(750, 999, 4),
                    ),
                    CompleteVocabCard(
                      title: "300 từ",
                      subtitle: "Gói 5",
                      isChosen: _isFirstColumnChosen[4],
                      onPressed: () => _setIndex(1000, 1299, 5),
                    ),
                    CompleteVocabCard(
                      title: "1300 từ",
                      subtitle: "Gói 6",
                      isChosen: _isFirstColumnChosen[5],
                      onPressed: () => _setIndex(0, 1299, 6),
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Spacer(),
                    Text(
                      "Số lượng thẻ",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    CompleteVocabCard(
                      title: "10",
                      isChosen: _isSecondColumnChosen[0],
                      onPressed: () => _setNumOfCards(10, 1),
                    ),
                    CompleteVocabCard(
                      title: "25",
                      isChosen: _isSecondColumnChosen[1],
                      onPressed: () => _setNumOfCards(25, 2),
                    ),
                    CompleteVocabCard(
                      title: "50",
                      isChosen: _isSecondColumnChosen[2],
                      onPressed: () => _setNumOfCards(50, 3),
                    ),
                    CompleteVocabCard(
                      title: "100",
                      isChosen: _isSecondColumnChosen[3],
                      onPressed: () => _setNumOfCards(100, 4),
                    ),
                    CompleteVocabCard(
                      title: "250",
                      isChosen: _isSecondColumnChosen[4],
                      onPressed: () => _setNumOfCards(250, 5),
                    ),
                    CompleteVocabCard(
                      title: "1300",
                      isChosen: _isSecondColumnChosen[5],
                      onPressed: () => _setNumOfCards(1300, 6),
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
              ],
            ),
            BottomButton(onPressed: () {
              if (_endIndexOfPackage == 0 ||
                  _numOfCards == 0 ||
                  _endIndexOfPackage == null ||
                  _numOfCards == null) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Hãy chọn cả 2 cột."),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                _setCurrentPackage(
                    _startIndexOfPackage, _endIndexOfPackage, _packageName);
                Navigator.of(context).pushNamed("/method",
                    arguments: MethodScreenArgs(
                      numOfCards: _numOfCards,
                    ));
              }
            }),
          ],
        ),
      ),
    );
  }
}
