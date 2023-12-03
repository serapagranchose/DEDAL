import 'dart:async';

import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/dtos/sign_up_dto.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/set_credential.dart';
import 'package:dedal/core/use_cases/sign_in.dart';
import 'package:dedal/core/use_cases/sign_up.dart';
import 'package:dedal/core/use_cases/sign_up_code.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignUpCubit extends Cubit<CrudState> {
  SignUpCubit({
    required SignUp signUp,
    required SignUpCode signUpCode,
    required UpdateUser updateUser,
    required SignIn signIn,
    required SetCredential setCredential,
  })  : _signUp = signUp,
        _signIn = signIn,
        _signUpCode = signUpCode,
        _updateUser = updateUser,
        _setCredential = setCredential,
        super(const CrudInitial());

  final SignUp _signUp;
  final SignIn _signIn;
  final SignUpCode _signUpCode;
  final UpdateUser _updateUser;
  final SetCredential _setCredential;

  SignUpDto? info;
  bool save = false;

  FutureOr<void> userSignUp(SignUpDto? params, bool save) async {
    info = params;
    save = save;
    final signUpResult =
        await _signUp.call(info).fold((value) => value, (error) => false);
    if (signUpResult) emit(const CrudOkReturn());
  }

  FutureOr<SignUpDto?> userSignUpCode(String? code) async {
    info?.code = code;
    emit(const CrudLoading());
    return _signUpCode.call(info).fold((value) {
      if (value) {
        userSignIn();
      }
      emit(const CrudError(''));
      return null;
    }, (error) {
      emit(const CrudError(''));
      return null;
    });
  }

  FutureOr<void> userSignIn() async {
    emit(const CrudLoading());
    return _signIn
        .call(SigninDto(email: info?.email, password: info?.password))
        .fold((value) {
      if (value.isNotNull) {
        if (save) {
          setValue(SigninDto(email: info?.email, password: info?.password));
        }
        _updateUser.call(value);
        emit(CrudLoaded<User>(value));
      } else {
        emit(const CrudError(''));
      }
    }, (error) {
      emit(CrudError(error.message));
    });
  }

  FutureOr<void> setValue(SigninDto? info) async {
    await _setCredential.call(info);
  }
}
