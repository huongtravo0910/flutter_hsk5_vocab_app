import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/packageModel.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/customedMethodAppBar.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/methodCard.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/methodDropdown.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/drawer.dart';
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
  GlobalKey<ScaffoldState> _key = GlobalKey();
  PackageModel _currentPackage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPackage =
        Provider.of<CurrentPackage>(context, listen: false).getPackageModel;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _currentPackage =
        Provider.of<CurrentPackage>(context, listen: false).getPackageModel;
  }

  @override
  Widget build(BuildContext context) {
    final MethodScreenArgs args = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: CustomedDrawer(),
        body: Stack(children: [
          Background(
            imageURL: "assets/images/bg2.png",
          ),
          CustomedAppBar(
            child: BackButton(),
            globalKey: _key,
          ),
          Column(
            children: [
              Spacer(),
              Center(
                child: Column(
                  children: [
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
                      subtitle: "Xem các thẻ cơ bản",
                      title: "Flashcard",
                    ),
                    MethodCard(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/quizInstruction");
                      },
                      icon: Icon(Icons.playlist_add_check),
                      subtitle: "Chọn câu trả lời đúng",
                      title: "Câu hỏi",
                    ),
                    MethodCard(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/matchingInstruction");
                      },
                      icon: Icon(Icons.vertical_split),
                      subtitle: "Ghép các từ với định nghĩa",
                      title: "Nối từ",
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ]),
      ),
    );
  }
}
