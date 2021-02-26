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
  List<HistoryModel> _historyList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _page = "statistics";
      _historyList = [];
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _getHistoryModelList());
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
          child: Timeline(
            children: _historyList
                .map<Widget>((history) => event(history, context))
                .toList(),
            indicators: _historyList
                .map<Widget>(
                    (history) => indicator(history.getStudiedType(), context))
                .toList(),
          ),
        );
        break;
      case "statistics":
        return ret =

            // SizedBox.shrink();

            Statistics();
        break;
    }
    return ret;
  }

  // void _getHistoryModelList() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String historyPref = _prefs.getString("historyList");
  //   if (historyPref != null && historyPref != "") {
  //     setState(() {
  //       _historyList = HistoryModel.decode(historyPref);
  //     });
  //   }
  // }

  void _getHistoryModelList() async {
    try {
      List<HistoryModel> _historyData =
          await HistoryService().getHistoryLimitOffset(0);
      setState(() {
        _historyList = _historyData;
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
