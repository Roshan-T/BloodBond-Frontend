import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  LatLng currentloc = const LatLng(22.2096, 83.9856);
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("12345"),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: "Pokhara"),
    ),
  }; //set does not allow duplication, each element unique

  void _onmapCreated(GoogleMapController controller) {
    GoogleMapController mapcontroller = controller;
  }

  void _onMapTapped(LatLng tappedpoint) {
    setState(() {
      currentloc = tappedpoint;
      markers.clear();
      markers.add(Marker(
          markerId: MarkerId(currentloc.toString()),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: currentloc.toString(),
          )));
    });
    print(currentloc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapToolbarEnabled: true,
          onTap: _onMapTapped,
          markers: markers,
          initialCameraPosition: CameraPosition(target: currentloc, zoom: 5),
          onMapCreated: _onmapCreated),
    );
  }
}
