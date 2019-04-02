import 'package:flutter/material.dart';
import 'package:learnalist/widgets/menu.dart';

class PlayRoute extends StatelessWidget {
  static String routePrefix = '/play';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Play Route"),
      ),
      drawer: Menu(),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
