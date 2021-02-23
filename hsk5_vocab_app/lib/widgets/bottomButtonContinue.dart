import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';

class BottomButton extends StatelessWidget {
  final Function onPressed;
  const BottomButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(children: [
            ShadowButton(
              onPressed: onPressed,
              child: Text(
                "       Tiếp tục",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 14, 0, 0),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(30),
                  right: Radius.circular(0),
                ),
                color: Colors.green[900],
              ),
              child: BackButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/");
                },
                color: Theme.of(context).primaryColor,
              ),
            ),
          ]),
        ],
      ),
      SizedBox(
        height: 20,
      ),
    ]);
  }
}
