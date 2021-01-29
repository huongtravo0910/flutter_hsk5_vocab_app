import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/customedMethodAppBar.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/methodCard.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/methodDropdown.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:provider/provider.dart';

class MethodScreenArgs {
  final int numOfCards;
  MethodScreenArgs({
    @required this.numOfCards,
  });
}

class MethodsScreen extends StatefulWidget {
  @override
  _MethodsScreenState createState() => _MethodsScreenState();
}

class _MethodsScreenState extends State<MethodsScreen> {
  PackageModel _currentPackage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPackage =
        Provider.of<CurrentPackage>(context, listen: false).getPackageModel;
  }

  @override
  Widget build(BuildContext context) {
    final MethodScreenArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(children: [
        Background(
          imageURL: "assets/images/bg2.png",
        ),
        Column(
          children: [
            CustomedMethodAppBar(
              child2: Text(
                _currentPackage.name,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              child1: BackButton(),
            ),
            MethodDropdown(
              endRoomNo: _currentPackage.numOfRooms,
              startIndexOfPackage: _currentPackage.startIndex,
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
