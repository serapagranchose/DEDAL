import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/login/main.dart';
import 'package:dedal/core/pages/profil/profil_cubit.dart';
import 'package:dedal/core/use_cases/clear_user.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/set_first_step.dart';
import 'package:dedal/core/use_cases/user_unsubscribe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class ProfilScreen extends CubitScreen<ProfilCubit, CrudState> {
  const ProfilScreen({Key? key}) : super(key: key);

  static const name = 'profil';

  @override
  ProfilCubit create(BuildContext context) => ProfilCubit(
      // if you need to add fonction add it in the cubit here
      // then user them in ProfilCubit
      // function that call APi should be in a usecase(check Getuser to get exeple) and api call must be in datasource
      getUser: GetUser(localStorageDataSource: getIt()),
      clearUser: ClearUser(localStorageDataSource: getIt()),
      userUnsubscribe: UserUnsubscribe(loginDataSource: getIt()),
      setFirstStep: SetFirstStep(localStorageDataSource: getIt()))
    ..load();

  @override
  //RegisterLayout is the global Layout for all the app
  // he can display appbar/nav bar and make the naviation working correctly
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
        index: 3,
        navBar: true,
        appBar: true,
        title: context.l18n!.navBarProfil.capitalize(),
        // To change what you want you can xhange the 'child' params
        // if you need a statefullWidget (you need one) juste create one named 'ProfilContent' (check HomeContent is you need exemple)
        child: Column(
          children: [
            if (state is CrudLoaded<User?>)
              // To get User info just look in state.data.whateveryouwant
              Text('email : ${state.data?.email}'),
            CustomStringButton(
              context: context,
              text: context.l18n!.profilDeco.capitalize(),
              onTap: (_) async => context.goNamed(Main.routeName),
            ),
            CustomStringButton(
              context: context,
              text: context.l18n!.profilDeletAccount.capitalize(),
              onTap: (_) async => context.read<ProfilCubit>().unsubscribe(),
            ),
            CustomStringButton(
              context: context,
              text: 'tmp redo first step',
              onTap: (_) async => context.read<ProfilCubit>().resetFirstStep(),
            ),
          ],
        ),
      );
}
