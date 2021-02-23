import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Foo2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _myController = TextEditingController();
  final _myController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Foo"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _myController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _myController2,
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        String history;
                        List<History> historyList = [];
                        history = (_prefs.getString("historyList") != null)
                            ? _prefs.getString("historyList")
                            : "";
                        DateTime _dateTime = DateTime.now();
                        History thisHistory = History(
                            date: _dateTime,
                            email: _myController.text,
                            name: _myController2.text);
                        debugPrint("thisHistory.get email: " +
                            thisHistory.getEmail().toString());
                        if (history != "") {
                          historyList = History.decode(history);
                          historyList.insert(0, thisHistory);
                          debugPrint("historyList" + historyList.toString());
                        } else {
                          historyList.add(thisHistory);
                        }
                        history = History.encode(historyList);
                        _prefs.setString("historyList", history);
                        debugPrint(_dateTime.toString());
                        debugPrint(_myController.text);
                        debugPrint(_myController2.text);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.

                      SharedPreferences _prefs =
                          await SharedPreferences.getInstance();
                      String stringList = _prefs.getString("historyList");

                      debugPrint(stringList.toString());
                    },
                    child: Text('Get'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class History {
  DateTime date;
  DateTime getDate() {
    return date;
  }

  String name;
  String getName() {
    return name;
  }

  String email;
  String getEmail() {
    return email;
  }

  History({this.date, this.email, this.name});

  //from Model to String

  static String encode(List<History> historyList) {
    return json.encode(historyList
        .map<Map<String, dynamic>>((history) => toMap(history))
        .toList());
  }

  static Map<String, dynamic> toMap(History history) {
    return {
      "date": history.getDate().toString(),
      "name": history.getName(),
      "email": history.getEmail(),
    };
  }

  //From String to Model List

  static List<History> decode(String historyList) =>
      (json.decode(historyList) as List<dynamic>)
          .map<History>((item) => History.fromJson(item))
          .toList();

  factory History.fromJson(Map<String, dynamic> jsonData) {
    return History(
      date: DateTime.parse(jsonData['date']),
      name: jsonData['name'],
      email: jsonData['email'],
    );
  }
}
