import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/play/v1/total_recall/total_recall_v1.dart';

class ListPlayV1TotalRecallScreen extends StatelessWidget {
  final AlistV1 aList;

  ListPlayV1TotalRecallScreen({Key key, @required this.aList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TotalRecallV1 totalRecall = TotalRecallV1(aList: aList);
    return Scaffold(
      // This is set, to avoid overflow when the keyboard is open  and the user is
      // writing text. There might be a better way.
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Play Total Recall"),
      ),
      body: Padding(padding: EdgeInsets.all(16.0), child: totalRecall),
    );
  }
}
