import 'package:firebase/Utils/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../UserScreen/Screen1.dart';
import '../Utils/fluttertoast.dart';
import '../widget/button.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKeyname = GlobalKey<FormState>();
  final _formKeypass = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKeyname,
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  label: Icon(Icons.email_outlined),
                  hintText: 'Input Emial',
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter Email';
                  }
                  return null;
                },
              ),
            ),
            Form(
              key: _formKeypass,
              child: TextFormField(
                controller: pass,
                decoration: const InputDecoration(
                  label: Icon(Icons.lock_open_outlined),
                  hintText: 'Input Passcode',
                  suffix: Icon(Icons.remove_red_eye),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter Password';
                  }
                  return null;
                },
              ),
            ),
            Button(
              loading: false,
              title: 'Sign Up',
              Tap: () {
                if (_formKeyname.currentState!.validate()) {
                  _auth
                      .createUserWithEmailAndPassword(
                          email: name.text.toString(),
                          password: pass.text.toString())
                      .then((value) {})
                      .onError((error, stackTrace) {
                    MyToast().toastFun(error.toString());
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Screen1()),
                      (Route<dynamic> route) => true);
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account?"),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text("Sign In"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
