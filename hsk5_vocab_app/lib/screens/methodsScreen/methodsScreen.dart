import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/customedMethodAppBar.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/methodCard.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/methodDropdown.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';

class MethodScreenArgs {
  final int numOfCards;
  final int startIndex;
  final int endIndex;

  MethodScreenArgs(
      {@required this.numOfCards,
      @required this.startIndex,
      @required this.endIndex});
}

class MethodsScreen extends StatefulWidget {
  // final int numOfCards;
  // final int startIndex;
  // final int endIndex;
  // const MethodsScreen(
  //     {Key key, this.numOfCards, this.endIndex, this.startIndex})
  //     : super(key: key);
  @override
  _MethodsScreenState createState() => _MethodsScreenState();
}

class _MethodsScreenState extends State<MethodsScreen> {
  int _numOfCards;
  int _startIndex;
  int _endIndex;
  @override
  Widget build(BuildContext context) {
    final MethodScreenArgs args = ModalRoute.of(context).settings.arguments;
    int numOfRooms =
        ((args.endIndex - args.startIndex + 1) / args.numOfCards).ceil();
    debugPrint("number of rooms " + numOfRooms.toString());
    return Scaffold(
      body: Stack(children: [
        Background(
          imageURL: "assets/images/bg2.png",
        ),
        Column(
          children: [
            CustomedMethodAppBar(
              child2: Text(
                "Goi 1",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              child1: BackButton(),
            ),
            MethodDropdown(
              endRoomNo: numOfRooms,
              startIndexOfPackage: args.startIndex,
              numOfCards: args.numOfCards,
            ), //Widget can provider
            MethodCard(
              onPressed: () {
                Navigator.of(context).pushNamed("/revealInstruction");
              },
              icon: Icon(Icons.book),
              subtitle: "Xem cac the co ban",
              title: "Flashcard",
            ),
            MethodCard(
              onPressed: () {
                Navigator.of(context).pushNamed("/quizInstruction");
              },
              icon: Icon(Icons.playlist_add_check),
              subtitle: "Chon cau tra loi dung",
              title: "Cau hoi",
            ),
            MethodCard(
              onPressed: () {
                Navigator.of(context).pushNamed("/matchingInstruction");
              },
              icon: Icon(Icons.vertical_split),
              subtitle: "Ghep cac tu voi dinh nghia",
              title: "Noi tu",
            ),
            Spacer(),
          ],
        ),
      ]),
    );
  }
}
