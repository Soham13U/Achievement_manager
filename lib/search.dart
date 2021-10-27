import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Main Stateful Widget Start
class ListViewPage extends StatefulWidget {
  //String uid;
  //ListViewPage({this.uid});

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  bool search = false;
  String searchstr;
  @override
  Widget build(BuildContext context) {
    // MediaQuery to get Device Width
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        // App Bar
        title: Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Color(0xff2F1E54),
      ),
      // Main List View With Builder
      body: StreamBuilder(
        stream: Firestore.instance.collection("final_ach").snapshots(),
        builder: (context, snapshot) {
          if (!search) {
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search by category or email!"),
                      onChanged: (text) {
                        // text = text.toLowerCase();
                        setState(() {
                          searchstr = text;
                          search = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      // itemCount: imgList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot _achievement =
                            snapshot.data.documents[index];
                        return GestureDetector(
                          onTap: () {
                            // This Will Call When User Click On ListView Item
                            showDialogFunc(
                                context,
                                _achievement['ach_image'],
                                _achievement['category'],
                                _achievement['description']);
                          },
                          // Card Which Holds Layout Of ListView Item
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  height: 100,
                                  child:
                                      Image.network(_achievement['ach_image']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _achievement['category'],
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: width,
                                        child: Text(
                                          _achievement['email'],
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[500]),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 30.0),
                    child: TextField(
                      decoration:
                          InputDecoration(prefixIcon: Icon(Icons.search)),
                      onChanged: (text) {
                        // text = text.toLowerCase();
                        setState(() {
                          searchstr = text;
                          search = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        // itemCount: imgList.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot _achievement =
                              snapshot.data.documents[index];
                          if ((_achievement['category'].contains(searchstr)) ||
                              (_achievement['email'].contains(searchstr))) {
                            print(
                                "Matcheeeeeeeeeeeeedddd + $_achievement['category'] $searchstr");

                            return GestureDetector(
                              onTap: () {
                                // This Will Call When User Click On ListView Item
                                showDialogFunc(
                                    context,
                                    _achievement['ach_image'],
                                    _achievement['category'],
                                    _achievement['description']);
                              },
                              // Card Which Holds Layout Of ListView Item
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                          _achievement['ach_image']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _achievement['category'],
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: width,
                                            child: Text(
                                              _achievement['email'],
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[500]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            print("not matched $searchstr");
                            return Container();
                          }
                        }),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// This is a block of Model Dialog
showDialogFunc(context, img, title, desc) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    img,
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      desc,
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
