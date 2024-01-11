import 'dart:async';

import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/get_first_step.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/get_user_geolocation.dart';
import 'package:dedal/core/use_cases/location_get_place_by_filter.dart';
import 'package:dedal/core/use_cases/set_first_step.dart';
import 'package:dedal/core/use_cases/tooltip_helper.dart';
import 'package:dedal/core/use_cases/update_user.dart';
import 'package:dedal/core/use_cases/user_get_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class HomeCubit extends Cubit<CrudState> {
  HomeCubit(
      {required GetUserGeolocation getUserGeolocation,
      required GetUser getUser,
      required UserGetMap userGetMap,
      required UpdateUser updateUser,
      required GetFirstStep getFirstStep,
      required LocationGetPlaceByFilter locationGetPlaceByFilter,
      required SetFirstStep setFirstStep})
      : _getUserGeolocation = getUserGeolocation,
        _getUser = getUser,
        _userGetMap = userGetMap,
        _updateUser = updateUser,
        _getFirstStep = getFirstStep,
        _setFirstStep = setFirstStep,
        _locationGetPlaceByFilter = locationGetPlaceByFilter,
        super(const CrudInitial());

  final GetUserGeolocation _getUserGeolocation;
  final LocationGetPlaceByFilter _locationGetPlaceByFilter;
  final GetFirstStep _getFirstStep;
  final SetFirstStep _setFirstStep;
  final GetUser _getUser;
  final UserGetMap _userGetMap;
  final UpdateUser _updateUser;

  FutureOr<void> load() async {
    bool change = false;
    emit(const CrudLoading());
    final res =
        await _getFirstStep.call(null).fold((value) => value, (error) => null);
    if (!(res ?? true)) {
      getIt<OnboardingTooTipHelper>().start.call();
    }
    await _getUser.call(const NoParam()).fold((user) async {
      if (user.isNotNull) {
        if (user?.pos.isNull ?? false) {
          change = true;
          final loc = await _getUserGeolocation
              .call(const NoParam())
              .fold((value) => value, (error) => null);
          if (loc != null) {
            user!.pos = LatLng(loc.latitude, loc.longitude);
          }
        }
        if (user?.info?.mapName.isNotNull ?? false) {
          change = true;
          final map =
              await _userGetMap(user).fold((value) => value, (error) => null);
          user?.info?.map = map;
        }
        if (change) {
          await _updateUser(user);
        }
        emit(CrudLoaded<User?>(user));
      }
    }, (error) => emit(CrudError(error.toString())));
  }

  FutureOr<void> loadWithPlace(String filterId) async {
    final userResult =
        await _getUser.call(null).fold((value) => value, (error) => null);
    if (userResult.isNull) {
      emit(const CrudError('user not found'));
      return;
    }
    if (filterId == '') {
      emit(CrudLoaded<(User, List<Place>)>((userResult!, [])));
      return;
    }
    final filterResult = await _locationGetPlaceByFilter
        .call((userResult!, filterId)).fold((value) => value, (error) => null);
    if (filterResult.isNull) {
      emit(const CrudError('placces not found'));
      return;
    }
    emit(CrudLoaded<(User, List<Place>)>((userResult, filterResult!)));
  }

  Future<void> setUserFirstStep() async => _setFirstStep.call(true);
}
