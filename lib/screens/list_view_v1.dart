import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';

class ListViewV1Screen extends StatelessWidget {
  final AlistV1 aList;

  ListViewV1Screen({Key key, @required this.aList}) : super(key: key);

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
