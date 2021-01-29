import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';
import 'package:hsk5_vocab_app/models/roomModel.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomBar.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/roundedAlertBox.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';
import 'package:provider/provider.dart';

import 'localWidgets/answerBar.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _random = new Random();
  int min = 0;
  int max = 1299;
  dynamic _data;
  RoomModel _currentRoom;
  PackageModel _currentPackage;
  int _currentWordNoInData;
  WordModel _currentWord;
  WordModel _selectedWord;
  int _numOfCards;
  int _wordNoInRoom;
  int _firstRandomWordIndex;
  int _secondRandomWordIndex;
  int _thirdRandomWordIndex;
  int _answersCorrect;
  List<bool> isAnswerChosen = [false, false, false, false];
  List<WordModel> choices = [];
  List<WordModel> shuffledChoices = [];

  bool _isTouched;
  bool _isFreezed;

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
      _selectedWord = selectedWord;
      _isFreezed = true;
    });

    //Dap an dung sai

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
    setState(() {
      isAnswerChosen = [false, false, false, false];
      _isFreezed = false;
      _isTouched = false;
      _wordNoInRoom = 1;
      _currentWordNoInData += 1;
      _answersCorrect = 0;
      choices = [];
    });
    (_currentPackage.endIndex >
            (_currentRoom.startIndex + _currentRoom.numOfCards))
        ? _numOfCards = _currentRoom.numOfCards
        : _numOfCards = _currentPackage.endIndex - _currentRoom.startIndex + 1;

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
    _currentWord = WordModel(
      stt: _data[_currentWordNoInData]["no"],
      definition: _data[_currentWordNoInData]["definition"],
      pronounciation: _data[_currentWordNoInData]["pronunciation"],
      word: _data[_currentWordNoInData]["word"],
    );

    choices.add(_currentWord);
    choices.add(WordModel(
      stt: _data[_firstRandomWordIndex]["no"],
      definition: _data[_firstRandomWordIndex]["definition"],
      pronounciation: _data[_firstRandomWordIndex]["pronunciation"],
      word: _data[_firstRandomWordIndex]["word"],
    ));
    choices.add(WordModel(
      stt: _data[_secondRandomWordIndex]["no"],
      definition: _data[_secondRandomWordIndex]["definition"],
      pronounciation: _data[_secondRandomWordIndex]["pronunciation"],
      word: _data[_secondRandomWordIndex]["word"],
    ));
    choices.add(WordModel(
      stt: _data[_thirdRandomWordIndex]["no"],
      definition: _data[_thirdRandomWordIndex]["definition"],
      pronounciation: _data[_thirdRandomWordIndex]["pronunciation"],
      word: _data[_thirdRandomWordIndex]["word"],
    ));

    shuffle(choices);
    Navigator.of(context).pop();
  }

  void _goNext() {
    setState(() {
      if (_selectedWord.getDefinition == _currentWord.getDefinition) {
        setState(() {
          _answersCorrect += 1;
        });
      }
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
      _currentWord = WordModel(
        stt: _data[_currentWordNoInData]["no"],
        definition: _data[_currentWordNoInData]["definition"],
        pronounciation: _data[_currentWordNoInData]["pronunciation"],
        word: _data[_currentWordNoInData]["word"],
      );
    });
    choices.add(_currentWord);
    choices.add(WordModel(
      stt: _data[_firstRandomWordIndex]["no"],
      definition: _data[_firstRandomWordIndex]["definition"],
      pronounciation: _data[_firstRandomWordIndex]["pronunciation"],
      word: _data[_firstRandomWordIndex]["word"],
    ));
    choices.add(WordModel(
      stt: _data[_secondRandomWordIndex]["no"],
      definition: _data[_secondRandomWordIndex]["definition"],
      pronounciation: _data[_secondRandomWordIndex]["pronunciation"],
      word: _data[_secondRandomWordIndex]["word"],
    ));
    choices.add(WordModel(
      stt: _data[_thirdRandomWordIndex]["no"],
      definition: _data[_thirdRandomWordIndex]["definition"],
      pronounciation: _data[_thirdRandomWordIndex]["pronunciation"],
      word: _data[_thirdRandomWordIndex]["word"],
    ));

    shuffle(choices);
  }

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
    var jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/completeHsk5Vocab.json");
    _data = json.decode(jsonData);

    _currentRoom =
        Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
    _currentPackage =
        Provider.of<CurrentPackage>(context, listen: false).getPackageModel;
    _currentWordNoInData = _currentRoom.startIndex;

    setState(() {
      (_currentPackage.endIndex >
              (_currentRoom.startIndex + _currentRoom.numOfCards))
          ? _numOfCards = _currentRoom.numOfCards
          : _numOfCards =
              _currentPackage.endIndex - _currentRoom.startIndex + 1;
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
      _currentWord = WordModel(
        stt: _data[_currentWordNoInData]["no"],
        definition: _data[_currentWordNoInData]["definition"],
        pronounciation: _data[_currentWordNoInData]["pronunciation"],
        word: _data[_currentWordNoInData]["word"],
      );

      choices.add(WordModel(
        stt: _data[_firstRandomWordIndex]["no"],
        definition: _data[_firstRandomWordIndex]["definition"],
        pronounciation: _data[_firstRandomWordIndex]["pronunciation"],
        word: _data[_firstRandomWordIndex]["word"],
      ));
      choices.add(WordModel(
        stt: _data[_secondRandomWordIndex]["no"],
        definition: _data[_secondRandomWordIndex]["definition"],
        pronounciation: _data[_secondRandomWordIndex]["pronunciation"],
        word: _data[_secondRandomWordIndex]["word"],
      ));
      choices.add(WordModel(
        stt: _data[_thirdRandomWordIndex]["no"],
        definition: _data[_thirdRandomWordIndex]["definition"],
        pronounciation: _data[_thirdRandomWordIndex]["pronunciation"],
        word: _data[_thirdRandomWordIndex]["word"],
      ));
      choices.add(_currentWord);
      shuffle(choices);
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
                      height: 130,
                    ),
                    Center(
                      child: Text(
                        _currentWord.getWord,
                        style: Theme.of(context).textTheme.subtitle1,
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
                        choice: choices[0].getDefinition,
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
                        choice: choices[1].getDefinition,
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
                        choice: choices[2].getDefinition,
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
                        choice: choices[3].getDefinition,
                        onPressed: () => (_isFreezed == false)
                            ? handleOnPressed(choices[3], 3)
                            : () {},
                      ),
                    ),
                  ],
                ),
              Column(
                children: [
                  SizedBox(
                    height: 370,
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
                          height: 20,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              Column(
                children: [
                  SizedBox(
                    height: 550,
                  ),
                  BottomBar(
                    roomName: _currentRoom.roomName,
                    packageName: _currentPackage.name,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
