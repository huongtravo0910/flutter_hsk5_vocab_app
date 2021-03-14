import 'package:flutter/material.dart';

class ShadowButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final bool isOutlined;
  const ShadowButton(
      {Key key, this.child, this.onPressed, this.isOutlined = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 140),
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
          side: isOutlined
              ? BorderSide(
                  color: Theme.of(context).secondaryHeaderColor, width: 2)
              : BorderSide.none,
        ),
        onPressed: onPressed,
        padding: EdgeInsets.all(10.0),
        color: isOutlined
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
        textColor: isOutlined
            ? Theme.of(context).secondaryHeaderColor
            : Theme.of(context).primaryColor,
        child: child,
      ),
    );
  }
}
