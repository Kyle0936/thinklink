import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './courselist.dart';

class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController mapController;

  static const LatLng _center = const LatLng(43.073051, -89.401230);
  int _selectedIndex = 1;

//  void _incrementTab(index) {
//    setState(() {
//      _cIndex = index;
//    });
//  }

  final _widgetOptions = [

    Text('Message'),
    Text('Profile'),
  ];

  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ThinkLink'),
          backgroundColor: Colors.blue[700],
        ),
        body: Stack(
          children:<Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 16.0,
              ),
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
          bottomNavigationBar:BottomNavigationBar(
            type: BottomNavigationBarType.shifting ,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,color: Color.fromARGB(255, 0, 0, 0)),
                  title: new Text('')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message,color: Color.fromARGB(255, 0, 0, 0)),
                  title: new Text('')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle,color: Color.fromARGB(255, 0, 0, 0)),
                  title: new Text('')
              )
            ],
            currentIndex: _selectedIndex,
            fixedColor: Colors.deepPurple,
            onTap: _onItemTapped,
          )
      ),
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
}