import 'dart:async';

import 'package:firebase/Splash_Screen/splash_service.dart';
import 'package:firebase/UserScreen/Screen1.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';


import '../Login/login.dart';

import 'dart:async';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  splashservice service = splashservice();

  void initState() {
    super.initState();
    service.islogin(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Column(
        children: [

              Expanded(child: Image(image: AssetImage('assets/splash.jpg'), fit: BoxFit.fill,))


        ],
      ),
    );
  }
}




/*

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState

    Timer( const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Login()), (Route<dynamic> route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(child: Text('This is splash screen', style: TextStyle(fontSize: 30),))
        ],
      ),
    );
  }
}

*/
