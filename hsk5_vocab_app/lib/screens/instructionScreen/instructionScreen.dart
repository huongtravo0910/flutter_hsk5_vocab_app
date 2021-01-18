import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/instructionScreen/localWidgets/matchingInstructionScreen.dart';
import 'package:hsk5_vocab_app/screens/instructionScreen/localWidgets/quizInstructionScreen.dart';
import 'package:hsk5_vocab_app/screens/instructionScreen/localWidgets/revealInstructionScreen.dart';

class InstructionScreen extends StatelessWidget {
  final String type;
  const InstructionScreen({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget ret;
    switch (type) {
      case "matching":
        {
          ret = MatchingInstructionScreen();
        }

        break;
      case "revealing":
        {
          ret = RevealInstructionScreen();
        }
        break;
      case "quiz":
        {
          ret = QuizInstructionScreen();
        }
        break;
      default:
    }
    return ret;
  }
}
