import 'dart:ffi';
import 'dart:io';

import 'package:ach/ach_notifier.dart';
import 'package:ach/achievement_form.dart';
import 'package:ach/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Achievement extends StatefulWidget {
  String uid;
  Achievement({this.uid});

  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  FirebaseAuth auth = FirebaseAuth.instance;

  var firebaseUser;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    user;
  }

  Future<Void> get user async {
    firebaseUser = await FirebaseAuth.instance.currentUser();
    setState(() {});
    return firebaseUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    AchNotifier achNotifier = Provider.of<AchNotifier>(context, listen: false);

    print("building Feed");
    var collection = user;
    print(firebaseUser.email.toString());
    String c = collection.toString();
    print(c);

    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
        backgroundColor: Color(0xff000000),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("final_ach")
            .where("uid", isEqualTo: firebaseUser.uid.toString())
            .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot _achievement = snapshot.data.documents[index];
              return ListTile(
                leading: Image.network(_achievement['ach_image']),
                title: Text(_achievement['category']),
                subtitle: Text(_achievement['description']),
              );
            },
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AchievementForm()));
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
