import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';

import 'package:hsk5_vocab_app/models/roomModel.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/backCard.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/multipyButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/nextButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/previousButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/tickButton.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomBar.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/roundedAlertBox.dart';

import 'package:provider/provider.dart';

import 'localWidgets/movingCard.dart';

class RevealScreen extends StatefulWidget {
  @override
  _RevealScreenState createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> {
  bool _isTouched;
  WordModel _currentWord;
  RoomModel _currentRoom;
  PackageModel _currentPackage;
  dynamic _data;
  int _currentWordNoInData;
  int _numOfCards;
  int _wordNoInRoom;
  int _numOfRememberedWords;
  int _numOfForgotWords;
  bool _isFreezed;
  String _roomName = "";
  String _pakageName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));
    _wordNoInRoom = 1;
    _numOfRememberedWords = 0;
    _numOfForgotWords = 0;
    _isFreezed = false;
    _isTouched = false;
  }

  void _fetchData(BuildContext context) async {
    var jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/completeHsk5Vocab.json");
    _data = json.decode(jsonData);
    _currentRoom =
        Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
    _currentPackage =
        Provider.of<CurrentPackage>(context, listen: false).getPackageModel;

    setState(() {
      _currentWordNoInData = _currentRoom.startIndex;
      (_currentPackage.endIndex >
              (_currentRoom.startIndex + _currentRoom.numOfCards))
          ? _numOfCards = _currentRoom.numOfCards
          : _numOfCards =
              _currentPackage.endIndex - _currentRoom.startIndex + 1;

      _currentWord = WordModel(
        stt: _data[_currentWordNoInData]["no"],
        definition: _data[_currentWordNoInData]["definition"],
        pronounciation: _data[_currentWordNoInData]["pronunciation"],
        word: _data[_currentWordNoInData]["word"],
      );
      _roomName = _currentRoom.roomName;
    });
  }

  void goPrevious() {
    setState(() {
      _currentWordNoInData -= 1;
      _currentWord = WordModel(
        stt: _data[_currentWordNoInData]["no"],
        definition: _data[_currentWordNoInData]["definition"],
        pronounciation: _data[_currentWordNoInData]["pronunciation"],
        word: _data[_currentWordNoInData]["word"],
      );
      _wordNoInRoom -= 1;
    });
  }

  void goNext() {
    setState(() {
      _currentWordNoInData += 1;
      _currentWord = WordModel(
        stt: _data[_currentWordNoInData]["no"],
        definition: _data[_currentWordNoInData]["definition"],
        pronounciation: _data[_currentWordNoInData]["pronunciation"],
        word: _data[_currentWordNoInData]["word"],
      );
      _wordNoInRoom += 1;

      _isTouched = false;
      _isFreezed = false;
    });
  }

  void _countRememberedWord() {
    if (_isFreezed == false) {
      setState(() {
        _numOfRememberedWords += 1;
        debugPrint("remember" + _numOfRememberedWords.toString());
      });
    }
    setState(() {
      _isFreezed = true;
    });
    if (_numOfCards == _wordNoInRoom) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _showMyDialog();
      });
    }
  }

  void _countForgotWord() {
    if (_isFreezed == false) {
      setState(() {
        _numOfForgotWords += 1;
        debugPrint("forgot" + _numOfForgotWords.toString());
      });
    }
    setState(() {
      _isFreezed = true;
    });
    if (_numOfCards == _wordNoInRoom) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _showMyDialog();
      });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return RoundedAlertBox(
          child: Column(
            children: [
              Text(
                "Tu nho:" + _numOfRememberedWords.toString(),
                style: TextStyle(color: Colors.green[900]),
              ),
              Text("Tu quen:" + _numOfForgotWords.toString(),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  )),
            ],
          ),
          onPressed: () {
            (_currentWordNoInData < 1299) ? _goToNextRoom() : _backToHome();
          },
        );
      },
    );
  }

  void _backToHome() {
    debugPrint("Hello");
    Navigator.of(context).pushNamed("/");
  }

  void _goToNextRoom() {
    Navigator.of(context).pop();
    int noOfRoom = 0;
    int noOfPackage = 0;
    noOfPackage = int.parse(
        _currentPackage.name.substring(_currentPackage.name.length - 1));
    if (_roomName.length == 7) {
      noOfRoom = int.parse(_roomName.substring(_roomName.length - 1));
    } else if (_roomName.length == 8) {
      noOfRoom = int.parse(_roomName.substring(_roomName.length - 2));
    } else if (_roomName.length == 9) {
      noOfRoom = int.parse(_roomName.substring(_roomName.length - 3));
    }
    debugPrint("noOfRoom" + noOfRoom.toString());
    if (noOfRoom < _currentPackage.numOfRooms) {
      setState(() {
        _roomName = "Phong " + (noOfRoom + 1).toString();
      });
    } else {
      _pakageName = "Goi " + (noOfPackage + 1).toString();
      _roomName = "Phong 1";
    }

    setState(() {
      _currentWordNoInData += 1;
      (_currentPackage.endIndex >
              (_currentRoom.startIndex + _currentRoom.numOfCards))
          ? _numOfCards = _currentRoom.numOfCards
          : _numOfCards =
              _currentPackage.endIndex - _currentRoom.startIndex + 1;

      _currentWord = WordModel(
        stt: _data[_currentWordNoInData]["no"],
        definition: _data[_currentWordNoInData]["definition"],
        pronounciation: _data[_currentWordNoInData]["pronunciation"],
        word: _data[_currentWordNoInData]["word"],
      );
    });
    Provider.of<CurrentRoom>(context, listen: false)
        .setCurrentRoom(_currentWordNoInData, _numOfCards, _roomName);
    switch (_pakageName) {
      case "Goi 1":
        {
          Provider.of<CurrentPackage>(context, listen: false).setCurrentPackage(
              0, 249, _pakageName, ((249 - 0 + 1) / _numOfCards).ceil());
        }
        break;
      case "Goi 2":
        {
          Provider.of<CurrentPackage>(context, listen: false).setCurrentPackage(
              250, 499, _pakageName, ((499 - 250 + 1) / _numOfCards).ceil());
        }
        break;
      case "Goi 3":
        {
          Provider.of<CurrentPackage>(context, listen: false).setCurrentPackage(
              500, 749, _pakageName, ((749 - 500 + 1) / _numOfCards).ceil());
        }
        break;
      case "Goi 4":
        {
          Provider.of<CurrentPackage>(context, listen: false).setCurrentPackage(
              750, 999, _pakageName, ((999 - 750 + 1) / _numOfCards).ceil());
        }
        break;
      case "Goi 5":
        {
          Provider.of<CurrentPackage>(context, listen: false).setCurrentPackage(
              1000,
              1299,
              _pakageName,
              ((1299 - 1000 + 1) / _numOfCards).ceil());
        }
        break;
      case "Goi 6":
        {
          Provider.of<CurrentPackage>(context, listen: false).setCurrentPackage(
              0, 1299, _pakageName, ((1299 - 0 + 1) / _numOfCards).ceil());
        }
        break;
    }
    setState(() {
      _isTouched = false;
      _wordNoInRoom = 1;
      _numOfRememberedWords = 0;
      _numOfForgotWords = 0;
      _isFreezed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(
            imageURL: "assets/images/bg2.png",
          ),
          Stack(
            children: [
              CustomedAppBar(
                child: Text(
                  _wordNoInRoom.toString() + "/" + _numOfCards.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              if (_currentWord != null)
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    MovingCardWidget(
                      urlFront: _currentWord.getWord,
                      urlBack: "/" + _currentWord.getPronounciation + "/",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _isTouched
                        ? Center(
                            child: BackCard(
                              text: _currentWord.getDefinition,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              Column(
                children: [
                  SizedBox(height: 300),
                  !_isTouched
                      ? Center(
                          child: Icon(
                            Icons.touch_app,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            size: 70,
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (_wordNoInRoom > 1)
                          ? PreviousButton(onPressed: () => goPrevious())
                          : SizedBox(width: 30),
                      SizedBox(
                        width: 5,
                      ),
                      (_wordNoInRoom != null &&
                              _numOfCards != null &&
                              _wordNoInRoom < _numOfCards)
                          ? NextButton(onPressed: () => goNext())
                          : SizedBox(width: 30),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 430,
                  ),
                  _isTouched
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TickButton(
                              onPressed: () {
                                if (_isFreezed == false) _countRememberedWord();
                              },
                            ),
                            SizedBox(width: 21),
                            MultipyButton(
                              onPressed: () {
                                if (_isFreezed == false) _countForgotWord();
                              },
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 220),
                  Center(
                    child: Container(
                      height: 200,
                      width: 350,
                      color: Colors.white.withOpacity(0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTouched = !_isTouched;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 550,
                  ),
                  BottomBar(
                    roomName:
                        (_currentRoom != null) ? _currentRoom.roomName : "",
                    packageName:
                        (_currentPackage != null) ? _currentPackage.name : "",
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
