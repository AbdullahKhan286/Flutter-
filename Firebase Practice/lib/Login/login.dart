import 'package:firebase/UserScreen/Screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/button.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Log in'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  label: Icon(Icons.email_outlined),
                  hintText: 'Input Email',
                ),
              ),
              TextFormField(
                controller: pass,
                decoration: const InputDecoration(
                  label: Icon(Icons.lock_open_outlined),
                  hintText: 'Input Passcode',
                  suffix: Icon(Icons.remove_red_eye),
                ),
              ),
              Button(
                title: 'Log in',
                Tap: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      Screen1()), (Route<dynamic> route) => true);
                },
                loading: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => SignUp()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
