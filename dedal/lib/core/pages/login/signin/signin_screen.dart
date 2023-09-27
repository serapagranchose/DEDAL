// ignore_for_file: use_build_context_synchronously

import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/components/text_fields/main_text_field.dart';
import 'package:dedal/core/datasources/local_storage_datasource.dart';
import 'package:dedal/core/datasources/login_datasource.dart';
import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/login/signin/signin_cubit.dart';
import 'package:dedal/core/use_cases/sign_in.dart';
import 'package:dedal/core/use_cases/update_token.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class SignInScreen extends CubitScreen<SignInCubit, CrudState> {
  SignInScreen({super.key});

  @override
  SignInCubit create(BuildContext context) => SignInCubit(
      signIn: SignIn(loginDataSource: getIt<LoginDataSource>()),
      updateToken:
          UpdateToken(localStorageDataSource: getIt<LocalStorageDataSource>()),
      updateUser:
          UpdateUser(localStorageDataSource: getIt<LocalStorageDataSource>()));

  static const routeName = '/signin';
  String? email;
  String? password;
  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
        appBar: true,
        title: 'Connection',
        child: state is CrudLoading
            ? const MainLoader()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainTextFields(
                    title: 'Votre E-mail',
                    placeholder: 'exemple@test.idk',
                    onChanged: (String value) => email = value,
                  ),
                  MainTextFields(
                    title: 'Votre mot de passe',
                    onChanged: (String value) => password = value,
                  ),
                  GlobalButton(
                    onTap: () async {
                      final res = await context.read<SignInCubit>().userSignIn(
                          SigninDto(email: email, password: password));
                      if (res != null && res) {
                        context.pushNamed(HomeScreen.name);
                      }
                    },
                    text: 'Connection',
                  ),
                ],
              ),
      );
}
