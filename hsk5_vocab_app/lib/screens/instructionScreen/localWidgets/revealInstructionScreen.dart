import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/multipyButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/tickButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/revealSreen.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomButtonStart.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/drawer.dart';
import 'package:provider/provider.dart';

class RevealInstructionScreen extends StatefulWidget {
  @override
  _RevealInstructionScreenState createState() =>
      _RevealInstructionScreenState();
}

class _RevealInstructionScreenState extends State<RevealInstructionScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    var room = Provider.of<CurrentRoom>(context, listen: false).getRoomModel;
    debugPrint(room.toString());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  child: BackButton(),
                  globalKey: _key,
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
                            Icons.bookmark,
                            size: 50,
                          ),
                        ),
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
                            "Giữ thẻ để đánh dấu từ",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          margin: EdgeInsets.all(20.0),
                          height: 50,
                          width: 150,
                          child: Text(
                            "Chạm để xem mặt sau",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          height: 50,
                          width: 150,
                          child: Text(
                            "Chọn nếu bạn nhớ từ này",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20.0),
                          height: 50,
                          width: 150,
                          child: Text(
                            "Chọn nếu bạn không nhớ từ này",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                BottomButton(
                  route: "/reveal",
                  text: "Bắt đầu",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
