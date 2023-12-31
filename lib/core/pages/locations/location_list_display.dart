import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/locations/location_place_container.dart';
import 'package:flutter/material.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocationListDisplay extends StatelessWidget {
  const LocationListDisplay({
    super.key,
    required this.list,
    required this.onTap,
    required this.action,
    this.supr = false,
  });

  final List<Place>? list;
  final bool supr;
  final bool action;
  final void Function(Place place) onTap;

  @override
  Widget build(BuildContext context) {
    return (list.isNull || list!.isEmpty)
        ? Text(context.l18n!.locationNoPlace.capitalize())
        : GridView.count(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 1,
            childAspectRatio: 2,
            mainAxisSpacing: 10,
            children: list!
                .map((e) => LocationPlaceContainer(
                      onTap: onTap,
                      place: e,
                      action: action,
                      supr: supr,
                    ))
                .toList(),
          );
  }
}
