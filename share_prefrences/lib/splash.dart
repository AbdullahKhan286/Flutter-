import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share_prefrences/admin.dart';
import 'package:share_prefrences/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [
        Expanded(
          child: Image(fit: BoxFit.fill, image: AssetImage('assets/pic.jpg')),
        )
      ],
    ));
  }

  void IsLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool log = sp.getBool('isLogin') ?? false;

    if (log == true) {
      Timer(Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Admin()));
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
  }
}
