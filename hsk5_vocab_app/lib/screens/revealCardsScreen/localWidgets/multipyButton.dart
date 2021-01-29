import 'package:flutter/material.dart';

class MultipyButton extends StatelessWidget {
  final Function onPressed;
  const MultipyButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 110,
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Theme.of(context).primaryColor,
        //   width: 2,
        // ),
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Icon(
          Icons.clear,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
