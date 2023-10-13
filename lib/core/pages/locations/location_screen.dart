// ignore_for_file: use_build_context_synchronously

import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/datasources/locations/locations_datasource.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/pages/filters/route_generate/route_generate_screen.dart';
import 'package:dedal/core/pages/locations/location_content.dart';
import 'package:dedal/core/pages/locations/location_cubit.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/locations_get_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class LocationScreen extends CubitScreen<LocationCubit, CrudState> {
  const LocationScreen({super.key});

  static const name = 'location';

  @override
  create(BuildContext context) => LocationCubit(
      getUser: GetUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      locationGetLists: LocationGetLists(
          filterDataSource: getIt<FilterDataSource>(),
          locationsDataSource: getIt<LocationsDataSource>()))
    ..load();
  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
      navBar: true,
      child: switch (state) {
        CrudLoading() => const MainLoader(),
        CrudLoaded(data: final list) => LocationContent(
            list: list,
            submit: (place) async {
              await context.read<LocationCubit>().setPlace(place);
              return;
              showDialog(
                  context: context,
                  builder: (context) => const RouteGenerateScreen());
            }),
        CrudError(message: final message) => Column(
            children: [
              Text(message ?? 'une erreur est subvenu'),
              GlobalButton(
                text: 'reload',
                onTap: () => context.read<LocationCubit>().load(),
              )
            ],
          ),
        _ => const Text('error'),
      });
}
