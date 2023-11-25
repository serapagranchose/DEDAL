import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/home/home_place_display.dart';
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
        childAspectRatio: 2,
        mainAxisSpacing: 10,
        children: list
                ?.map((e) => HomePlaceDisplay(
                      place: e,
                    ))

                // LocationPlaceContainer(
                //       onTap: onTap,
                //       place: e,
                //       action: action,
                //     ))
                .toList() ??
            [Text(context.l18n!.locationNoPlace.capitalize())],
      );
}
