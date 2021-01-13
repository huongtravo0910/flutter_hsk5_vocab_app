import 'package:flutter/material.dart';

class OutlinedCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.0),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
    );
  }
}
