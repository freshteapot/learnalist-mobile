import 'package:flutter/material.dart';
import 'package:learnalist/widgets/menu.dart';
import 'package:learnalist/screens/lists.dart';

class FindRoute extends StatelessWidget {
  static String routePrefix = '/find';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Lists'),
      ),
      drawer: Menu(),
      body: ListsScreen(),
    );
  }
}
