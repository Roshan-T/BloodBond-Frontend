import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  LatLng sourceLocation = LatLng(37.7749, -122.4194); // Source location
  LatLng destinationLocation = LatLng(37.7749, -122.4315); // Destination location

  Set<Marker> markers = {
    Marker(
      markerId: MarkerId('sourceMarker'),
      position: LatLng(37.7749, -122.4194),
      infoWindow: InfoWindow(title: 'Source'),
    ),
    Marker(
      markerId: MarkerId('destinationMarker'),
      position: LatLng(37.7749, -122.4315),
      infoWindow: InfoWindow(title: 'Destination'),
    ),
  };

  Set<Polyline> polylines = {
    Polyline(
      polylineId: PolylineId('route'),
      color: Colors.blue,
      width: 5,
      points: [
        LatLng(37.7749, -122.4194),
        LatLng(37.7749, -122.4315),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
      ),
      body: Column(
        children: [
          // Container taking up half of the screen for the map
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: sourceLocation,
                zoom: 12,
              ),
              markers: markers,
              polylines: polylines,
              onMapCreated: (GoogleMapController controller) {
                // You can use the controller to interact with the map, if needed
              },
            ),
          ),
          // Other widgets can be added below the map
          // ...
        ],
      ),
    );
  }
}
