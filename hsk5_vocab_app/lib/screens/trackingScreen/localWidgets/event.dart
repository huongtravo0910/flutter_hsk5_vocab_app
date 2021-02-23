import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/trackingScreen/localModels/historyModel.dart';

Widget event(HistoryModel historyModel, BuildContext context) {
  double _deviceHeight = MediaQuery.of(context).size.height;
  double _deviceWidth = MediaQuery.of(context).size.width;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            historyModel.getStudiedType(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.query_builder,
                    color: Color.fromARGB(171, 171, 162, 119),
                  ),
                  Text("    "),
                  Text(
                      historyModel.getDateTime().day.toString() +
                          "/" +
                          historyModel.getDateTime().month.toString() +
                          "/" +
                          historyModel.getDateTime().year.toString(),
                      style: TextStyle(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.5),
                      ))
                ],
              ),
              Text(
                historyModel.getDateTime().hour.toString() +
                    ":" +
                    historyModel.getDateTime().minute.toString(),
                style: TextStyle(
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
        child: Text("Bạn đã học " +
            historyModel.getNumOfCards().toString() +
            " từ vựng trong " +
            historyModel.getPackageName() +
            "-" +
            historyModel.getroomName() +
            ", thành thạo 10 từ, chưa nhớ 0 từ. "),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
