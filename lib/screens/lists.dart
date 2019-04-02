import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/routes/view_list.dart';

// TODO move to be dynamic
final List<Alist> listOfLists = getLists();

class ListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: _buildList(listOfLists),
    );
  }
}

Widget _buildList(List<Alist> listOfLists) {
  return ListView.builder(
    itemCount: listOfLists.length,
    itemBuilder: (context, index) {
      return aListTile(context, listOfLists[index]);
    },
  );
}

// Parse in the list and have
ListTile aListTile(BuildContext context, Alist aList) {
  final IconData icon = Icons.toc;
  return ListTile(
    title: Text(aList.listInfo.title,
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
