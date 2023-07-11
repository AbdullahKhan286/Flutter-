import 'package:e_notic_board/cors/board.controller.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class WriteNoticeBord extends StatefulWidget {
  const WriteNoticeBord({Key? key}) : super(key: key);
  @override
  State<WriteNoticeBord> createState() => _WriteNoticeBordState();
}

class _WriteNoticeBordState extends State<WriteNoticeBord> {
 final board = Get.put(BoardController());
  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    Widget selectBatch(){
      return GetBuilder(
        init: board,
        builder: (context) {
          return Container(
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
            ),
            child: PopupMenuButton(
              onSelected: board.selectValue,
              itemBuilder: (context){
                return [
                  PopupMenuItem(
                      onTap: (){

                      },
                      value: "All Batches",
                      child: Text("All Batches",style: style,)
                  ),
                  PopupMenuItem(
                      onTap: (){},
                      value: "19 Batch",
                      child:  Text("19 Batch",style: style,)
                  ),
                  PopupMenuItem(
                      onTap: (){},
                      value: "20 Batch",
                      child: Text("20 Batch",style: style,)
                  ),
                  PopupMenuItem(
                      onTap: (){},
                      value: "21 Batch",
                      child:  Text("21 Batch",style: style,)
                  ),
                  PopupMenuItem(
                      onTap: (){},
                      value: "22 Batch",
                      child:  Text("22 Batch",style: style,)
                  ),
                ];
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(board.selectBatchText,style: style,),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.arrow_drop_down),)
                ],
              ),
            ),
          );
        }
      );
    }
    Widget title(){
      return Container(
        height: 60,
        padding: const EdgeInsets.only(left: 16,right: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        child: TextField(
          cursorColor: Colors.black,
          controller: board.title,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Title",
            hintStyle: style,
          ),
        ),
      );
    }
    Widget messageBody(){
      return Container(
        padding: const EdgeInsets.only(left: 16,right: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        child: TextField(
          cursorColor: Colors.black,
          controller: board.messageBody,
          minLines: 6,
          maxLines: 12,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "description",
              hintStyle: style,
          ),
        ),
      );
    }
    Widget attachment(){
      return GestureDetector(
        onTap: board.selectFiles,
        child: GetBuilder(
          init: board,
          builder: (context) {
            return Container(
              height: 60,
              padding: const EdgeInsets.only(left: 16,right: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: board.attachments.isEmpty?Text("Not Attachment",style: style)
              : Text("${board.attachments.length} Attachment",style: style),
            );
          }
        ),
      );
    }
    Widget attachmentsNames(){
      return GetBuilder(
        init: board,
        builder: (context) {
          return board.attachments.isNotEmpty? Container(
            height: 60,
            padding: const EdgeInsets.only(left: 16,right: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: board.attachments.map((e) => Chip(
                label: Text(path.basename(e),style: style),
                onDeleted: () => board.deleteSelectedFile(e),
              )).toList(),
            ),
          ):Container();
        }
      );
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          children: [
            selectBatch(),
            const SizedBox(height: 20),
            title(),
            const SizedBox(height: 20),
            messageBody(),
            const SizedBox(height: 20),
            Text("Select Attachment(Optional)",style: style),
            const SizedBox(height: 10),
            attachment(),
            const SizedBox(height: 10),
            attachmentsNames(),
            const SizedBox(height: 20),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: activeColor,
                    padding: const EdgeInsets.only(top: 16,bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
                ),
                onPressed: board.sendData,
                child: const Text("Send",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),)),
          ],
        ),
      ),
    );
  }
}
