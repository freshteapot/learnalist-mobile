import 'package:flutter/material.dart';

class ListEditNotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Edit Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [Text('List type not supported.')]),
      ),
    );
  }
}
