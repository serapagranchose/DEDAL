import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/text_fields/main_text_field.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/components/button/icon_button.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/login/main.dart';
import 'package:dedal/core/pages/profil/profil_cubit.dart';
import 'package:dedal/core/pages/profil/profil_content.dart';
import 'package:dedal/core/use_cases/user_set_name.dart';
import 'package:dedal/core/use_cases/clear_user.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/set_first_step.dart';
import 'package:dedal/core/use_cases/user_unsubscribe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class ProfileScreen extends CubitScreen<ProfilCubit, CrudState> {
  const ProfileScreen({Key? key}) : super(key: key);

  static const name = 'profile';

  @override
  ProfilCubit create(BuildContext context) => ProfilCubit(
      // if you need to add fonction add it in the cubit here
      // then user them in ProfilCubit
      // function that call APi should be in a usecase(check Getuser to get exeple) and api call must be in datasource
      getUser: GetUser(localStorageDataSource: getIt()),
      clearUser: ClearUser(localStorageDataSource: getIt()),
      userUnsubscribe: UserUnsubscribe(loginDataSource: getIt()),
      setUserName: UserSetName(filterDataSource: getIt()),
      setFirstStep: SetFirstStep(localStorageDataSource: getIt()))
    ..load();

  @override
  Widget parent(BuildContext context, Widget child) => RegisterLayout(
      appBar: true,
      navBar: true,
      title: context.l18n!.navBarProfil.capitalize(),
      index: 3,
      child: child);
// state.data.email
  @override
  //RegisterLayout is the global Layout for all the app
  // he can display appbar/nav bar and make the naviation working correctly
  Widget onBuild(BuildContext context, CrudState state) => switch (state) {
        CrudLoading() => const MainLoader(),
        CrudLoaded() => Column(children: [
            ProfileContent(
                user: state.data,
                edit: (username) async =>
                    context.read<ProfilCubit>().setUserName(username)),
            const Expanded(
              child: Gap(15),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(children: [
                  // Delete account button
                  Expanded(
                    child: CustomStringButton(
                      border: Border.all(
                        width: 2,
                        color:
                            SharedColorPalette().mainDisable(Theme.of(context)),
                      ),
                      backgroundColor: SharedColorPalette().secondary,
                      context: context,
                      text: context.l18n!.profilDeletAccount.capitalize(),
                      onTap: (_) async => context
                          .read<ProfilCubit>()
                          .unsubscribe()
                          .then((value) =>
                              value ? context.goNamed(Main.routeName) : null),
                    ),
                  ),
                  const Gap(30),
                  // Log out button
                  Expanded(
                    child: CustomStringButton(
                      backgroundColor:
                          SharedColorPalette().accent(Theme.of(context)),
                      textColor: SharedColorPalette().text(Theme.of(context)),
                      border: Border.all(
                        width: 2,
                        color:
                            SharedColorPalette().mainDisable(Theme.of(context)),
                      ),
                      context: context,
                      text: context.l18n!.profilDeco.capitalize(),
                      onTap: (_) async => context.goNamed(Main.routeName),
                    ),
                  )
                ])),
          ]),
        CrudError(message: final message) => Column(
            children: [
              Text(message ?? context.l18n!.globalError.capitalize()),
              CustomStringButton(
                context: context,
                text: context.l18n!.globalRestart.capitalize(),
                onTap: (c) async => context.read<ProfilCubit>().load(),
              )
            ],
          ),
        _ => Text(context.l18n!.globalError.capitalize()),
      };
}
