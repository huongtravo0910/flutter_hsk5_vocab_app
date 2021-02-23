import 'package:flutter/material.dart';

class TickButton extends StatelessWidget {
  final Function onPressed;
  final int isRemembered;
  const TickButton({Key key, this.onPressed, this.isRemembered})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 110,
      decoration: BoxDecoration(
        border: (isRemembered == 1)
            ? Border.all(
                width: 2,
              )
            : Border.all(
                width: 2,
                color: Colors.green[900],
              ),
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
