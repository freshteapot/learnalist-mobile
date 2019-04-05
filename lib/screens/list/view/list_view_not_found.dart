import 'package:flutter/material.dart';

class ListViewNotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View Route"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [Text('List type not supported.')]),
      ),
    );
  }
}
