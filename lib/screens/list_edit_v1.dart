import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/widgets/list_edit_list_info.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/screens/list_edit_v1_item.dart';
import 'package:learnalist/routes/view_list.dart';

// Create a Form Widget
class ListEditV1Screen extends StatefulWidget {
  final AlistV1 aList;

  ListEditV1Screen({Key key, @required this.aList}) : super(key: key);

  @override
  ListEditV1ScreenState createState() {
    return ListEditV1ScreenState();
  }
}

class ListEditV1ScreenState extends State<ListEditV1Screen> {
  void onSaveListInfo(String value) {
    bool hasChanged = widget.aList.listInfo.title != value;
    if (hasChanged) {
      widget.aList.listInfo.title = value;
      ScopedModel.of<ListsRepository>(context, rebuildOnChange: true)
          .updateAlist(widget.aList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Edit Screen"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ListEditItemV1Screen(aList: widget.aList)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          EditListInfo(
            aList: widget.aList,
            onSaved: onSaveListInfo,
          ),
          _buildListItems(widget.aList)
        ]),
      ),
    );
  }

  Widget _buildListItems(AlistV1 aList) {
    return Flexible(
        child: ScopedModelDescendant<ListsRepository>(
            builder: (context, child, storage) => ListView.builder(
                  padding: const EdgeInsets.all(32),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: aList.listData.length,
                  itemBuilder: (context, index) {
                    final item = aList.listData[index];
                    return Dismissible(
                        key: Key(item),
                        onDismissed: (direction) {
                          // Remove the item from our data source.
                          print(direction);

                          aList.listData.removeAt(index);
                          ScopedModel.of<ListsRepository>(context,
                                  rebuildOnChange: true)
                              .updateAlist(aList);
                          // Then show a snackbar!
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("$item dismissed")));
                        },
                        // Show a red background as the item is swiped away
                        background: Container(color: Colors.red),
                        child: ListTile(
                          title: Text('$item'),
                          /*
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            print('edit - create a pop up with the add.');
                          },
                          */
                        ));
                  },
                )));
  }
}
