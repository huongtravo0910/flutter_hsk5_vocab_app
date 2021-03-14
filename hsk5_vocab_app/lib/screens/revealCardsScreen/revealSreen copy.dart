import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';

import 'package:hsk5_vocab_app/models/roomModel.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/backCard.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/markedDialog.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/multipyButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/nextButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/previousButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/tickButton.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/localModels/historyModel.dart';
import 'package:hsk5_vocab_app/services/historyService.dart';
import 'package:hsk5_vocab_app/services/wordService.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomBar.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/drawer.dart';
import 'package:hsk5_vocab_app/widgets/roundedAlertBox.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localWidgets/movingCard.dart';

class RevealScreen extends StatefulWidget {
  @override
  _RevealScreenState createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _isWordToDefinition;
  bool _isTouched;
  WordModel _currentWord;
  RoomModel _currentRoom;
  PackageModel _currentPackage;
  List<WordModel> _data;
  int _currentWordNoInData;
  int _numOfCards;
  int _wordNoInRoom;
  List<int> _rememberedWordsList;
  List<int> _forgotWordsList;

  String _roomName = "";
  String _pakageName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));
    _wordNoInRoom = 1;
    _rememberedWordsList = [];
    _forgotWordsList = [];
    _isTouched = false;
  }

  void _fetchData(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _isWordToDefinition = _prefs.getBool("isWordToDefinitionState");
    _currentRoom =
        Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
    _currentPackage =
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
    debugPrint(
        "endIndexOfPackage when fetched" + _currentPackage.endIndex.toString());
    Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _currentWordNoInData = _currentRoom.startIndex;
      (_currentPackage.endIndex >=
              (_currentRoom.startIndex + _currentRoom.numOfCards - 1))
          ? _numOfCards = _currentRoom.numOfCards
          : _numOfCards =
              _currentPackage.endIndex - _currentRoom.startIndex + 1;

      _currentWord = _data[_currentWordNoInData];
      _roomName = _currentRoom.roomName;
      _pakageName = _currentPackage.name;
    });
  }

  void _goPrevious() async {
    _countForgotWord(_currentWord);
    _countRememberedWord(_currentWord);
    setState(() {
      _currentWordNoInData -= 1;
      _data[_currentWordNoInData].isStudied = true;
      _currentWord = _data[_currentWordNoInData];
      _wordNoInRoom -= 1;
      _isTouched = false;
    });
    debugPrint("goPrev Word: " + _currentWord.toString());
  }

  void _goNext() async {
    _countForgotWord(_currentWord);
    _countRememberedWord(_currentWord);
    debugPrint("_data.length" + _data.length.toString());
    debugPrint("endPackageIndex" + _currentPackage.endIndex.toString());
    debugPrint("_currentWordNoInData" + _currentWordNoInData.toString());
    setState(() {
      _currentWordNoInData += 1;
      _currentWord = _data[_currentWordNoInData];
      _wordNoInRoom += 1;
      _isTouched = false;
    });
  }

  void _countRememberedWord(WordModel word) {
    debugPrint("_rememberedWordsList isEmpty: " +
        _rememberedWordsList.isEmpty.toString());
    bool isWordExistedInForgotArr = false;
    bool isWordExistedInRememberedArr = false;
    if (_currentWord.remembered == 1 &&
        _rememberedWordsList != null &&
        _rememberedWordsList != [] &&
        _rememberedWordsList.isNotEmpty &&
        isWordExistedInRememberedArr == false) {
      for (var i = 0; i < _rememberedWordsList.length; i++) {
        if (int.parse(word.getStt) == _rememberedWordsList[i]) {
          isWordExistedInRememberedArr = true;
        }
      }
      debugPrint("isWordExistedInRememberedArr" +
          isWordExistedInRememberedArr.toString());

      setState(() {
        _rememberedWordsList.add(int.parse(word.getStt));
        debugPrint("remember after add" + _rememberedWordsList.toString());
      });
    }
    if (_currentWord.remembered == 1 && isWordExistedInRememberedArr == true) {
      setState(() {
        _rememberedWordsList.remove(int.parse(word.getStt));
        debugPrint("remember after remove" + _rememberedWordsList.toString());
      });
    }
    if (_currentWord.remembered == 1 && _rememberedWordsList.isEmpty) {
      _rememberedWordsList.add(int.parse(word.getStt));
      debugPrint("remember" + _rememberedWordsList.toString());
    }
    if (_currentWord.remembered == 0 && isWordExistedInForgotArr == false) {
      for (var i = 0; i < _rememberedWordsList.length; i++) {
        if (_rememberedWordsList[i].toString() == word.getStt) {
          isWordExistedInForgotArr = true;
        }
      }
    }
    if (_currentWord.remembered == 0 && isWordExistedInForgotArr == true) {
      _rememberedWordsList.remove(int.parse(word.getStt));
      debugPrint("remember after fix" + _rememberedWordsList.toString());
    }
  }

  Future<void> _saveStudiedWord() async {
    debugPrint("save word");
    setState(() {
      _currentWord.isStudied = true;
    });
    await WordService().updateWord(_currentWord);
  }

  Future<void> _saveRememberedWord() async {
    debugPrint("beforesaved " + _currentWord.toString());
    setState(() {
      _currentWord.remembered = 1;
    });
    debugPrint("after saved: " + _currentWord.toString());
    await WordService().updateWord(_currentWord);
  }

  void _countForgotWord(WordModel word) {
    bool isWordExistedInForgotArr = false;
    bool isWordExistedInRememberedArr = false;
    debugPrint(
        "_forgotWordsList isEmpty : " + _forgotWordsList.isEmpty.toString());

    if (_currentWord.remembered == 0 &&
        _forgotWordsList != [] &&
        _forgotWordsList != null &&
        _forgotWordsList.isNotEmpty &&
        isWordExistedInForgotArr == false) {
      for (var i = 0; i < _forgotWordsList.length; i++) {
        if (_forgotWordsList[i] == int.parse(word.getStt)) {
          isWordExistedInForgotArr = true;
        }
      }
      debugPrint(
          "isWordExistedInForgotArr" + isWordExistedInForgotArr.toString());

      setState(() {
        _forgotWordsList.add(int.parse(word.getStt));
        debugPrint("forgot after add :" + _forgotWordsList.toString());
      });
    }
    if (_currentWord.remembered == 0 && isWordExistedInForgotArr == true) {
      setState(() {
        _forgotWordsList.remove(int.parse(word.getStt));
        debugPrint("forgot after remove : " + _forgotWordsList.toString());
      });
    }
    if (_currentWord.remembered == 0 && _forgotWordsList.isEmpty) {
      setState(() {
        _forgotWordsList.add(int.parse(word.getStt));
        debugPrint("forgot" + _forgotWordsList.length.toString());
      });
    }

    if (_currentWord.remembered == 1 && isWordExistedInRememberedArr == false) {
      for (var i = 0; i < _forgotWordsList.length; i++) {
        if (_forgotWordsList[i].toString() == word.getStt) {
          isWordExistedInRememberedArr = true;
        }
      }
    }
    if (_currentWord.remembered == 1 && isWordExistedInRememberedArr == true) {
      _forgotWordsList.remove(int.parse(word.getStt));
      debugPrint("forgot after fix" + _forgotWordsList.length.toString());
    }
  }

  Future<void> _saveForgotWord() async {
    setState(() {
      _currentWord.remembered = 0;
    });
    await WordService().updateWord(_currentWord);
  }

  Future<void> _saveIsMarkedWord() async {
    await WordService().updateWord(_currentWord);
    debugPrint("isMaredWord" + _currentWord.toString());
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
                "Từ nhớ:" + _rememberedWordsList.length.toString(),
                style: TextStyle(color: Colors.green[900]),
              ),
              Text("Từ quên:" + _forgotWordsList.length.toString(),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  )),
            ],
          ),
          onPressed: () {
            (_currentWordNoInData + 1 < _data.length)
                ? _goToNextRoom()
                : _backToHome();
          },
        );
      },
    );
  }

  void _backToHome() {
    debugPrint("Hello");
    if (_currentPackage.name == "Từ chưa nhớ" ||
        _currentPackage.name == "Từ đánh dấu" ||
        _currentPackage.name == "Từ mới") {
      Navigator.of(context).pushNamed("/review");
    } else {
      Navigator.of(context).pushNamed("/completevocab");
    }
  }

  void _goToNextRoom() {
    Navigator.of(context).pop();

    if (_currentPackage.name != "Từ chưa nhớ" &&
        _currentPackage.name != "Từ đánh dấu" &&
        _currentPackage.name != "Từ mới") {
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
          _roomName = "Phòng " + (noOfRoom + 1).toString();
        });
      } else {
        _pakageName = "Gói " + (noOfPackage + 1).toString();
        _roomName = "Phòng 1";
      }

      setState(() {
        _currentWord = _data[_currentWordNoInData];
        (_currentPackage.endIndex >
                (_currentRoom.startIndex + _currentRoom.numOfCards))
            ? _numOfCards = _currentRoom.numOfCards
            : _numOfCards =
                _currentPackage.endIndex - _currentRoom.startIndex + 1;
      });
      Provider.of<CurrentRoom>(context, listen: false)
          .setCurrentRoom(_currentWordNoInData, _numOfCards, _roomName);
      switch (_pakageName) {
        case "Gói 1":
          {
            Provider.of<CurrentPackage>(context, listen: false)
                .setCurrentPackage(
                    0, 249, _pakageName, ((249 - 0 + 1) / _numOfCards).ceil());
          }
          break;
        case "Gói 2":
          {
            Provider.of<CurrentPackage>(context, listen: false)
                .setCurrentPackage(250, 499, _pakageName,
                    ((499 - 250 + 1) / _numOfCards).ceil());
          }
          break;
        case "Gói 3":
          {
            Provider.of<CurrentPackage>(context, listen: false)
                .setCurrentPackage(500, 749, _pakageName,
                    ((749 - 500 + 1) / _numOfCards).ceil());
          }
          break;
        case "Gói 4":
          {
            Provider.of<CurrentPackage>(context, listen: false)
                .setCurrentPackage(750, 999, _pakageName,
                    ((999 - 750 + 1) / _numOfCards).ceil());
          }
          break;
        case "Gói 5":
          {
            Provider.of<CurrentPackage>(context, listen: false)
                .setCurrentPackage(1000, 1299, _pakageName,
                    ((1299 - 1000 + 1) / _numOfCards).ceil());
          }
          break;
        case "Gói 6":
          {
            Provider.of<CurrentPackage>(context, listen: false)
                .setCurrentPackage(0, 1299, _pakageName,
                    ((1299 - 0 + 1) / _numOfCards).ceil());
          }
          break;
      }
    } else {
      debugPrint("1");
      int noOfRoom = 0;
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
          _roomName = "Phòng " + (noOfRoom + 1).toString();
        });
      }
      debugPrint("endPkIndex " + _currentPackage.endIndex.toString());

      setState(() {
        _currentWord = _data[_currentWordNoInData];
        (_currentPackage.endIndex >
                (_currentRoom.startIndex + _currentRoom.numOfCards))
            ? _numOfCards = _currentRoom.numOfCards
            : _numOfCards =
                _currentPackage.endIndex - _currentRoom.startIndex + 1;
      });
      debugPrint("_numOfCards " + _numOfCards.toString());
      Provider.of<CurrentRoom>(context, listen: false)
          .setCurrentRoom(_currentWordNoInData, _numOfCards, _roomName);
    }
    setState(() {
      _isTouched = false;
      _wordNoInRoom = 1;
      _currentWordNoInData += 1;
      _rememberedWordsList = [];
      _forgotWordsList = [];
    });
    DateTime thisTime = DateTime.now();
    HistoryService().insertHistory(HistoryModel(
      dateTime: thisTime,
      packageName: _currentPackage.name,
      numOfCard: _numOfCards,
      roomName: _currentRoom.roomName,
      studiedType: "Flash card",
    ));
  }

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: CustomedDrawer(),
        key: _key,
        floatingActionButton: (_numOfCards == _wordNoInRoom)
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                mini: true,
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    _showMyDialog();
                  });
                },
                child: Icon(
                  Icons.done,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              )
            : SizedBox.shrink(),
        body: Stack(
          children: [
            Background(
              imageURL: "assets/images/bg2.png",
            ),
            CustomedAppBar(
              globalKey: _key,
              child: Text(
                _wordNoInRoom.toString() + "/" + _numOfCards.toString(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Stack(
              children: [
                if (_currentWord != null)
                  Column(
                    children: [
                      SizedBox(
                        height: _deviceWidth / 3,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return MarkedDialog(
                                    checkbox: Checkbox(
                                      value: _currentWord.isMarked,
                                      onChanged: (value) {
                                        setState(() {
                                          _currentWord.isMarked =
                                              !_currentWord.isMarked;
                                        });
                                        _saveIsMarkedWord();
                                      },
                                    ),
                                  );
                                });
                              });
                        },
                        child: MovingCardWidget(
                          urlFront: _isWordToDefinition
                              ? _currentWord.getWord
                              : _currentWord.getDefinition,
                          urlBack: "/" + _currentWord.getPronounciation + "/",
                        ),
                      ),
                      SizedBox(
                        height: _deviceHeight / 20,
                      ),
                      _isTouched
                          ? Center(
                              child: BackCard(
                                text: _isWordToDefinition
                                    ? _currentWord.getDefinition
                                    : _currentWord.getWord,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                Column(
                  children: [
                    Spacer(),
                    SizedBox(height: _deviceHeight / 8),
                    !_isTouched
                        ? Center(
                            child: Icon(
                              Icons.touch_app,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              size: 70,
                            ),
                          )
                        : SizedBox.shrink(),
                    Spacer(),
                  ],
                ),
                Column(
                  children: [
                    Spacer(),
                    SizedBox(
                      height: _deviceHeight / 3 * 2,
                    ),
                    _isTouched
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TickButton(
                                onPressed: () {
                                  _countRememberedWord(_currentWord);
                                  _saveRememberedWord();
                                },
                                isRemembered: _currentWord.remembered,
                              ),
                              SizedBox(width: 21),
                              MultipyButton(
                                onPressed: () {
                                  _countForgotWord(_currentWord);
                                  _saveForgotWord();
                                },
                                isRemembered: _currentWord.remembered,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    Spacer(),
                  ],
                ),
                Column(
                  children: [
                    Spacer(),
                    SizedBox(height: _deviceHeight / 8),
                    Center(
                      child: Container(
                        height: _deviceHeight / 3 * 1.5,
                        width: _deviceWidth * 9 / 10,
                        color: Colors.white.withOpacity(0.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isTouched = !_isTouched;
                              _saveStudiedWord();
                            });
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         (_wordNoInRoom > 1)
            //             ? PreviousButton(onPressed: () => _goPrevious())
            //             : SizedBox(width: 30),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         (_wordNoInRoom != null &&
            //                 _numOfCards != null &&
            //                 _wordNoInRoom < _numOfCards)
            //             ? NextButton(onPressed: () {
            //                 _saveStudiedWord();
            //                 _goNext();
            //               })
            //             : SizedBox(width: 30),
            //       ],
            //     ),
            //     SizedBox(
            //       height: 40,
            //     ),
            //   ],
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 550,
                ),
                BottomBar(
                  roomName: (_currentRoom != null) ? _currentRoom.roomName : "",
                  packageName:
                      (_currentPackage != null) ? _currentPackage.name : "",
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
