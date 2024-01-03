import 'package:cached_network_image/cached_network_image.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/location_detail/location_place_detail_cubit.dart';
import 'package:dedal/core/use_cases/get_place.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocationPlaceDetailScreen
    extends CubitScreen<LocationPlaceDetailCubit, CrudState> {
  const LocationPlaceDetailScreen({
    super.key,
    required this.id,
    required this.placeName,
  });

  static const name = 'place-detail';

  final String? id;
  final String? placeName;

  @override
  Widget parent(BuildContext context, Widget child) => RegisterLayout(
        appBar: true,
        title: placeName,
        child: child,
      );

  @override
  LocationPlaceDetailCubit create(BuildContext context) =>
      LocationPlaceDetailCubit(
          getPlace: GetPlace(filterDataSource: getIt()), id: id)
        ..load();
  @override
  Widget onBuild(BuildContext context, CrudState state) => switch (state) {
        CrudLoaded<Place?>(data: final place) => place.isNotNull
            ? RegisterLayout(
                child: Column(children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: place!.pict != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                              place.pict!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: AssetImage(
                              switch (place.type) {
                                'Art et culture' =>
                                  'assets/images/filters/art.jpg',
                                'bar' => 'assets/images/filters/bar.png',
                                'Divertissement' =>
                                  'assets/images/filters/divertissement.jpg',
                                'Shopping' =>
                                  'assets/images/filters/shopping.jpg',
                                'Café' => 'assets/images/filters/cafe.png',
                                'Parc et espace vert' =>
                                  'assets/images/filters/parc.jpg',
                                'Histoire' =>
                                  'assets/images/filters/histoire_lille.jpg',
                                'Restaurant' =>
                                  'assets/images/filters/restaurant.png',
                                'Bien-être' =>
                                  'assets/images/filters/bien-etre.jpg',
                                'Enfant' => 'assets/images/filters/enfant.png',
                                _ => 'assets/images/filters/divertissement.jpg',
                              },
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const Gap(20),
                Text(
                  place.description ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const Gap(20),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded),
                    Expanded(
                      child: Text(
                        place.address ?? '',
                        overflow: TextOverflow.fade,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.link),
                    const Gap(5),
                    Expanded(
                      child: InkWell(
                          child: Text(
                            place.link ?? '',
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 16),
                          ),
                          onTap: () => launchUrl(Uri.parse(place.link ?? ''))),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Row(
                        children: [
                          Text(
                            '${place.price?.round()}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.euro),
                        ],
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Row(
                        children: [
                          const Icon(Icons.hourglass_bottom),
                          Text(
                            '${place.duration?.round()} min',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ]),
                  ],
                ),
              ]))
            : const SizedBox.shrink(),
        _ => const MainLoader(),
      };
}
