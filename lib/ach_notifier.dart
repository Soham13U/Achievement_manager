import 'dart:collection';

import 'package:ach/ach.dart';

import 'package:flutter/cupertino.dart';

class AchNotifier with ChangeNotifier{

  List<Ach> _achlist = [];

  Ach _currentAch;

  UnmodifiableListView<Ach> get achlist => UnmodifiableListView(_achlist);

  Ach get currentAch => _currentAch;
   
  
  set achlist(List<Ach> achlist){
    
    _achlist=achlist;
    notifyListeners();

  }

  set currentAch(Ach ach){
    _currentAch = ach;
    notifyListeners();
  }

}