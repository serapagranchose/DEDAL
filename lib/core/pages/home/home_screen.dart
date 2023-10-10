import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/home/home_content.dart';
import 'package:dedal/core/pages/home/home_cubit.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/get_user_geolocation.dart';
import 'package:dedal/core/use_cases/user_get_map.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class HomeScreen extends CubitScreen<HomeCubit, CrudState> {
  const HomeScreen({super.key});

  static const name = 'home';

  @override
  create(BuildContext context) => HomeCubit(
      getUser: GetUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      getUserGeolocation: GetUserGeolocation(),
      userGetMap: UserGetMap(filterDataSource: getIt<FilterDataSource>()))
    ..load();
  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
      navBar: true,
      child: switch (state) {
        CrudLoading() => const MainLoader(),
        CrudLoaded<User?>(data: final data) => data?.pos != null
            ? HomeContent(
                userPosition: data!.pos!,
                map: data.info?.map,
                places: data.places,
              )
            : const MainLoader(),
        CrudError(message: final message) => Column(
            children: [
              Text(message ?? 'une erreur est subvenu'),
              GlobalButton(
                text: 'reload',
                onTap: () => context.read<HomeCubit>().load(),
              )
            ],
          ),
        _ => const Text('error'),
      });
}
