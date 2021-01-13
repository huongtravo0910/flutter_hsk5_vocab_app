import 'package:flutter/material.dart';
import 'package:hsk5_vocab_app/screens/homeScreen/localWigets/homeCard.dart';
import 'package:hsk5_vocab_app/screens/methodsScreen/methodsScreen.dart';
import 'package:hsk5_vocab_app/widgets/background.dart';
import 'package:hsk5_vocab_app/widgets/shadowButton.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(
            imageURL: "assets/images/bg1.png",
          ),
          Row(
            children: [
              Spacer(),
              Column(
                children: [
                  Spacer(),
                  Text(
                    "Cac goi tu vung",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  HomeCard(
                    title: "250 tu",
                    subtitle: "Goi 1",
                  ),
                  HomeCard(
                    title: "250 tu",
                    subtitle: "Goi 2",
                  ),
                  HomeCard(
                    title: "250 tu",
                    subtitle: "Goi 3",
                  ),
                  HomeCard(
                    title: "250 tu",
                    subtitle: "Goi 4",
                  ),
                  HomeCard(
                    title: "300 tu",
                    subtitle: "Goi 5",
                  ),
                  HomeCard(
                    title: "1300 tu",
                    subtitle: "Goi 5",
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Spacer(),
                  Text(
                    "So luong the",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  HomeCard(
                    title: "10",
                  ),
                  HomeCard(
                    title: "25",
                  ),
                  HomeCard(
                    title: "50",
                  ),
                  HomeCard(
                    title: "100",
                  ),
                  HomeCard(
                    title: "250",
                  ),
                  HomeCard(
                    title: "1300",
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
            ],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShadowButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MethodsScreen();
                    }),
                  ),
                  child: Text(
                    "Tiep tuc",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ])
        ],
      ),
    );
  }
}
