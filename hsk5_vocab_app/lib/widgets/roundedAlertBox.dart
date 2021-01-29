import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';

class RoundedAlertBox extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  const RoundedAlertBox({Key key, this.child, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green[900],
              ),
              child: Icon(
                Icons.done,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text("Hoan thanh"),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 2,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            SizedBox(
              height: 10,
            ),
            child,
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/");
              },
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 1.0,
                    top: 2.0,
                    child: Icon(
                      Icons.home,
                      color: Colors.black45,
                      size: 40,
                    ),
                  ),
                  Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 39,
                  ),
                ],
              ),
            ),
            ShadowButton(child: Text("Tiep tuc"), onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
