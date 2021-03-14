import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/animatedCard.dart';
import 'package:hsk5_vocab_app/screens/revealCardsScreen/localWidgets/movingCard.dart';

class TestSwipeHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Foo"),
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return MovingCardWidget(
            urlBack: "Hello",
            urlFront: "Yoyo",
          );
        },
        onIndexChanged: (index) {
          debugPrint("$index");
        },
        itemCount: 3,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
