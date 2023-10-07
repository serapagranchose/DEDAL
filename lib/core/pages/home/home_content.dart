import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
    Key? key,
    required this.userPosition,
  }) : super(key: key);

  final LatLng userPosition;

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) => GoogleMap(
        // on below line setting camera position
        initialCameraPosition: CameraPosition(
          target: widget.userPosition,
          zoom: 14.4746,
        ),
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
      );
}
