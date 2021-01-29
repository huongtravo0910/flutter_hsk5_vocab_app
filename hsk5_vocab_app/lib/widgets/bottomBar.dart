import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final String roomName;
  final String packageName;
  const BottomBar({Key key, this.packageName, this.roomName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          packageName,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          " - ",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          roomName,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
