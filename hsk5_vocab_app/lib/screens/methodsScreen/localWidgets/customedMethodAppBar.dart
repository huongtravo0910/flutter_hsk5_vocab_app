import 'package:flutter/material.dart';

class CustomedMethodAppBar extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  const CustomedMethodAppBar({Key key, this.child1, this.child2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 30, 50, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [child1, child2],
      ),
    );
  }
}
