import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/locations/location_place_dialog.dart';
import 'package:flutter/material.dart';

class LocationPlaceContainer extends StatelessWidget {
  const LocationPlaceContainer({
    super.key,
    required this.place,
    required this.onTap,
    required this.action,
  });

  final Place place;
  final bool action;
  final void Function(Place place) onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: SharedColorPalette().main,
            ),
            height: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  (place.name ?? '').capitalize(),
                  style: const TextStyle(color: Colors.white),
                )),
              ],
            )),
        onTap: () => showDialog(
            context: context,
            builder: (context) => LocationPlaceDialog(
                  text: !action ? 'Ajouter' : 'Retirer',
                  action: onTap,
                  place: place,
                )),
      );
}
