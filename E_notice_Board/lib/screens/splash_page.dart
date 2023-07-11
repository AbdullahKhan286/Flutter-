import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_notic_board/cors/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final auth = Get.put(AuthController());
  final _colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  final _colorizeTextStyle = const TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Horizon',
  );

  @override
  void initState() {
    auth.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        alignment: Alignment.center,
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            ColorizeAnimatedText('DCSE',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
          ],
        ),
      ),
    );
  }
}

