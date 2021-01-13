import 'package:flutter/material.dart';

class ShadowButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  const ShadowButton({Key key, this.child, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black45.withOpacity(0.2),
            offset: Offset(0.0, 3.0),
            spreadRadius: 0.0,
            blurRadius: 1.0,
          ),
        ],
      ),
      child: RaisedButton(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: () => onPressed(),
        padding: EdgeInsets.all(10.0),
        color: Theme.of(context).accentColor,
        textColor: Theme.of(context).primaryColor,
        child: child,
      ),
    );
  }
}
