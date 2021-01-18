import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/state/currentRoomState.dart';
import 'package:provider/provider.dart';

class MethodDropdown extends StatefulWidget {
  final int startIndexOfPackage;
  final int numOfCards;
  final int endRoomNo;
  const MethodDropdown(
      {Key key, this.endRoomNo, this.numOfCards, this.startIndexOfPackage})
      : super(key: key);
  @override
  _MethodDropdownState createState() => _MethodDropdownState();
}

class _MethodDropdownState extends State<MethodDropdown> {
  String dropdownValue = "Phong 1";
  List<String> rooms;

  @override
  Widget build(BuildContext context) {
    rooms = ["Phong 1"];
    for (var i = 2; i <= widget.endRoomNo; i++) {
      String room = "Phong " + i.toString();
      rooms.add(room);
    }
    void _setCurrentRoom(int startIndex, int numOfCards) {
      CurrentRoom().setCurrentRoom(startIndex, numOfCards);
    }

    return SizedBox(
      height: 50,
      width: 100,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Consumer<CurrentRoom>(builder: (context, mymodel, child) {
          return DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 20,
            elevation: 0,
            style: Theme.of(context).textTheme.bodyText1,
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String newValue) {
              // debugPrint("Room" + newValue.substring(newValue.length - 1));
              int noOfRoom = int.parse(newValue.substring(newValue.length - 1));
              // debugPrint((noOfRoom * widget.numOfCards).toString());

              int startIndex =
                  widget.startIndexOfPackage + noOfRoom * widget.numOfCards;
              // debugPrint("startIndex" + startIndex.toString());

              _setCurrentRoom(startIndex, widget.numOfCards);

              setState(() {
                dropdownValue = newValue;
              });
            },
            items: rooms.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
