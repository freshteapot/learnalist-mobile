import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/routes/view_list.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class ListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ListsRepository>(
      builder: (context, child, storage) => ListView(
            // Take the items in the current cart.
            children: storage.aLists
                // For each of them, create a Text widget.
                .map((item) => aListTile(context, item))
                // Then make a list of these widgets.
                .toList(),
          ),
    );
  }
}

// Parse in the list and have
ListTile aListTile(BuildContext context, Alist aList) {
  final IconData icon = Icons.toc;
  return ListTile(
    title: Text(aList.info.title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    // TODO Do I want to use subtile
    subtitle: Text('TODO'),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
    onTap: () {
      Navigator.of(context).pushNamed(ViewListRoute.routePrefix,
          arguments: ViewListRouteArguments(aList.uuid, aList: aList));
    },
  );
}
