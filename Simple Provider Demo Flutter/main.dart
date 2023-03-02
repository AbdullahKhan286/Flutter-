import 'package:api/ProTest/provide/newProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ProTest/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> newProvider())
    ],
    child: const MaterialApp(home: ProTest()),);
  }
}
