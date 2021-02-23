import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/outlinedCircle.dart';
import 'package:hsk5_vocab_app/widgets/shadowContainerButton.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onPressed;
  final Icon icon;
  const HomeCard(
      {Key key, this.icon, this.subtitle, this.title, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ShadowContainerButton(
      isChosen: false,
      onPressed: onPressed,
      margin: 8,
      child: SizedBox(
        height: 90,
        width: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  icon,
                  OutlinedCircle(),
                ],
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              (subtitle != null)
                  ? Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
