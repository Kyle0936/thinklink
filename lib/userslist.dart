import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersList extends StatefulWidget{
  @override
  _UsersListState createState() => _UsersListState(); 
}

class _UsersListState extends State<UsersList> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  void onChange1(bool value){
    setState(() {
     _isChecked1 = value;
    });
  }
  void onChange2(bool value){
    setState(() {
      _isChecked2 = value;
    });
  }
  void onChange3(bool value){
    setState(() {
      _isChecked3 = value;
    });
  }
  void onChange4(bool value){
    setState(() {
      _isChecked4 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Classmates List';

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Container(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new CheckboxListTile(
                title: Text("CS 354"),
                value: _isChecked1,
                activeColor: Colors.blue,
                secondary: const Icon(Icons.book),
                onChanged: (bool value){onChange1(value);},
              ),
              new CheckboxListTile(
                title: Text("CS 564"),
                value: _isChecked2,
                activeColor: Colors.blue,
                secondary: const Icon(Icons.book),
                onChanged: (bool value){onChange2(value);},
              ),
              new CheckboxListTile(
                title: Text("CS 577"),
                value: _isChecked3,
                activeColor: Colors.blue,
                secondary: const Icon(Icons.book),
                onChanged: (bool value){onChange3(value);},
              ),
              new CheckboxListTile(
                title: Text("Zoo 101"),
                value: _isChecked4,
                activeColor: Colors.blue,
                secondary: const Icon(Icons.book),
                onChanged: (bool value){onChange4(value);},
              )
            ],
          )
        )
      );
  }
}
