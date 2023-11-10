import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/use_cases/set_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/constants/enum/generate_route_enum.dart';
import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/pages/filters/route_generate/route_generate_cubit.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:dedal/core/use_cases/user_get_map.dart';
import 'package:dedal/core/use_cases/user_get_path.dart';
import 'package:dedal/core/use_cases/user_get_place.dart';

class RouteGenerateScreen extends CubitScreen<RouteGenerateCubit, CrudState> {
  const RouteGenerateScreen({
    super.key,
    this.skip,
  });

  final bool? skip;

  @override
  RouteGenerateCubit create(BuildContext context) => RouteGenerateCubit(
      getUser: GetUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      userGetMap: UserGetMap(filterDataSource: getIt<FilterDataSource>()),
      userGetPat: UserGetPath(filterDataSource: getIt<FilterDataSource>()),
      userGetPlace: UserGetPlace(filterDataSource: getIt<FilterDataSource>()),
      updateUser:
          UpdateUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      setInfoUser: SetInfoUser(filterDataSource: getIt<FilterDataSource>()),
      skip: skip)
    ..load();

  @override
  Future<void> onListen(BuildContext context, CrudState state) async {
    super.onListen(context, state);
    if (state is CrudLoaded<GenerateRouteEnum>) {
      switch (state.data) {
        case GenerateRouteEnum.start:
          context.read<RouteGenerateCubit>().update();
        case GenerateRouteEnum.saveUser:
          context.read<RouteGenerateCubit>().places();
        case GenerateRouteEnum.getPlace:
          context.read<RouteGenerateCubit>().path();
        case GenerateRouteEnum.getPath:
          context.read<RouteGenerateCubit>().map();
        case GenerateRouteEnum.getMap:
          context.read<RouteGenerateCubit>().lastUpdate();
        case GenerateRouteEnum.end:
          context.goNamed(HomeScreen.name);
        case null:
      }
    }
  }

  @override
  Widget onBuild(BuildContext context, CrudState state) => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: AspectRatio(
          aspectRatio: 0.8,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  context.l18n!.globalLoading.capitalize(),
                  textAlign: TextAlign.center,
                ),
                const PlanLoader(),
                if (state is CrudLoaded<GenerateRouteEnum>)
                  Text(
                    switch (state.data) {
                      GenerateRouteEnum.getMap =>
                        context.l18n!.filterGenerateMap.capitalize(),
                      GenerateRouteEnum.getPath =>
                        context.l18n!.filterGeneratePath.capitalize(),
                      GenerateRouteEnum.getPlace =>
                        context.l18n!.filterGeneratePlace.capitalize(),
                      GenerateRouteEnum.saveUser =>
                        context.l18n!.filterGenerateUser.capitalize(),
                      GenerateRouteEnum.start =>
                        context.l18n!.filterGenerateStart.capitalize(),
                      GenerateRouteEnum.end =>
                        context.l18n!.filterGenerateEnd.capitalize(),
                      _ => '',
                    },
                    textAlign: TextAlign.center,
                  )
                else if (state is CrudError) ...[
                  Text(state.message ?? 'error'),
                  CustomStringButton(
                    context: context,
                    text: (context.l18n!.globalClose.capitalize()),
                    onTap: (controller) async => context.pop(),
                  )
                ]
              ],
            ),
          ),
        ),
      );
}
