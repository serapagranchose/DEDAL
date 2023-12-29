import 'dart:async';

import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/info.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/get_filters.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/set_user_info.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class FiltersCubit extends Cubit<CrudState> {
  FiltersCubit({
    required GetUser getUser,
    required GetFilters getFilters,
    required SetInfoUser setInfoUser,
    required UpdateUser updateUser,
  })  : _getUser = getUser,
        _getFilters = getFilters,
        _setInfoUser = setInfoUser,
        _updateUser = updateUser,
        super(const CrudInitial());

  final GetUser _getUser;
  final GetFilters _getFilters;
  final SetInfoUser _setInfoUser;
  final UpdateUser _updateUser;
  User? user;

  FutureOr<void> load() async {
    emit(const CrudLoading());
    print('hrer');
    final getUserResult = await _getUser.call(const NoParam()).fold(
          (value) => value,
          (error) => null,
        );
    print('getUserResult?.token => ${getUserResult?.token}');

    if (getUserResult.isNotNull) {
      user = getUserResult;
      _getFilters.call(getUserResult!.token).fold(
            (value) =>
                emit(CrudLoaded<(User, List<Filter>?)>((getUserResult, value))),
            (error) => emit(CrudError(error.message)),
          );
    }
  }

  FutureOr<bool> setInfo(Info info) async {
    user?.info = info;
    await _updateUser(user);
    return await _setInfoUser
        .call(user)
        .fold((value) => value, (error) => false);
  }
}
