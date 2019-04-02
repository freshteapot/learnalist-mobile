import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/widgets/list_view_list_info.dart';

class ListEditV2Screen extends StatelessWidget {
  final AlistV2 aList;

  ListEditV2Screen({Key key, @required this.aList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Edit Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [buildTitleSection(aList), _buildList(aList)]),
      ),
    );
  }
}

Widget _buildList(AlistV2 aList) {
  return ListView.builder(
    padding: const EdgeInsets.all(32),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: aList.listData.length,
    itemBuilder: (context, index) {
      return ListTile(
        title:
            Text('${aList.listData[index].from} = ${aList.listData[index].to}'),
      );
    },
  );
}
