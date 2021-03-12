import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/quizScreen/localWidgets/answerBar.dart';
import 'package:hsk5_vocab_app/screens/quizScreen/quizScreen.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomButtonStart.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/drawer.dart';

class QuizInstructionScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: CustomedDrawer(),
        body: Stack(
          children: [
            Background(
              imageURL: "assets/images/bg2.png",
            ),
            CustomedAppBar(
              child: BackButton(),
              globalKey: _key,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Spacer(),
                    Center(
                      child: Text(
                        "你好",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: AnswerBar(
                        isChosen: false,
                        isCorrect: false,
                        choice: "học sinh",
                        isTapped: true,
                      ),
                    ),
                    Center(
                      child: AnswerBar(
                        isChosen: false,
                        isCorrect: false,
                        choice: "cố gắng",
                        isTapped: true,
                      ),
                    ),
                    Center(
                      child: AnswerBar(
                        isChosen: false,
                        isCorrect: false,
                        choice: "hạnh phúc",
                        isTapped: true,
                      ),
                    ),
                    Center(
                      child: AnswerBar(
                        isChosen: true,
                        isCorrect: true,
                        choice: "xin chào",
                        isTapped: true,
                      ),
                    ),
                    SizedBox(
                      height: _deviceHeight / 8,
                    ),
                    Spacer()
                  ],
                ),
                Column(
                  children: [
                    Spacer(),
                    SizedBox(
                      height: _deviceHeight / 3,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 35,
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
                              "Bấm chọn câu trả lời ",
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
                  route: "/quiz",
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
