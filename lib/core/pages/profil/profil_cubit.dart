import 'dart:async';

import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/clear_user.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/set_first_step.dart';
import 'package:dedal/core/use_cases/user_unsubscribe.dart';
import 'package:dedal/core/use_cases/user_set_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dedal/core/dtos/change_username_dto.dart';

class ProfilCubit extends Cubit<CrudState> {
  ProfilCubit({
    required GetUser getUser,
    required ClearUser clearUser,
    required UserUnsubscribe userUnsubscribe,
    required UserSetName setUserName,
    required SetFirstStep setFirstStep,
  })  : _getUser = getUser,
        _clearUser = clearUser,
        _userUnsubscribe = userUnsubscribe,
        _setUserName = setUserName,
        _setFirstStep = setFirstStep,
        super(const CrudInitial());

  final GetUser _getUser;
  final SetFirstStep _setFirstStep;
  final ClearUser _clearUser;
  final UserSetName _setUserName;
  final UserUnsubscribe _userUnsubscribe;

  FutureOr<void> load() async {
    emit(const CrudLoading());
    await _getUser.call(const NoParam()).fold((value) {
      if (value.isNotNull) {
        emit(CrudLoaded<User?>(value));
      } else {
        emit(const CrudError('User not found'));
      }
    }, (error) => emit(CrudError(error.toString())));
  }

  Future<void> deconnection() async {
    _clearUser.call(const NoParam());
  }

  Future<bool> unsubscribe() async => _getUser.call(null).fold(
        (value) {
          _userUnsubscribe.call(value);
          deconnection();
          return true;
        },
        (error) => false,
      );

  Future<bool> setUserName(ChangeUsernameDto params) async => _setUserName.call(params).fold(
        (value) {
          return true;
        },
        (error) => false,
      );

  void toggleThemeMode(BuildContext context) {
    final themeMode = AdaptiveTheme.of(context).mode;
    final newMode = themeMode == AdaptiveThemeMode.light
        ? AdaptiveThemeMode.dark
        : AdaptiveThemeMode.light;
    AdaptiveTheme.of(context).setThemeMode(newMode);
  }

  Future<void> resetFirstStep() async {
    await _setFirstStep.call(false);
    deconnection();
  }
}
