import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notic_board/cors/auth.controller.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shortid/shortid.dart';
import 'package:path/path.dart' as path;

class BoardController extends GetxController{
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  String selectBatchText = "All Batches";
  List<String> attachments = [];
  var title = TextEditingController();
  var messageBody = TextEditingController();

  void selectValue(value){
    selectBatchText = value;
    update();
  }

  void selectFiles() async {
    var paths = await FilePicker.platform.pickFiles();
    if(paths !=null){
     for(var path in paths.paths){
       if(path != null){
         attachments.add(path);
         update();
       }
     }
    }
  }
  void deleteSelectedFile(String path){
    attachments.remove(path);
    update();
  }
  void sendData() async {
    try{
      loadingDialog();
      shortid.characters('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
      final notification = db.collection("notification");
      if(title.text.trim().isNotEmpty){
        Map<String, dynamic> data = {
          "title": title.text,
          "authorId": auth.currentUser!.uid,
          "authorName": auth.currentUser!.displayName,
          "createdAt": FieldValue.serverTimestamp(),
        };
        if(selectBatchText == "All Batches"){
          data["batches"] = allowBatches;
        }
        if(auth.currentUser!.photoURL != null){
          data["authorPhoto"] = auth.currentUser!.photoURL;
        }
        if(messageBody.text.isNotEmpty){
          data["content"] = messageBody.text;
        }
        String attachmentsPath = "attachments/${shortid.generate()}";
        if(attachments.isNotEmpty){
          for(var att in attachments){
            await storage.ref().child("$attachmentsPath/${path.basename(att)}").putFile(File(att));
          }
          data["totalAttachments"] = attachments.length;
          data["attachmentsPath"] = attachmentsPath;
          await notification.add(data);
        } else {
          await notification.add(data);
        }
      } else {
        toast("Title is Required",gravity: ToastGravity.TOP,bgColor: Colors.red,textColor: Colors.white);
      }
      Get.back();
      title.clear();
      attachments.clear();
      update();
    }catch(_){
      toast("Something went wrong",gravity: ToastGravity.TOP,bgColor: Colors.red,textColor: Colors.white);
    }
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
