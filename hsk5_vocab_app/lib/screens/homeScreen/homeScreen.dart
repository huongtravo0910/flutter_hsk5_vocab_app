import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/screens/homeScreen/localWidgets/homeCard.dart';
import 'package:hsk5_vocab_app/services/wordService.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("init");
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));
  }

  void _fetchData(BuildContext context) async {
    debugPrint("Hello");
    //json => loop =>jsonObject => wordObject => add to database
    int count = await WordService().countAllWords();
    debugPrint("count : " + count.toString());
    if (count != 1300) {
      var jsonData = await DefaultAssetBundle.of(context)
          .loadString("assets/completeHsk5Vocab.json");
      setState(() {
        _data = json.decode(jsonData);
      });
      for (var i = 0; i < 1300; i++) {
        WordModel word = WordModel(
            stt: _data[i]["no"],
            definition: _data[i]["definition"],
            pronounciation: _data[i]["pronunciation"],
            word: _data[i]["word"],
            isMarked: false,
            isStudied: false,
            remembered: 2);
        WordService().insertWord(word);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) => Stack(
            children: [
              Background(
                imageURL: "assets/images/bg1.png",
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Spacer(),
                    HomeCard(
                      title: "Từ vựng HSK5",
                      icon: Icon(Icons.book),
                      onPressed: () {
                        Navigator.pushNamed(context, "/completevocab");
                      },
                    ),
                    HomeCard(
                      title: "Ôn tập",
                      icon: Icon(Icons.library_books),
                      onPressed: () {
                        Navigator.pushNamed(context, "/review");
                      },
                    ),
                    HomeCard(
                      title: "Theo dõi",
                      icon: Icon(Icons.track_changes),
                      onPressed: () {
                        Navigator.pushNamed(context, "/tracking");
                      },
                    ),
                    HomeCard(
                      title: "Cài đặt",
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.pushNamed(context, "/setting");
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
