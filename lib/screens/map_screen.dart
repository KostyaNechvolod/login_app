import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(50.005758, 36.229163);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(50.005758, 36.229163),
        infoWindowText: InfoWindowText('Random Place', '5 Star Rating'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(
            myLocationEnabled: true,
            compassEnabled: true,
            cameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ),
      ),
    );
  }
}