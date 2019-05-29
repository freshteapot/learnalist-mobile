import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:learnalist/routes/find.dart';
import 'package:scoped_model/scoped_model.dart';

// Create a Form Widget
class ListDeleteScreen extends StatelessWidget {
  final Alist aList;

  ListDeleteScreen({Key key, @required this.aList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remove list"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          FlatButton(
            child: Text('I want to hide all evidence of this list.'),
            onPressed: () async {
              print('Back to the future.');
              await ScopedModel.of<ListsRepository>(context).removeAlist(aList);
              Navigator.pushNamedAndRemoveUntil(context, FindRoute.routePrefix,
                  ModalRoute.withName(FindRoute.routePrefix));
            },
          )
        ]),
      ),
    );
  }
}
