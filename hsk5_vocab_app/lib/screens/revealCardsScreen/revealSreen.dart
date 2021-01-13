import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/multipyButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/nextButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/previousButton.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/tickButton.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';
import 'package:hsk5_vocab_app/widgets/plainContainer.dart';

class RevealScreen extends StatelessWidget {
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
                    height: 100,
                  ),
                  Center(
                    child: PlainContainer(
                      child: Text(
                        "学生",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Center(
                  //   child: PlainContainer(
                  //     child: Text(
                  //       "学生",
                  //       style: Theme.of(context).textTheme.subtitle1,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 250),
                  Center(
                    child: Icon(
                      Icons.touch_app,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      size: 70,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 400,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TickButton(),
                      SizedBox(width: 50),
                      MutipyButton(),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PreviousButton(
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      NextButton(
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
