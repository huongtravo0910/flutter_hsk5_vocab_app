import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/services/wordService.dart';
import 'package:hsk5_vocab_app/utils/random.dart';
import 'package:hsk5_vocab_app/widgets/indicator.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  int touchedIndex;
  int numOfRememberedWords;
  int numOfForgotWords;
  int numOfUnstudiedWords;
  int numOfRemainingWords;
  final int numOfAllWords = 1300;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      touchedIndex = 0;
      numOfForgotWords = 0;
      numOfUnstudiedWords = 0;
      numOfRemainingWords = 0;
    });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _calculateData(context));

    Future.delayed(Duration(milliseconds: 500));
  }

  void _calculateData(BuildContext context) async {
    int remembered = await WordService().countRememberedWords();
    int forgot = await WordService().countForgotWords();
    int unstudied = await WordService().countUnStudiedWords();

    if (this.mounted) {
      setState(() {
        numOfRememberedWords = remembered;
        numOfForgotWords = forgot;
        numOfUnstudiedWords = unstudied;
        numOfRemainingWords = numOfAllWords -
            numOfForgotWords -
            numOfRememberedWords -
            numOfUnstudiedWords;
      });
    }
    debugPrint("numOfRememberedWords " + numOfRememberedWords.toString());
    debugPrint("numOfForgotWords " + numOfForgotWords.toString());
    debugPrint("numOfUnstudiedWords " + numOfUnstudiedWords.toString());
    debugPrint("numOfRemainingWords " + numOfRemainingWords.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Card(
                color: Theme.of(context).primaryColor.withOpacity(1),
                shadowColor: Colors.black.withOpacity(0.6),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Indicator(
                          color: Colors.green,
                          text: 'Từ đã thành thạo',
                          isSquare: false,
                          size: touchedIndex == 0 ? 18 : 16,
                          textColor: Theme.of(context).secondaryHeaderColor,
                          fontWeight: touchedIndex == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        Indicator(
                          color: Theme.of(context).accentColor,
                          text: 'Từ sắp thành thạo',
                          isSquare: false,
                          size: touchedIndex == 1 ? 18 : 16,
                          textColor: Theme.of(context).secondaryHeaderColor,
                          fontWeight: touchedIndex == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        Indicator(
                          color: Colors.grey,
                          text: 'Từ mới',
                          isSquare: false,
                          size: touchedIndex == 2 ? 18 : 16,
                          textColor: Theme.of(context).secondaryHeaderColor,
                          fontWeight: touchedIndex == 2
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        Indicator(
                          color: Theme.of(context).secondaryHeaderColor,
                          text: 'Từ chưa gắn trạng thái',
                          isSquare: false,
                          size: touchedIndex == 3 ? 18 : 16,
                          textColor: Theme.of(context).secondaryHeaderColor,
                          fontWeight: touchedIndex == 3
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: (numOfRememberedWords != null &&
                                numOfForgotWords != null &&
                                numOfUnstudiedWords != null &&
                                numOfRemainingWords != null)
                            ? PieChart(
                                PieChartData(
                                    pieTouchData: PieTouchData(
                                        touchCallback: (pieTouchResponse) {
                                      setState(() {
                                        if (pieTouchResponse.touchInput
                                                is FlLongPressEnd ||
                                            pieTouchResponse.touchInput
                                                is FlPanEnd) {
                                          touchedIndex = -1;
                                        } else {
                                          touchedIndex = pieTouchResponse
                                              .touchedSectionIndex;
                                        }
                                      });
                                    }),
                                    startDegreeOffset: 180,
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 1,
                                    centerSpaceRadius: 0,
                                    sections: showingSections()),
                              )
                            : SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          panda(context, numOfRememberedWords, numOfUnstudiedWords),
          Spacer(),
        ],
      ),
    );
  }

  Widget panda(
      BuildContext context, int numOfRememberedWords, int numOfUnstudiedWords) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;
    List<String> pandaList = [
      "assets/images/panda1.png",
      "assets/images/panda2.png",
      "assets/images/panda3.png",
      "assets/images/panda4.png",
      "assets/images/panda5.png"
    ];
    return Center(
      child: Container(
          height: _deviceHeight / 5,
          width: _deviceWidth,
          child: pandaSelected(
              pandaList, numOfRememberedWords, numOfUnstudiedWords)),
    );
  }

  Widget pandaSelected(List<String> pandaList, int numOfRememberedWords,
      int numOfUnstudiedWords) {
    if ((numOfUnstudiedWords == 1300)) {
      return Image.asset(
        pandaList[0],
        alignment: Alignment.center,
      );
    } else if (numOfRememberedWords == 1300) {
      return Image.asset(
        pandaList[4],
        alignment: Alignment.center,
      );
    } else {
      return Image.asset(
        pandaList[randomValue(1, 4)],
        alignment: Alignment.center,
      );
    }
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 0.65 : 1;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Theme.of(context).accentColor.withOpacity(opacity),
              value: (numOfRememberedWords != null)
                  ? (numOfRememberedWords / numOfAllWords) * 100
                  : 0,
              title: (numOfRememberedWords != null &&
                      (numOfRememberedWords / numOfAllWords) > 0.1)
                  ? numOfRememberedWords.toString()
                  : "",
              radius: 80,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).secondaryHeaderColor),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color:
                  Theme.of(context).secondaryHeaderColor.withOpacity(opacity),
              value: (numOfForgotWords != null)
                  ? (numOfForgotWords / numOfAllWords) * 100
                  : 0,
              title: (numOfForgotWords != null &&
                      (numOfForgotWords / numOfAllWords) > 0.1)
                  ? numOfForgotWords.toString()
                  : "",
              radius: 65,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor),
              titlePositionPercentageOffset: 0.55,
            );
          case 2:
            return PieChartSectionData(
              color: Colors.grey.withOpacity(opacity),
              value: (numOfUnstudiedWords != null)
                  ? (numOfUnstudiedWords / numOfAllWords) * 100
                  : 0,
              title: (numOfUnstudiedWords != null &&
                      (numOfUnstudiedWords / numOfAllWords) > 0.1)
                  ? numOfUnstudiedWords.toString()
                  : "",
              radius: 60,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).secondaryHeaderColor),
              titlePositionPercentageOffset: 0.6,
            );
          case 3:
            return PieChartSectionData(
              color: Colors.green.withOpacity(opacity),
              value: (numOfRemainingWords != null)
                  ? (numOfRemainingWords / numOfAllWords) * 100
                  : 0,
              title: (numOfRemainingWords != null &&
                      (numOfRemainingWords / numOfAllWords) > 0.1)
                  ? numOfRemainingWords.toString()
                  : "",
              radius: 70,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).secondaryHeaderColor),
              titlePositionPercentageOffset: 0.55,
            );
          default:
            return null;
        }
      },
    );
  }
}
