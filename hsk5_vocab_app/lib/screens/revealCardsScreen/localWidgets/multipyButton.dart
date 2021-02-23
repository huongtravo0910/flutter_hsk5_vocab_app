import 'package:flutter/material.dart';

class MultipyButton extends StatelessWidget {
  final Function onPressed;
  final int isRemembered;
  const MultipyButton({Key key, this.onPressed, this.isRemembered})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 110,
      decoration: BoxDecoration(
        border: (isRemembered == 0)
            ? Border.all(
                width: 2,
              )
            : Border.all(
                width: 2,
                color: Theme.of(context).accentColor,
              ),
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
