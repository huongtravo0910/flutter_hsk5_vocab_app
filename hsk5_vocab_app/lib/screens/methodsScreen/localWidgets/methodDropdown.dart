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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CurrentRoom>(context, listen: false).setCurrentRoom(
        widget.startIndexOfPackage, widget.numOfCards, "Phong 1");
  }

  @override
  Widget build(BuildContext context) {
    rooms = ["Phong 1"];
    for (var i = 2; i <= widget.endRoomNo; i++) {
      String room = "Phong " + i.toString();
      rooms.add(room);
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
              int noOfRoom = 0;
              if (newValue.length < 8) {
                noOfRoom = int.parse(newValue.substring(newValue.length - 1));
              } else if (newValue.length == 8) {
                noOfRoom = int.parse(newValue.substring(newValue.length - 2));
              } else if (newValue.length == 9) {
                noOfRoom = int.parse(newValue.substring(newValue.length - 3));
              }

              int startIndex = widget.startIndexOfPackage +
                  (noOfRoom - 1) * widget.numOfCards;

              setState(() {
                dropdownValue = newValue;
              });
              Provider.of<CurrentRoom>(context, listen: false)
                  .setCurrentRoom(startIndex, widget.numOfCards, dropdownValue);
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
