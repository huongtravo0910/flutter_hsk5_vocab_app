import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/localWidgets/matchingCard.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomButtonStart.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/drawer.dart';

class MatchingInstructionScreen extends StatefulWidget {
  @override
  _MatchingInstructionScreenState createState() =>
      _MatchingInstructionScreenState();
}

class _MatchingInstructionScreenState extends State<MatchingInstructionScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
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
                      children: [
                        Spacer(),
                        MatchingCard(
                          mainText: "加油",
                          isChosen: false,
                        ),
                        MatchingCard(
                          mainText: "你好",
                          isChosen: true,
                        ),
                        SizedBox(height: 40),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Spacer(),
                        MatchingCard(
                          mainText: "xin chào",
                          isChosen: true,
                        ),
                        MatchingCard(
                          mainText: "cố lên",
                          isChosen: false,
                        ),
                        SizedBox(height: 40),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 200,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.touch_app_outlined,
                              size: 60,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Bấm chọn các thẻ 2 bên cột phù hợp ",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                BottomButton(
                  route: "/matching",
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
