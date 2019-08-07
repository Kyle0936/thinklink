import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './Signup&Login.dart';

class LimitedHomepage extends StatefulWidget {
  LimitedHomepage({Key key}) : super(key: key);

  @override
  _LimitedHomepageState createState() => _LimitedHomepageState();
}

class _LimitedHomepageState extends State<LimitedHomepage> {
  GoogleMapController mapController;
  static const LatLng _center = const LatLng(43.073051, -89.401230);

  var currentClient;
  var currentBearing;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  void initState() {
    super.initState();
    setState(() {
      populateClients();
    });
  }

  populateClients() {
    // clients = [];
    Firestore.instance
        .collection('Markers')
        .document('UW-Madison')
        .collection('places')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          print("success");
        });
        for (int i = 0; i < docs.documents.length; ++i) {
          // clients.add(docs.documents[i].data);
          initMarker(docs.documents[i].data);
        }
      }
    });
  }

  initMarker(client) {
    // mapController.clearMarkers().then((val) {
    //   mapController.addMarker(MarkerOptions(
    //       position:
    //           LatLng(client['location'].latitude, client['location'].longitude),
    //       draggable: false,
    //       infoWindowText: InfoWindowText(client['clientName'], 'Nice')));
    // });
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    print("marker ID: " + _markerIdCounter.toString());
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(client['location'].latitude, client['location'].longitude),
      infoWindow: InfoWindow(title: client['name'], snippet: 'There are currently ' + client['users there'].toString() + ' users here.'),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThinkLink'),
        backgroundColor: Colors.blue[700],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 16.0,
            ),
            markers: Set<Marker>.of(markers.values),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: null,
          )
        ],
//          _widgetOptions.elementAt(_selectedIndex),
      ),
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
    );
  }

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
