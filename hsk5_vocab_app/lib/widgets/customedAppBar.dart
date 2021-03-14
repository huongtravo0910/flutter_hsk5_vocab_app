import 'package:flutter/material.dart';

class CustomedAppBar extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldState> globalKey;
  const CustomedAppBar({Key key, this.child, this.globalKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          child,
          InkWell(
              onTap: () {
                globalKey.currentState.openDrawer();
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
