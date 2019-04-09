import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/screens/list/play/list_play_v1_total_recall.dart';
import 'package:learnalist/widgets/list_view_list_info.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/routes/edit_list.dart';
import 'package:learnalist/routes/find.dart';

class ListViewV1Screen extends StatelessWidget {
  final AlistV1 aList;

  ListViewV1Screen({Key key, @required this.aList}) : super(key: key);

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
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              _showPlayMenu(context, aList);
            },
          ),
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

  Widget _buildList(AlistV1 aList) {
    return ScopedModelDescendant<ListsRepository>(
        builder: (context, child, storage) => ListView.builder(
              padding: const EdgeInsets.all(32),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: aList.getItems().length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${aList.getItems()[index]}'),
                );
              },
            ));
  }
}

void _showPlayMenu(BuildContext context, AlistV1 aList) {
  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.memory),
                title: new Text('Total recall'),
                onTap: () async {
                  _openDialog(
                      context, ListPlayV1TotalRecallScreen(aList: aList));
                }),
          ],
        );
      });
}

Future _openDialog(BuildContext context, Widget screen) async {
  await Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return screen;
      },
      fullscreenDialog: true));
  // Now we close the menu after as we dont want to see it.
  Navigator.pop(context);
}
