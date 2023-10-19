import 'dart:async';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/home/home_place_display.dart';
import 'package:dedal/src/app.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
    Key? key,
    required this.userPosition,
    this.map,
    this.places,
  }) : super(key: key);

  final LatLng userPosition;
  final Map<String, Object>? map;
  final List<Place?>? places;

  @override
  HomeContentState createState() => HomeContentState();
}

class HomeContentState extends State<HomeContent> {
  Place? selected;

  final Completer<GoogleMapController> _controller = Completer();
  Polyline polyline = Polyline(
    points: const [],
    polylineId: const PolylineId('parcours'),
    width: 5,
    color: SharedColorPalette().mainDisable,
  );
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.userPosition,
              zoom: 14.4746,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: true,
            polylines: {polyline},
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          if (selected.isNotNull) HomePlaceDisplay(place: selected!),
        ],
      );

  @override
  void initState() {
    super.initState();
    if (widget.map.isNotNull) {
      final lines = widget.map!['LongLat'] as List;
      final building = widget.map!['Buildings'] as List;
      for (var element in lines) {
        final value = Map.from(element);
        polyline = polyline.copyWith(
          pointsParam: [
            ...polyline.points,
            LatLng(
              value['latitude'] != null
                  ? double.parse(value['latitude'].toString())
                  : 0,
              value['longitude'] != null
                  ? double.parse(value['longitude'].toString())
                  : 0,
            ),
          ],
        );
      }
      for (var element in building) {
        final place = Place.fromJson(element);
        if (place.coordinates != null) {
          markers.add(Marker(
              markerId: MarkerId(place.id!),
              icon: MyApp.markerIcon,
              position: place.coordinates!,
              onTap: () {
                setState(() {
                  selected = place;
                });
              }));
        }
      }
    }
  }
}
