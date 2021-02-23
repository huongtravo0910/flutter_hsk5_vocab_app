import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDemo extends StatefulWidget {
  SharedPreferencesDemo({Key key}) : super(key: key);

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;
  Future<String> _wordList;
  List<WordModel> _decodedData;
  WordModel _word;

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    String wordList = (prefs.getString("wordList") ?? "no word");

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });

      WordModel sample1 = WordModel(
        stt: "1",
        definition: "xin chao",
        pronounciation: "he-lo",
        word: "Hello",
        isMarked: true,
        remembered: 0,
      );

      WordModel sample2 = WordModel(
        stt: "2",
        definition: "hoc sinh",
        pronounciation: "s-tiu-den",
        word: "Student",
        isMarked: true,
        remembered: 0,
      );
      Map<String, dynamic> sample3 = {
        "stt": "3",
        "definition": "tra",
        "pronounciation": "t-ee",
        "word": "tea",
        "isMarked": true,
        "remembered": 0,
      };
      _word = WordModel.fromJson(sample3);

      debugPrint("sample3" + _word.getWord);
      wordList = WordModel.encode([sample1, sample2]);

      debugPrint("wordList : " + WordModel.encode([sample1, sample2]));
      _wordList = prefs.setString("wordList", wordList).then((bool success) {
        return wordList;
      });
      _decodedData = WordModel.decode(wordList);
      debugPrint("sample1: " + _decodedData[1].getWord);
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
    _wordList = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString("wordList") ?? "no word");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences Demo"),
      ),
      body: Center(
          child: FutureBuilder<int>(
              future: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n\n'
                                'This should persist across restarts.\n\n' +
                            _decodedData[1].getWord,
                      );
                    }
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
