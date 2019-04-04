import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/widgets/list_edit_list_info.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/routes/view_list.dart';

class ListCreateV1Screen extends StatefulWidget {
  @override
  ListCreateV1ScreenState createState() {
    return ListCreateV1ScreenState();
  }
}

class ListCreateV1ScreenState extends State<ListCreateV1Screen> {
  AlistV1 aList;
  @override
  void initState() {
    super.initState();
    aList = newEmptyAlistV1();
  }

  void onSaveListInfo(String value) {
    bool hasChanged = aList.listInfo.title != value;
    if (hasChanged) {
      aList.listInfo.title = value;
      ScopedModel.of<ListsRepository>(context).updateAlist(aList);
      Navigator.of(context).popAndPushNamed(ViewListRoute.routePrefix,
          arguments: ViewListRouteArguments(aList.uuid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Create Screen V1"),
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
