import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';

import 'localWidgets/answerBar.dart';

class QuizScreen extends StatelessWidget {
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
                  "1/50",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
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
                      isChosen: false,
                      isCorrect: false,
                      choice: "Hoc sinh",
                    ),
                  ),
                  Center(
                    child: AnswerBar(
                      isChosen: false,
                      isCorrect: false,
                      choice: "Truong hoc",
                    ),
                  ),
                  Center(
                    child: AnswerBar(
                      isChosen: false,
                      isCorrect: false,
                      choice: "Gia dinh",
                    ),
                  ),
                  Center(
                    child: AnswerBar(
                      isChosen: false,
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
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShadowButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return QuizScreen();
                          }),
                        ),
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
            ],
          ),
        ],
      ),
    );
  }
}
