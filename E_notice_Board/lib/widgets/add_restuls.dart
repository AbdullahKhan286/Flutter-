import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notic_board/cors/auth.controller.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:short_uuids/short_uuids.dart';

class AddResults extends StatefulWidget {
  const AddResults({Key? key}) : super(key: key);

  @override
  State<AddResults> createState() => _AddResultsState();
}

class _AddResultsState extends State<AddResults> {
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  String select = "Select Batch";
  var text = TextEditingController();
  File? file;
  bool loading = false;
  void loadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
      setState(() {});
    } else {
    }
  }
  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return SizedBox(
        height: 490,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(16),
              child: Text("Add Time Table",style: style,),
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
                controller: text,
                minLines: 2,
                maxLines: 2,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Time Table ...",
                  hintStyle: style,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(16),
              child: Text("Select Batch",style: style,),
            ),
            DropdownButton(
                icon: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(select),
                      const SizedBox(width: 16),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                items: allowBatches.map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e))).toList(),
                onChanged: (value){
                  setState(() {
                    select = value!;
                  });
                }
            ),
            const SizedBox(height: 26,),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(16),
              child: Text("Add Pdf File",style: style,),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.only(left: 16,right: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: file != null? Chip(
                label: Text(file!.path.split("/").last),
                onDeleted: (){
                  file = null;
                  setState(() {});
                },
              ):TextButton(onPressed: loadFile, child: const Text("Attach")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
                const SizedBox(width: 16,),
                loading? const CircularProgressIndicator() :TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: activeColor,
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
                    ),
                    onPressed: ()async {
                      setState(() {
                        loading = true;
                      });
                      const short = ShortUuid();
                      String id =  short.generate();
                      if(file != null){
                        await storage.ref("results/$id").putFile(file!);
                        Map<String,dynamic> data = {
                          "path": "timetables/$id",
                          "createdAt": FieldValue.serverTimestamp(),
                          "text": text.text,
                          "batch": select,
                          "name": file!.path.split("/").last,
                        };
                        await db.collection("results").add(data);
                      }
                      setState(() {
                        loading = false;
                      });
                      text.clear();
                      file = null;
                      select = "Select Batch";
                      Get.back();
                    },
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
    );
  }
}
