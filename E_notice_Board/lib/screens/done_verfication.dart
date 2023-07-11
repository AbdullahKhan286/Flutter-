import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationDonePage extends StatefulWidget {
  final String message;
  final Widget nextPage;
  const VerificationDonePage({Key? key,required this.message,required this.nextPage}) : super(key: key);
  @override
  State<VerificationDonePage> createState() => _VerificationDonePageState();
}

class _VerificationDonePageState extends State<VerificationDonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(100),
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: activeColor,
              ),
              child: const Icon(BootstrapIcons.check2_all,size: 50,color: Colors.white,),
            ),
            const SizedBox(height: 20,),
            Text(widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30,),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: activeColor,
                    padding: const EdgeInsets.only(top: 16,bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                ),
                onPressed: () => Get.to(() => widget.nextPage),
                child: const Text("Let's Go",style: TextStyle(
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
