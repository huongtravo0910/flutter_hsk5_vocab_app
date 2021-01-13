import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/localWidgets/matchingCard.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';

import 'localWidgets/matchingCardWithAuText.dart';

class MatchingScreen extends StatelessWidget {
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
            ],
          ),
        ],
      ),
    );
  }
}
