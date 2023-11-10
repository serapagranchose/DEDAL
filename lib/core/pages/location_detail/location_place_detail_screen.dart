import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/pages/location_detail/location_place_detail_cubit.dart';
import 'package:dedal/core/use_cases/get_place.dart';
import 'package:flutter/material.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocationPlaceDetailScreen
    extends CubitScreen<LocationPlaceDetailCubit, CrudState> {
  const LocationPlaceDetailScreen({
    super.key,
    required this.id,
  });

  static const name = 'place-detail';

  final String? id;

  @override
  LocationPlaceDetailCubit create(BuildContext context) =>
      LocationPlaceDetailCubit(
          getPlace: GetPlace(filterDataSource: getIt()), id: id);
  @override
  Widget onBuild(BuildContext context, CrudState state) => switch (state) {
        CrudLoaded<Place?>(data: final place) => place.isNotNull
            ? RegisterLayout(
                child: Column(
                children: [
                  Text(place!.name ?? ''),
                  Text(place.description ?? ''),
                  Text(place.address ?? ''),
                  Text(place.price?.toString() ?? ''),
                  Text(place.duration?.toString() ?? ''),
                  Text(place.type ?? ''),
                ],
              ))
            : const SizedBox.shrink(),
        _ => const SizedBox.shrink(),
      };
}
