import 'dart:developer';

import 'package:flutter/material.dart';
import 'botton.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var input = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        input.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 32, ),
                      ),
                      Text(
                        answer.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 32, ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                                text: 'AC',
                                onPress: () {
                                  input = '';
                                  answer = '';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '+/-',
                                onPress: () {
                                  input += '+/-';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '%',
                                onPress: () {
                                  input += '%';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '/',
                                color: Colors.orangeAccent,
                                onPress: () {
                                  input += '/';
                                  setState(() {});
                                }),
                          ]),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                                text: '7',
                                onPress: () {
                                  input += '7';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '8',
                                onPress: () {
                                  input += '8';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '9',
                                onPress: () {
                                  input += '9';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: 'x',
                                color: Colors.orangeAccent,
                                onPress: () {
                                  input += 'x';
                                  setState(() {});
                                }),
                          ]),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                                text: '4',
                                onPress: () {
                                  input += '4';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '5',
                                onPress: () {
                                  input += '5';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '6',
                                onPress: () {
                                  input += '6';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '-',
                                color: Colors.orangeAccent,
                                onPress: () {
                                  input += '-';
                                  setState(() {});
                                }),
                          ]),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                                text: '1',
                                onPress: () {
                                  input += '1';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '2',
                                onPress: () {
                                  input += '2';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '3',
                                onPress: () {
                                  input += '3';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '+',
                                color: Colors.orangeAccent,
                                onPress: () {
                                  input += '+';
                                  setState(() {});
                                }),
                          ]),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                                text: '0',
                                onPress: () {
                                  input += '0';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '.',
                                onPress: () {
                                  input += '.';
                                  setState(() {});
                                }),
                            CustomButton(
                                text: 'Del',
                                onPress: () {
                                  input = input.substring(0, input.length - 1);
                                  setState(() {});
                                }),
                            CustomButton(
                                text: '=',
                                color: Colors.orangeAccent,
                                onPress: () {
                                  Equal_Function();
                                  setState(() {
                                  });
                                }),
                          ]),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  void Equal_Function() {
    Parser p = Parser();
    Expression exp = p.parse(input);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();

  }

}
