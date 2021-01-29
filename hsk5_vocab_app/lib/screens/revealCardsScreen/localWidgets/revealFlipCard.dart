import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/plainContainer.dart';

class RevealFlipCard extends StatefulWidget {
  final String pronunciation;
  final String word;
  const RevealFlipCard({Key key, this.pronunciation, this.word})
      : super(key: key);

  @override
  _RevealFlipCardState createState() => _RevealFlipCardState();
}

class _RevealFlipCardState extends State<RevealFlipCard> {
  bool _isTapped = false;
  _renderContent(context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          // debugPrint(status.toString());
        },
        flipOnTouch: true,
        back: _isTapped
            ? PlainContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.word,
                        style: Theme.of(context).textTheme.headline),
                  ],
                ),
              )
            : PlainContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("/" + widget.pronunciation + "/",
                        style: Theme.of(context).textTheme.body1),
                  ],
                ),
              ),
        front: _isTapped
            ? PlainContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("/" + widget.pronunciation + "/",
                        style: Theme.of(context).textTheme.body1),
                  ],
                ),
              )
            : PlainContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.word,
                        style: Theme.of(context).textTheme.headline),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: _renderContent(context),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
