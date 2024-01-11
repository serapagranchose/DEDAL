import 'dart:async';
import 'package:dedal/components/button/icon_button.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
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
    required this.init,
    this.map,
    this.places,
  }) : super(key: key);

  final LatLng userPosition;
  final Map<String, Object>? map;
  final List<Place?>? places;
  final VoidCallback init;

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
                  child: HomePlaceDisplay(
                    place: selected!,
                    close: () => setState(() {
                      selected = null;
                    }),
                  ),
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
                              Icons.route,
                            ),
                            action: widget.init),
                      CustomIconButton(
                        icon: const Icon(
                          Icons.my_location,
                          // color: Colors.black,
                        ),
                        action: () => moveCamera(widget.userPosition),
                      ),
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
              HomePlaceFilterScreen(
                      selected: widget.map.isNull
                          ? widget.places?.first?.foundFilter?.first
                          : null)
                  .allowShowTooltip(context,
                      index: 0,
                      title: context.l18n!.firstTile.capitalize(),
                      display: true,
                      description: context.l18n!.firstDesc.capitalize())
            ],
          ),
        ],
      );

  void customInit() {
    markers.clear();
    polyline = polyline.copyWith(pointsParam: []);
    if (widget.map.isNotNull) {
      final lines = widget.map!['LongLat'] as List;
      final building = widget.map!['Buildings'] as List;
      for (var element in lines) {
        final value = Map.from(element);
        polyline = polyline.copyWith(
          visibleParam: true,
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

      moveCamera(LatLng(lines.last['latitude'], lines.last['longitude']));
    } else if (widget.places.isNotNull) {
      markers.clear();
      polyline = polyline.copyWith(visibleParam: false);
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
      moveCamera(widget.places?.last?.coordinates);
    }
  }

  @override
  void didUpdateWidget(covariant HomeContent oldWidget) {
    customInit();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    customInit();

    super.initState();
  }

  Future<void> moveCamera(LatLng? pos) async {
    if (pos.isNull) {
      return;
    }
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        // on below line we have given positions of Location 5
        CameraPosition(
      target: pos!,
      zoom: 14,
    )));
    setState(() {});
  }
}
