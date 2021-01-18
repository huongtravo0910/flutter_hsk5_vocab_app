import 'package:flutter/material.dart';
import "dart:convert";

import 'package:hsk5_vocab_app/models/wordModel.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<WordModel> firstDataRange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing JSON File from local"),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            firstDataRange = [];
            var showData = json.decode(snapshot.data.toString());
            for (var i = 0; i <= 4; i++) {
              firstDataRange.add(
                WordModel(
                  stt: showData[i]["stt"],
                  definition: showData[i]["Dịch nghĩa"],
                  pronounciation: showData[i]["Phiên âm"],
                  word: showData[i]["Từ"],
                ),
              );
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(firstDataRange[index].getStt),
                  subtitle: Text(firstDataRange[index].getWord),
                );
              },
              itemCount: firstDataRange.length,
            );
          },
          future: DefaultAssetBundle.of(context)
              .loadString("assets/hsk5vocab.json"),
        ),
      ),
    );
  }
}
