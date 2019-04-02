import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                // TODO add image for learnalist
                // Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('Learnalist'),
              ],
            ),
            SizedBox(height: 120.0),
            // Username
            AccentColorOverride(
              color: Colors.black,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                autocorrect: true,
              ),
            ),

            // Spacer
            SizedBox(height: 12.0),
            // Password
            AccentColorOverride(
              color: Colors.black,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                autocorrect: false,
              ),
            ),

            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    debugPrint('Cancel');
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                RaisedButton(
                  child: Text('Next'),
                  elevation: 8.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}
