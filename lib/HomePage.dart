// import 'package:ach/achievement2.dart';
// import 'package:ach/achievement_form2.dart';
import 'package:ach/achievement.dart';
import 'package:ach/auth.dart';
import 'package:ach/search.dart';
import 'package:ach/temp.dart';
import 'package:ach/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  String uid;
  HomePage(String uid) {
    this.uid = uid;

    print('uid2 ' + this.uid);
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Material MyItems(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 20.0,
                      )),
                ),

                //Icon
                Material(
                  color: new Color(color),
                  borderRadius: BorderRadius.circular(24.0),
                  child: GestureDetector(
                    onTap: () {
                      if (icon == Icons.update) {
                        print("update");
                        //ProfilePage();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                      uid: widget.uid,
                                    )));
                      } else if (icon == Icons.account_circle) {
                        print("view");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Temp(
                                      widget.uid,
                                    )));
                      } else if (icon == Icons.school) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Achievement(
                                    //   uid: widget.uid,
                                    )));
                      } else {
                        print("search");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListViewPage(
                                    // uid: widget.uid,
                                    )));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                )
              ])
        ]),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Authservice _auth = Authservice();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2F1E54),
        title: Text('Dashboard'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                _auth.signOut();
              },
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            MyItems(Icons.update, "Update Profile", 0xff2F1E54),
            MyItems(Icons.account_circle, "View Profile", 0xff2F1E54),
            MyItems(Icons.school, "Achievement", 0xff2F1E54),
            MyItems(Icons.search, "Search", 0xff2F1E54),
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
          ],
        ),
      ),
    );
  }
}
