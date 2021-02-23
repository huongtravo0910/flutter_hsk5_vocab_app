import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 0, 0),
          child: InkWell(
            child: Text("Hi"),
            onTap: () {
              debugPrint("Hello");
            },
          ),
        ),
      ),
    );
  }
}
