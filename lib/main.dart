import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './limitedHomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // locate the user first
    return MaterialApp(
        title: 'ThinkLink',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LimitedHomepage());
  }
}
