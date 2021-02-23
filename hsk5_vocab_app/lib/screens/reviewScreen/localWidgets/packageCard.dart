import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/shadowContainerButton.dart';

class PackageCard extends StatelessWidget {
  final String subtitle;
  final String title;
  final Function onPressed;
  final bool isChosen;
  const PackageCard(
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
        height: 114,
        width: 100,
        child: subtitle != null
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: 8,
                // ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                )
              ])
            : Center(
                child:
                    Text(title, style: Theme.of(context).textTheme.headline4),
              ),
      ),
    );
  }
}
