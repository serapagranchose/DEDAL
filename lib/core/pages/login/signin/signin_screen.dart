// ignore_for_file: use_build_context_synchronously

import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/login/signin/signin_content.dart';
import 'package:dedal/core/pages/login/signin/signin_cubit.dart';
import 'package:dedal/core/use_cases/set_credential.dart';
import 'package:dedal/core/use_cases/sign_in.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignInScreen extends CubitScreen<SignInCubit, CrudState> {
  SignInScreen({super.key});

  @override
  SignInCubit create(BuildContext context) => SignInCubit(
        signIn: SignIn(loginDataSource: getIt<LoginDataSource>()),
        setCredential: SetCredential(
            localStorageDataSource: getIt<LocalStorageDataSource>()),
        updateUser:
            UpdateUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      );
  static const routeName = '/signin';

  String? email;
  String? password;

  @override
  Future<void> onListen(BuildContext context, CrudState state) async {
    super.onListen(context, state);

    if (state is CrudLoaded<User> && state.data.isNotNull) {
      context
          .read<SignInCubit>()
          .setValue(SigninDto(email: email, password: password));
      context.pushNamed(HomeScreen.name);
    }
  }

  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
      appBar: true,
      title: 'Connection',
      child: state is CrudLoading
          ? const MainLoader()
          : SigninContent(
              validate: (email, password) async => context
                  .read<SignInCubit>()
                  .userSignIn(SigninDto(email: email, password: password)),
              isError: state is CrudError,
            ));
}
