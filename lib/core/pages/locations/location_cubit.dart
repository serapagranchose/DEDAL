import 'dart:async';

import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/locations_get_list.dart';
import 'package:dedal/core/use_cases/user_get_place.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocationCubit extends Cubit<CrudState> {
  LocationCubit({
    required GetUser getUser,
    required LocationGetLists locationGetLists,
  })  : _getUser = getUser,
        _locationGetLists = locationGetLists,
        super(const CrudInitial());

  final GetUser _getUser;
  final LocationGetLists _locationGetLists;

  FutureOr<void> load() async {
    emit(const CrudLoading());
    await _getUser.call(const NoParam()).fold((user) async {
      if (user.isNotNull) {
        await _locationGetLists.call(user!).fold(
              (list) => emit(CrudLoaded(list)),
              (error) => emit(const CrudError('Error in loading places')),
            );
        emit(CrudLoaded<User?>(user));
      } else {
        emit(const CrudError('User not found'));
      }
    }, (error) => emit(CrudError(error.toString())));
  }
}
