
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Login/login.dart';
import '../Utils/fluttertoast.dart';
import '../widget/button.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  String city = '';
  bool loading = false;
  TextEditingController postController = TextEditingController();
  TextEditingController postController2 = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Post'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: 4,
                controller: postController,
                decoration: InputDecoration(
                    hintText: 'What is in your mind?',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLines: 1,
                controller: postController2,
                decoration: InputDecoration(
                    hintText: 'Enter City Name',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
              Button(
                  title: 'Post',
                  loading: loading,
                  Tap: () {
                    final idtime =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    // if (_formKey.currentState.validate()) {
                    //   // The form is valid, post data to Firebase
                    //   String value = _controller.text;
                    //   // ... code to post data to Firebase ...
                    // } else {
                    //   // The form is invalid, show error message
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('Please enter a value')),
                    //   );
                    // }
                    setState(() {
                      loading = true;
                    });
                    String id = idtime.toString();
                    databaseRef.child(id).set({
                      'title': postController.text.toString(),
                      'id': idtime.toString(),
                      'city': postController2.text.toString()
                    }).then((value) {
                      MyToast().toastFun('Post added');
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      MyToast().toastFun(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                    postController.clear();
                    postController2.clear();
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.view_carousel_outlined),
          backgroundColor: Colors.green,
          onPressed: () {
            //Navigator.push(
              //  context, MaterialPageRoute(builder: (context) => PostView()));
          },
        ));
  }
}

//sufyaan286@gmail.com
