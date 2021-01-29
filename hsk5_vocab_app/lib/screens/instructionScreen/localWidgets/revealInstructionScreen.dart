import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/homeScreen/homeScreen.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/multipyButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/tickButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/revealSreen.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomButton.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';
import 'package:provider/provider.dart';

class RevealInstructionScreen extends StatefulWidget {
  @override
  _RevealInstructionScreenState createState() =>
      _RevealInstructionScreenState();
}

class _RevealInstructionScreenState extends State<RevealInstructionScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    var room = Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
    debugPrint(room.toString());
    super.didChangeDependencies();
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
                child: BackButton(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15.0),
                        height: 60,
                        width: 100,
                        child: Icon(
                          Icons.touch_app,
                          size: 50,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child: TickButton(
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child: MultipyButton(
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        margin: EdgeInsets.all(20.0),
                        height: 50,
                        width: 150,
                        child: Text(
                          "Bam de xem mat sau",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        height: 50,
                        width: 150,
                        child: Text(
                          "Chon neu ban nho tu nay",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        height: 50,
                        width: 150,
                        child: Text(
                          "Chon neu ban khong nho tu nay",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              BottomButton(
                route: RevealScreen(),
                text: "Bat dau",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
