import 'package:flutter/material.dart';
import 'package:learnalist/widgets/menu.dart';

class CreateRoute extends StatelessWidget {
  static String routePrefix = '/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      drawer: Menu(),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Create a simple list of items (v1).'),
            onTap: () {
              Navigator.of(context).pushNamed('/create/list',
                  arguments: CreateListRouteArguments('v1'));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Create a list of  from -> to (v2).'),
            onTap: () {
              Navigator.of(context).pushNamed('/create/list',
                  arguments: CreateListRouteArguments('v2'));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Create a list of based on the concept2 (v3).'),
            onTap: () {
              Navigator.of(context).pushNamed('/create/list',
                  arguments: CreateListRouteArguments('v3'));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Create a list of content and urls (v4).'),
            onTap: () {
              Navigator.of(context).pushNamed('/create/list',
                  arguments: CreateListRouteArguments('v4'));
            },
          ),
          ListTile(
            title: Text('Return to top level'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}

class CreateListRouteArguments {
  final String listType;

  CreateListRouteArguments(this.listType);
}
