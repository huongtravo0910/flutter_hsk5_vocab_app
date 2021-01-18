import 'package:flutter/material.dart';

class ShadowContainerButton extends StatelessWidget {
  final double margin;
  final Function onPressed;
  final Widget child;
  final bool isChosen;
  const ShadowContainerButton(
      {Key key, this.child, this.margin, this.onPressed, this.isChosen})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      child: Container(
        margin: EdgeInsets.all(margin),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: isChosen
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black45.withOpacity(0.3),
                offset: Offset(0.0, 4.0),
                spreadRadius: 0.5,
                blurRadius: 2.0,
              )
            ]),
        child: child,
      ),
    );
  }
}
