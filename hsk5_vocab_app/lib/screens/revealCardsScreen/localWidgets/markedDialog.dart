import 'package:flutter/material.dart';

class MarkedDialog extends StatelessWidget {
  final Widget checkbox;
  const MarkedDialog({Key key, this.checkbox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      child: Container(
        height: 100,
        width: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Đánh dấu",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            checkbox
          ],
        ),
      ),
    );
  }
}
