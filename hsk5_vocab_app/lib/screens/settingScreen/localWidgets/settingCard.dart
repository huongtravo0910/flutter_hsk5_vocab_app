import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const SettingCard({Key key, this.child, this.subtitle, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10,
          ),
          (subtitle != null)
              ? Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyText2,
                )
              : SizedBox.shrink(),
          SizedBox(
            height: 10,
          ),
          child,
          Divider(),
        ],
      ),
    );
  }
}
