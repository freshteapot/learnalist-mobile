import 'package:flutter/material.dart';

// Create a Form Widget
class ListRecallV1 extends StatefulWidget {
  final Function actionButtonPressed;
  final List<String> validItems;
  ListRecallV1({this.validItems, this.actionButtonPressed});

  @override
  ListRecallV1State createState() {
    return ListRecallV1State();
  }
}

class ListRecallV1State extends State<ListRecallV1> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _firstFocus;

  @override
  void initState() {
    super.initState();
    _firstFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    _firstFocus.dispose();

    super.dispose();
  }

  Widget _buildField() {
    return TextFormField(
        initialValue: '',
        autocorrect: false,
        autofocus: false,
        validator: (value) {
          // Is it in the list of items
          if (!widget.validItems.contains(value)) {
            return 'Not in this list';
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    List<Widget> widgets = List<Widget>();

    for (var i = 0; i < widget.validItems.length; i++) {
      widgets.add(_buildField());
    }

    widgets.add(ButtonBar(
      children: [
        FlatButton(
          onPressed: () {
            _formKey.currentState.reset();
          },
          child: Text('Clear answers'),
        ),
        RaisedButton(
          onPressed: () {
            widget.actionButtonPressed(context, _formKey);
          },
          child: Text('Check'),
        ),
      ],
    ));
    // TODO Try this https://github.com/flutter/flutter/issues/13339
    // Currently setting all to false but maybe we just need to use
    // SingleChildScrollView.
    return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets)),
        ]);
  }
}
