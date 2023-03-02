import 'package:api/ProTest/provide/newProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProTest extends StatefulWidget {
  const ProTest({Key? key}) : super(key: key);
  @override
  State<ProTest> createState() => _ProTestState();
}

class _ProTestState extends State<ProTest> {
  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<newProvider>(builder: (context, cval, child) {
            return Slider(
              value: cval.count,
              onChanged: (value) {
                cval.get(value);
              },
              max: 1,
              min: 0,
            );
          }),
          Consumer<newProvider>(builder: (context, cval, child) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    color: Colors.green.withOpacity(cval.count),
                    child: const Center(child: Text('Box One')),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    color: Colors.blue.withOpacity(cval.count),
                    child: const Center(child: Text('Box Two')),
                  ),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
