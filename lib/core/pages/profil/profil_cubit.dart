import 'dart:async';

import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/clear_user.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class ProfilCubit extends Cubit<CrudState> {
  ProfilCubit({
    required GetUser getUser,
    required ClearUser clearUser,
  })  : _getUser = getUser,
        _clearUser = clearUser,
        super(const CrudInitial());

  final GetUser _getUser;
  final ClearUser _clearUser;

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
}
