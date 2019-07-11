import 'package:flutter/material.dart';
import 'package:learnalist/routes/routes.dart';
import 'package:learnalist/screens/lists.dart';
import 'package:learnalist/routes/create.dart';

class FindRoute extends StatelessWidget {
  static String routePrefix = '/find';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Lists'),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popAndPushNamed(context, RootRoute.routePrefix);
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(CreateRoute.routePrefix);
            },
          )
        ],
      ),
      body: ListsScreen(),
    );
  }
}
