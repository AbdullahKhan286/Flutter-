import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Random rand = Random();

  int x = 9;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () {
            x = rand.nextInt(10);
            print(x.toString());
            setState(() {});
          },
          child: const Icon(Icons.refresh),
        ),
        appBar: AppBar(
          title: Text('Lottery App'),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Text('Lottery winning number is 7')),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: x == 7
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.done_all,
                            size: 65,
                            color: Colors.green,
                          ),
                          SizedBox(height: 20),
                          Text('You win the lottery You Number is 7 ',
                              textAlign: TextAlign.center),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 65,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Best of luck next time the lucky draw number is $x \nyou lose this time ',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
