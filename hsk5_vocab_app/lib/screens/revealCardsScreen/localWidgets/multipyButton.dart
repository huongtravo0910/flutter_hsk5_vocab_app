import 'package:flutter/material.dart';

class MutipyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).secondaryHeaderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(
        Icons.clear,
        color: Theme.of(context).secondaryHeaderColor,
        size: 30,
      ),
    );
  }
}
