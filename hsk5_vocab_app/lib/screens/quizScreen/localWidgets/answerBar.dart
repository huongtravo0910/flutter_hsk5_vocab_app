import 'package:flutter/material.dart';

class AnswerBar extends StatelessWidget {
  final String choice;
  final bool isCorrect;
  final bool isChosen;
  const AnswerBar({Key key, this.choice, this.isCorrect, this.isChosen})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 300,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30),
          border: isCorrect && isChosen
              ? Border.all(
                  width: 2, color: Theme.of(context).secondaryHeaderColor)
              : Border.all(width: 2, color: Theme.of(context).primaryColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
          ),
          isCorrect
              ? Icon(
                  Icons.done,
                  color:
                      isChosen ? Colors.black : Theme.of(context).primaryColor,
                )
              : Icon(
                  Icons.clear,
                  color:
                      isChosen ? Colors.black : Theme.of(context).primaryColor,
                ),
          SizedBox(
            width: 5,
          ),
          Text(
            choice,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
