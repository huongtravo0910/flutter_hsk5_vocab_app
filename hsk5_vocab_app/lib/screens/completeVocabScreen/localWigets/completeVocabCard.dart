import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/shadowContainerButton.dart';

class CompleteVocabCard extends StatelessWidget {
  final String subtitle;
  final String title;
  final Function onPressed;
  final bool isChosen;
  const CompleteVocabCard(
      {Key key,
      this.subtitle,
      @required this.title,
      this.onPressed,
      this.isChosen})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ShadowContainerButton(
      isChosen: isChosen,
      onPressed: onPressed,
      margin: 5.0,
      child: Container(
        height: 45,
        width: 100,
        child: subtitle != null
            ? Column(children: [
                Text(subtitle, style: Theme.of(context).textTheme.bodyText2),
                Text(title, style: Theme.of(context).textTheme.headline4)
              ])
            : Center(
                child:
                    Text(title, style: Theme.of(context).textTheme.headline4),
              ),
      ),
    );
  }
}
