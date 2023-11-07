import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/pages/login/main.dart';
import 'package:dedal/core/pages/profil/profil_cubit.dart';
import 'package:dedal/core/use_cases/clear_user.dart';
import 'package:dedal/core/use_cases/get_user.dart';
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
      getUser: GetUser(localStorageDataSource: getIt()),
      clearUser: ClearUser(localStorageDataSource: getIt()),
      userUnsubscribe: UserUnsubscribe(loginDataSource: getIt()));

  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
        index: 3,
        navBar: true,
        appBar: true,
        title: 'Profil',
        child: Column(
          children: [
            CustomStringButton(
              context: context,
              text: 'Deconnection',
              onTap: (_) async => context.goNamed(Main.routeName),
            ),
            CustomStringButton(
              context: context,
              text: 'Supprmier le compte',
              onTap: (_) async => context.read<ProfilCubit>().unsubscribe(),
            ),
          ],
        ),
      );
}
