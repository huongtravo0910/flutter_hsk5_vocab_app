import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/screens/settingScreen/localWidgets/resultDialog.dart';
import 'package:hsk5_vocab_app/services/historyService.dart';
import 'package:hsk5_vocab_app/services/wordService.dart';

class ConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Bạn có muốn reset lại ứng dụng?",
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text("Có", style: TextStyle(color: Colors.white)),
              onPressed: () {
                _resetWordList(context);
                _cleanHistory();
                Navigator.pop(context);
                Future.delayed(Duration(milliseconds: 1000));
                showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (_) {
                      return ResultDialog();
                    });
              },
            ),
            RaisedButton(
              child: Text(
                "Không",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

void _cleanHistory() async {
  HistoryService().deleteHistory();
}

void _resetWordList(BuildContext context) async {
  dynamic _data = json.decode(await DefaultAssetBundle.of(context)
      .loadString("assets/completeHsk5Vocab.json"));
  for (var i = 0; i < 1300; i++) {
    WordModel word = WordModel(
        stt: _data[i]["no"],
        definition: _data[i]["definition"],
        pronounciation: _data[i]["pronunciation"],
        word: _data[i]["word"],
        isMarked: false,
        remembered: 2);
    WordService().updateWord(word);
  }
}
