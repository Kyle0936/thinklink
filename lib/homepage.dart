import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './courselist.dart';
import './userslist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController mapController;
  static const LatLng _center = const LatLng(43.073051, -89.401230);

  var currentClient;
  var currentBearing;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  void initState() {
    super.initState();
    _initCurrentLocation().then((curr) {
      _loopDatabase(curr);
    });
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
      infoWindow: InfoWindow(
          title: client['name'],
          snippet: 'There are currently ' +
              client['users there'].toString() +
              ' users here.'),
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

        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new UsersList()),
        );
      });
    }
  }

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                child: Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new CourseList()),
                      );
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.list, size: 36.0),
                  ),
                ),
              )
            ],
//          _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
                  title: new Text('')),
              BottomNavigationBarItem(
                  icon:
                      Icon(Icons.message, color: Color.fromARGB(255, 0, 0, 0)),
                  title: new Text('')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  title: new Text(''))
            ],
            currentIndex: _selectedIndex,
            fixedColor: Colors.deepPurple,
            onTap: _onItemTapped,
          )),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  _loopDatabase(curr) {
    const threshold = 150;
    Firestore.instance
        .collection('Markers')
        .document('UW-Madison')
        .collection('places')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; ++i) {
          // clients.add(docs.documents[i].data);
          // _initCurrentLocation().then((curr) {
          //   getDistance(curr, docs.documents[i].data['location'].latitude,
          //           docs.documents[i].data['location'].longitude)
          //       .then((dis) {
          //     if (dis > threshold) {
          //       _updateDatabase(docs.documents[i].documentID,
          //           docs.documents[i].data['users there']);
          //     }
          //   });
          // });
          getDistance(curr, docs.documents[i].data['location'].latitude,
                  docs.documents[i].data['location'].longitude)
              .then((dis) {
            print("Distance: " + dis.toString());
            if (dis < threshold) {
              _updateDatabase(docs.documents[i].documentID,
                  docs.documents[i].data['users there']);
            }
          });
        }
      }
    });
  }

  _updateDatabase(id, numOfUsers) {
    numOfUsers++;
    Firestore.instance
        .collection('Markers')
        .document('UW-Madison')
        .collection('places')
        .document(id)
        .updateData({
      'users there': numOfUsers,
    });
  }

  _initCurrentLocation() async {
    Position curr = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    print("la: " +
        curr.latitude.toString() +
        " long: " +
        curr.longitude.toString());
    return curr;
  }

  getDistance(curr, double latitude, double longitude) async {
    double dis = await Geolocator()
        .distanceBetween(curr.latitude, curr.longitude, latitude, longitude);
    return dis;
  }
}
