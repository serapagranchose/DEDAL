// ignore_for_file: use_build_context_synchronously

import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/components/text_fields/main_text_field.dart';
import 'package:dedal/core/datasources/local_storage_datasource.dart';
import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/dtos/sign_up_dto.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/login/signUp/signUp_cubit.dart';
import 'package:dedal/core/pages/login/signin/signin_cubit.dart';
import 'package:dedal/core/pages/login/stateless/code_dialog.dart';
import 'package:dedal/core/use_cases/sign_up.dart';
import 'package:dedal/core/use_cases/sign_up_code.dart';
import 'package:dedal/core/use_cases/update_token.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class SignUpScreen extends CubitScreen<SignUpCubit, CrudState> {
  SignUpScreen({super.key});

  @override
  SignUpCubit create(BuildContext context) => SignUpCubit(
      signUp: SignUp(loginDataSource: getIt<LoginDataSource>()),
      signUpCode: SignUpCode(loginDataSource: getIt<LoginDataSource>()),
      updateToken:
          UpdateToken(localStorageDataSource: getIt<LocalStorageDataSource>()),
      updateUser:
          UpdateUser(localStorageDataSource: getIt<LocalStorageDataSource>()));

  static const routeName = '/signup';

  String? email;
  String? password;
  String? code;

  @override
  Future<void> onListen(BuildContext context, CrudState state) async {
    super.onListen(context, state);
    print('state => $state');
    if (state is CrudOkReturn) {
      await showDialog(
          context: context,
          builder: (_) => CodeDialog(action: (code) async {
                print('here');
                context
                    .read<SignUpCubit>()
                    .userSignUpCode(SignUpDto(email: email, code: code));
              }));
    }
  }

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
                    onTap: () async => context.read<SignUpCubit>().userSignUp(
                        SignUpDto(email: email, password: password)),
                    text: 'Connection',
                  ),
                ],
              ),
      );
}
