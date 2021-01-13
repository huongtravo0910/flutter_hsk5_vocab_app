import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/localWidgets/matchingCard.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/localWidgets/matchingCardWithAuText.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/matchingScreen.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomButton.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';

class MatchingInstructionScreen extends StatelessWidget {
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
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      MatchingCard(
                        mainText: "学生",
                        isChosen: false,
                      ),
                      MatchingCard(
                        mainText: "你好",
                        isChosen: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      MatchingCardWithAuText(
                        mainText: "Xin chao",
                        auText: "Xi-n Cha-o",
                        isChosen: true,
                      ),
                      MatchingCardWithAuText(
                        mainText: "Hoc sinh",
                        auText: "Ho-c si-nh",
                        isChosen: false,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 330,
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
                            "Bam chon cac the 2 ben cot phu hop ",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              BottomButton(
                route: MatchingScreen(),
                text: "Bat dau",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
