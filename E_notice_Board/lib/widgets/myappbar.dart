import 'package:e_notic_board/cors/auth.controller.dart';
import 'package:e_notic_board/cors/complaint.controller.dart';
import 'package:e_notic_board/cors/human.functions.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatefulWidget {
  final String title;
  const MyAppBar({Key? key,required this.title}) : super(key: key);
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  final auth = Get.put(AuthController());
  final conplaint = Get.put(ComplaintController());
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1000,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Container(
        /*margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),*/
        child: Text(widget.title.isNotEmpty?widget.title:"Notifications",style: TextStyle(color: Colors.black),) /*TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            suffixIcon: GestureDetector(
              onTap: (){},
              child: const Icon(Icons.search),
            )
          ),
        )*/,
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(40,30),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: activeColor,
            ),
            child: Text(nameCharacters(name: auth.user!.name),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),),
            onSelected: (value){
              if(value == "complaint"){
                complaint();
              }
            },
            itemBuilder: (context){
              return [
                /*PopupMenuItem(
                    onTap: (){},
                    value: "profile",
                    child: const Text("Profile")
                ),*/
                const PopupMenuItem(
                    value: "complaint",
                    child: Text("Create Complaint")
                ),
                PopupMenuItem(
                    onTap: auth.logOut,
                    value: "logout",
                    child: const Text("Log Out")
                ),
              ];
            }
        ),
        const SizedBox(width: 15,),
      ],
    );
  }
  void complaint(){
    var style = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    Get.dialog(

      Dialog(
        child: SizedBox(
          height: 290,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(16),
                child: Text("Write Your Complaint",style: style,),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16,right: 16),
                padding: const EdgeInsets.only(left: 16,right: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey,width: 1.5)
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: conplaint.com,
                  minLines: 6,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Complaint",
                    hintStyle: style,
                  ),
                ),
              ),
              const SizedBox(height: 26,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
                  const SizedBox(width: 16,),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: activeColor,
                          padding: const EdgeInsets.only(left: 16,right: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
                      ),
                      onPressed: conplaint.sendComplaint,
                      child: const Text("Submit",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      )
                  ),
                  const SizedBox(width: 16,),
                ],
              ),
            ],
          )
        ),
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
    );
  }
}
