import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';
import 'package:hsk5_vocab_app/models/roomModel.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/services/wordService.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomBar.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/drawer.dart';
import 'package:hsk5_vocab_app/widgets/roundedAlertBox.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localWidgets/answerBar.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  final _random = new Random();
  int min = 0;
  int max = 1299;
  List<WordModel> _data;
  List<WordModel> _completeData;
  RoomModel _currentRoom;
  PackageModel _currentPackage;
  int _currentWordNoInData;
  WordModel _currentWord;
  int _numOfCards;
  int _wordNoInRoom;
  int _firstRandomWordIndex;
  int _secondRandomWordIndex;
  int _thirdRandomWordIndex;
  int _answersCorrect;
  String _roomName = "";
  String _pakageName = "";
  List<bool> isAnswerChosen = [false, false, false, false];
  List<WordModel> choices = [];
  List<WordModel> shuffledChoices = [];

  bool _isTouched;
  bool _isFreezed;

  bool _isWordToDefinition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));
    _wordNoInRoom = 1;
    _isTouched = false;
    _answersCorrect = 0;
    _isFreezed = false;
  }

  void _fetchData(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _isWordToDefinition = _prefs.getBool("isWordToDefinitionState");
    _currentRoom =
        Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
    _currentPackage =
        Provider.of<CurrentPackage>(context, listen: false).getPackageModel;
    _completeData = await WordService().words();
    if (_currentPackage.name == "forgot") {
      _data = await WordService().forgotWords();
    } else if (_currentPackage.name == "marked") {
      _data = await WordService().markedWords();
    } else if (_currentPackage.name == "unstudied") {
      _data = await WordService().unstudiedWords();
    } else {
      _data = await WordService().words();
    }
    setState(() {
      _currentWordNoInData = _currentRoom.startIndex;
      (_currentPackage.endIndex >=
              (_currentRoom.startIndex + _currentRoom.numOfCards - 1))
          ? _numOfCards = _currentRoom.numOfCards
          : _numOfCards = _currentPackage.endIndex - _currentRoom.startIndex;

      _currentWord = _data[_currentWordNoInData];
      _roomName = _currentRoom.roomName;
      _pakageName = _currentPackage.name;
    });

    setState(() {
      _firstRandomWordIndex = min + _random.nextInt(max - min);
      if (10 <= _firstRandomWordIndex && _firstRandomWordIndex <= 1289) {
        _secondRandomWordIndex = _firstRandomWordIndex + 10;
        _thirdRandomWordIndex = _firstRandomWordIndex - 10;
      } else if (_firstRandomWordIndex < 10) {
        _secondRandomWordIndex = _firstRandomWordIndex + 10;
        _thirdRandomWordIndex = _firstRandomWordIndex + 20;
      } else if (_firstRandomWordIndex > 1289) {
        _secondRandomWordIndex = _firstRandomWordIndex - 10;
        _thirdRandomWordIndex = _firstRandomWordIndex - 20;
      }
      choices.add(_completeData[_firstRandomWordIndex]);
      choices.add(_completeData[_secondRandomWordIndex]);
      choices.add(_completeData[_thirdRandomWordIndex]);
      choices.add(_currentWord);
      shuffle(choices);
    });
  }

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  void handleOnPressed(WordModel selectedWord, int chosenPos) {
    //Chon dap an
    switch (chosenPos) {
      case 0:
        {
          setState(() {
            isAnswerChosen = [true, false, false, false];
          });
        }
        break;
      case 1:
        {
          setState(() {
            isAnswerChosen = [false, true, false, false];
          });
        }
        break;
      case 2:
        {
          setState(() {
            isAnswerChosen = [false, false, true, false];
          });
        }
        break;
      case 3:
        {
          setState(() {
            isAnswerChosen = [false, false, false, true];
          });
        }
        break;
    }
    setState(() {
      _isTouched = true;
      _isFreezed = true;
    });

    //Dap an dung sai
    if (selectedWord.getDefinition == _currentWord.getDefinition) {
      setState(() {
        _answersCorrect += 1;
      });
    }

    if (_numOfCards == _wordNoInRoom) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _showMyDialog();
      });
    }
  }

  bool isCorrect(WordModel word) {
    bool ret = false;
    if (word.getDefinition == _currentWord.getDefinition) {
      ret = true;
    }

    return ret;
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
                "Tra loi dung:" + _answersCorrect.toString(),
                style: TextStyle(color: Colors.green[900]),
              ),
              Text("Tra loi sai:" + (_numOfCards - _answersCorrect).toString(),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  )),
            ],
          ),
          onPressed: () {
            _goToNextRoom();
          },
        );
      },
    );
  }

  void _goToNextRoom() {
    Navigator.of(context).pop();
    int noOfRoom = 0;
    int noOfPackage = 0;
    if (_currentPackage.name != "marked" &&
        _currentPackage.name != "unstudied" &&
        _currentPackage.name != "forgot") {
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

      debugPrint("roomName" + _roomName);
      debugPrint("packageName" + _pakageName);
      setState(() {
        choices = [];
        _currentWord = _data[_currentWordNoInData];
        (_currentPackage.endIndex >
                (_currentRoom.startIndex + _currentRoom.numOfCards))
            ? _numOfCards = _currentRoom.numOfCards
            : _numOfCards = _currentPackage.endIndex - _currentRoom.startIndex;
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
      _firstRandomWordIndex = min + _random.nextInt(max - min);
      if (10 <= _firstRandomWordIndex && _firstRandomWordIndex <= 1289) {
        _secondRandomWordIndex = _firstRandomWordIndex + 10;
        _thirdRandomWordIndex = _firstRandomWordIndex - 10;
      } else if (_firstRandomWordIndex < 10) {
        _secondRandomWordIndex = _firstRandomWordIndex + 10;
        _thirdRandomWordIndex = _firstRandomWordIndex + 20;
      } else if (_firstRandomWordIndex > 1289) {
        _secondRandomWordIndex = _firstRandomWordIndex - 10;
        _thirdRandomWordIndex = _firstRandomWordIndex - 20;
      }
      _currentWord = _data[_currentWordNoInData];

      choices.add(_completeData[_firstRandomWordIndex]);
      choices.add(_completeData[_secondRandomWordIndex]);
      choices.add(_completeData[_thirdRandomWordIndex]);
      choices.add(_currentWord);
      shuffle(choices);
      setState(() {
        isAnswerChosen = [false, false, false, false];
        _isFreezed = false;
        _isTouched = false;
        _wordNoInRoom = 1;
        _currentWordNoInData += 1;
        _answersCorrect = 0;
      });
    }
  }

  void _goNext() {
    setState(() {
      isAnswerChosen = [false, false, false, false];
      _isFreezed = false;
      _isTouched = false;
      _wordNoInRoom += 1;
      _currentWordNoInData += 1;
      choices = [];
      _firstRandomWordIndex = min + _random.nextInt(max - min);
      if (10 <= _firstRandomWordIndex && _firstRandomWordIndex <= 1289) {
        _secondRandomWordIndex = _firstRandomWordIndex + 10;
        _thirdRandomWordIndex = _firstRandomWordIndex - 10;
      } else if (_firstRandomWordIndex < 10) {
        _secondRandomWordIndex = _firstRandomWordIndex + 10;
        _thirdRandomWordIndex = _firstRandomWordIndex + 20;
      } else if (_firstRandomWordIndex > 1289) {
        _secondRandomWordIndex = _firstRandomWordIndex - 10;
        _thirdRandomWordIndex = _firstRandomWordIndex - 20;
      }
      _currentWord = _data[_currentWordNoInData];
    });
    choices.add(_completeData[_firstRandomWordIndex]);
    choices.add(_completeData[_secondRandomWordIndex]);
    choices.add(_completeData[_thirdRandomWordIndex]);
    choices.add(_currentWord);
    shuffle(choices);
  }

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      drawer: CustomedDrawer(),
      body: Stack(
        children: [
          Background(
            imageURL: "assets/images/bg2.png",
          ),
          Stack(
            children: [
              CustomedAppBar(
                globalKey: _key,
                child: Text(
                  _wordNoInRoom.toString() + "/" + _numOfCards.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              if (_currentWord != null)
                Column(
                  children: [
                    Spacer(),
                    Center(
                      child: Text(
                        _isWordToDefinition
                            ? _currentWord.getWord
                            : _currentWord.getDefinition,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: AnswerBar(
                        isChosen: isAnswerChosen[0],
                        isCorrect: isCorrect(choices[0]),
                        isTapped: _isTouched,
                        choice: _isWordToDefinition
                            ? choices[0].getDefinition
                            : choices[0].getWord,
                        onPressed: () => (_isFreezed == false)
                            ? handleOnPressed(choices[0], 0)
                            : () {},
                      ),
                    ),
                    Center(
                      child: AnswerBar(
                        isChosen: isAnswerChosen[1],
                        isCorrect: isCorrect(choices[1]),
                        isTapped: _isTouched,
                        choice: _isWordToDefinition
                            ? choices[1].getDefinition
                            : choices[1].getWord,
                        onPressed: () => (_isFreezed == false)
                            ? handleOnPressed(choices[1], 1)
                            : () {},
                      ),
                    ),
                    Center(
                      child: AnswerBar(
                        isChosen: isAnswerChosen[2],
                        isCorrect: isCorrect(choices[2]),
                        isTapped: _isTouched,
                        choice: _isWordToDefinition
                            ? choices[2].getDefinition
                            : choices[2].getWord,
                        onPressed: () => (_isFreezed == false)
                            ? handleOnPressed(choices[2], 2)
                            : () {},
                      ),
                    ),
                    Center(
                      child: AnswerBar(
                        isChosen: isAnswerChosen[3],
                        isCorrect: isCorrect(choices[3]),
                        isTapped: _isTouched,
                        choice: _isWordToDefinition
                            ? choices[3].getDefinition
                            : choices[3].getWord,
                        onPressed: () => (_isFreezed == false)
                            ? handleOnPressed(choices[3], 3)
                            : () {},
                      ),
                    ),
                    SizedBox(
                      height: _deviceHeight / 8,
                    ),
                    Spacer(),
                  ],
                ),
            ],
          ),
          _isTouched && (_wordNoInRoom < _numOfCards)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShadowButton(
                          onPressed: _goNext,
                          child: Text(
                            "Tiep tuc",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )
              : SizedBox.shrink(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
    );
  }
}
