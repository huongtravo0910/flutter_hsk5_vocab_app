import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/quizScreen/localWidgets/answerBar.dart';
import 'package:hsk5_vocab_app/screens/quizScreen/quizScreen.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomButton.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';

class QuizInstructionScreen extends StatelessWidget {
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
              Column(
                children: [
                  SizedBox(
                    height: 130,
                  ),
                  Center(
                    child: Text(
                      "学生",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: AnswerBar(
                      isChosen: true,
                      isCorrect: false,
                      choice: "Hoc sinh",
                    ),
                  ),
                  Center(
                    child: AnswerBar(
                      isChosen: true,
                      isCorrect: false,
                      choice: "Truong hoc",
                    ),
                  ),
                  Center(
                    child: AnswerBar(
                      isChosen: true,
                      isCorrect: false,
                      choice: "Gia dinh",
                    ),
                  ),
                  Center(
                    child: AnswerBar(
                      isChosen: true,
                      isCorrect: true,
                      choice: "Xin chao",
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 370,
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
                            "Bam chon cau tra loi ",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              BottomButton(
                route: QuizScreen(),
                text: "Bat dau",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
