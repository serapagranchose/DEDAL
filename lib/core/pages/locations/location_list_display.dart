import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/locations/location_place_container.dart';
import 'package:flutter/material.dart';

class LocationListDisplay extends StatelessWidget {
  const LocationListDisplay(
      {super.key,
      required this.list,
      required this.onTap,
      required this.action});

  final List<Place>? list;
  final bool action;
  final void Function(Place place) onTap;

  @override
  Widget build(BuildContext context) => GridView.count(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 1,
        childAspectRatio: 8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: list
                ?.map((e) => LocationPlaceContainer(
                      onTap: onTap,
                      place: e,
                      action: action,
                    ))
                .toList() ??
            [const Text('no list found')],
      );
}
