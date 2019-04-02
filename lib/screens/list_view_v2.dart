import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';

class ListViewV2Screen extends StatelessWidget {
  final AlistV2 aList;

  ListViewV2Screen({Key key, @required this.aList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View Route"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(aList.listInfo.listType.toString()),
      ),
    );
  }
}
