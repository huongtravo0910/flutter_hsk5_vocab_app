import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/localModels/historyModel.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/localWidgets/statistics.dart';
import 'package:hsk5_vocab_app/services/historyService.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/drawer.dart';
import 'localWidgets/event.dart';
import 'localWidgets/timeLine.dart';
import 'localWidgets/sideIcon.dart';

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  String _page;
  int _size;
  bool _isAll;
  List<HistoryModel> _historyList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _page = "statistics";
      _historyList = [];
      _size = 1;
      _isAll = false;
    });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getHistoryModelList(_size));
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    double _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      drawer: CustomedDrawer(),
      body: Stack(
        children: [
          Background(
            imageURL: "assets/images/bg2.png",
          ),
          Center(
            child: Container(
              width: _deviceWidth - 20,
              color: Theme.of(context).primaryColor.withOpacity(0.6),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: onScreen(context),
          ),
          appBar(context, _key),
        ],
      ),
    );
  }

  Widget onScreen(BuildContext context) {
    Widget ret;
    switch (_page) {
      case "history":
        return ret = Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Timeline(
                  children: _historyList
                      .map<Widget>((history) => event(history, context))
                      .toList(),
                  indicators: _historyList
                      .map<Widget>((history) =>
                          indicator(history.getStudiedType(), context))
                      .toList(),
                ),
                _isAll
                    ? SizedBox.shrink()
                    : RaisedButton(
                        child: Text(
                          "Tiếp tục",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            _size += 10;
                            _getHistoryModelList(_size);
                          });
                        },
                      ),
              ],
            ),
          ),
        );
        break;
      case "statistics":
        return ret = Statistics();
        break;
    }
    return ret;
  }

  void _getHistoryModelList(int size) async {
    try {
      List<HistoryModel> _historyData =
          await HistoryService().getHistoryLimitOffset(size * 10);
      if (_historyData.length < size * 10) {
        setState(() {
          _isAll = true;
        });
      }
      setState(() {
        _historyList = _historyData;
        debugPrint(_historyList.length.toString());
      });
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  Widget appBar(BuildContext context, GlobalKey<ScaffoldState> key) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(
          _deviceWidth / 30, _deviceHeight / 20, _deviceWidth / 30, 0),
      height: _deviceHeight / 10,
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [BoxShadow(color: Colors.grey[600], blurRadius: 3)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                child: Text(
                  "Thống kê",
                  style: TextStyle(
                      fontWeight: (_page == "statistics")
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: Theme.of(context).primaryColor),
                ),
                onTap: () {
                  debugPrint("statistics");
                  setState(() {
                    _page = "statistics";
                  });
                },
              ),
              Text(
                "    |    ",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              InkWell(
                child: Text(
                  "Lịch sử",
                  style: TextStyle(
                      fontWeight: (_page == "history")
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: Theme.of(context).primaryColor),
                ),
                onTap: () {
                  debugPrint("History");
                  setState(() {
                    _page = "history";
                  });
                },
              ),
            ],
          ),
          InkWell(
            child: Icon(
              Icons.menu,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              key.currentState.openDrawer();
            },
          ),
        ],
      ),
    );
  }
}
