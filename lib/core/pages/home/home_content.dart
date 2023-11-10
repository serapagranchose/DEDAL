import 'dart:async';
import 'package:dedal/components/button/filter_icon.dart';
import 'package:dedal/components/button/icon_button.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      CustomIconButton(
                          icon: const Icon(
                            Icons.pin_drop,
                            color: Colors.black,
                          ),
                          action: () async {
                            if (widget.map.isNotNull) {
                              final lines = widget.map!['LongLat'] as List;
                              moveCamera(LatLng(lines[1]['latitude'],
                                  lines.first['longitude']));
                            }
                          }),
                      CustomIconButton(
                        icon: const Icon(
                          Icons.location_off_outlined,
                          color: Colors.black,
                        ),
                        action: () {
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
                      ),
                      CustomIconButton(
                        icon: Icon(
                          mapType == MapType.normal
                              ? Icons.map_outlined
                              : Icons.map,
                          color: Colors.black,
                        ),
                        action: () {
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
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  height: 57,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FilterIcon(
                        icon: Icon(Icons.museum),
                        title: 'Art',
                        action: () => print('Art'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.museum),
                        title: 'Divertissement',
                        action: () => print('Divertissement'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.add_to_home_screen),
                        title: 'Nature',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.air),
                        title: 'Shopping',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.add_ic_call),
                        title: 'Enfant',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.badge),
                        title: 'Bar',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.filter),
                        title: 'title',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.filter),
                        title: 'title',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.filter),
                        title: 'title',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.filter),
                        title: 'title',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.filter),
                        title: 'title',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.filter),
                        title: 'title',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.filter),
                        title: 'title',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.filter),
                        title: 'title',
                        action: () => print('ui'),
                      ),
                      FilterIcon(
                        icon: Icon(Icons.filter),
                        title: 'title',
                        action: () => print('ui'),
                      ),
                    ],
                  ),
                ),
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

  Future<void> moveCamera(LatLng pos) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        // on below line we have given positions of Location 5
        CameraPosition(
      target: pos,
      zoom: 14,
    )));
    setState(() {});
  }
}
