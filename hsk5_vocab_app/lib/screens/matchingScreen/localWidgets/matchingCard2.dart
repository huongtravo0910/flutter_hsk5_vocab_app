import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/plainContainer.dart';

class MatchingCard2 extends StatelessWidget {
  final String mainText;
  final bool isChosen;
  const MatchingCard2({Key key, this.mainText, this.isChosen})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PlainContainer(
      child: Text(
        mainText,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
