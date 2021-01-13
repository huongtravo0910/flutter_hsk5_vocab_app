import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/homeScreen/homeScreen.dart';
import 'package:hsk5_vocab_app/utils/ourTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: OurTheme().buildTheme(),
      home: HomeScreen(),
    );
  }
}
