import 'package:flutter/material.dart';
import 'package:learnalist/widgets/menu.dart';

class CreateListV1Route extends StatelessWidget {
  static String routePrefix = '/create/list/v1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create list v1"),
      ),
      drawer: Menu(),
    );
  }
}
