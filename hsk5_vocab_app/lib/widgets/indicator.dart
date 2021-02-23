import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;
  final FontWeight fontWeight;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.fontWeight,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 100),
          padding: EdgeInsets.only(left: 4),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16, fontWeight: fontWeight, color: textColor),
          ),
        )
      ],
    );
  }
}
