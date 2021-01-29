import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/plainContainer.dart';

class MatchingCardWithSubText extends StatelessWidget {
  final String mainText;
  final String subText;
  final bool isChosen;
  const MatchingCardWithSubText(
      {Key key, this.mainText, this.subText, this.isChosen})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: isChosen
              ? Border.all(
                  width: 2, color: Theme.of(context).secondaryHeaderColor)
              : Border.all(width: 2, color: Theme.of(context).primaryColor)),
      height: 100,
      width: 170,
      child: PlainContainer(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            mainText,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            subText,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ]),
      ),
    );
  }
}
