import 'package:flutter/material.dart';

class AnswerBar extends StatelessWidget {
  final Function onPressed;
  final String choice;
  final bool isCorrect;
  final bool isChosen;
  final bool isTapped;
  const AnswerBar(
      {Key key,
      this.choice,
      this.isCorrect,
      this.isChosen,
      this.onPressed,
      this.isTapped})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 45,
      width: 300,
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30),
          border: isChosen
              ? Border.all(
                  width: 2, color: Theme.of(context).secondaryHeaderColor)
              : Border.all(width: 2, color: Theme.of(context).primaryColor)),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
            ),
            isCorrect
                ? Icon(
                    Icons.done,
                    color: isTapped
                        ? Colors.black
                        : Theme.of(context).primaryColor,
                  )
                : Icon(
                    Icons.clear,
                    color: isTapped
                        ? Colors.black
                        : Theme.of(context).primaryColor,
                  ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                choice,
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
