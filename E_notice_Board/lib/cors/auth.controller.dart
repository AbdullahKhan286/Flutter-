import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notic_board/models/iam.model.dart';
import 'package:e_notic_board/screens/done_verfication.dart';
import 'package:e_notic_board/screens/home_page.dart';
import 'package:e_notic_board/screens/login_page.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

List<String> allowBatches = ["19pwecse","20pwecse","21pwecse","22pwecse"];

class AuthController extends GetxController{

  var email = TextEditingController();
  var password = TextEditingController();
  var userName = TextEditingController();
  MUser? user;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<void> getUser() async {
    User? me = auth.currentUser;
    if(me != null){
     var data = await db.collection("users").where("id",isEqualTo: me.uid).limit(1).get();
     user = MUser.fromMap(data.docs.first.data());
     update();
    }
  }
  void init() async {
    await getUser();
    await Future.delayed(const Duration(seconds: 3),() async {
      if(auth.currentUser != null){
        Get.offAll(() => const MyHomePage());
      } else {
        //Get.offAll(() => const MyHomePage());
        Get.offAll(() => const LoginPage());
      }
    });
  }
  void handleLogin() async {
    loadingDialog();
    try{
      if(email.text.isNotEmpty && password.text.length>5){
        await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
        await getUser();
        Get.back();
        Get.offAll(() => const MyHomePage());
      }
    }catch(e){
      Get.back();
    }
  }
  void handleForgetPassword() async {
    try{
      await auth.sendPasswordResetEmail(email: email.text);
      Get.offAll(() => VerificationDonePage(
        message: "Reset Password send to your email \n ${email.text}",
        nextPage: const LoginPage(),
      ));
    }catch(_){
      toast("Some thing went wrong");
    }
  }
  void createAccount() async {
    var regNo = email.text.toLowerCase().split("@").first;
    if(regNo.contains("pwcse")){
      if(userName.text.length>5){
        loadingDialog();
        try{
          await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
          User? me = auth.currentUser;
          if(me != null){
            await auth.currentUser!.updateDisplayName(userName.text);
            Map<String, dynamic> userData = {
              "name": userName.text,
              "email": me.email,
              "id": me.uid,
              "regNo": regNo,
            };
            user = MUser(id: me.uid, email: me.email??"", name: me.displayName??"");
            update();
            await db.collection("users").add(userData);
            await auth.currentUser!.sendEmailVerification();
            Get.offAll(() => VerificationDonePage(
              message: "Verification is send to \n ${me.email}",
              nextPage: const LoginPage(),
            ));
          }
        }catch(e){
          Get.back();
          toast("Check Email or Week Password");
        }
      } else {
        toast("Check User Name");
      }
    } else {
      toast("Department Error");
    }
  }
  void logOut() async {
    await auth.signOut();
    Get.offAll(() => const LoginPage());
  }
  void loadingDialog(){
    Get.dialog(

      Dialog(
        child: Container(
          height: 160,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            strokeWidth: 2.0,
            color: activeColor,
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}