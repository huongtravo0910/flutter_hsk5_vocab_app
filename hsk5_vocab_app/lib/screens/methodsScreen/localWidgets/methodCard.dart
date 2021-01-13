import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/localWidgets/outlinedCircle.dart';
import 'package:hsk5_vocab_app/widgets/shadowContainerButton.dart';

class MethodCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onPressed;
  final Icon icon;
  const MethodCard(
      {Key key, this.icon, this.subtitle, this.title, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ShadowContainerButton(
      onPressed: onPressed,
      margin: 10,
      child: SizedBox(
        height: 100,
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
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
