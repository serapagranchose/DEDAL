import 'dart:async';

import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/get_user_geolocation.dart';
import 'package:dedal/core/use_cases/user_get_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class HomeCubit extends Cubit<CrudState> {
  HomeCubit({
    required GetUserGeolocation getUserGeolocation,
    required GetUser getUser,
    required UserGetMap userGetMap,
  })  : _getUserGeolocation = getUserGeolocation,
        _getUser = getUser,
        super(const CrudInitial());

  final GetUserGeolocation _getUserGeolocation;
  final GetUser _getUser;

  FutureOr<void> load() async {
    emit(const CrudLoading());
    await _getUser.call(const NoParam()).fold((user) async {
      if (user.isNotNull) {
        final loc = await _getUserGeolocation
            .call(const NoParam())
            .fold((value) => value, (error) => null);
        if (loc != null) {
          user!.pos = LatLng(loc.latitude, loc.longitude);
          print(user.places);
          print(user.info?.map);
          emit(CrudLoaded<User?>(user));
        }
      }
    }, (error) => emit(CrudError(error.toString())));
  }
}
