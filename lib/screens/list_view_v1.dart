import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/widgets/list_view_list_info.dart';

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
        child: Column(children: [buildTitleSection(aList), _buildList(aList)]),
      ),
    );
  }
}

Widget _buildList(AlistV1 aList) {
  return ListView.builder(
    padding: const EdgeInsets.all(32),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: aList.listData.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text('${aList.listData[index]}'),
      );
    },
  );
}
