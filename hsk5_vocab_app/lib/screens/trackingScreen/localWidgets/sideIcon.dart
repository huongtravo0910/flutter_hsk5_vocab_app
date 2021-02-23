import 'package:flutter/material.dart';

Widget indicator(String type, BuildContext context) {
  Icon icon;
  switch (type) {
    case "Noi tu":
      {
        icon = Icon(
          Icons.map_outlined,
          color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
          size: 20,
        );
      }
      break;
    case "Flash card":
      {
        icon = Icon(
          Icons.bookmark,
          color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
          size: 20,
        );
      }
      break;
  }
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 73, 57, 32).withOpacity(0.0),
      shape: BoxShape.circle,
      border: Border.all(
        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
        width: 1,
      ),
    ),
    child: icon,
  );
}
