import 'package:flutter/material.dart';


class FileOpen extends StatefulWidget {
  final String path;
  const FileOpen({Key? key,required this.path}) : super(key: key);
  @override
  State<FileOpen> createState() => _FileOpenState();
}

class _FileOpenState extends State<FileOpen> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
