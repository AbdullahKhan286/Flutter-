import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String title;
  final VoidCallback Tap;
  final bool loading;
  const Button({Key? key, required this.title, required this.Tap , required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightGreen,
        ),
        height: 45,
        width: 400,
        child: ElevatedButton(
          onPressed : Tap,
          child: loading ? CircularProgressIndicator() : Center(child: Text(title)),
        ),
      ),
    );
  }
}
