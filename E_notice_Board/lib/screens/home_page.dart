import 'package:e_notic_board/cors/auth.controller.dart';
import 'package:e_notic_board/cors/human.functions.dart';
import 'package:e_notic_board/models/ui.models.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../cors/complaint.controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final auth = Get.put(AuthController());
  final conplaint = Get.put(ComplaintController());
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    int role = auth.user!.userRole.index;
    final info05 = InfoProperties(
        topLabelStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        topLabelText: '', bottomLabelStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        bottomLabelText: '', mainLabelStyle: const TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.w600),
        modifier: (double value) {return '';});
    final customColors05 = CustomSliderColors(
        dotColor: HexColor('#FFB1B2'),
        trackColor: HexColor('#E9585A'),
        progressBarColors: [HexColor('#FB9967'), HexColor('#E9585A')],
        shadowColor: HexColor('#FFB1B2'),
        shadowMaxOpacity: 0.05);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1000,
        title: const Text("DCSE Notice Board",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),),
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
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 8,right: 8),
        child: ListView(
          physics:const BouncingScrollPhysics(),
          children: [
           for(var d in data)
             Visibility(
               visible: d.role <= role,
               child: SizedBox(
                 height: 120,
                 width: Get.width,
                 child: GestureDetector(
                   onTap: () => Get.to(() => d.widget),
                   child: Card(
                     child: Stack(
                       children: [
                         SizedBox(
                           height: 120,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               SizedBox(
                                 height: 80,
                                 child: SleekCircularSlider(
                                     appearance: CircularSliderAppearance(
                                         customWidths: CustomSliderWidths(trackWidth: 2, progressBarWidth: 15, shadowWidth: 70),
                                         customColors: customColors05,
                                         infoProperties: info05,
                                         startAngle: 20,
                                         angleRange: 360,
                                         size: 150.0,
                                         animationEnabled: true
                                     ),
                                   innerWidget: (value) => Container(
                                     alignment: Alignment.center,
                                     child: Image.asset(d.image,height: 36,),),
                                 ),
                               ),
                               Text(d.title,style: TextStyle(
                                 fontSize: 22,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.grey.shade600,
                                 fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                               ),)
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
          ],
        ),
      ),
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
                const SizedBox(height: 12,),
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


