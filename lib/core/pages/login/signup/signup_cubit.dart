import 'dart:async';

import 'package:dedal/core/dtos/sign_up_dto.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/sign_up.dart';
import 'package:dedal/core/use_cases/sign_up_code.dart';
import 'package:dedal/core/use_cases/update_token.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignUpCubit extends Cubit<CrudState> {
  SignUpCubit({
    required SignUp signUp,
    required SignUpCode signUpCode,
    required UpdateToken updateToken,
    required UpdateUser updateUser,
  })  : _signUp = signUp,
        _signUpCode = signUpCode,
        _updateToken = updateToken,
        _updateUser = updateUser,
        super(const CrudInitial());

  final SignUp _signUp;
  final SignUpCode _signUpCode;
  final UpdateToken _updateToken;
  final UpdateUser _updateUser;

  FutureOr<void> userSignUp(SignUpDto? params) async {
    final signUpResult =
        await _signUp.call(params).fold((value) => value, (error) => false);
    print(signUpResult);
    if (await signUpResult) emit(const CrudOkReturn());
  }

  FutureOr<bool> userSignUpCode(SignUpDto? params) async {
    emit(const CrudLoading());
    return _signUpCode.call(params).fold((value) => value, (error) => false);
  }

  FutureOr<void> setValue(User? user) async {
    _updateToken.call(user?.token);
    _updateUser.call(user?.id);
  }
}
