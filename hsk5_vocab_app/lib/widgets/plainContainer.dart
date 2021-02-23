import 'package:flutter/material.dart';

class PlainContainer extends StatelessWidget {
  final Widget child;
  const PlainContainer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(minHeight: 110),
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
        child: child,
      ),
    );
  }
}
