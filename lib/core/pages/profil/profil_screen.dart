import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/datasources/local_storage_datasource.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/pages/home/home_cubit.dart';
import 'package:dedal/core/pages/locations/location_cubit.dart';
import 'package:dedal/core/use_cases/get_token.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class ProfilScreen extends CubitScreen<LocationCubit, CrudState> {
  const ProfilScreen({super.key});

  static const name = 'profil';

  @override
  create(BuildContext context) => LocationCubit(
      getToken:
          GetToken(localStorageDataSource: getIt<LocalStorageDataSource>()),
      getUser: GetUser(localStorageDataSource: getIt<LocalStorageDataSource>()))
    ..load();
  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
      navBar: true,
      child: switch (state) {
        CrudLoading() => const MainLoader(),
        CrudLoaded<String?>() => const Text('NOUS SOMMES SUR PROFIL'),
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
