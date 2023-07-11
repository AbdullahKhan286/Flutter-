import 'package:flutter/material.dart';
import 'package:share_prefrences/student.dart';
import 'package:share_prefrences/teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final agecontroller = TextEditingController();

  bool adminvalue = false;
  bool studentvalue = false;
  bool teachervalue = false;

  int user = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
     Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/pic2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: emailcontroller,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(19))),
                  label: Text("Email"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: passwordcontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(19))),
                  label: Text("Passcode"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: agecontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(19))),
                  label: Text("Age"),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Admin"),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        value: this.adminvalue,
                        onChanged: (bool? value) {
                          setState(() {
                            this.adminvalue = value!;
                            user = 1;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Student"),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        value: this.studentvalue,
                        onChanged: (bool? value) {
                          setState(() {
                            this.studentvalue = value!;
                            user = 2;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Teacher"),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        value: this.teachervalue,
                        onChanged: (bool? value) {
                          setState(() {
                            this.teachervalue = value!;
                            user = 3;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.setString('name', emailcontroller.text.toString());
                  sp.setString('passcode', passwordcontroller.text.toString());
                  sp.setString('age', agecontroller.text.toString());
                  sp.setBool('isLogin', true);
                  sp.setInt('type', user);
                  if (user == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Admin()));
                  } else if (user == 2) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Student()));
                  } else if (user == 3) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Teacher()));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16)),
                  alignment: Alignment.center,
                  height: 40,
                  child: Text("Click Here"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
