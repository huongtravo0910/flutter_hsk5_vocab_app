import 'package:flutter/cupertino.dart';

class Background extends StatelessWidget {
  final String imageURL;
  const Background({Key key, this.imageURL}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
