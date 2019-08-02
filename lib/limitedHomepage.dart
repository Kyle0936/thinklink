import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './Signup&Login.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _count = 0;
  GoogleMapController mapController;
  // Completer<GoogleMapController> _controller = Completer();

  var clients = [];

  var currentClient;
  var currentBearing;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.073051, -89.401230),
    zoom: 14.4746,
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThinkLink'),
      ),
      body: new Expanded(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: <Widget>[
            // Center(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  // _controller.complete(controller);
                },
              ),
          //   ),
          // ],
        ),
      // ),
      bottomNavigationBar: BottomAppBar(
        child: ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            RaisedButton(
              child: Text('Sign up'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //         _count++;
      //       }),
      //   tooltip: 'Increment Counter',
      //   child: Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
