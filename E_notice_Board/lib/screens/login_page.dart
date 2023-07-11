import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:e_notic_board/cors/auth.controller.dart';
import 'package:e_notic_board/screens/forget_password_page.dart';
import 'package:e_notic_board/screens/signup_page.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Widget myInput(title,icon,controller){
      return Container(
        padding: const EdgeInsets.only(bottom: 6,top: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(8)
        ),
        child: TextField(
          controller: controller,
          cursorColor: Colors.black45,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(
                fontSize: 18,
              ),
              prefixIcon: Icon(icon,color: Colors.black45,)
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(left: 16,right: 16),
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          children: [
            myInput("Enter University Email", BootstrapIcons.person, auth.email),
            const SizedBox(height: 20,),
            myInput("Enter Password", BootstrapIcons.lock, auth.password),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Get.to(() => const ForgetPasswordPage()), child: const Text("Forget Password"))
              ],),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: activeColor,
                    padding: const EdgeInsets.only(top: 16,bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
                ),
                onPressed: auth.handleLogin,
                child: const Text("Login",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),)),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () => Get.to(() => const SignUpPage()), child: const Text("Register Now"))
              ],),
          ],
        ),
      ),
    );
  }
}
