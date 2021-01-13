import 'package:flutter/material.dart';

class MethodDropdown extends StatefulWidget {
  @override
  _MethodDropdownState createState() => _MethodDropdownState();
}

class _MethodDropdownState extends State<MethodDropdown> {
  String dropdownValue = "Phong 1";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: DropdownButton<String>(
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
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['Phong 1', 'Phong 2', 'Phong 3', 'Phong 4']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
