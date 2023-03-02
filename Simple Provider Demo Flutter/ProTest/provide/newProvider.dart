import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class newProvider with ChangeNotifier{

  double _count = 1;
  double get count => _count;

  void get(double Val){
    _count = Val;
    notifyListeners();
  }



}