import 'dart:async';

import 'package:flutter/material.dart';
import './limitedHomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThinkLink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainWidget()
    );
  }
}



/* Danny
class LogIn extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final userName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 80.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
              ),
              // spacer
              SizedBox(height: 12.0),
              // [Password]
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      _usernameController.clear();
                      _passwordController.clear();
                    },
                  ),
                  RaisedButton(
                    child: Text('NEXT'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(_usernameController.text)));
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text the user has typed in using our
                            // TextEditingController
                            content: Text(_usernameController.text),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
*/




/* Danny
class SignUp extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordconfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 80.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
              ),
              // spacer
              SizedBox(height: 12.0),
              // [Password]
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 12.0),
              // [Password]
              TextFormField(
                controller: _passwordconfirmController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwrod is not matching';
                  }     
                },
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      _usernameController.clear();
                      _passwordController.clear();
                    },
                  ),
                  RaisedButton(
                    child: Text('VERIFY'),
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text the user has typed in using our
                            // TextEditingController
                            content: Text(_usernameController.text),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}*/

// class HomeScreen extends StatelessWidget {
//   final String usernameController; //if you have multiple values add here
//   HomeScreen(this.usernameController, {Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(centerTitle: true, title: Text("ThinkLink")),
//       body: ListView(
//         children: <Widget>[
//           Text(usernameController),
//         ],
//       ),
//     );
//   }
// }
