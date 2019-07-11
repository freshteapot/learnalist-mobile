import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/play/v2/total_recall/total_recall_v2.dart';

class ListPlayV2TotalRecallScreen extends StatelessWidget {
  final AlistV2 aList;

  ListPlayV2TotalRecallScreen({Key key, @required this.aList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TotalRecallV2 totalRecall = TotalRecallV2(aList: aList);
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
