import 'package:flutter/material.dart';

class TickButton extends StatelessWidget {
  final Function onPressed;
  const TickButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 110,
      decoration: BoxDecoration(
        color: Colors.green[900],
        borderRadius: BorderRadius.circular(30),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Icon(
          Icons.done,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
