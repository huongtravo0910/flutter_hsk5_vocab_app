import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/bottomButtonContinue.dart';
import 'package:hsk5_vocab_app/screens/completeVocabScreen/localWigets/completeVocabCard.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/methodsScreen.dart';
import 'package:hsk5_vocab_app/screens/reviewScreen/localWidgets/packageCard.dart';
import 'package:hsk5_vocab_app/services/wordService.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  Map<String, dynamic> word;
  int _numOfForgot = 0;
  int _numOfMarked = 0;
  int _numOfNew = 0;
  int _chosenPackageAmount = 0;
  int _startIndexOfPackage = 0;

  int _endIndexOfPackage = 0;

  int _numOfCards = 0;

  int _numOfRooms = 0;

  String _packageName = "";

  List<bool> _isFirstColumnChosen = [false, false, false];

  List<bool> _isSecondColumnChosen = [false, false, false, false, false, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));
  }

  void _fetchData(BuildContext context) async {
    int forgot = await WordService().countForgotWords();
    int marked = await WordService().countMarkedWords();
    int unstudied = await WordService().countUnStudiedWords();
    setState(() {
      _numOfForgot = forgot;
      _numOfMarked = marked;
      _numOfNew = unstudied;
    });
  }

  void _setCurrentPackage(int startIndex, int endIndex, String packageName) {
    _numOfRooms = ((endIndex - startIndex + 1) / _numOfCards).ceil();
    Provider.of<CurrentPackage>(context, listen: false)
        .setCurrentPackage(startIndex, endIndex, packageName, _numOfRooms);
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          mini: true,
          child: Icon(
            Icons.refresh,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/review");
          },
        ),
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
                      PackageCard(
                        title: _numOfForgot.toString() + " từ",
                        subtitle: "Gói ôn tập những từ chưa nhớ",
                        isChosen: _isFirstColumnChosen[0],
                        onPressed: () {
                          setState(() {
                            _endIndexOfPackage = _numOfForgot - 1;
                            _chosenPackageAmount = _numOfForgot;
                            _packageName = "Từ chưa nhớ";
                          });
                          setState(() {
                            _isFirstColumnChosen = [true, false, false];
                          });
                        },
                      ),
                      PackageCard(
                        title: _numOfMarked.toString() + " từ",
                        subtitle: "Gói ôn tập những từ đánh dấu",
                        isChosen: _isFirstColumnChosen[1],
                        onPressed: () {
                          setState(() {
                            _endIndexOfPackage = _numOfMarked - 1;
                            _chosenPackageAmount = _numOfMarked;
                            _packageName = "Từ đánh dấu";
                          });
                          setState(() {
                            _isFirstColumnChosen = [false, true, false];
                          });
                        },
                      ),
                      PackageCard(
                        title: _numOfNew.toString() + " từ",
                        subtitle: "Gói từ mới",
                        isChosen: _isFirstColumnChosen[2],
                        onPressed: () {
                          setState(() {
                            _endIndexOfPackage = _numOfNew - 1;
                            _chosenPackageAmount = _numOfNew;
                            _packageName = "Từ mới";
                          });
                          debugPrint("endIndex of unstudied package" +
                              _endIndexOfPackage.toString());
                          setState(() {
                            _isFirstColumnChosen = [false, false, true];
                          });
                        },
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
                if (_chosenPackageAmount == 0) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Không có từ nào trong gói này."),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (_chosenPackageAmount == 0 && _numOfCards == 0) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Hãy chọn cả 2 cột."),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (_numOfCards == 0 ||
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
      ),
    );
  }
}
