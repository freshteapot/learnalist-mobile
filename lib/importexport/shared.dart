import 'package:flutter/material.dart';

class UriInput {
  String scheme;
  String userInfo;
  String host;
  int port;
  String path;
}

// Create a Form Widget
class ImportExportForm extends StatefulWidget {
  Function actionButtonPressed;
  String actionButtonText;
  ImportExportForm({this.actionButtonPressed, this.actionButtonText});

  @override
  ImportExportFormState createState() {
    return ImportExportFormState();
  }
}

class ImportExportFormState extends State<ImportExportForm> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _firstFocus;
  UriInput _uriInput;
  /*
            scheme: 'http',
            host: '192.168.1.135',
            port: 8080,
            path: '/export')
            */
  @override
  void initState() {
    super.initState();
    _uriInput = new UriInput();
    _firstFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    _firstFocus.dispose();

    super.dispose();
  }

  Widget _buildSchemeField() {
    return TextFormField(
        initialValue: 'http',
        decoration: InputDecoration(
          labelText: 'Scheme:',
        ),
        validator: (value) {
          if (value == 'http') {
            return null;
          }
          if (value == 'https') {
            return null;
          }
          return 'Please enter http or https';
        },
        onSaved: (String value) {
          _uriInput.scheme = value;
        });
  }

  Widget _buildHostField() {
    return TextFormField(
        initialValue: '192.168.1.1',
        decoration: InputDecoration(
          labelText: 'Host:',
        ),
        focusNode: _firstFocus,
        autofocus: true,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter an ip address or hostname.';
          }
        },
        onSaved: (String value) {
          _uriInput.host = value;
        });
  }

  Widget _buildPortField() {
    return TextFormField(
        initialValue: '8080',
        decoration: InputDecoration(
          labelText: 'Port:',
        ),
        validator: (value) {
          var isValidInt = int.tryParse(value);
          if (isValidInt == null) {
            return 'Enter a valid port';
          }
        },
        onSaved: (String value) {
          _uriInput.port = int.parse(value);
        });
  }

  Widget _buildPathField() {
    return TextFormField(
        initialValue: '/',
        decoration: InputDecoration(
          labelText: 'Path:',
        ),
        validator: (value) {
          if (value.startsWith('/')) {
            return null;
          }

          return 'Path needs to start with /.';
        },
        onSaved: (String value) {
          _uriInput.path = value;
        });
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
                    _buildSchemeField(),
                    _buildHostField(),
                    _buildPortField(),
                    _buildPathField(),
                    ButtonBar(
                      children: [
                        FlatButton(
                          onPressed: () {
                            _formKey.currentState.reset();
                          },
                          child: Text('Reset'),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            widget.actionButtonPressed(
                                context, _formKey, _uriInput);
                          },
                          child: Text(widget.actionButtonText),
                        ),
                      ],
                    ),
                  ])),
        ]);
  }
}
