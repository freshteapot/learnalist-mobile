import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/widgets/list_view_list_info.dart';
import 'package:learnalist/routes/edit_list.dart';
import 'package:learnalist/routes/find.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/models/lists_repository.dart';

class ListViewV3Screen extends StatelessWidget {
  final AlistV3 aList;

  ListViewV3Screen({Key key, @required this.aList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View Screen"),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popAndPushNamed(context, FindRoute.routePrefix);
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(EditListRoute.routePrefix,
                  arguments: EditListRouteArguments(aList.uuid, aList: aList));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          buildTitleSection(aList),
          Flexible(child: _buildList(aList))
        ]),
      ),
    );
  }

  Widget _buildList(AlistV3 aList) {
    return ScopedModelDescendant<ListsRepository>(
        builder: (context, child, storage) => ListView.builder(
              padding: const EdgeInsets.all(32),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: aList.getItems().length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${aList.getItems()[index].overall.distance} = ${aList.getItems()[index].overall.time}'),
                );
              },
            ));
  }
}
