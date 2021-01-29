import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/plainContainer.dart';

class MatchingCard extends StatelessWidget {
  final String mainText;
  final bool isChosen;
  const MatchingCard({Key key, this.mainText, this.isChosen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 100,
      width: 170,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: isChosen
              ? Border.all(
                  width: 2, color: Theme.of(context).secondaryHeaderColor)
              : Border.all(width: 2, color: Theme.of(context).primaryColor)),
      child: PlainContainer(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              mainText,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ]),
        ),
      ),
    );
  }
}
