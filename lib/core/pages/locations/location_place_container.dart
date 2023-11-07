import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/locations/location_place_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                const Gap(5),
                Icon(
                  switch (place.type) {
                    'restaurant' => Icons.restaurant,
                    'jeu' => Icons.games_outlined,
                    'site historique' => Icons.museum,
                    'jardin historique' => Icons.grass,
                    'jardin artistique' => Icons.grass,
                    'rue commerçante' => Icons.euro,
                    'salon de beauté' => Icons.face_2_outlined,
                    "parc d'attractions" => Icons.euro,
                    'musée' => Icons.museum,
                    'zoo' => Icons.grass,
                    String()? => Icons.euro,
                    null => null,
                  },
                  color: SharedColorPalette().main,
                ),
                VerticalDivider(
                  thickness: 1,
                  color: Colors.black.withOpacity(0.12),
                  width: 33,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (place.name ?? '').capitalize(),
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () => showDialog(
              context: context,
              builder: (context) => LocationPlaceDialog(
                    text: !action
                        ? context.l18n!.globalAdd.capitalize()
                        : context.l18n!.globalRemove.capitalize(),
                    action: onTap,
                    place: place,
                  )),
        ),
      );
}
