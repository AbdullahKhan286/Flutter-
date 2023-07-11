import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notic_board/models/complaint.model.dart';
import 'package:e_notic_board/utitls/constants.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({Key? key}) : super(key: key);
  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 1000,
        backgroundColor: Colors.white,
        title: const Text("Complaints",style: TextStyle(
          color: Colors.black,
        ),)),
      body: Container(
        margin: const EdgeInsets.only(left: 16,right: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection("conplaints").snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              List data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    return complaintBox(data[index]);
                  }
              );
            } else if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            } else{
              return const Center(child: Text("Some thing went wrong"));
            }
          },
        ),
      ),
    );
  }
  Widget complaintBox(QueryDocumentSnapshot data){
    Map<String, dynamic> content = data.data() as Map<String, dynamic>;
    MComplaint complaint = MComplaint.fromJson(data: content);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ReadMoreText(
        complaint.title,
        trimLines: 6,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
