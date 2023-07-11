
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../Login/login.dart';
import '../UserScreen/Screen1.dart';
import 'package:flutter/material.dart';

class splashservice{


  void islogin(context){

    final auth= FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Timer(const Duration(seconds: 3),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Screen1()))
      );
    }else {
      Timer(const Duration(seconds: 3),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Login()))
      );
    }
  }




}