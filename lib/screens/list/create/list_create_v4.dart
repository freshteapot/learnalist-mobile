import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/widgets/list_edit_list_info.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/routes/view_list.dart';

class ListCreateV4Screen extends StatefulWidget {
  @override
  ListCreateV4ScreenState createState() {
    return ListCreateV4ScreenState();
  }
}

class ListCreateV4ScreenState extends State<ListCreateV4Screen> {
  AlistV4 aList;
  @override
  void initState() {
    super.initState();
    aList = newEmptyAlistV4();
  }

  void onSaveListInfo(String value) async {
    bool hasChanged = aList.info.title != value;
    if (hasChanged) {
      aList.info.title = value;
      var saved =
          await ScopedModel.of<ListsRepository>(context).addAlist(aList);
      // It makes the different because we get a new uuid from the server.
      aList = AlistV4(saved);
      Navigator.of(context).popAndPushNamed(ViewListRoute.routePrefix,
          arguments: ViewListRouteArguments(aList.uuid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Create Screen V4"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          EditListInfo(
            aList: aList,
            onSaved: onSaveListInfo,
          ),
        ]),
      ),
    );
  }
}
