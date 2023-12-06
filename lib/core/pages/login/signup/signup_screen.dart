// ignore_for_file: use_build_context_synchronously

import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/dtos/sign_up_dto.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/login/signup/signup_cubit.dart';
import 'package:dedal/core/pages/login/signin/signin_content.dart';
import 'package:dedal/core/pages/login/signin/signin_cubit.dart';
import 'package:dedal/core/pages/login/signup/signup_content.dart';
import 'package:dedal/core/pages/login/stateless/code_dialog.dart';
import 'package:dedal/core/use_cases/set_credential.dart';
import 'package:dedal/core/use_cases/sign_in.dart';
import 'package:dedal/core/use_cases/sign_up.dart';
import 'package:dedal/core/use_cases/sign_up_code.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignUpScreen extends CubitScreen<SignUpCubit, CrudState> {
  const SignUpScreen({super.key});

  static const routeName = '/signup';

  @override
  SignUpCubit create(BuildContext context) => SignUpCubit(
      signUp: SignUp(loginDataSource: getIt<LoginDataSource>()),
      signUpCode: SignUpCode(loginDataSource: getIt<LoginDataSource>()),
      updateUser:
          UpdateUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      signIn: SignIn(loginDataSource: getIt<LoginDataSource>()),
      setCredential: SetCredential(localStorageDataSource: getIt()));

  @override
  Widget parent(BuildContext context, Widget child) => Scaffold(
        backgroundColor: Colors.transparent,
        body: DraggableScrollableSheet(
            initialChildSize: 0.9,
            builder: (context, scrollController) => DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: child,
                )),
      );

  @override
  Future<void> onListen(BuildContext context, CrudState state) async {
    super.onListen(context, state);
    if (state is CrudOkReturn) {
      await showDialog(
          context: context,
          builder: (_) => CodeDialog(action: (code) async {
                final res =
                    await context.read<SignUpCubit>().userSignUpCode(code);
                if (res.isNotNull) {
                  context.read<SignInCubit>().userSignIn(
                      SigninDto(email: res?.email, password: res?.password),
                      false);
                }
              }));
    }
    if (state is CrudLoaded<User> && state.data.isNotNull) {
      context.pushNamed(HomeScreen.name);
    }
    if (state is CrudError) {
      context.pop();
    }
  }

  @override
  Widget onBuild(BuildContext context, CrudState state) => state is CrudLoading
      ? const MainLoader()
      : SignUpContent(validate: (email, password, saveCreadential) async {
          await context.read<SignUpCubit>().userSignUp(
              SignUpDto(email: email, password: password), saveCreadential);
        });
}
