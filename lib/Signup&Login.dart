import 'package:flutter/material.dart';
import './limitedHomepage.dart';
import './homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 50.0),
            Column(
              children: <Widget>[
                Image.asset('assets/login_icon.jpg'),
                SizedBox(height: 5.0),
                Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                filled: true,
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new LimitedHomepage()),// didn't log in
                    );
                  },
                ),
                RaisedButton(
                  child: Text('NEXT'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new HomePage()),// loged in!
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool validator = false;
  @override
  void dispose(){
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 50),
            Column(
              children: <Widget>[
                Image.asset('assets/login_icon.jpg'),
                SizedBox(height: 5),
                Text(
                  'SINGUP',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                filled: true,
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: confirmController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                filled: true,
                errorText: validator ? 'Password doesn\'t match' : null,
              ),
              obscureText: true,
              
            ),
            ButtonBar(children: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new LimitedHomepage()),
                  );
                },
              ),
              RaisedButton(child: Text('NEXT'), onPressed: () {
                setState(() {
                 if(passwordController.text != confirmController.text)  validator = true;
                 else validator = false;
                });
                if (!validator)
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: new Text('CONGRATULATION!'),
                          content: new Text('Sign Up Successfully!'),
                          actions:<Widget>[
                            new FlatButton(
                              child: new Text('CLOSE'),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => new HomePage()),
                                );
                              }
                            )
                          ]
                        );
                     }
                  );
              })
            ])
          ],
        ),
      ),
    );
  }
  
}