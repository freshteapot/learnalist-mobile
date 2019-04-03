import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/widgets/list_view_list_info.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';

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
  bool _showingAddCard = false;

  void _toggleShowingAddForm() {
    setState(() {
      if (_showingAddCard) {
        _showingAddCard = false;
      } else {
        _showingAddCard = true;
      }
      // Causes the app to rebuild with the new _selectedChoice.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Edit Screen"),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              //ScopedModel.of<ListsRepository>(context, rebuildOnChange: true)
              //.updateAlist(widget.aList);
              print('Leaving the edit screen');
              Navigator.pop(context, true);
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _toggleShowingAddForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          buildTitleSection(widget.aList),
          _showingAddCard
              ? V1ListForm(
                  widget.aList,
                  _toggleShowingAddForm,
                )
              : new Container(),
          Flexible(child: _buildList(widget.aList))
        ]),
      ),
    );
  }

  Widget _buildList(AlistV1 aList) {
    return ScopedModelDescendant<ListsRepository>(
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
                      onTap: () {
                        print('edit');
                      },
                    ));
              },
            ));
  }
}

// Create a Form Widget
class V1ListForm extends StatefulWidget {
  final Alist aList;
  VoidCallback successCallback;
  V1ListForm(this.aList, this.successCallback);

  @override
  V1ListFormState createState() {
    return V1ListFormState();
  }
}

class V1ListFormState extends State<V1ListForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Card(
        color: Colors.white,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                              initialValue: '',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                              },
                              onSaved: (String value) {
                                widget.aList.listData.add(value);
                              }),
                          ButtonBar(
                            children: [
                              FlatButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  widget.successCallback();
                                },
                                child: Text('Hide / Cancel'),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.

                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    // If the form is valid, we want to show a Snackbar
                                    ScopedModel.of<ListsRepository>(context,
                                            rebuildOnChange: true)
                                        .updateAlist(widget.aList);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Processing Data')));
                                  }
                                },
                                child: Text('Add Item'),
                              ),
                            ],
                          ),
                        ])),
              ]),
        ));
  }
}
