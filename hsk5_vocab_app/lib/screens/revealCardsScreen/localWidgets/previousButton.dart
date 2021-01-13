import 'package:flutter/material.dart';

class PreviousButton extends StatelessWidget {
  final Function onPressed;
  const PreviousButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(0),
          left: Radius.circular(10),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: Center(
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: onPressed,
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
