import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/homeScreen/localWigets/homeCard.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/methodsScreen.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              _packageName = "Goi 1";
            });
          }
          break;
        case 2:
          {
            setState(() {
              _isFirstColumnChosen = [false, true, false, false, false, false];
              _packageName = "Goi 2";
            });
          }
          break;
        case 3:
          {
            setState(() {
              _isFirstColumnChosen = [false, false, true, false, false, false];
              _packageName = "Goi 3";
            });
          }
          break;
        case 4:
          {
            setState(() {
              _isFirstColumnChosen = [false, false, false, true, false, false];
              _packageName = "Goi 4";
            });
          }
          break;
        case 5:
          {
            setState(() {
              _isFirstColumnChosen = [false, false, false, false, true, false];
              _packageName = "Goi 5";
            });
          }
          break;
        case 6:
          {
            setState(() {
              _isFirstColumnChosen = [false, false, false, false, false, true];
              _packageName = "Goi 6";
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
                      "Cac goi tu vung",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    HomeCard(
                      title: "250 tu",
                      subtitle: "Goi 1",
                      isChosen: _isFirstColumnChosen[0],
                      onPressed: () => _setIndex(0, 249, 1),
                    ),
                    HomeCard(
                      title: "250 tu",
                      subtitle: "Goi 2",
                      isChosen: _isFirstColumnChosen[1],
                      onPressed: () => _setIndex(250, 499, 2),
                    ),
                    HomeCard(
                      title: "250 tu",
                      subtitle: "Goi 3",
                      isChosen: _isFirstColumnChosen[2],
                      onPressed: () => _setIndex(500, 749, 3),
                    ),
                    HomeCard(
                      title: "250 tu",
                      subtitle: "Goi 4",
                      isChosen: _isFirstColumnChosen[3],
                      onPressed: () => _setIndex(750, 999, 4),
                    ),
                    HomeCard(
                      title: "300 tu",
                      subtitle: "Goi 5",
                      isChosen: _isFirstColumnChosen[4],
                      onPressed: () => _setIndex(1000, 1299, 5),
                    ),
                    HomeCard(
                      title: "1300 tu",
                      subtitle: "Goi 6",
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
                      "So luong the",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    HomeCard(
                      title: "10",
                      isChosen: _isSecondColumnChosen[0],
                      onPressed: () => _setNumOfCards(10, 1),
                    ),
                    HomeCard(
                      title: "25",
                      isChosen: _isSecondColumnChosen[1],
                      onPressed: () => _setNumOfCards(25, 2),
                    ),
                    HomeCard(
                      title: "50",
                      isChosen: _isSecondColumnChosen[2],
                      onPressed: () => _setNumOfCards(50, 3),
                    ),
                    HomeCard(
                      title: "100",
                      isChosen: _isSecondColumnChosen[3],
                      onPressed: () => _setNumOfCards(100, 4),
                    ),
                    HomeCard(
                      title: "250",
                      isChosen: _isSecondColumnChosen[4],
                      onPressed: () => _setNumOfCards(250, 5),
                    ),
                    HomeCard(
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
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShadowButton(
                    onPressed: () {
                      _setCurrentPackage(_startIndexOfPackage,
                          _endIndexOfPackage, _packageName);

                      if (_endIndexOfPackage == 0 || _numOfCards == 0) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Please choose cards in two columns."),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        Navigator.of(context).pushNamed("/method",
                            arguments: MethodScreenArgs(
                              numOfCards: _numOfCards,
                            ));
                      }
                    },
                    child: Text(
                      "Tiep tuc",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
