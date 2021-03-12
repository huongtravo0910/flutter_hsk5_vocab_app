import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/models/wordModel.dart';
import 'package:hsk5_vocab_app/screens/settingScreen/localWidgets/confirmDialog.dart';
import 'package:hsk5_vocab_app/screens/settingScreen/localWidgets/settingCard.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/localModels/historyModel.dart';
import 'package:hsk5_vocab_app/services/historyService.dart';
import 'package:hsk5_vocab_app/services/wordService.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isWordToDefinitionState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isWordToDefinitionState = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => _getCardState(context));

    Future.delayed(Duration(milliseconds: 1000));
  }

  void _getCardState(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    bool isWordToDefinitionState = _prefs.getBool("isWordToDefinitionState");
    setState(() {
      _isWordToDefinitionState = isWordToDefinitionState;
    });
  }

  void _setCardState() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("isWordToDefinitionState", !_isWordToDefinitionState);
    setState(() {
      _isWordToDefinitionState = !_isWordToDefinitionState;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer: CustomedDrawer(),
        key: _key,
        body: Builder(
          builder: (context) => Stack(
            children: [
              Background(
                imageURL: "assets/images/bg2.png",
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
                  alignment: Alignment.center,
                  height: deviceHeight - 60,
                  width: deviceWidth - 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CÀI ĐẶT",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                            onTap: () {
                              _key.currentState.openDrawer();
                            },
                          )
                        ],
                      ),
                      Container(
                        height: deviceHeight - 200,
                        width: deviceWidth - 50,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              SettingCard(
                                title: "Chế độ Trung-Việt",
                                subtitle:
                                    "Chế độ mặc định đang là chế độ  Trung Việt. Chạm để chuyển sang chế độ Việt Trung",
                                child: InkWell(
                                  onTap: () {
                                    _setCardState();
                                  },
                                  child: (_isWordToDefinitionState)
                                      ? Icon(Icons.toggle_off, size: 50)
                                      : Icon(
                                          Icons.toggle_on,
                                          size: 50,
                                          color: Theme.of(context).accentColor,
                                        ),
                                ),
                              ),
                              SettingCard(
                                  title: "Reset",
                                  child: RaisedButton(
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    onPressed: () async {
                                      showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (_) {
                                            return ConfirmDialog();
                                          });
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
