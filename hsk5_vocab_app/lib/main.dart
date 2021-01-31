import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/homeScreen/homeScreen.dart';
import 'package:hsk5_vocab_app/screens/instructionScreen/instructionScreen.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/matchingScreen.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/methodsScreen.dart';
import 'package:hsk5_vocab_app/screens/quizScreen/quizScreen.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/revealSreen.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/utils/ourTheme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentRoom>(create: (_) => CurrentRoom()),
        ChangeNotifierProvider<CurrentPackage>(create: (_) => CurrentPackage()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          "/": (context) => HomeScreen(),
          "/method": (context) => MethodsScreen(),
          "/revealInstruction": (context) =>
              InstructionScreen(type: "revealing"),
          "/reveal": (context) => RevealScreen(),
          "/quizInstruction": (context) => InstructionScreen(type: "quiz"),
          "/quiz": (context) => QuizScreen(),
          "/matchingInstruction": (context) =>
              InstructionScreen(type: "matching"),
          "/matching": (context) => MatchingScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: OurTheme().buildTheme(),
        // home: TestScreen2(),
      ),
    );
  }
}
