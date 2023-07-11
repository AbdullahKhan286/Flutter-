import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Teacher extends StatefulWidget {
  const Teacher({Key? key}) : super(key: key);

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  String name = '', passcode = '', age = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  void load() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('name') ?? '';
    passcode = sp.getString('passcode') ?? '';
    age = sp.getString('age') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Teacher'),
            automaticallyImplyLeading: false,
            centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('User'),
                  Text(name.toString()),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Teacher'),
                  Text(age.toString()),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.clear();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  color: Colors.blue,
                  child: const Text("Click Here"),
                ),
              ),
            ],
          ),
        ));
  }
}
