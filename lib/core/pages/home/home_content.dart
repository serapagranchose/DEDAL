import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({required this.initialPosition, Key? key})
      : super(key: key);

  final LatLng initialPosition;

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final Completer<GoogleMapController> _controller = Completer();
// on below line we have specified camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  late LatLng _userPos;
// on below line we have created the list of markers

// created method for getting user current location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F9D58),
        // on below line we have given title of app
        title: const Text("GFG"),
      ),
      body: SafeArea(
        // on below line creating google maps
        child: GoogleMap(
          // on below line setting camera position
          initialCameraPosition: CameraPosition(target: _userPos),
          // on below line we are setting markers on the map
          // on below line specifying map type.
          mapType: MapType.normal,
          // on below line setting user location enabled.
          myLocationEnabled: true,
          // on below line setting compass enabled.
          compassEnabled: true,
          // on below line specifying controller on map complete.
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
