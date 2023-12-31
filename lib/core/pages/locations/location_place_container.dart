import 'package:cached_network_image/cached_network_image.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/location_detail/location_place_detail_screen.dart';
import 'package:dedal/core/pages/locations/location_place_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        onTap: () => onTap,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: AspectRatio(
            aspectRatio: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(place.pict!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          place.name ?? 'name',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Expanded(
                            child: Text(
                              place.description ?? 'description',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
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
                                  'supprimer',
                                  style: TextStyle(
                                    color: SharedColorPalette().secondary,
                                    fontSize: 12,
                                  ),
                                )),
                            InkWell(
                              onTap: () {
                                context.pushNamed(
                                    LocationPlaceDetailScreen.name,
                                    queryParameters: {
                                      'id': place.id!,
                                      'placeName': place.name
                                    });
                              },
                              child: Text(
                                "Plus d'info >",
                                style: TextStyle(
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
                ),
              ],
            ),
          ),
        ),
      );
}
