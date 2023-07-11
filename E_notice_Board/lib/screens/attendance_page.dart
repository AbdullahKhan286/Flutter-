import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notic_board/models/enums.dart';
import 'package:e_notic_board/widgets/add_attendance_sheet.dart';
import 'package:e_notic_board/widgets/myappbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cors/auth.controller.dart';


class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final auth = Get.put(AuthController());
  void addData(){
    Get.dialog(const Dialog(
      child: AddAttendanceSheet(),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(50),child: MyAppBar(title: "Attendance"),),
      floatingActionButton: auth.user!.userRole == Role.teacher?  FloatingActionButton.extended(
        onPressed: addData,
        backgroundColor: Colors.white,
        icon: const Icon(Icons.add,color: Colors.black,),
        label: const Text("Attendance",style: TextStyle(color: Colors.black),),
      ):Container(),
      body: Container(
        margin: const EdgeInsets.only(left: 16,right: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection("attendance").orderBy("createdAt",descending: true).snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            } else if(snapshot.hasData){
              if(snapshot.data!.docs.isNotEmpty){
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                      Map<String,dynamic> data = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                      return Container(
                        height: 100,
                        margin: const EdgeInsets.only(top: 10),
                        width: Get.width,
                        child: Card(
                          child: Column(
                            children: [
                              Text(data["text"]??""),
                              TextButton(onPressed: () => handleView(data["path"]), child: const Text("View Time Table")),
                            ],
                          ),
                        ),
                      );
                    }
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
  void handleView(path) async {
    String url = await storage.ref(path).getDownloadURL();
    print(url);
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch');
    }
  }
}
