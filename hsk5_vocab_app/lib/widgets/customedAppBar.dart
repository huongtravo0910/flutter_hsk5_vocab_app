import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/homeScreen/homeScreen.dart';

class CustomedAppBar extends StatelessWidget {
  final Widget child;
  const CustomedAppBar({Key key, this.child}) : super(key: key);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomeScreen(),
                  ),
                );
              },
              child: Icon(
                Icons.home,
                size: 35,
              ))
        ],
      ),
    );
  }
}
