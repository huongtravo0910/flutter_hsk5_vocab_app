import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/widgets/plainContainer.dart';

class MovingCardWidget extends StatefulWidget {
  final String urlFront;
  final String urlBack;

  const MovingCardWidget({
    @required this.urlFront,
    @required this.urlBack,
    Key key,
  }) : super(key: key);

  @override
  _MovingCardWidgetState createState() => _MovingCardWidgetState();
}

class _MovingCardWidgetState extends State<MovingCardWidget>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool isFront = true;
  double verticalDrag = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  _renderFrontWidget(context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
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
                  flex: 3,
                  child: SingleChildScrollView(
                    child: PlainContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.urlFront,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
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

  _renderBackWidget(context) {
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
                  child: PlainContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.urlBack,
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                  ),
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

  @override
  Widget build(BuildContext context) => GestureDetector(
        onVerticalDragStart: (details) {
          controller.reset();

          setState(() {
            isFront = true;
            verticalDrag = 0;
          });
        },
        onVerticalDragUpdate: (details) {
          setState(() {
            verticalDrag += details.delta.dy;
            verticalDrag %= 360;

            setImageSide();
          });
        },
        onVerticalDragEnd: (details) {
          final double end = 360 - verticalDrag >= 180 ? 0 : 360;

          animation =
              Tween<double>(begin: verticalDrag, end: end).animate(controller)
                ..addListener(() {
                  setState(() {
                    verticalDrag = animation.value;
                    setImageSide();
                  });
                });
          controller.forward();
        },
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(verticalDrag / 180 * pi),
          alignment: Alignment.center,
          child: isFront
              ? _renderFrontWidget(context)
              : Transform(
                  transform: Matrix4.identity()..rotateX(pi),
                  alignment: Alignment.center,
                  child: _renderBackWidget(context),
                ),
        ),
      );

  void setImageSide() {
    if (verticalDrag <= 90 || verticalDrag >= 270) {
      isFront = true;
    } else {
      isFront = false;
    }
  }
}
