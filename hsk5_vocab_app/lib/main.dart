import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/completeVocabScreen/completeVocabScreen.dart';
import 'package:hsk5_vocab_app/screens/homeScreen/homeScreen.dart';
import 'package:hsk5_vocab_app/screens/instructionScreen/instructionScreen.dart';
import 'package:hsk5_vocab_app/screens/matchingScreen/matchingScreen.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/methodsScreen.dart';
import 'package:hsk5_vocab_app/screens/quizScreen/quizScreen.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/revealSreen.dart';
import 'package:hsk5_vocab_app/screens/reviewScreen/reviewScreen.dart';
import 'package:hsk5_vocab_app/screens/settingScreen/settingScreen.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/trackingScreen.dart';
import 'package:hsk5_vocab_app/services/databaseService.dart';
import 'package:hsk5_vocab_app/state/currentPackage.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:hsk5_vocab_app/utils/ourTheme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  final isFirstTimeOpenApp = _prefs.getBool("isFirstTimeOpenApp");
  if (isFirstTimeOpenApp == null) {
    await DatabaseService().deleteDB();
    _prefs.setBool("isFirstTimeOpenApp", false);
    _prefs.setBool("isWordToDefinitionState", true);
    // _prefs.setString("historyList", "");
  }
  await DatabaseService().initDatabase();
  // await Future.delayed(Duration(milliseconds: 200));
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
          "/completevocab": (context) => CompleteVocabScreen(),
          "/review": (context) => ReviewScreen(),
          "/method": (context) => MethodsScreen(),
          "/revealInstruction": (context) =>
              InstructionScreen(type: "revealing"),
          "/reveal": (context) => RevealScreen(),
          "/quizInstruction": (context) => InstructionScreen(type: "quiz"),
          "/quiz": (context) => QuizScreen(),
          "/matchingInstruction": (context) =>
              InstructionScreen(type: "matching"),
          "/matching": (context) => MatchingScreen(),
          "/setting": (context) => SettingScreen(),
          "/tracking": (context) => TrackingScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: OurTheme().buildTheme(),
        // home: Foo2(),
      ),
    );
  }
}
