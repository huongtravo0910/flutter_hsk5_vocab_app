import 'package:flutter/material.dart';

class CustomedDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            height: 100,
            child: Image.asset("assets/images/panda.png"),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home),
                Text("  "),
                Text(
                  "Trang chủ",
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.library_books),
                Text("  "),
                Text(
                  "Từ vựng HSK5",
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/completevocab");
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.book_sharp),
                Text("  "),
                Text(
                  "Ôn tập từ vựng",
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/review");
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.track_changes),
                Text("  "),
                Text(
                  "Theo dõi tiến độ học",
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/tracking");
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.settings),
                Text("  "),
                Text(
                  "Cài đặt",
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                "/setting",
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
