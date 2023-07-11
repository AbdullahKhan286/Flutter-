import 'package:e_notic_board/screens/results_page.dart';
import 'package:e_notic_board/screens/time_table_page.dart';
import 'package:flutter/material.dart';
import '../screens/attendance_page.dart';
import '../screens/complaints_page.dart';
import '../screens/notice_bord.dart';

class HomeModel{
  final String image;
  final String title;
  final Widget widget;
  int role;
  HomeModel(this.image, this.title, this.widget,{this.role = 0});
}

List<HomeModel> data = [
  HomeModel("assets/bell.png", "Notifications", const NoticeBoard()),
  HomeModel("assets/class.png", "Attendance", const AttendancePage()),
  HomeModel("assets/results.png", "Results", const ResultsPage()),
  HomeModel("assets/roll-call.png", "Time Table", const TimeTable()),
  HomeModel("assets/complaint.png", "Complaints", const ComplaintsPage(),role: 1),
];