import 'package:cached_network_image/cached_network_image.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/location_detail/location_place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocationPlaceContainer extends StatelessWidget {
  const LocationPlaceContainer({
    super.key,
    required this.place,
    required this.onTap,
    required this.action,
    this.supr = false,
  });

  final Place place;
  final bool supr;
  final bool action;
  final void Function(Place place) onTap;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: place.pict != null
                  ? DecorationImage(
                      image: CachedNetworkImageProvider(
                        place.pict!,
                      ),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage(
                          'assets/images/filters/divertissement.jpg'),
                      fit: BoxFit.cover,
                    ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(26),
            child: Text(
              place.name ?? '',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      place.accessible ?? false
                          ? Icons.accessible
                          : Icons.not_accessible,
                      color: SharedColorPalette().secondary,
                    ),
                    InkWell(
                        onTap: () => onTap.call(place),
                        child: Text(
                          supr
                              ? context.l18n!.globalRemove.capitalize()
                              : context.l18n!.globalAdd.capitalize(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: SharedColorPalette().secondary,
                            fontSize: 12,
                          ),
                        )),
                    InkWell(
                      onTap: () {
                        context.pushNamed(LocationPlaceDetailScreen.name,
                            queryParameters: {
                              'id': place.id!,
                              'placeName': place.name
                            });
                      },
                      child: Text(
                        context.l18n!.more.capitalize(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: SharedColorPalette().secondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
