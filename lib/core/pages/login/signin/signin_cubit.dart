import 'dart:async';

import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/sign_in.dart';
import 'package:dedal/core/use_cases/update_token.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignInCubit extends Cubit<CrudState> {
  SignInCubit({
    required SignIn signIn,
  })  : _signIn = signIn,
        super(const CrudInitial());

  final SignIn _signIn;

  FutureOr<void> userSignIn(SigninDto? params) async {
    emit(const CrudLoading());
    return _signIn.call(params).fold((value) {
      if (value.isNotNull) {
        emit(CrudLoaded<User>(value));
      } else {
        emit(const CrudError(''));
      }
    }, (error) {
      emit(const CrudError(''));
    });
  }
}
