import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/matchingInstructionScreen.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/methodCard.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/methodDropdown.dart';
import 'package:hsk5_vocab_app/screens/quizScreen/quizInstructionScreen.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/revealInstructionScreen.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/customedAppBar.dart';

class MethodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Background(
          imageURL: "assets/images/bg2.png",
        ),
        Column(
          children: [
            Spacer(),
            CustomedAppBar(
              child: BackButton(),
            ),
            MethodDropdown(),
            MethodCard(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RevealInstructionScreen(),
                  ),
                );
              },
              icon: Icon(Icons.book),
              subtitle: "Xem cac the co ban",
              title: "Flashcard",
            ),
            MethodCard(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizInstructionScreen(),
                  ),
                );
              },
              icon: Icon(Icons.playlist_add_check),
              subtitle: "Chon cau tra loi dung",
              title: "Cau hoi",
            ),
            MethodCard(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MatchingInstructionScreen(),
                  ),
                );
              },
              icon: Icon(Icons.vertical_split),
              subtitle: "Ghep cac tu voi dinh nghia",
              title: "Noi tu",
            ),
            SizedBox(
              height: 60,
            ),
            Spacer(),
          ],
        ),
        // Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       ShadowButton(
        //         onPressed: () => Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) {
        //             return MethodsScreen();
        //           }),
        //         ),
        //         child: Text(
        //           "Tiep tuc",
        //           style: Theme.of(context).textTheme.subtitle2,
        //         ),
        //       ),
        //     ],
        //   ),
        //   SizedBox(
        //     height: 20,
        //   ),
        // ])
      ]),
    );
  }
}
