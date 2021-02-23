import 'package:flutter/material.dart';

class CustomedAppBar extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldState> globalKey;
  const CustomedAppBar({Key key, this.child, this.globalKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 30, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          child,
          FlatButton(
              onPressed: () {
                globalKey.currentState.openDrawer();
                debugPrint("Yo");
              },
              child: Icon(
                Icons.menu,
                size: 30,
              ))
        ],
      ),
    );
  }
}
