import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/services/wordService.dart';

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("click here"),
        onPressed: () async {
          WordModel word = WordModel(
              definition: "yop",
              word: "yo",
              pronounciation: "ha-ha",
              stt: "11",
              remembered: 1,
              isMarked: true);
          WordService().insertWord(word);
          // WordService().deleteWord(2);
          List<WordModel> wordsList = await WordService().words();
          debugPrint(wordsList[1].toString());
        },
      ),
    );
  }
}
