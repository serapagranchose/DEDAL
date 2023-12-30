import 'dart:async';
import 'package:dedal/components/button/filter_icon.dart';
import 'package:dedal/components/button/icon_button.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/tooltip.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/home/home_place_display.dart';
import 'package:dedal/core/pages/home/home_place_filter/home_place_filter_screen.dart';
import 'package:dedal/src/app.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    color: SharedColorPalette().secondary,
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
          if (selected.isNotNull)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: HomePlaceDisplay(place: selected!),
                ),
                const Gap(60),
              ],
            ),
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
                            Icons.my_location,
                            // color: Colors.black,
                          ),
                          action: () async {
                            if (widget.map.isNotNull) {
                              final lines = widget.map!['LongLat'] as List;
                              moveCamera(LatLng(lines[1]['latitude'],
                                  lines.first['longitude']));
                            }
                            if (widget.places.isNotNull &&
                                widget.places?.first?.coordinates != null) {
                              moveCamera(widget.places!.first!.coordinates!);
                            } else {
                              moveCamera(widget.userPosition);
                            }
                          }),
                      CustomIconButton(
                        icon: Icon(
                          mapType == MapType.normal
                              ? Icons.map_outlined
                              : Icons.map,
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
              if (widget.map == null)
                HomePlaceFilterScreen(
                        selected: widget.places?.first?.foundFilter?.first)
                    .allowShowTooltip(context,
                        index: 0,
                        title: 'bienvenue !',
                        display: true,
                        description: 'Bienvenue sur DEDAL les boys')
              else
                const SizedBox.shrink()
            ],
          ),
        ],
      );

  @override
  void didUpdateWidget(covariant HomeContent oldWidget) {
    markers.clear();
    if (widget.places.isNotNull && widget.places!.isNotEmpty) {
      print('here => ${widget.places}');
      for (var place in widget.places!) {
        markers.add(Marker(
            markerId: MarkerId(place!.id!),
            icon: MyApp.markerIcon,
            position: place.coordinates!,
            onTap: () {
              setState(() {
                selected = place;
              });
            }));
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    print('place => ${widget.places}');
    print('map => ${widget.map}');

    if (widget.map.isNotNull) {
      print('here');
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
    } else if (widget.places.isNotNull) {
      print('here => ${widget.places}');
      for (var place in widget.places!) {
        markers.add(Marker(
            markerId: MarkerId(place!.id!),
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
