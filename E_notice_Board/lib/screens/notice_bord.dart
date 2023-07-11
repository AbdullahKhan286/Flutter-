import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notic_board/cors/auth.controller.dart';
import 'package:e_notic_board/cors/human.functions.dart';
import 'package:e_notic_board/models/enums.dart';
import 'package:e_notic_board/models/notification.model.dart';
import 'package:e_notic_board/screens/detail_page.dart';
import 'package:e_notic_board/screens/write_on_notice_board.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:e_notic_board/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({Key? key}) : super(key: key);
  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const PreferredSize(preferredSize: Size.fromHeight(50),child: MyAppBar(title: ""),),
      body: Container(
        margin: const EdgeInsets.only(left: 10,right: 10),
        child: StreamBuilder<QuerySnapshot>(
            stream: db.collection("notification").orderBy("createdAt",descending: true).snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                List data = snapshot.data!.docs;
                return data.isNotEmpty? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context,index){
                      return notificationCard(data[index]);
                    }
                ):Container(
                  alignment: Alignment.center,
                  child: const Text("Empty"),
                );
              } else if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              } else{
                return const Center(child: Text("Some thing went wrong"));
              }
            },
        ),
      ),
      floatingActionButton: auth.user!.userRole == Role.teacher?  FloatingActionButton.extended(
          onPressed: () => Get.to(() =>const WriteNoticeBord()),
        backgroundColor: Colors.white,
        icon: const Icon(Icons.add,color: Colors.black,),
        label: const Text("Notification",style: TextStyle(color: Colors.black),),
      ):Container(),
    );
  }
  Widget notificationCard(QueryDocumentSnapshot data){
    Map<String, dynamic> content = data.data() as Map<String, dynamic>;
    MNotification notification = MNotification.fromJson(data: content);
    notification.nId = data.id;
    return GestureDetector(
      onTap: () => Get.to(() => DetailPage(notification: notification)),
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        child: Card(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              ListTile(
                leading: notification.authorPhoto!=null?Container():Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeColor,
                  ),
                  child: Text(nameCharacters(name: notification.authorName),style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                ),
                title: Text(notification.authorName),
                subtitle: Text(dataFromSeconds(seconds: notification.createdAt.seconds)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10,right: 10),
                width: Get.width,
                child: Text(notification.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              notification.body != null?Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: Get.width,
                child: Text(notification.body!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ):Container(),
              notification.totalAttachments != null?Chip(
                label: Text("${notification.totalAttachments} Attachments"),
              ):Container(),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
