import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';

// Create a Form Widget
class ListEditItemV1Screen extends StatelessWidget {
  final AlistV1 aList;

  ListEditItemV1Screen({Key key, @required this.aList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          ListItemV1Form(aList),
        ]),
      ),
    );
  }
}

// Create a Form Widget
class ListItemV1Form extends StatefulWidget {
  final Alist aList;

  ListItemV1Form(this.aList);

  @override
  ListItemV1FormState createState() {
    return ListItemV1FormState();
  }
}

class ListItemV1FormState extends State<ListItemV1Form> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _firstFocus;
  String _newItem;
  @override
  void initState() {
    super.initState();
    _newItem = '';
    _firstFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    _firstFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Column(
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
                        focusNode: _firstFocus,
                        autofocus: true,
                        autocorrect: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        onSaved: (String value) {
                          _newItem = value;
                        }),
                    ButtonBar(
                      children: [
                        FlatButton(
                          onPressed: () {
                            _formKey.currentState.reset();
                          },
                          child: Text('Reset'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              widget.aList.listData.add(_newItem);

                              _formKey.currentState.reset();
                              FocusScope.of(context).requestFocus(_firstFocus);

                              // If the form is valid, we want to show a Snackbar
                              ScopedModel.of<ListsRepository>(context)
                                  .updateAlist(widget.aList);
                            }
                          },
                          child: Text('Add'),
                        ),
                      ],
                    ),
                  ])),
        ]);
  }
}
