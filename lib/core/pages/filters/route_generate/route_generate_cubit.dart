import 'dart:async';

import 'package:dedal/constants/enum/generate_route_enum.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:dedal/core/use_cases/user_get_map.dart';
import 'package:dedal/core/use_cases/user_get_path.dart';
import 'package:dedal/core/use_cases/user_get_place.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class RouteGenerateCubit extends Cubit<CrudState> {
  RouteGenerateCubit({
    required GetUser getUser,
    required UserGetMap userGetMap,
    required UserGetPath userGetPat,
    required UserGetPlace userGetPlace,
    required UpdateUser updateUser,
  })  : _getUser = getUser,
        _userGetMap = userGetMap,
        _userGetPath = userGetPat,
        _userGetPlace = userGetPlace,
        _updateUser = updateUser,
        super(const CrudInitial());

  final GetUser _getUser;
  final UserGetMap _userGetMap;
  final UserGetPath _userGetPath;
  final UserGetPlace _userGetPlace;
  final UpdateUser _updateUser;
  User? user;

  FutureOr<void> load() async {
    emit(const CrudLoading());
    final getUserResult = await _getUser.call(const NoParam()).fold(
          (value) => value,
          (error) => null,
        );
    if (getUserResult.isNotNull) {
      user = getUserResult;
      emit(const CrudLoaded<GenerateRouteEnum>(GenerateRouteEnum.start));
    } else {
      emit(const CrudError('cannot get user'));
    }
  }

  FutureOr<void> update() async {
    await _updateUser(user).fold(
        (value) => emit(
            const CrudLoaded<GenerateRouteEnum>(GenerateRouteEnum.saveUser)),
        (error) => emit(CrudError(error.message)));
  }

  FutureOr<void> places() async => _userGetPlace(user).fold((value) async {
        user?.places = value;
        await _updateUser.call(user);
        emit(const CrudLoaded<GenerateRouteEnum>(GenerateRouteEnum.getPlace));
      }, (error) => emit(CrudError(error.message)));

  FutureOr<void> path() async => _userGetPath(user).fold((value) async {
        user?.info?.mapName = value;
        await _updateUser.call(user);
        emit(const CrudLoaded<GenerateRouteEnum>(GenerateRouteEnum.getPath));
      }, (error) => emit(CrudError(error.message)));

  FutureOr<void> map() async => _userGetMap(user).fold((value) async {
        user?.info?.map = value;
        await _updateUser.call(user);
        emit(const CrudLoaded<GenerateRouteEnum>(GenerateRouteEnum.getMap));
      }, (error) => emit(CrudError(error.message)));

  FutureOr<void> lastUpdate() async {
    await _updateUser(user).fold(
        (value) =>
            emit(const CrudLoaded<GenerateRouteEnum>(GenerateRouteEnum.end)),
        (error) => emit(CrudError(error.message)));
  }
}
