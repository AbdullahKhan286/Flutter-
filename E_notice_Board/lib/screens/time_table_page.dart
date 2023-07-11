import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notic_board/cors/auth.controller.dart';
import 'package:e_notic_board/models/enums.dart';
import 'package:e_notic_board/widgets/myappbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/add_time_table.dart';
class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final auth = Get.put(AuthController());
  void addData(){
    Get.dialog(const Dialog(
      child: AddTimeTable(),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(50),child: MyAppBar(title: "Time Table"),),
      floatingActionButton: auth.user!.userRole == Role.teacher?  FloatingActionButton.extended(
        onPressed: addData,
        backgroundColor: Colors.white,
        icon: const Icon(Icons.add,color: Colors.black,),
        label: const Text("Time Table",style: TextStyle(color: Colors.black),),
      ):Container(),
      body: Container(
        margin: const EdgeInsets.only(left: 16,right: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection("tables").orderBy("createdAt",descending: true).limit(1).snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            } else if(snapshot.hasData){
              if(snapshot.data!.docs.isNotEmpty){
                Map<String,dynamic> data = snapshot.data!.docs.first.data() as Map<String,dynamic>;
                return Container(
                  height: 100,
                  width: Get.width,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(data["text"]??""),
                        TextButton(onPressed: () => handleView(data["path"]), child: const Text("View Time Table")),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: Text("No Time Table"));
              }
            } else {
              return const Center(child: Text("Some went Wrong"));
            }
          },
        ),
      ),
    );
  }
  Widget timeTable(path){
    return Container();
  }
  void handleView(path) async {
    String url = await storage.ref(path).getDownloadURL();
    print(url);
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch');
    }
  }
}
