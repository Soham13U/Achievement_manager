import 'package:ach/HomePage.dart';
import 'package:ach/SignUp.dart';
import 'package:ach/Start.dart';
import 'package:ach/user.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return Start();
    } else {
      print('Done');
      return HomePage(
        user.uid,
      );
    }
  }
}