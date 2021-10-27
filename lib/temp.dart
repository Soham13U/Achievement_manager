import 'package:ach/database.dart';
import 'package:ach/user.dart';
import 'package:ach/view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../bloc.navigation_bloc/navigation_bloc.dart';

class Temp extends StatelessWidget  {
  String uid;
  Temp(String uid) {
    this.uid = uid;
    print('uid3 ' + this.uid);
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserInfo>>.value(
      value: DatabaseService().userData,
      child: Scaffold(
        body: ViewProfile(uid),
      ),
    );
  }
}