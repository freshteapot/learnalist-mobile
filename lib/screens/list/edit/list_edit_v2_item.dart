import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';

// Create a Form Widget
class ListEditItemV2Screen extends StatelessWidget {
  final AlistV2 aList;

  ListEditItemV2Screen({Key key, @required this.aList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          ListItemV2Form(aList),
        ]),
      ),
    );
  }
}

// Create a Form Widget
class ListItemV2Form extends StatefulWidget {
  final AlistV2 aList;

  ListItemV2Form(this.aList);

  @override
  ListItemV2FormState createState() {
    return ListItemV2FormState();
  }
}

class ListItemV2FormState extends State<ListItemV2Form> {
  final _formKey = GlobalKey<FormState>();
  TypeV2Item _newItem;
  FocusNode _firstFocus;

  @override
  void initState() {
    super.initState();

    _firstFocus = FocusNode();
    _newItem = new TypeV2Item('', '');
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
                        focusNode: _firstFocus,
                        autofocus: true,
                        autocorrect: false,
                        initialValue: '',
                        decoration: InputDecoration(
                          labelText: 'From:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        onSaved: (String value) {
                          _newItem.from = value;
                        }),
                    TextFormField(
                        initialValue: '',
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'To:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        onSaved: (String value) {
                          _newItem.to = value;
                        }),
                    ButtonBar(
                      children: [
                        FlatButton(
                          onPressed: () {
                            _formKey.currentState.reset();
                            _newItem = new TypeV2Item('', '');
                            FocusScope.of(context).requestFocus(_firstFocus);
                          },
                          child: Text('Reset'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              widget.aList.addItem(_newItem);

                              _formKey.currentState.reset();
                              _newItem = new TypeV2Item('', '');
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
