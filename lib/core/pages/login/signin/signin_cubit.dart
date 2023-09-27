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
    required UpdateToken updateToken,
    required UpdateUser updateUser,
  })  : _signIn = signIn,
        _updateToken = updateToken,
        _updateUser = updateUser,
        super(const CrudInitial());

  final SignIn _signIn;
  final UpdateToken _updateToken;
  final UpdateUser _updateUser;

  FutureOr<bool?> userSignIn(SigninDto? params) async {
    emit(const CrudLoading());
    return _signIn.call(params).fold((value) {
      if (value.isNotNull) {
        setValue(value);
        emit(CrudLoaded<User>(value));
        return true;
      } else {
        emit(const CrudError(''));
        return false;
      }
    }, (error) {
      emit(const CrudError(''));
      return false;
    });
  }

  FutureOr<void> setValue(User? user) async {
    _updateToken.call(user?.token);
    _updateUser.call(user?.id);
  }
}
