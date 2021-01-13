import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';

class BottomButton extends StatelessWidget {
  final Widget route;
  final String text;
  const BottomButton({Key key, this.route, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadowButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return route;
                }),
              ),
              child: Text(
                "Bat dau",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
