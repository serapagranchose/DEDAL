import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/home/home_content.dart';
import 'package:dedal/core/pages/home/home_cubit.dart';
import 'package:dedal/core/use_cases/get_first_step.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/get_user_geolocation.dart';
import 'package:dedal/core/use_cases/location_get_place_by_filter.dart';
import 'package:dedal/core/use_cases/set_first_step.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:dedal/core/use_cases/user_get_map.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class HomeScreen extends CubitScreen<HomeCubit, CrudState> {
  const HomeScreen({super.key});

  static const name = 'home';

  @override
  create(BuildContext context) => HomeCubit(
      getUser: GetUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      getUserGeolocation: GetUserGeolocation(),
      userGetMap: UserGetMap(filterDataSource: getIt<FilterDataSource>()),
      updateUser:
          UpdateUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      getFirstStep:
          GetFirstStep(localStorageDataSource: getIt<LocalStorageDataSource>()),
      setFirstStep:
          SetFirstStep(localStorageDataSource: getIt<LocalStorageDataSource>()),
      locationGetPlaceByFilter:
          LocationGetPlaceByFilter(locationsDataSource: getIt()))
    ..load();

  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
      padding: false,
      index: 1,
      navBar: true,
      child: switch (state) {
        CrudLoading() => const MainLoader(),
        CrudLoaded<User?>(data: final data) => data != null
            ? HomeContent(
                userPosition: data.pos ?? const LatLng(0, 0),
                places: null,
                map: data.info?.map,
                init: bloc(context).load,
              )
            : const MainLoader(),
        CrudError(message: final message) => Column(
            children: [
              Text(message ?? context.l18n!.globalError.capitalize()),
              CustomStringButton(
                context: context,
                text: context.l18n!.globalRestart,
                onTap: (c) async => context.read<HomeCubit>().load(),
              )
            ],
          ),
        CrudLoaded<(User, List<Place>)>(data: final data) => HomeContent(
            userPosition: data!.$1.pos ?? const LatLng(0, 0),
            places: data.$2.isEmpty ? null : data.$2,
            map: null,
            init: bloc(context).load,
          ),
        _ => Text(context.l18n!.globalError.capitalize()),
      });
}
