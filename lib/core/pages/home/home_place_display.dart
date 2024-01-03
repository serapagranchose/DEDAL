import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/location_detail/location_place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomePlaceDisplay extends StatelessWidget {
  const HomePlaceDisplay({
    super.key,
    required this.place,
    required this.close,
  });

  final Place place;
  final VoidCallback close;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 4,
                spreadRadius: 4,
              ),
            ],
            color: SharedColorPalette().accent(Theme.of(context)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: AspectRatio(
          aspectRatio: 2,
          child: Row(
            children: [
              Text(place.pict ?? 'PICT'),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(place.pict ?? ''),
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              place.name ?? 'name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: SharedColorPalette()
                                    .text(Theme.of(context)),
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                            onTap: close,
                            child: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            place.description ?? 'description',
                            style: TextStyle(
                              color:
                                  SharedColorPalette().text(Theme.of(context)),
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              place.accessible ?? false
                                  ? Icons.accessible
                                  : Icons.not_accessible,
                              color: SharedColorPalette().secondary,
                            ),
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
                                context.l18n!.more.capitalize(),
                                style: TextStyle(
                                  color: SharedColorPalette().secondary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
