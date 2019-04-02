import 'package:flutter/material.dart';
import 'package:learnalist/widgets/menu.dart';

class CreateListV2Route extends StatelessWidget {
  static String routePrefix = '/create/list/v2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create list v2"),
      ),
      drawer: Menu(),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/create/list');
          },
          child: Text('Abort'),
        ),
      ),
    );
  }
}
