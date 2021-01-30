import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/plainContainer.dart';
import 'matchingScreen/localWidgets/matchingCard2.dart';

class TestScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    PlainContainer(
                      child: Text("Hello"),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    PlainContainer(
                      child: Text("Hello"),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    PlainContainer(
                      child: Text("Hello"),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    PlainContainer(
                      child: Text("Hello"),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    PlainContainer(
                      child: Text("Hello"),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    PlainContainer(
                      child: Text("Hello"),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    PlainContainer(
                      child: Text("Hello"),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    PlainContainer(
                      child: Text("Hello"),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
