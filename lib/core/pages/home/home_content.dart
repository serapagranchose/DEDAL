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
  MapType mapType = MapType.normal;

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
            mapType: mapType,
            myLocationButtonEnabled: false,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => print('ui'),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (mapType == MapType.normal) {
                        setState(() {
                          mapType = MapType.satellite;
                        });
                      } else {
                        setState(() {
                          mapType = MapType.normal;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            mapType == MapType.normal
                                ? Icons.map_outlined
                                : Icons.map,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
