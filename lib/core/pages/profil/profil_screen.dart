import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/locations/location_cubit.dart';
import 'package:dedal/core/pages/login/main.dart';
import 'package:dedal/core/pages/profil/profil_cubit.dart';
import 'package:dedal/core/use_cases/clear_user.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class ProfilScreen extends CubitScreen<ProfilCubit, CrudState> {
  const ProfilScreen({super.key});

  static const name = 'profil';

  @override
  create(BuildContext context) => ProfilCubit(
      getUser: GetUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      clearUser:
          ClearUser(localStorageDataSource: getIt<LocalStorageDataSource>()))
    ..load();
  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
      navBar: true,
      child: switch (state) {
        CrudLoading() => const MainLoader(),
        CrudLoaded<User?>() => GlobalButton(
            text: 'deco',
            onTap: () async => context
                .read<ProfilCubit>()
                .deconnection()
                .then((value) => context.goNamed(Main.routeName)),
          ),
        CrudError(message: final message) => Column(
            children: [
              Text(message ?? 'une erreur est subvenu'),
              GlobalButton(
                text: 'reload',
                onTap: () => context.read<ProfilCubit>().load(),
              )
            ],
          ),
        _ => const Text('error'),
      });
}
