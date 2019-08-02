import 'package:cloud_firestore/cloud_firestore.dart';
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
  static const LatLng _center = const LatLng(43.073051, -89.401230);
  // Completer<GoogleMapController> _controller = Completer();

  var clients = [];

  var currentClient;
  var currentBearing;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  void initState(){
    super.initState();
    setState(() {
      populateClients();
    });
  }

  populateClients() {
    clients = [];
    Firestore.instance.collection('markers').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          // clientsToggle = true;
        });
        for (int i = 0; i < docs.documents.length; ++i) {
          clients.add(docs.documents[i].data);
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
  }

  @override
  void dispose() {
    super.dispose();
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
            child:null,
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
