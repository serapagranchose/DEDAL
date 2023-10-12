import 'dart:async';

import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/set_credential.dart';
import 'package:dedal/core/use_cases/sign_in.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignInCubit extends Cubit<CrudState> {
  SignInCubit({
    required SignIn signIn,
    required SetCredential setCredential,
    required UpdateUser updateUser,
  })  : _signIn = signIn,
        _updateUser = updateUser,
        _setCredential = setCredential,
        super(const CrudInitial());

  final SignIn _signIn;
  final SetCredential _setCredential;
  final UpdateUser _updateUser;

  FutureOr<void> userSignIn(SigninDto? params) async {
    emit(const CrudLoading());
    return _signIn.call(params).fold((value) {
      if (value.isNotNull) {
        setValue(params);
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
