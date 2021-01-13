import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final Function onPressed;
  const NextButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(0),
          right: Radius.circular(10),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: Center(
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: onPressed,
          child: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
