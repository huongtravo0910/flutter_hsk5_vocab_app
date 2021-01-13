import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/homeScreen/homeScreen.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/multipyButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/tickButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/revealSreen.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/bottomButton.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';

class RevealInstructionScreen extends StatelessWidget {
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
                        child: TickButton(),
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child: MutipyButton(),
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
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // SizedBox(height: 200),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.touch_app,
              //           size: 50,
              //         ),
              //         SizedBox(
              //           width: 20,
              //         ),
              //         Text(
              //           "Bam de xem mat sau",
              //           style: Theme.of(context).textTheme.bodyText1,
              //         )
              //       ],
              //     ),
              //     SizedBox(
              //       height: 30,
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         TickButton(),
              //         SizedBox(
              //           width: 20,
              //         ),
              //         Text(
              //           "Chon neu ban nho tu nay",
              //           style: Theme.of(context).textTheme.bodyText1,
              //         )
              //       ],
              //     ),
              //     SizedBox(
              //       height: 30,
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         MutipyButton(),
              //         SizedBox(
              //           width: 20,
              //         ),
              //         Text(
              //           "Chon neu ban khong nho tu nay",
              //           style: Theme.of(context).textTheme.bodyText1,
              //         )
              //       ],
              //     ),
              //   ],
              // ),
              BottomButton(
                route: RevealScreen(),
                text: "Bat dau",
              ),
            ],
          )
        ],
      ),
    );
  }
}
