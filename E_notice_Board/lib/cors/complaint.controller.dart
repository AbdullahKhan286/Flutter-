import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ComplaintController extends GetxController{

  var com = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendComplaint() async {
    if(!(com.text.length<20)){
      Map<String, dynamic> data = {
        "title": com.text,
        "authorId": auth.currentUser!.uid,
        "authorName": auth.currentUser!.displayName,
        "createdAt": FieldValue.serverTimestamp(),
        "read": false,
      };
      if(auth.currentUser!.photoURL != null){
        data["authorPhoto"] = auth.currentUser!.photoURL;
      }
      await db.collection("conplaints").add(data);
      Get.back();
      toast("Complaint Submitted",
        bgColor: activeColor,
      );
      com.clear();
    } else {
      toast("Complaint must Greater than 20 Charactors",
        textColor: Colors.white,
        bgColor: Colors.red,
        gravity: ToastGravity.TOP,
      );
    }
  }
}
