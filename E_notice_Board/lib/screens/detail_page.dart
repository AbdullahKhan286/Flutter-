import 'package:e_notic_board/models/notification.model.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final MNotification notification;
  const DetailPage({Key? key,required this.notification}) : super(key: key);
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  Map<String, bool> files = {};
  void downloadFile(Reference reference) async {
    String url = await reference.getDownloadURL();
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch');
    }
  }
  void initPath() async {
  }

  @override
  void initState() {
    initPath();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget hintBox(text){
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text(text,style: const TextStyle(
          fontWeight: FontWeight.w700,
          wordSpacing: -1.2,
          fontSize: 18,
        ),),
      );
    }
    Widget bodyBox(){
      return widget.notification.body!=null? Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(widget.notification.body!),
      ):Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(child: Text("Nothing"),),
      );
    }
    Widget titleBox(){
      return  Card(
        margin: const EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Text(widget.notification.title,style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),),
        ),
      );
    }
    Widget attachmentBuilder(){
      return widget.notification.totalAttachments != null?FutureBuilder<ListResult>(
        future: storage.ref(widget.notification.attachmentsPath!).listAll(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<Reference> data = snapshot.data!.items;
            return data.isNotEmpty? Wrap(
              children: data.map((Reference reference){
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(reference.name),
                      TextButton(
                          onPressed: () => downloadFile(reference),
                          child: const Text("Open")
                      ),
                    ],
                  ),
                );
              }).toList(),
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
      ):const Center(child: Text("No Attachment"),);
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(widget.notification.title,
        style: const TextStyle(color: Colors.black),),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 16,right: 16),
        child: ListView(
          shrinkWrap: true,
          children: [
            hintBox("Title"),
            titleBox(),
            hintBox("Description"),
            bodyBox(),
            hintBox("Attachments"),
            attachmentBuilder(),
          ],
        ),
      ),
    );
  }
}
